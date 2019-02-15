CC = i686-elf-gcc
CFLAGS = -ffreestanding

all: kernel.bin

%.o : %.c
	$(CC) -c $< -o $@

clean:
	rm *.o *.bin

kernel.bin: ../boot/kernel_entry.o kernel.o
	i686-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

# DO NOT DELETE
kernel.o: kernel.c /usr/include/stdc-predef.h
