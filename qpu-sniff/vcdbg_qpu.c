#define _POSIX_C_SOURCE 2

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

#include "vcdbg_qpu.h"

char *default_filters[] = {
	"'shader code'",
	"'uniform map'",
	"'mem_strdup'",
	"'GL20_PROGRAM_T'",
	"'GL20_PROGRAM_T.uniform_data'",
	"'GL20_PROGRAM_T.uniform_info'",
	"'GL20_PROGRAM_T.sampler_info'",
	"'GL20_PROGRAM_T.attrib_info'",
	"'GL20_SHADER_T'",
	"'GL20_SHADER_T.sources_current'",
	"'GLXX_FRAMEBUFFER_T'",
	"'GLXX_BUFFER_T'",
	"'GLXX_BUFFER_INNER_T.storage'",
	"'VG_PAINT_T'",
	0
};

struct processor_t;

struct processor_fn_t {
	void (*begin)(struct processor_t *o);
	void (*next)(struct processor_t *o, char *data);
	void (*end)(struct processor_t *o, int err);
	void (*error)(struct processor_t *o, int err);
};
struct processor_t {
	struct processor_fn_t *fn;
};

void processor_base_begin(struct processor_t *o) {
}
void processor_base_next(struct processor_t *o, char *data) {
}
void processor_base_end(struct processor_t *o, int err) {
}
void processor_base_error(struct processor_t *o, int err) {
	printf("[error %d]", err);
}
struct processor_fn_t processor_fn_base = {
	processor_base_begin, processor_base_next, processor_base_end, processor_base_error
};
#define new_processor_base() (struct processor_t){&processor_fn_base}

void process(struct processor_t *o, const char *command) {
	o->fn->begin(o);
	FILE *f = popen(command, "r");
	if (f == 0) {
		o->fn->error(o, -1);
		return;
	}
	char linebuf[1024];
	while (fgets(linebuf, sizeof(linebuf)-1, f)) {
		o->fn->next(o, linebuf);
	}
	o->fn->end(o, pclose(f));
} 

struct processor_data_t {
	struct processor_fn_t *fn;
	unsigned int size;
	char *type;
	unsigned int original_address;
	void (*on_reloc)(char *type, unsigned int original_address, unsigned int *data, int size);
	unsigned int *data;
	unsigned char *ptr;
};

void processor_data_begin(struct processor_t *bo) {
	struct processor_data_t *o = (struct processor_data_t *)bo;
	o->ptr = (unsigned char *) (o->data = malloc(o->size+16));
}

void processor_data_next(struct processor_t *bo, char *data) {
	struct processor_data_t *o = (struct processor_data_t *)bo;
	unsigned char *u8 = o->ptr;

	o->ptr += sscanf(
		data,
		"%*0x: %0hhx %0hhx %0hhx %0hhx %0hhx %0hhx %0hhx %0hhx %0hhx %0hhx %0hhx %0hhx %0hhx %0hhx %0hhx %0hhx",
		&u8[0], &u8[1], &u8[2], &u8[3], &u8[4], &u8[5], &u8[6], &u8[7], &u8[8],
		&u8[9], &u8[10], &u8[11], &u8[12], &u8[13], &u8[14], &u8[15]
	);
}

void processor_data_end(struct processor_t *bo, int err) {
	struct processor_data_t *o = (struct processor_data_t *)bo;
	o->on_reloc(o->type, o->original_address, o->data, o->size);
	free(o->data);
}

struct processor_fn_t processor_fn_data = {
	processor_data_begin, processor_data_next, processor_data_end, processor_base_error
};
#define new_processor_data(size, type, original_address, on_reloc) *(struct processor_t *)&(struct processor_data_t){&processor_fn_data, size, type, original_address, on_reloc}

struct processor_reloc_t {
	struct processor_fn_t *fn;
	char **filters;
	void (*on_reloc)(char *type, unsigned int original_address, unsigned int *data, int size);
} ;
void scan_reloc(struct processor_t *bo, char *s) {
	struct processor_reloc_t *o = (struct processor_reloc_t *)bo;
	int size;
	unsigned int data;
	int n = sscanf(s, "[%*d] 0x%*0x: used %*f%*c (refcount %*d lock count %*d, size %d, align %*d, data 0x%x", &size, &data);
	if (n == 2) {
	       	char *type = strchr(s, '\'');
		s[strlen(s)-1] = 0;

		if (o->on_reloc) {
			int i = 0;
			for (; type && (!o->filters || o->filters[i]); i++) {
				if (strcmp(type, o->filters[i])==0) {
					char dump[256];
					sprintf(dump, "sudo vcdbg dump 0x%08x %d 2>&1", data, size);
					process(&new_processor_data(size, type, data, o->on_reloc), dump);
					continue;
				}
			}
		}
		else {
			printf("(%s 0x%08x %d)\n", type, data, size);
		}
	}
}
struct processor_fn_t processor_fn_reloc = {
	processor_base_begin, scan_reloc, processor_base_end, processor_base_error
};
#define new_processor_reloc(filters, on_reloc) *(struct processor_t *)&(struct processor_reloc_t){&processor_fn_reloc, filters, on_reloc}

void vcdbg_scan_relocs(char *filters[], void on_reloc(char *type, unsigned int original_addr, unsigned int *data, int size)) {
	process(&new_processor_reloc(filters ? filters : default_filters, on_reloc), "sudo vcdbg reloc small 2>&1");
}


#ifdef TEST
char printable(char c) {
	return ((c>=32) && (c<127)) ? c : '.';
}

void show(char *type, unsigned int *data, int size) {
	int i = 0;
	printf("(%s %08x %d)\n", type, data, size);
	for (; i<size/4; i+=2) {
		unsigned char *u8 = (unsigned char *)&data[i];
		int j = 0;
		for (;j<8;j++) printf("%c", printable(u8[j]));
		printf(" %08x %08x", data[i+0], data[i+1]);
		float *f = (float *)&data[i];
		printf(" %10.4g %10.4g\n", f[0], f[1]);
	}
	printf("\n");
}

int main(int argc, char *argv[]) {
	vcdbg_scan_relocs(0, show);
}
#endif
