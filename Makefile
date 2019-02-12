all: boot kernel

boot:
	cd boot ; $(MAKE)

kernel:
	cd kernel ; $(MAKE)