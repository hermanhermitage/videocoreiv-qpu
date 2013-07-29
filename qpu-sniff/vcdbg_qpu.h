/*
 * vcdbg_qpu.h
 * Captures 'live' QPU code fragments using vcdbg
 */

/* Scan for qpu fragments on the VC relocable heap */
void vcdbg_scan_relocs(char *filters[], void on_reloc(char *type, unsigned int original_addr, unsigned int *data, int size));

