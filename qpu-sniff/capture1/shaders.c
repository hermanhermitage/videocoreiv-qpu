	glClearColor(0.15f, 0.25f, 0.35f, 1.0f);
	glClear( GL_COLOR_BUFFER_BIT );

   	// Init Shaders
	static const GLfloat vertex_data[] = {
		-1.0,-1.0,1.0,1.0,
		1.0,-1.0,1.0,1.0,
		1.0,1.0,1.0,1.0,
		-1.0,1.0,1.0,1.0
	};

	const GLchar *vs_source =
		"attribute vec4 vertex;"
		"void main(void) {"
		" vec4 pos = vertex;"
		" gl_Position = vec4(pos.x*0.75, pos.y*0.75, pos.z, pos.w);"
		"}";
      
	const GLchar *fs_source =
		"void main(void) {"
		"  gl_FragColor = vec4(1,1,0,0.5);"
		"}";
