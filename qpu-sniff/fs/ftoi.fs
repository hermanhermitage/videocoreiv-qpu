uniform float f1;
void main(void) {
  if (int(f1) == 1)
    gl_FragColor = vec4(1, 1, 1, 1);
  else
    gl_FragColor = vec4(0, 0, 0, 0);
}

