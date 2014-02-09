all:	qpu-01 qpu-02

qpu-01: mailbox.c qpu-01.c
	gcc -o qpu-01 mailbox.c qpu-01.c

qpu-02: mailbox.c qpu-02.c
	gcc -o qpu-02 mailbox.c qpu-02.c
clean:
	rm -f qpu-01 qpu-02
