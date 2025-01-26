; Tuguldur Erdenebat
; 1/23/2025
; Lab 3 Cat
; how to compile: make compile
; Description: Basic version of cat. Reads from stdin, and copies into stdout
; To submit: submit -c=SI459 -p=lab03 lab2.asm lab2.lst

bits 64

section .text
    global _start

;;;;;;;;;;;;NOTES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ; function args 1:rdi, 2:rsi, 3:rcx, 4:rdx, 5:r8, 6:r9
        ; frame pointer: rbp
        ; function return value: rax

        ; sys_write(int fd, const void buf[.count], size_t count)
        ; rax = 1

        ; sys_read(int fd, void buf[.count], size_t count)
        ; rax = 0

        ;convention: syscall NR:rax, return:rax, arg0:rdi, arg1:rsi, arg2:rdx, arg3:r10  ...r8...r9
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

_start:

    ;read in from stdin
    mov al, 1 ; set syscall number to (sys_read + 1)
    sub al, 1 ; set syscall number to (sys_read)
    mov dil, 1 ; set file desctriptor to (stdin + 1)
    sub dil, 1  ;file descriptor set to 0 (stdin)
    add rsp, 8  ;increment the stack pointer by 1 byte
    mov rsi, rsp ;set buffer to stack pointer
    mov dl, 1  ;just read one bit
    syscall

    ;check if eof or error was reached
    add rax, 1  ;add 1 to rax
    cmp rax, 1  ;see if success (cmp rax+1, 1)
    je .done    ;if return value is zero(eof), then jump to done

    ;write to stdout
    mov al, 1  ;set syscall number to sys_write
    mov dil, 1  ;file descriptor set to 1 (stdout)
    mov rsi, rsp ;set buffer to stack pointer
    mov dl, 1  ;just write one byte
    syscall
    jmp _start  ;loop back to the beginning

.done:

    ;syscall for exit
    mov ax, 60    ;syscall for sys_exit
    mov dil, 1  ;set status code to (success + 1)
    sub dil, 1  ;set status code 0 (success)
    syscall
