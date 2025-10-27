data segment
    ORG 0016h            ; 设置数据段起始地址为0016H
    result dw ?           ; 定义一个存放结果的变量（位置假设为0016H）
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data          ; 将数据段地址装入 DS
    mov ds, ax

    mov ax, 0038h         ; AX ← 0038H
    mov bx, 0010h         ; BX ← 0010H
    sub ax, bx            ; AX ← AX - BX = 0038H - 0010H = 0028H

    mov result, ax       ; 把 AX 中的结果写入resullt
    
    int 3 ; 调试中断
    mov ah, 4ch           ; 返回 DOS
    int 21h
code ends
end start
