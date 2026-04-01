bits 64
global ft_write
extern __errno_location

section .text
ft_write:
mov rax, 1
syscall
cmp rax, 0
jge .end
neg rax
push rax
call __errno_location
pop rdx
mov [rax], edx
mov rax, -1

.end:
ret