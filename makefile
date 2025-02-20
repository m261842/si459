compile: copycat.asm 
	nasm -f elf64 copycat.asm -l copycat.lst
	ld -o copycat -m elf_x86_64 copycat.o -z noexecstack

run:
	@./copycat
