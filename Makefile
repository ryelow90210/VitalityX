C_SOURCES = $(wildcard libc/vitality/*.c libc/*.c drivers/*.c kernel/*.c libc/ext/*.c)
CPP_SOURCES = $(wildcard libc/g++/*.cpp)
HEADERS = $(wildcard libc/vitality/*.h libc/*.h drivers/*.h kernel/*.h libc/ext/*.h)
CPP_HEADERS = $(wildcard libc/g++/*.h)
A_SOURCES = ${wildcard kernel/libasm/*.s}
A2_SOURCES = ${wildcard kernel/libasm/*.asm}
OBJ = ${C_SOURCES:.c=.o}
LOBJ = ${LIBC_SOURCES:*.c=.o}
POBJ = ${CPP_SOURCES:.cpp=.o}
AOBJ = ${A_SOURCES:.s=.o}
A2OBJ = ${A2_SOURCES:.asm=.o}

CC = i686-elf-gcc
LD = i686-elf-ld
PP = i686-elf-g++
WSL = C:\Windows\sysnative\wsl
AS = i686-elf-as
SYS = C:\Windows\sysnative\command
BOCHS = C:\Program Files\Bochs-2.6.11\bochsdbg
NASM = nasm
GDB = i686-elf-GDB
# flags for the compiler
CFLAGS = -g

.DEFAULT_GOAL := run

ORIGIN = 0x7e00

operating.bin: bootloader/boot.bin kernel.bin
	${WSL} cat $^ > operating.bin

kernel.bin: kernel/kentry.o LINKER.ld ${OBJ} ${AOBJ} ${A2OBJ}
	${LD} -o $@ -Ttext ${ORIGIN} $^ --oformat binary

kernel.elf: kernel/kentry.o LINKER.ld ${OBJ} ${AOBJ} ${A2OBJ}
	${LD} -o $@ -Ttext ${ORIGIN} $^

run: operating.bin
	qemu-system-i386 -no-reboot -no-shutdown -fda operating.bin -hda sys.img -boot a

debug: operating.bin
	${BOCHS}

%.o: %.c ${HEADERS}
	${CC} ${CFLAGS} -ffreestanding -c $< -o $@

%.o: %.cpp ${CPP_HEADERS}
	${PP} ${CFLAGS} -ffreestanding -c $< -o $@

%.o: %.s
	${AS} ${CFLAGS} -c $< -o $@

%.o: %.asm
	${NASM} $< -f elf -o $@

%.bin: %.asm bootloader/gdt.asm
	${NASM} $< -f bin -o $@

clean:
	${WSL} rm -rf *.bin *.dis *.o operating.bin *.elf
	${WSL} rm -rf kernel/*.o bootloader/*.bin bootloader/*.o libc/*.o libc/vitality/*.o
