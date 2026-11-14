section .bss
    buf resb 1048577

section .text
    global _start

_start:
    mov r12, 0

lecture:
    mov rax, 0
    mov rdi, 0
    mov rsi, buf
    add rsi, r12
    mov rdx, 1048577
    sub rdx, r12
    syscall

    cmp rax, 0
    jl exit1
    je traitement

    add r12, rax
    cmp r12, 1048576
    ja exit1
    jmp lecture

traitement:
    cmp r12, 0
    je ecrire

    mov rsi, buf
    mov rdi, buf
    add rdi, r12
    cmp byte [rdi - 1], 10
    jne inverser
    dec rdi
    dec r12

inverser:
    dec rdi

boucle:
    cmp rsi, rdi
    jae ecrire
    mov al, [rsi]
    mov dl, [rdi]
    mov [rsi], dl
    mov [rdi], al
    inc rsi
    dec rdi
    jmp boucle

ecrire:
    mov byte [buf + r12], 10
    inc r12
    mov rsi, buf
    mov rdx, r12
    mov rax, 1
    mov rdi, 1
    syscall

    mov rdi, 0
    jmp sortir

exit1:
    mov rdi, 1

sortir:
    mov rax, 60
    syscall