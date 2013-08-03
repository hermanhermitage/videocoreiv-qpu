#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <assert.h>
#include <unistd.h>

#include "bcm_host.h"

#include "GLES2/gl2.h"
#include "EGL/egl.h"
#include "EGL/eglext.h"

#define MAX(x, y) (((x) > (y)) ? (x) : (y))
#define MIN(x, y) (((x) < (y)) ? (x) : (y))

#define checkGl() assert(glGetError() == 0)

struct gl_t {
	uint32_t width;
	uint32_t height;
	EGLDisplay display;
	EGLSurface surface;
	EGLContext context;
};

struct gl_t *createGl(int eglVersion, int width, int height, int offscreen) {

	bcm_host_init();

	EGLint attribute_list[] =
	{
		EGL_RED_SIZE, 8,
		EGL_GREEN_SIZE, 8,
		EGL_BLUE_SIZE, 8,
		EGL_ALPHA_SIZE, 8,
		EGL_DEPTH_SIZE, 24,//added
		EGL_STENCIL_SIZE, 8, // added
		EGL_SURFACE_TYPE, EGL_WINDOW_BIT,
		EGL_NONE
	};
   
	EGLint context_attributes[] = 
	{
		EGL_CONTEXT_CLIENT_VERSION, eglVersion,
		EGL_NONE
	};
	EGLConfig config;

	struct gl_t *gl = malloc(sizeof(struct gl_t));

	gl->display = eglGetDisplay(EGL_DEFAULT_DISPLAY);
	assert(gl->display!=EGL_NO_DISPLAY);
	checkGl();

	EGLBoolean result = eglInitialize(gl->display, NULL, NULL);
	assert(EGL_FALSE != result);
	checkGl();

	EGLint num_config;
	result = eglChooseConfig(gl->display, attribute_list, &config, 1, &num_config);
	assert(EGL_FALSE != result);
	checkGl();

	result = eglBindAPI(EGL_OPENGL_ES_API);
	assert(EGL_FALSE != result);
	checkGl();

	gl->context = eglCreateContext(gl->display, config, EGL_NO_CONTEXT, context_attributes);
	assert(gl->context!=EGL_NO_CONTEXT);
	checkGl();

	int32_t success = graphics_get_display_size(0 /* LCD */, &gl->width, &gl->height);
	assert(success>=0);
	if (width)
		gl->width = MIN(width, gl->width);
	if (height)
		gl->height = MIN(height, gl->height);

	if (offscreen) {
		EGLint info[] =
		{
			EGL_HEIGHT, gl->width,
			EGL_WIDTH, gl->height, 
			EGL_NONE
		};

		gl->surface = eglCreatePbufferSurface(gl->display, config, info);
		assert(gl->surface != EGL_NO_SURFACE);
		checkGl();
	}
	else {
		DISPMANX_DISPLAY_HANDLE_T dispman_display = vc_dispmanx_display_open(0 /* LCD */);
		DISPMANX_UPDATE_HANDLE_T dispman_update = vc_dispmanx_update_start(0);
		DISPMANX_ELEMENT_HANDLE_T dispman_element = vc_dispmanx_element_add(
			dispman_update,
			dispman_display,
			0/*layer*/,
			&(VC_RECT_T){0, 0, gl->width, gl->height} /*dest rect*/,
			0/*src*/,
			&(VC_RECT_T){0, 0, gl->width<<16, gl->height<<16} /*src rect*/,
			DISPMANX_PROTECTION_NONE,
			0/*alpha*/, 
			0/*clamp*/,
			0/*transform*/
		);
		vc_dispmanx_update_submit_sync(dispman_update);

		gl->surface = eglCreateWindowSurface(
			gl->display,
			config,
			&(EGL_DISPMANX_WINDOW_T){dispman_element, gl->width, gl->height},
			NULL
		);
		assert(gl->surface != EGL_NO_SURFACE);
		checkGl();
	}

	result = eglMakeCurrent(gl->display, gl->surface, gl->surface, gl->context);
	assert(EGL_FALSE != result);
	checkGl();

	return gl;
}


GLuint vshader;
GLuint fshader;
GLuint program;
GLuint buf;
GLuint unif_color;
GLuint attr_vertex; 

static char *getShaderInfoLog(GLint shader)
{
	GLint len = 0;
	glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &len);
	checkGl();
	char *log = malloc(len);
   	glGetShaderInfoLog(shader, len, NULL, log);
	checkGl();
	return log;
}

static char *getProgramInfoLog(GLint program)
{
	GLint len = 0;
	glGetProgramiv(program, GL_INFO_LOG_LENGTH, &len);
	checkGl();
	char *log = malloc(len);
   	glGetProgramInfoLog(program, len, NULL, log);
	checkGl();
	return log;
}

int compile_shaders(const char *vs_source, const char *fs_source, char **vs_log, char **fs_log, char **program_log) {

	int errors = 0;
	GLint status;

        vshader = glCreateShader(GL_VERTEX_SHADER);
        glShaderSource(vshader, 1, &vs_source, 0);
        glCompileShader(vshader);
	glGetShaderiv(vshader, GL_COMPILE_STATUS, &status);
	if (glGetError() || !status)
		errors++;
	if (vs_log)
		*vs_log = getShaderInfoLog(vshader);

        fshader = glCreateShader(GL_FRAGMENT_SHADER);
        glShaderSource(fshader, 1, &fs_source, 0);
        glCompileShader(fshader);
	glGetShaderiv(vshader, GL_COMPILE_STATUS, &status);
	if (glGetError() || !status)
		errors++;
	if (fs_log)
		*fs_log = getShaderInfoLog(fshader);

        program = glCreateProgram();
        glAttachShader(program, vshader);
        glAttachShader(program, fshader);
        glLinkProgram(program);
	glGetProgramiv(program, GL_LINK_STATUS, &status);
	if (glGetError() || !status)
		errors++;
	if (program_log)
		*program_log = getProgramInfoLog(program);

	return errors;
}

void run_shaders() {
	// Wire up vertex buffer to shader
        attr_vertex = glGetAttribLocation(program, "vertex");
	if (attr_vertex != -1) {
		glVertexAttribPointer(attr_vertex, 4, GL_FLOAT, 0, 16, 0);
		glEnableVertexAttribArray(attr_vertex);
		checkGl();
	}

	// Set Uniforms
        unif_color  = glGetUniformLocation(program, "color");
	if (unif_color != -1) {
		glUniform4f(unif_color, 0.5, 0.5, 0.8, 1.0);
        	checkGl();
	}

	if (0) {
		glBlendFunc(GL_ONE_MINUS_SRC_ALPHA, GL_SRC_COLOR);//GL_SRC_ALPHA);
		glBlendEquation(GL_FUNC_ADD);
		glBlendColor(0.5, 0.5, 0.5, 1.0);
		glEnable(GL_BLEND);
	}

	if (0) {
		glColorMask(1.0, 0.0, 0.0, 1.0);
	}

	if (0) {
		//  glLogicOp(GL_AND); // not in es2	
	}

	if (0) {
		glDepthFunc(GL_EQUAL);
		glEnable(GL_DEPTH_TEST);
	}

	if (0) {
		glStencilFunc(GL_LESS, 10, 0xffffffff);
		glStencilOp(GL_INCR, GL_DECR, GL_ZERO);
		glEnable(GL_STENCIL_TEST);
	}

	if (0) {
		GLuint texureId;
		glGenTextures(1, &texureId);
		glBindTexture(GL_TEXTURE_2D, texureId);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST); 
		//glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
	}

	// Draw triangles
	glBindFramebuffer(GL_FRAMEBUFFER,0);
	glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);

	glBindBuffer(GL_ARRAY_BUFFER, buf);
	glUseProgram(program);

	glDrawArrays(GL_TRIANGLE_FAN, 0, 4 );
	glBindBuffer(GL_ARRAY_BUFFER, 0);

	glFlush();
	glFinish();
}

void free_shaders() {
	glUseProgram(0);
	glDetachShader(program, fshader);
	glDetachShader(program, vshader);
	glDeleteProgram(program);
	glDeleteShader(vshader);
	glDeleteShader(fshader);
}

static struct gl_t *gl;

void begin_gl_test(int offscreen) {
	gl = createGl(2, 0, 0, offscreen);
	
        // Prepare viewport
        glViewport(0, 0, gl->width, gl->height);
        checkGl();
	
	// Set background color and clear buffers
        glClearColor ( 0.0, 1.0, 1.0, 1.0 );

   	// Init Shaders
	static const GLfloat vertex_data[] = {
		-1.0,-1.0,1.0,1.0,
		1.0,-1.0,1.0,1.0,
		1.0,1.0,1.0,1.0,
		-1.0,1.0,1.0,1.0
	};
        // Upload vertex data to a buffer
        glGenBuffers(1, &buf);
        glBindBuffer(GL_ARRAY_BUFFER, buf);
        glBufferData(GL_ARRAY_BUFFER, sizeof(vertex_data), vertex_data, GL_STATIC_DRAW);
}

int run_gl_test(const char *vs_source, const char *fs_source, char **vs_log, char **fs_log, char **program_log) {
	int errors = compile_shaders(vs_source, fs_source, vs_log, fs_log, program_log);
	if (errors == 0)
		run_shaders();
	return errors;
	//eglSwapBuffers(gl->display, gl->surface);
}

void end_gl_test() {
	free_shaders();
}

#ifdef TEST
int main()
{
	int offscreen = 1;

	char *vs_log;
	char *fs_log;
	char *program_log;

	printf("Preparing GL\n");
	begin_gl_test(offscreen);

	printf("Running Test\n");
	int errors = run_gl_test(
		"attribute vec4 vertex; void main(void) { gl_Position = vertex; }",
		"uniform vec4 c1; void main(void) { gl_FragColor = c1; }",
		&vs_log, &fs_log, &program_log);

	if (errors) {
		printf("Vertex Shader Log\n%s\n", vs_log);
		printf("Fragment Shader Log\n%s\n", fs_log);
		printf("Program Info Log\n%s\n", program_log);
	}

	free(vs_log);
	free(fs_log);
	free(program_log);
            
	printf("Press enter to release resources and quit...");
	getchar();
	end_gl_test();

	return 0;
}
#endif

