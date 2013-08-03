uniform sampler2D texture[8]; 
uniform vec2 texCoord[8];
 
void main(void) {
    gl_FragColor = texture2D(texture[0], texCoord[0])+texture2D(texture[1], texCoord[1])
    		 + texture2D(texture[2], texCoord[2])+texture2D(texture[3], texCoord[3])
    		 + texture2D(texture[4], texCoord[4])+texture2D(texture[5], texCoord[5])
    		 + texture2D(texture[6], texCoord[6])+texture2D(texture[7], texCoord[7]);
	;
}
