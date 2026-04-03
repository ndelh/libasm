bits 64
global ft_list_push_front
extern malloc

section .text
ft_list_push_front:
push r12
push r13
push r14
test rdi, rdi
jz .end
mov r12, rdi
mov r13, rsi
mov rdi, 16; 2 pointer in struct so 2 * 8
call malloc
test rax, rax ; did malloc fail ?
jz .end
mov [rax], r13 ; loading data pointer into the rax->data
mov r8, [r12]; because indirection dereference is needed
mov [rax + 8], r8 ; moving *(argument1) into rax->next
mov [r12], rax

.end:
    pop r14
    pop r13
    pop r12
    ret
