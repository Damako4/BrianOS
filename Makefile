C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

OBJ = ${C_SOURCES:.c=.o}

CC = i686-elf-gcc
ASSEMBLER = i686-elf-as
GDB = i686-elf-gdb

CFLAGS = -ffreestanding -g -O0 -Wall -Wextra

kernel.bin: boot/boot.o ${OBJ}
	${CC} -T linker.ld -o $@ ${CFLAGS} -nostdlib $^ -lgcc

kernel.elf: boot/boot.o ${OBJ}
	${CC} -T linker.ld -o $@ -ffreestanding -g -O0 -Wall -Wextra  -mx32 -nostdlib -lgcc $^

debug: kernel.bin kernel.elf
	qemu-system-i386 -s -kernel kernel.bin &
	${GDB} -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

%.o: %.c ${HEADERS}
	${CC} ${CFLAGS} -c $< -o $@

%.o: %.s
	${ASSEMBLER} $< -o $@

run: kernel.bin
	qemu-system-i386 -kernel kernel.bin

clean:
	rm -rf *.bin *.dis *.o kernel.bin *.elf
	rm -rf kernel/*.o boot/*.bin drivers/*.o boot/*.o
