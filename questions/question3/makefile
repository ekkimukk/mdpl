all:
	gcc -g -ggdb -c -o c.o c.c
	nasm -g -f elf64 asm.asm -l asm.lst -F dwarf
	gcc -g -o c c.o asm.o -fno-pie -no-pie
clean:
	rm c *.o *.lst
