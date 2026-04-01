bits 64
global ft_read
extern __errno_location
section .text
ft_read:
mov rax, 0
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