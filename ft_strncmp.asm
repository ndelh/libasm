bits 64
global ft_strncmp

section .text
ft_strncmp:
    mov r8, 0x0101010101010101
    mov r9, 0x8080808080808080
    mov rcx, rdi
    xor rax, rax
    xor rcx, rsi
    test rcx, -8 ; checking if both string share the same alignement, allowed by the previous xor, -8 represent 11111000
    jnz .desync_finish_loop
    test rdi, 7
    jnz .align_loop

.fast_loop:
    test rdx, rdx
    jz .end
    test rdx, -8 ; checking if atleast one of the five strong bit is active, so if rdx is superior to seven
    jz .desync_finish_loop
    mov rcx, [rdi]
    mov r10, rcx
    mov r11, r10
    sub rcx, r8 ;Swaring
    not r10
    and rcx, r10
    and rcx, r9
    jnz .desync_finish_loop ;falling back to one by one
    xor r11, [rsi]
    jnz .desync_finish_loop
    sub rdx, 8
    add rdi, 8
    add rsi, 8
    jmp .fast_loop

.align_loop:
    test rdx, rdx
    jz .end
    movzx rax, byte [rdi]
    movzx rcx, byte [rsi]
    sub rax, rcx
    jnz .end
    test rcx, rcx
    jz .end
    inc rdi
    inc rsi
    dec rdx
    test rdi, 7
    jz .fast_loop
    jmp .align_loop

.desync_finish_loop: 
    test rdx, rdx
    jz .end
    movzx rax, byte [rdi]
    movzx rcx, byte [rsi]
    sub rax, rcx
    jnz .end
    test rcx, rcx
    jz .end
    inc rdi
    inc rsi
    dec rdx
    jmp .desync_finish_loop

.end:
    ret



