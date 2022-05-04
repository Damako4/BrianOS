# Makefiles

CC := i686-elf-gcc
CFLAGS := -ffreestanding -O2 -nostdlib -lgcc
NAME = brianos

compile: src/linker.ld
	+$(MAKE) -C src
	$(CC) $(CFLAGS) -T src/linker.ld -o bin/$(NAME).bin build/boot.o build/kernel.o

run: bin/brianos.bin
	echo "Booting kernel, have fun :)"
	qemu-system-i386 -kernel bin/brianos.bin
