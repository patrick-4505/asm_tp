section .bss
    buf resb 64

section .text
    global _start

_start:
    cmp qword [rsp], 4
    jne exit2

    mov rsi, [rsp+16]
    call lire
    mov rbx, rax

    mov rsi, [rsp+24]
    call lire
    cmp rax, rbx
    cmovg rbx, rax

    mov rsi, [rsp+32]
    call lire
    cmp rax, rbx
    cmovg rbx, rax

    mov rax, rbx
    mov rdi, buf + 20
    mov byte [rdi], 10
    mov r8, 0
    cmp rax, 0
    jge positif
    mov r8, 1
    neg rax

positif:
    mov rcx, 10

boucle_aff:
    mov rdx, 0
    div rcx
    add dl, '0'
    dec rdi
    mov [rdi], dl
    cmp rax, 0
    jne boucle_aff

    cmp r8, 1
    jne ecrire
    dec rdi
    mov byte [rdi], '-'

ecrire:
    mov rsi, rdi
    mov rdx, buf + 21
    sub rdx, rsi
    mov rax, 1
    mov rdi, 1
    syscall

    mov rdi, 0
    jmp sortir

lire:
    mov rax, 0
    mov r8, 1

    cmp byte [rsi], '-'
    jne lire_debut
    mov r8, -1
    inc rsi

lire_debut:
    cmp byte [rsi], 0
    je exit1

lire_boucle:
    movzx rcx, byte [rsi]
    cmp rcx, 0
    je lire_fin
    cmp rcx, '0'
    jb exit1
    cmp rcx, '9'
    ja exit1
    sub rcx, '0'
    imul rax, rax, 10
    add rax, rcx
    inc rsi
    jmp lire_boucle

lire_fin:
    imul rax, r8
    ret

exit1:
    mov rdi, 1
    jmp sortir

exit2:
    mov rdi, 2

sortir:
    mov rax, 60
    syscall