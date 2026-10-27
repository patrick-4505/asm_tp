section .bss
    buf resb 128

section .text
    global _start

_start:
    mov rbx, 16
    mov rsi, [rsp+16]

    cmp qword [rsp], 2
    je lire
    cmp qword [rsp], 3
    jne exit2

    cmp byte [rsi], '-'
    jne exit2
    cmp byte [rsi+1], 'b'
    jne exit2
    cmp byte [rsi+2], 0
    jne exit2

    mov rbx, 2
    mov rsi, [rsp+24]

lire:
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
    cmp rax, 0
    jne convertir
    mov r8, 0

convertir:
    mov rdi, buf + 127
    mov byte [rdi], 10

boucle_conv:
    mov rdx, 0
    div rbx
    add dl, '0'
    cmp dl, '9'
    jbe stocker
    add dl, 7

stocker:
    dec rdi
    mov [rdi], dl
    cmp rax, 0
    jne boucle_conv

    cmp r8, 1
    jne ecrire
    dec rdi
    mov byte [rdi], '-'

ecrire:
    mov rsi, rdi
    mov rdx, buf + 128
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