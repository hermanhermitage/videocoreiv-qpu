uniform vec4 c1;
uniform vec4 c2;
void main(void) {
  gl_FragColor = max(c1, c2);
}

