all: boot kernel pack
.PHONY: boot kernel

boot:
	cd boot ; $(MAKE)

kernel:
	cd kernel ; $(MAKE)

clean:
	cd boot ; $(MAKE) clean
	cd kernel ; $(MAKE) clean
	rm os-image.img

pack: boot/boot.bin kernel/kernel.bin
	cat $^ > os-image.img