uniform bool a;
uniform bool b;
void main(void) {
  if (a & b)
    gl_FragColor = vec4(1,1,1,1);
  else 
    gl_FragColor = vec4(0,0,0,0);
}

