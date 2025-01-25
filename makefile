compile: ecat.asm 
	nasm -f elf64 ecat.asm
	ld -o ecat -m elf_x86_64 ecat.o -z noexecstack

run:
	@./ecat