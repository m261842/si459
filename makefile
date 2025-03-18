compile: bind.asm 
	nasm -f elf64 bind.asm -l bind.lst
	ld -o bind -m elf_x86_64 bind.o -z noexecstack

run:
	@./bind
