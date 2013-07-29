uniform vec4 c1;
uniform vec4 c2;
uniform vec4 c3;
uniform vec4 c4;
uniform int i1;
void main(void) {
  if (i1 == 1)
    gl_FragColor = c1;
  else if (i1 == 2)
    gl_FragColor = c2;
  else if (i1 == 3)
    gl_FragColor = c3;
  else
    gl_FragColor = c4;
}

