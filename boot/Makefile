AS = nasm

all : boot.bin kernel_entry.o

%.bin : %.asm
	nasm $< -f bin -o $@

%.o : %.asm
	nasm $< -f elf -o $@

clean:
	rm *.bin *.o