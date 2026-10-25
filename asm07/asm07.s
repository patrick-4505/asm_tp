section .bss
    buf resb 64

section .text
    global _start

_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, buf
    mov rdx, 63
    syscall

    mov rsi, buf
    mov rax, 0
    mov r8, 0

    cmp byte [rsi], '-'
    jne debut
    mov r8, 1
    inc rsi

debut:
    cmp byte [rsi], 10
    je exit2
    cmp byte [rsi], 0
    je exit2

boucle:
    movzx rcx, byte [rsi]
    cmp rcx, 10
    je fin
    cmp rcx, 0
    je fin
    cmp rcx, '0'
    jb exit2
    cmp rcx, '9'
    ja exit2
    sub rcx, '0'
    imul rax, rax, 10
    add rax, rcx
    inc rsi
    jmp boucle

fin:
    cmp r8, 1
    je exit1
    cmp rax, 2
    jb exit1

    mov r9, rax
    mov rbx, 2

diviseur:
    mov rax, rbx
    imul rax, rbx
    cmp rax, r9
    ja exit0

    mov rax, r9
    mov rdx, 0
    div rbx
    cmp rdx, 0
    je exit1

    inc rbx
    jmp diviseur

exit0:
    mov rdi, 0
    jmp sortir

exit1:
    mov rdi, 1
    jmp sortir

exit2:
    mov rdi, 2

sortir:
    mov rax, 60
    syscall