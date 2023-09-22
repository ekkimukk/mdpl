all:
	gcc -g -ggdb -c -o ctest.o ctest.c
	nasm -g -f elf64 atest.asm -l atest.lst -F dwarf
	gcc -o ctest ctest.o atest.o -fno-pie -no-pie
clean:
	rm ctest *.o *.lst
