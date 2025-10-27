DATA SEGMENT
    MSG_INPUT DB 'INPUT: $'
    MSG_OUTPUT DB 09H,'Output: $'
    MSG_ERROR DB 09H,'Error: Invalid input! Please enter only 0 or 1.$'
    NEWLINE DB 0DH,0AH,'$'
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX

INPUT:
    MOV BX,0
    MOV CX,7

    LEA DX,MSG_INPUT
    MOV AH,09H
    INT 21H

INLOG:
    MOV AH,01H
    INT 21H

    CMP AL,0DH          ; 检查是否按下回车
    JE EXIT          ; 如果按回车，则退出输入

    CMP AL,30H          ; 检查是否小于'0'
    JB INVALID_INPUT    ; 无效输入，重新开始
    CMP AL,31H          ; 检查是否大于'1'
    JA INVALID_INPUT    ; 无效输入，重新开始

    SUB AL,30H          ; 转换为数字
    SHL BL,1            ; 左移一位
    ADD BL,AL           ; 添加当前位
    LOOP INLOG          ; 继续下一位

DISPLAY:
    LEA DX,MSG_OUTPUT
    MOV AH,09H
    INT 21H

    MOV AH,02H
    MOV DL,BL
    INT 21H

    LEA DX,NEWLINE
    MOV AH,09H
    INT 21H

    JMP INPUT

INVALID_INPUT:
    LEA DX,NEWLINE
    MOV AH,09H
    INT 21H

    LEA DX,MSG_ERROR    ; 显示错误信息
    MOV AH,09H
    INT 21H

    LEA DX,NEWLINE
    MOV AH,09H
    INT 21H

    JMP INPUT           ; 重新开始输入

EXIT:
    MOV AH,4CH
    INT 21H

CODE ENDS
    END START