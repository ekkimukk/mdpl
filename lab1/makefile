all:
	gcc -g -ggdb -c -o c.o c.c
	nasm -g -f elf64 asm.asm -l asm.lst -F dwarf
	gcc -o c c.o asm.o 	-fno-pie -no-pie -z noexecstack
clean:
	rm c *.o *.lst
