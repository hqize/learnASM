Data segment
    String db 'I love China!$'
Data ends
code segment
assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    mov dx,offset String
    mov ah,09h
    int 21h
    int 3 ; 调试中断
    mov ah,4ch
    int 21h
code ends
end start