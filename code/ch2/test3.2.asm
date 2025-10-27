;计算表达式：((V+Z)*(X-Y)-16)/X
;其中：X=4, Y=2, Z=14H(20), V=18H(24)
;计算过程：
;  V+Z = 24+20 = 44
;  X-Y = 4-2 = 2
;  44*2 = 88
;  88-16 = 72
;  72/4 = 18
;最终结果：RESULT = 18

DATA SEGMENT
    X DW 4           ;X = 4
    Y DW 2           ;Y = 2
    Z DW 14H         ;Z = 20（16进制）
    V DW 18H         ;V = 24（16进制）
    ORG 200H
    RESULT DW ?      ;用于存储计算结果
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
    
START:
    ;初始化数据段
    MOV AX, DATA
    MOV DS, AX
    
    ;========== 第1步：计算 V+Z ==========
    MOV AX, V        ;AX = V (24)
    ADD AX, Z        ;AX = V + Z (24 + 20 = 44)
    ;现在 AX = 44
    
    ;========== 第2步：计算 X-Y ==========
    MOV BX, X        ;BX = X (4)
    SUB BX, Y        ;BX = X - Y (4 - 2 = 2)
    ;现在 BX = 2
    
    ;========== 第3步：计算 (V+Z)*(X-Y) ==========
    MUL BX           ;DX:AX = AX * BX = 44 * 2 = 88
                     ;注意：MUL 使用 AX 和 BX，结果在 DX:AX
                     ;DX = 0（高32位）, AX = 88（低32位）
    ;现在 DX:AX = 88
    
    ;========== 第4步：计算 (V+Z)*(X-Y)-16 ==========
    SUB AX, 16       ;AX = 88 - 16 = 72（低32位减法）
    SBB DX, 0        ;DX = 0 - 0 = 0（带借位的高32位减法，处理借位情况）
    ;现在 DX:AX = 72
    
    ;========== 第5步：计算 ((V+Z)*(X-Y)-16)/X ==========
    MOV BX, X        ;BX = 4（除数）
    DIV BX           ;DX:AX / BX
                     ;商存在 AX (72/4 = 18)
                     ;余数存在 DX (72%4 = 0)
    
    ;========== 第6步：存储结果 ==========
    MOV RESULT, AX   ;RESULT = 18（保存商到结果变量）
    INT 3            ; 调试中断
    
    ;程序结束
    MOV AH, 4CH      ;DOS程序结束功能号
    INT 21H          ;调用DOS中断退出

CODE ENDS
END START