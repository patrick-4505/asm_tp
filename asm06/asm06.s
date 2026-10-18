section .bss
    buf resb 64

section .text
    global _start

_start:
    cmp qword [rsp], 3
    jne exit2

    mov rsi, [rsp+16]
    call lire
    mov rbx, rax

    mov rsi, [rsp+24]
    call lire

    add rax, rbx
    jo exit1

    call afficher

    mov rdi, 0
    jmp sortir

lire:
    mov rax, 0
    mov r8, 0

    cmp byte [rsi], '-'
    jne lire_debut
    mov r8, 1
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
    jo exit1
    sub rax, rcx
    jo exit1
    inc rsi
    jmp lire_boucle

lire_fin:
    cmp r8, 1
    je lire_ok
    neg rax
    jo exit1

lire_ok:
    ret

afficher:
    mov rdi, buf + 20
    mov byte [rdi], 10
    mov r8, 0
    cmp rax, 0
    jge aff_suite
    mov r8, 1
    neg rax

aff_suite:
    mov rcx, 10

aff_boucle:
    mov rdx, 0
    div rcx
    add dl, '0'
    dec rdi
    mov [rdi], dl
    cmp rax, 0
    jne aff_boucle

    cmp r8, 1
    jne aff_ecrire
    dec rdi
    mov byte [rdi], '-'

aff_ecrire:
    mov rsi, rdi
    mov rdx, buf + 21
    sub rdx, rsi
    mov rax, 1
    mov rdi, 1
    syscall
    ret

exit2:
    mov rdi, 2
    jmp sortir

exit1:
    mov rdi, 1

sortir:
    mov rax, 60
    syscall