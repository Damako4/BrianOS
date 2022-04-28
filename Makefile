C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

OBJ = ${C_SOURCES:.c=.o}

CC = i686-elf-gcc
ASSEMBLER = i686-elf-as

CFLAGS = -ffreestanding -O2 -Wall -Wextra

kernel.bin: boot/boot.o ${OBJ}
	${CC} -T linker.ld -o $@ ${CFLAGS} -nostdlib $^ -lgcc

%.o: %.c ${HEADERS}
	${CC} ${CFLAGS} -c $< -o $@

%.o: %.s
	${ASSEMBLER} $< -o $@

run: kernel.bin
	qemu-system-i386 -kernel kernel.bin

clean:
	rm -rf *.bin *.dis *.o kernel.bin *.elf
	rm -rf kernel/*.o boot/*.bin drivers/*.o boot/*.o
