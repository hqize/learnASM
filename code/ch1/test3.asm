Data segment
msg db 'hello world! my name is Lihua.$'
Data ends
code segment
assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    
    mov ah,09h
    lea dx, msg       ;offset获取字符串地址
    int 21h
     ; -------------------------
    ; 1. 直接寻址（Direct Addressing）
    mov dl, msg[25]      ; 第26个字符到 DL,注意这里标准风格是mov dl, [msg+25]
    
     ; 将 DL 内容输出（单字符）
    mov ah, 02h
    mov dl, dl
    int 21h ;显示的是Lihua中的i


    ; 2. 寄存器间接寻址
    mov bx, 25
    mov dh, [msg+bx]     ; 第26个字符到 DH

    ; 3. 基址加变址寻址（Base + Index）
    mov bx, 0
    mov si, 25
    mov bh, [bx+si+msg]  ; 第26个字符到 BH

    ; 4. 寄存器相对 BP 寻址（BP + displacement）
    mov bp, 0
    mov bl, [bp+msg+25]  ; 第26个字符到 BL

    ; 5. 立即偏移（Offset）寻址
    mov cl, [msg+25]     ; 第26个字符到 CL

    int 3 ; 调试中断
     ; 程序结束
    mov ah,4ch
    int 21h
code ends
end start