ASSEMBLER = i686-elf-as
CFLAGS = -std=gnu99 -ffreestanding -O2 -Wall -Wextra
CC = i686-elf-gcc

compile: boot.s kernel.c
	$(ASSEMBLER) boot.s -o ../build/boot.o
	$(CC) $(CFLAGS) -c kernel.c -o ../build/kernel.o
