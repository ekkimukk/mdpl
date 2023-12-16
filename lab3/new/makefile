all:
	nasm -g -f elf64 asm.asm -l asm.lst -F dwarf
	ld -o asm asm.o
clean:
	rm c *.o *.lst
