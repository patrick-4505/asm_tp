section .data
    retour db 10

section .text
    global _start

_start:
    cmp qword [rsp], 2
    jne mauvais_arguments

    mov rsi, [rsp + 16]

    mov rdx, 0

longueur:
    cmp byte [rsi + rdx], 0
    je ecrire
    inc rdx
    jmp longueur


ecrire:
    mov rax, 1
    mov rdi, 1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, retour
    mov rdx, 1
    syscall

    mov rdi, 0
    jmp sortir

mauvais_arguments:
    mov rdi, 2

sortir:
    mov rax, 60
    syscall