bits 64
global ft_list_sort

section .text
ft_list_sort:

.first_null_check:
    test rdi, rdi ; is ** in arg 1null
    jz .quick_end
    test rsi, rsi ; is arg2 null?
    jz .quick_end

.init:
    push r12 ; will be used to store original arg1
    push r13 ; will be used as a cursor on *arg1
    push r14; will be used to store head of the new node
    push r15; will be used as a cursor on new_chain
    push rbx ; will be used to store function pointer passed as argv 2
    ; pile is now displaced by 48 (5 * 8) + 8
    sub rsp, 8
    ;pile is now displaced by 56
    mov r12, rdi
    mov rbx, rsi
    mov r13, [rdi]
    mov r14, r13 
    test r13, r13 ; is arg2 null?
    jz .end

.displacing_first_node:
    mov r13, [r13 + 8]; cursor = node->next
    mov qword [r14 + 8], 0 ; setting new_list first_node->next to null LAST TEST WAS HERE

.main_loop:
    test r13, r13 ; has cursor reached the end of the initial list?
    jz .end
    mov rsi, [r13] ; preparing for comp function by fetching data
    mov rdi, [r14]
    push rsi
    call rbx
    pop rsi ;restauring to->insert data in arg2
    cmp eax, 0
    jg .replace_first_node
    mov r15, r14 ; loading r13 to allow use of r15 as a cursor on new_list
    jmp .comp_loop

.replace_first_node:
    mov rax, r13
    mov r13, [r13 + 8] ; cursor = cursor->next
    mov [rax + 8], r14 ; comnnecting to_insert to current head
    mov r14, rax ; updating head
    jmp .main_loop

.comp_loop:
    cmp qword [r15 + 8], 0
    jz .insert_last
    mov rax, [r15 + 8]
    mov rdi, [rax] ; goal is to compare if i need to insert before the next node
    push rsi
    call rbx
    pop rsi ;rsi was loaded as the node to_insert->data so restauring here allow to chain comp
    cmp eax, 0
    jge .standard_insert
    mov r15, [r15 + 8]
    jmp .comp_loop

.insert_last:
    mov rax, r13 ;loading to insert in rax
    mov r13, [r13 + 8] ; cursor = cursor->next
    mov qword [rax + 8], 0 ; setting up to_insert next to null
    mov [r15 + 8], rax ; setting old last->next to to_insert
    jmp .main_loop

.standard_insert:
    mov rax, r13
    mov r13, [r13 + 8] ; cursor = cursor->next
    mov rdi, [r15 + 8] ; retrieving new_list_cursor->next
    mov [r15 + 8], rax ; connecting upper part to to_insert
    mov [rax + 8], rdi ; connecting to_insert to lower part
    jmp .main_loop


.end:
    mov [r12], r14 ; updating *arg 1
    add rsp, 8
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    ret

.quick_end:
    ret