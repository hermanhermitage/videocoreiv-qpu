CFLAGS = -std=c99

LDFLAGS+=-L$(SDKSTAGE)/opt/vc/lib/ -lGLESv2 -lEGL -lbcm_host -lvcos 
GLINCLUDES+=-I/opt/vc/include/ -I/opt/vc/include/interface/vmcs_host/linux -I./ -I/opt/vc/include/interface/vcos/pthreads -I/opt/vc/include/interface/vmcs_host/linux

all: qpu-sniff 

clean:
	rm qpu-sniff
	rm testgl

qpu-sniff: qpu-sniff.c vcdbg_qpu.c qpudis.c testgl.o

testgl.o: testgl.c
	$(CC) $(CPPFLAGS) $(GLINCLUDES) $(GLLDFLAGS) testgl.c -c
