compile: lab2.asm 
	nasm -f elf64 lab2.asm -l lab2.lst
	ld -o lab2 -m elf_x86_64 lab2.o -z noexecstack

run:
	@./lab2