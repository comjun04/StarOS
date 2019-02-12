.SUFFIXES : .asm .bin

AS = nasm

all : 

%.bin : %.asm
	$(AS) $< -f bin -o $@

clean:
	rm *.bin *.o

kernel_entry.o : kernel_entry.asm
	$(AS) $< -f elf -o $@