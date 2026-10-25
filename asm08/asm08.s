section .bss
    buf resb 64

section .text
    global _start

_start:
    cmp qword [rsp], 2
    jne exit2

    mov rsi, [rsp+16]
    mov rax, 0
    mov r8, 0

    cmp byte [rsi], '-'
    jne debut
    mov r8, 1
    inc rsi

debut:
    cmp byte [rsi], 0
    je exit1

boucle:
    movzx rcx, byte [rsi]
    cmp rcx, 0
    je fin
    cmp rcx, '0'
    jb exit1
    cmp rcx, '9'
    ja exit1
    sub rcx, '0'
    imul rax, rax, 10
    add rax, rcx
    inc rsi
    jmp boucle

fin:
    cmp r8, 1
    je zero
    cmp rax, 1
    jbe zero

    mov rbx, rax
    dec rbx
    imul rax, rbx
    shr rax, 1
    jmp afficher

zero:
    mov rax, 0

afficher:
    mov rdi, buf + 20
    mov byte [rdi], 10
    mov rcx, 10

boucle_aff:
    mov rdx, 0
    div rcx
    add dl, '0'
    dec rdi
    mov [rdi], dl
    cmp rax, 0
    jne boucle_aff

    mov rsi, rdi
    mov rdx, buf + 21
    sub rdx, rsi
    mov rax, 1
    mov rdi, 1
    syscall

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