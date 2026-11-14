section .bss
    buf resb 1024
    nombre resb 32

section .text
    global _start

_start:
    mov rbx, 0

lecture:
    mov rax, 0
    mov rdi, 0
    mov rsi, buf
    mov rdx, 1024
    syscall

    cmp rax, 0
    jl exit1
    je afficher

    mov r8, rax
    mov rsi, buf

boucle:
    movzx rcx, byte [rsi]
    cmp rcx, 'a'
    je voyelle
    cmp rcx, 'e'
    je voyelle
    cmp rcx, 'i'
    je voyelle
    cmp rcx, 'o'
    je voyelle
    cmp rcx, 'u'
    je voyelle
    jmp suivant

voyelle:
    inc rbx

suivant:
    inc rsi
    dec r8
    cmp r8, 0
    jne boucle
    jmp lecture

afficher:
    mov rax, rbx
    mov rdi, nombre + 20
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
    mov rdx, nombre + 21
    sub rdx, rsi
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