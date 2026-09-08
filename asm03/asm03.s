section .text
global _start
_start:
    

    cmp qword [rsp], 2
    mov rsi, [rsp+16]
    
    mov al, [rsi]
    cmp al, '4'
    jne exit1
    
    mov al, [rsi+1]
    cmp al, '2'
    jne exit1
    
    mov al, [rsi+2]
    cmp al, 0
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



 