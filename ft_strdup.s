bits 64
global ft_strdup
extern ft_strlen
extern ft_strcpy
extern malloc

section .text
ft_strdup:
    push r12
    mov r12, rdi
    call ft_strlen
    inc rax
    mov rdi, rax
    call malloc
    test rax, rax
    jz .end
    mov rdi, rax
    mov rsi, r12
    call ft_strcpy

.end:
    pop r12
    ret