uniform vec3 texCoord;
uniform sampler3D texture; 
 
void main(void) {
    gl_FragColor = texture3D(texture, texCoord);
}
