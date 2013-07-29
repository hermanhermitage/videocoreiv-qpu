uniform int i1;
uniform int i2;
void main(void) {
  gl_FragColor = vec4(float(i1+int(gl_FragCoord.x)), gl_FragCoord.y, 1, 1);
}

