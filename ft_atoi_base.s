bits 64
global ft_atoi_base
extern ft_strlen

section .text
ft_atoi_base:
push r12
push r13
sub rsp, 264; reserving space to parse_base (256 + 8 for memory alignement)
xor rax, rax
test rdi, rdi ; null test
jz .end
test rsi, rsi ; null test
jz .end
mov r12, rdi ; preserving original argv[1]
mov r13, rsi; preserving orginal argv[2]
mov r9 , 1 ; r9 will be used as a sign marker

.init_base_table:
mov rdi, rsi ; need to put argv[2] in first argument for ft_strlen
call ft_strlen
mov r8, rax ;storing the result for ulterior calculul
xor rax, rax
cmp r8, 2 ; base cannot have less than two char
jl .end
mov al, 255
mov rdi, rsp ; will be used to iterate with stosb
mov rcx, 256 ; number of iteration for rep
cld ;clear direction flag, allow to unsure that rep will increment even if asked to decrement before
rep stosb ; while rcx, rdi[byte] = al; ++rdi; --rcx
mov rdi, r13 ; putting base in rdi
xor rax, rax

.poisonning_table:
mov rcx, 5
lea rdi, [rsp + 9]
mov al, 254
rep stosb
xor rax, rax ; restauring rax in case of error in parse base
mov byte [rsp + 32], 254
mov byte [rsp + 43], 253
mov byte [rsp + 45], 252
mov rdi, r13 ; restauring orginal base pointer on rdi

.parse_base_loop:
movzx rdx ,byte [rdi]
cmp rdx, 0
je .skip_space_init
cmp byte [rsp + rdx], 255
jne .end ; different mean the flag was already activated or poisonned
mov rcx, rdi
sub rcx, r13 ; arithmetic pointer, r13 hold the value of the initial base pointer, rcx the current position
mov byte [rsp + rdx], cl ; cl because the value of sub rcx, r13 will always fit in cl and cl matches the byte ; now the index rsp + ascii number contain the index of the symbol
inc rdi
jmp .parse_base_loop


.skip_space_init:
mov rdi, r12 ; putting orginal argv[1] pointer in rdi 
.skip_space:
movzx rdx, byte [rdi]
cmp byte [rdx + rsp], 254 ; all white space where set up to 254
jne .sign
inc rdi
jmp .skip_space

.sign:
movzx rdx, byte [rdi]
cmp byte[rdx + rsp], 252
je .minus
cmp byte[rdx + rsp], 253
jne .atoi_loop
inc rdi
jmp .atoi_loop

.minus:
mov r9, -1
inc rdi

.atoi_loop:
movzx rdx, byte [rdi] ;fetching the char under "cursor"
movzx rcx, byte [rsp + rdx] ; retrievieng the value of this char
cmp rcx, r8 ; 
jae .end ; cannot be superior to size and size cannot exceed 252
imul rax, r8 ;multiplictate by base size
add rax, rcx;
inc rdi
jmp .atoi_loop

.end:
imul rax, r9 ;applying sign
add rsp, 264 ; restauring rsp
pop r13
pop r12
ret