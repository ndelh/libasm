bits 64
global ft_list_remove_if
extern free
section .text
ft_list_remove_if:

.null_test:
    test rcx, rcx ;is second func null
    jz .fast_end
    test rdx, rdx ;is first function null
    jz .fast_end
    test rdi, rdi
    jz .fast_end
    test rdi, rdi ;is **arg1 null?
    jz .fast_end
    mov rax, [rdi] ; dereferencing arg 1 to check on the following line if it contains a null pointer
    test rax, rax
    jz .fast_end

.init:
    push r12 ;original pointer
    push r13 ; cursor
    push r14 ; arg to compare
    push r15 ; comp func
    push rbx ; delete func
    ;pile is now displaced by 48
    mov r12, rdi
    mov r13, rax ;
    mov r14, rsi
    mov r15, rdx
    mov rbx, rcx

 .loop_on_first:
    test r13, r13
    jz .end ;means we have emptyed the list
    mov rdi, r14
    mov rsi, [r13]
    call r15
    test eax, eax
    jnz .loop_on_list
    mov rdi, [r13]
    call rbx
    mov rdi, r13
    mov r13,  [r13 + 8] ; actualising the head
    mov [r12], r13 ; actualiising original pointer
    call free
    jmp .loop_on_first


.loop_on_list:
    mov rsi, [r13 + 8]
    test rsi, rsi
    jz .end ; if next node is null we have finished
    mov rsi, [rsi] ; goal is to know if next node is going to be erased
    mov rdi, r14
    call r15
    test eax, eax
    jz .erase_next
    mov r13, [r13 + 8]
    jmp .loop_on_list

.erase_next:

    mov rdi, [r13 + 8]
    mov rdi, [rdi] ; retrieving next data
    call rbx
    mov rdi, [r13 + 8] 
    mov rax, [rdi + 8] ;retrieving next->next 
    mov [r13 + 8], rax ; bridging node before remowe with after re
    call free
    jmp .loop_on_list

.end:
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    ret

.fast_end:
    ret