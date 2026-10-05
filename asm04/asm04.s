section .bss
    buf resb 64

section .text
    global _start

_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, buf
    mov rdx, 32
    syscall

    cmp rax, 0
    jle pas_un_nombre

    mov rsi, buf
    cmp byte [rsi], '-'
    jne apres_signe
    inc rsi

apres_signe:
    mov rbx, rsi

boucle:
    mov al, [rsi]

    cmp al, 10
    je fin
    cmp al, 0
    je fin

    cmp al, '0'
    jb pas_un_nombre
    cmp al, '9'
    ja pas_un_nombre

    inc rsi
    jmp boucle

fin:
    cmp rsi, rbx
    je pas_un_nombre

    mov al, [rsi - 1]
    test al, 1
    jz pair

impair:
    mov rdi, 1
    jmp sortir

pair:
    mov rdi, 0
    jmp sortir

pas_un_nombre:
    mov rdi, 2

sortir:
    mov rax, 60
    syscall