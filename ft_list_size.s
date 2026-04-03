bits 64
global ft_list_size

section .text
ft_list_size:

xor rax, rax

.count_loup:
test rdi, rdi ; feasible in assembly allow to gain one comparison compared to c
jz .end
inc rax
mov rdi, [rdi + 8]
jmp .count_loup

.end:
ret