data segment
    ORG 0009H            ; 设置数据段起始地址为0009H
    result db ?   ;将结果存放在数据段的第10个字节开始的位置
data ends

code segment
    assume cs:code, ds:data
start:
    mov ax, data          ; 将数据段地址装入 DS
    mov ds, ax          ; 初始化数据段
    
    ; 接收第一个数字字符
    mov ah, 01h         ; 功能号：读取字符
    int 21h
    sub al, '0'         ; 将ASCII码转换为数字值
    mov bl, al          ; 暂时保存到BL
    
    ; 接收第二个数字字符  
    mov ah, 01h
    int 21h
    sub al, '0'         ; 将ASCII码转换为数字值
    
    ; 求和
    add bl, al          ; BL = 第一个数字 + 第二个数字
    
    ; 将结果保存到数据段第10个字节开始的位置
    mov result, bl
    int 3 ; 调试中断
    
    ; 程序结束
    mov ah, 4ch
    int 21h
code ends
end start