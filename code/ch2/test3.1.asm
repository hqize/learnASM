;计算表达式：(V-(X*Y+Z-16))/X
;其中：X=4, Y=2, Z=14H(20), V=18H(24)
;最终结果：AX = 3

DATA SEGMENT
    X DW 4          ;X = 4
    Y DW 2          ;Y = 2
    Z DW 14H        ;Z = 20（16进制14H）
    V DW 18H        ;V = 24（16进制18H）
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
    
START:
    ;初始化数据段
    MOV AX, DATA
    MOV DS, AX
    
    ;========== 第1步：计算 X*Y ==========
    MOV AX, X       ;AX = 4
    IMUL Y          ;DX:AX = 4*2 = 8，即 DX=0, AX=8（有符号乘法，结果在DX:AX）
    MOV CX, AX      ;CX = 8（保存低16位）
    MOV BX, DX      ;BX = 0（保存高16位）
    ;现在 BX:CX = 8（32位结果，高位在BX，低位在CX）
    
    ;========== 第2步：加上 Z ==========
    MOV AX, Z       ;AX = 20
    CWD             ;将AX扩展为32位（DX:AX），DX自动为0
    ADD CX, AX      ;CX = 8 + 20 = 28（低16位加法）
    ADC BX, DX      ;BX = 0 + 0 = 0（带进位的高16位加法）
    ;现在 BX:CX = 28，即 X*Y+Z = 28
    
    ;========== 第3步：减去 16 ==========
    SUB CX, 16      ;CX = 28 - 16 = 12（低16位减法）
    SBB BX, 0       ;BX = 0 - 0 = 0（带借位的高16位减法）
    ;现在 BX:CX = 12，即 X*Y+Z-16 = 12
    
    ;========== 第4步：计算 V - (X*Y+Z-16) ==========
    MOV AX, V       ;AX = 24
    CWD             ;DX:AX = 24（扩展为32位）
    SUB AX, CX      ;AX = 24 - 12 = 12（低16位减法）
    SBB DX, BX      ;DX = 0 - 0 = 0（带借位的高16位减法）
    ;现在 DX:AX = 12，即 V-(X*Y+Z-16) = 12
    
    ;========== 第5步：除以 X ==========
    IDIV X          ;DX:AX / X = 12 / 4
                    ;商在 AX = 3
                    ;余数在 DX = 0
    ;最终结果：AX = 3
    INT 3           ; 调试中断
    ;程序结束
    MOV AH, 4CH     ;DOS退出功能号
    INT 21H         ;调用DOS中断退出
    
CODE ENDS
END START