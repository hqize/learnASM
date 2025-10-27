CODE SEGMENT
    ASSUME CS:CODE
START:
    MOV BX,0FB32H 
    MOV CX,4    ;循环次数，4次
SHIFT:          ;循环左移四位
    ROL BX,1
    ROL BX,1
    ROL BX,1
    ROL BX,1

    MOV AL,BL
    AND AL,0FH  ;按位与，取低四位
    ADD AL,30H  ;转换为ASCII码
    
    CMP AL,39H  ;判断是否大于9
    JLE DIG     ;如果小于等于9，跳转输出
    ADD AL,07H  ;转换为A-F的ASCII码
DIG:
    MOV DL,AL
    MOV AH,02H
    INT 21H
    LOOP SHIFT
    
    MOV AH,4CH
    INT 21H
CODE ENDS
    END START   