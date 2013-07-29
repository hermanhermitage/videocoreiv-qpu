uniform float x;
void main(void) {
  gl_FragColor = vec4(log2(x), exp2(x), 1, inversesqrt(x));
}

