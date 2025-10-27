Data Segment
    numA1 DW 5678H      ; 数字A的高位字
    numA2 DW 7890H      ; 数字A的低位字  
    numB1 DW 1234H      ; 数字B的高位字
    numB2 DW 3456H      ; 数字B的低位字
    org 100H
    result DD ?         ; 结果
Data Ends

Code Segment
    ASSUME CS:Code, DS:Data
Start:  
    MOV AX, Data             
    MOV DS, AX

    ; 加载数字
    MOV AX, numA2        ; 加载数字A的低位字
    MOV DX, numA1        ; 加载数字A的高位字  
    MOV CX, numB2        ; 加载数字B的低位字
    MOV BX, numB1        ; 加载数字B的高位字
    
    ; 32位加法
    SUB AX, CX           ; AX = A低 + B低
    SBB DX, BX           ; DX = A高 + B高 + 进位
    
    ; 存储结果
    MOV word ptr result, AX     ; 存储结果的低位字
    MOV word ptr result+2, DX   ; 存储结果的高位字
    INT 3               ; 调试中断

     ; 结束程序
    MOV AX, 4C00H
    INT 21H

        
Code Ends
END Start