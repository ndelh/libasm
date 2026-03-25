bits 64
global ft_strlen

%define macro 0xffff

section .text
ft_strlen:
    mov rsi, rdi ; preserving original pointer
    mov r10, 0x0101010101010101 ; underflow mask
    mov r11, 0x8080808080808080 ; mask with most significant bit active

.alignloop:

    test rdi, 7
    jz .loop
    cmp byte [rdi], 0
    je .early_end
    inc rdi
    jmp .alignloop

.loop:
    mov rax, [rdi]
    add rdi, 8
    mov rdx, rax
    sub rax, r10 ; cause an underflow on \0 if presents, now it s value is 
    not rdx ; inversion of rdx
    and rax, rdx ; allow to put aside the cases of char with the most representative bit activated
    and rax, r11; using and with 10000000, cumulated with previous manipulation, will now result on zero flag set if initial char as a different value 
    jz .loop
    bsf rax, rax
    shr rax, 3
    add rdi, rax
    sub rdi, rsi
    sub rdi, 8
    mov rax, rdi
    ret

.early_end:
    sub rdi, rsi
    mov rax, rdi
    ret
