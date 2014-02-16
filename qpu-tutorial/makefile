all:	qpu-01 qpu-02

qpu-01.hex: qpu-01.s
	nodejs qpuasm.js qpu-01.s > qpu-01.hex

qpu-02.hex: qpu-02.s
	nodejs qpuasm.js qpu-02.s > qpu-02.hex

qpu-01: mailbox.c qpu-01.c qpu-01.hex
	gcc -o qpu-01 mailbox.c qpu-01.c

qpu-02: mailbox.c qpu-02.c qpu-02.hex
	gcc -o qpu-02 mailbox.c qpu-02.c
clean:
	rm -f qpu-01 qpu-02
