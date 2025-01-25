; Tuguldur Erdenebat
; 1/23/2025
; Lab 3 Cat
; how to compile:
; Description:
; To submit: submit -c=SI459 -p=lab03 cat.asm

bits 64

section .data
    hello db 'Hello, World!', 0x0A    ; 0x0A is the ASCII code for newline

section .text
    global _start

; function args 1:rdi, 2:rsi, 3:rcx, 4:rdx, 5:r8, 6:r9
; frame pointer: rbp
; function return value: rax

; sys_write(int fd, const void buf[.count], size_t count)
; rax = 1

; sys_read(int fd, void buf[.count], size_t count)
; rax = 0

;convention: syscall NR:rax, return:rax, arg0:rdi, arg1:rsi, arg2:rdx, arg3:r10  ...r8...r9

_start:
    ;write to stdout
    mov rax, 1  ;set syscall number to sys_write
    mov rdi, 1  ;file descriptor set to 1 (stdout)
    mov rsi, hello ;set buffer
    mov rdx, 20  ;just write one byte
    syscall

    ;syscall for exit
    mov rax, 60    ;syscall for sys_exit
    mov rdi, 0  ;set status code 0 (success)
    syscall


;rsi - amt of space