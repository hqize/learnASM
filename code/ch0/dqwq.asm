data segment
    result db ?          ; 保存结果
data ends

code segment
assume cs:code, ds:data

start:
    mov ax, data
    mov ds, ax

    mov al, 1
    add al, 1
    mov result, al

    ; 转成字符显示
    add al, 30h
    mov dl, al
    mov ah, 02h
    int 21h

    mov ax, 4C00h
    int 21h

code ends
end start
