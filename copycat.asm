; Tuguldur Erdenebat
; 3/5/2025
; Project 2 ShellCode
; how to compile: make compile
; Description: Opens a file called win, and writes output to stdout

bits 64

;section .data
;    ;define win file name and bin/sh
;    win db './///win', 0x0
;    bin db '//bin/sh', 0x0
;    ;winFd db '', 0x0

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

;;;;;;;;;;;;;;;ORIGINAL COPYCAT STDIN;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;read in from stdin
    ;mov al, 1 ; set syscall number to (sys_read + 1)
    ;sub al, 1 ; set syscall number to (sys_read)
    ;mov dil, 1 ; set file desctriptor to (stdin + 1)
    ;sub dil, 1  ;file descriptor set to 0 (stdin)
    ;add rsp, 8  ;increment the stack pointer by 1 byte
    ;mov rsi, rsp ;set buffer to stack pointer
    ;mov dl, 1  ;just read one bit
    ;syscall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;open win file
    ;int fd = open('.////win', O_RDONLY, NULL)
    ;int open(const char *pathname, int flags, /* mode_t mode */)
    mov al, 2 ; set syscall number to (sys_open)
    mov rdi, win ; set filename to win;
    mov rsi, 0 ;set flag to O_RDONLY
    mov dl, 0  ;set mode to null/0
    syscall
    mov r10, rax;move fd to variable

_read:
    
    ;read in from the file
    mov al, 0 ; set syscall number to (sys_read)
    mov rdi, r10 ; set file desctriptor to (winFd)   ;dil to rdi
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
    jmp _read  ;loop back to the beginning

.done:

    ;syscall for exit
    xor rax, rax
    mov al, 60    ;syscall for sys_exit
    mov dil, 1  ;set status code to (success + 1)
    sub dil, 1  ;set status code 0 (success)
    syscall
    
win:
    db './///win', 0x0
