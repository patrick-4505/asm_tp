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
    jl exit2
    je traitement

    add r12, rax
    cmp r12, 1048576
    ja exit2
    jmp lecture

traitement:
    cmp r12, 0
    je palindrome

    mov rsi, buf
    mov rdi, buf
    add rdi, r12
    cmp byte [rdi - 1], 10
    jne comparer
    dec rdi

comparer:
    dec rdi

boucle:
    cmp rsi, rdi
    jae palindrome
    mov al, [rsi]
    mov dl, [rdi]
    cmp al, dl
    jne exit1
    inc rsi
    dec rdi
    jmp boucle

palindrome:
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