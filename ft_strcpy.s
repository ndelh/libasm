bits 64
global ft_strcpy

section .text
ft_strcpy:
    mov r9, rdi ;saving dest original pointer
    mov r10, 0x0101010101010101 ;underflow mask
    mov r11, 0x8080808080808080 ;filter mask, only the most significant bit is active
    test rsi, 7 ;checking initial alignement
    jz .loop

.align_and_finish:

    mov al, byte[rsi]
    mov byte [rdi], al
    test al, al
    jz .end
    inc rsi
    inc rdi
    test rsi, 7 ;test can be performed here, worst case scenario it will happen 14 times in program (7 unaligned + 7 finish)
    jz .loop
    jmp .align_and_finish

.loop:
    mov rax, [rsi] ;classic SWAR
    mov rdx, rax
    sub rax, r10
    not rdx
    and rax, rdx
    and rax, r11
    jnz .align_and_finish
    mov r8, [rsi]
    mov [rdi], r8
    add rsi, 8
    add rdi, 8
    jmp .loop

.end:
    mov rax, r9
    ret