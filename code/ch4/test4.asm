DATA SEGMENT
    PROMPT DB 'Input: $'
    RESULT DB 0DH, 0AH, 'Binary: $'
    HEX_NUM DW 0        ; 存储转换后的十六进制数
    BIN_STR DB 16 DUP('0'), '$'  ; 存储二进制字符串
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
    
START:
    MOV AX, DATA
    MOV DS, AX
    
    ; 显示提示信息
    LEA DX, PROMPT
    MOV AH, 09H
    INT 21H
    
    ; 输入4个十六进制字符
    MOV CX, 4           ; 循环4次
    MOV BX, 0           ; BX用于累积结果
    
INPUT_LOOP:
    MOV AH, 01H         ; 键盘输入一个字符
    INT 21H
    
    ; 将BX左移4位，为新的十六进制位腾出空间
    SHL BX, 1
    SHL BX, 1
    SHL BX, 1
    SHL BX, 1
    
    ; 判断输入字符是数字还是字母
    CMP AL, '9'
    JBE IS_DIGIT        ; 如果 <= '9'，是数字
    
    ; 是字母A-F
    SUB AL, 'A'         ; 'A' -> 0, 'B' -> 1, ...
    ADD AL, 10          ; 转换为10-15
    JMP ADD_TO_BX
    
IS_DIGIT:
    SUB AL, '0'         ; '0' -> 0, '1' -> 1, ...
    
ADD_TO_BX:
    OR BL, AL           ; 将当前位加入BX的低4位
    LOOP INPUT_LOOP
    
    ; 将结果保存
    MOV HEX_NUM, BX
    
    ; 显示结果提示
    LEA DX, RESULT
    MOV AH, 09H
    INT 21H
    
    ; 将十六进制数转换为二进制字符串
    MOV CX, 16          ; 16位二进制
    LEA DI, BIN_STR     ; DI指向二进制字符串
    MOV BX, HEX_NUM
    
CONVERT_LOOP:
    SHL BX, 1           ; 左移一位，最高位进入CF
    JB SET_ONE          ; 如果CF=1，设置为'1'
    
    MOV BYTE PTR [DI], '0'
    JMP NEXT_BIT
    
SET_ONE:
    MOV BYTE PTR [DI], '1'
    
NEXT_BIT:
    INC DI
    LOOP CONVERT_LOOP
    
    ; 显示二进制字符串
    LEA DX, BIN_STR
    MOV AH, 09H
    INT 21H
    
    ; 程序结束
    MOV AH, 4CH
    INT 21H
    
CODE ENDS
    END START