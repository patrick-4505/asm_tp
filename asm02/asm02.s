section .text
global _start
_start:
    mov rax, 0          
    mov rdi, 0          
    lea rsi, [buff]
    mov rdx, 4096
    syscall

    cmp byte [buff], '4'
    jne exit1
    
    cmp byte [buff+1], '2'
    jne exit1
    
    cmp byte [buff+2], 10
    jne exit1
    
    mov rax, 1
    mov rdi, 1     
    mov rsi, msg  
    mov rdx, 5
    syscall 

exit0:
    
    mov rax, 60
    mov rdi, 0
    syscall

exit1:
    mov rax, 60
    mov rdi, 1
    syscall


section .data
msg db '1337', 10

section .bss
buff: resb 4096


 