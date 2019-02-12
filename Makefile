all: boot kernel

boot:
	cd boot ; $(MAKE)

kernel:
	cd kernel ; $(MAKE)

clean:
	cd boot ; $(MAKE) clean
	cd kernel ; $(MAKE) clean