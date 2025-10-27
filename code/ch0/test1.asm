DATA SEGMENT
    ORG 0100H ;指定起始地址
    STRING DB 'abcddskfaofkg$' ;定义字符串
    MSG DB 0DH,0AH,'Result: $' ;存放结果
DATA ENDS
CODE SEGMENT
MAIN PROC FAR
    ASSUME CS:CODE,DS:DATA
    START:
        MOV AX,DATA
        MOV DS,AX
        
        ; 显示提示信息
        LEA DX,MSG
        MOV AH,09H
        INT 21H
        
        ; XLAT操作
        MOV BX,100H
        MOV AL,4
        XLAT
        
        ; 显示结果字符
        MOV DL,AL
        MOV AH,02H
        INT 21H
        
        ; 退出
        MOV AH,4CH
        INT 21H
MAIN ENDP
CODE ENDS
END START