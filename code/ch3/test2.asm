; 输入小写转大写，输入大写转小写，其他字符原样输出
; 每次转换后换行，按回车键退出

DATA SEGMENT
    MSG_PROMPT  DB '=== Case Converter ===', 0DH, 0AH
                DB 'Press ENTER to exit', 0DH, 0AH, '$'
    MSG_INPUT   DB 'Input: $'
    MSG_OUTPUT  DB 'Output: $'
    MSG_EXIT    DB 'Goodbye!', 0DH, 0AH, '$'
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
    
START:
    MOV AX, DATA
    MOV DS, AX
    
    ; 显示提示信息
    MOV AH, 09H
    LEA DX, MSG_PROMPT
    INT 21H
    
INPUT_LOOP:
    ; 换行
    CALL NEWLINE
    
    ; 显示输入提示
    LEA DX, MSG_INPUT
    MOV AH, 09H
    INT 21H
    
    ; 键盘输入
    MOV AH, 01H
    INT 21H
    
    ; 检查是否按回车键退出
    CMP AL, 0DH              ; 回车键的ASCII码是0DH
    JE EXIT_PROGRAM
    
    ; 保存输入字符
    MOV BL, AL
    
    ; 检查是否为大写字母 A-Z
    CMP AL, 41H              ; 'A'
    JL NOT_LETTER
    CMP AL, 5AH              ; 'Z'
    JG CHECK_LOWER
    
    ; 是大写字母，转换为小写
    ADD AL, 20H
    JMP OUTPUT_RESULT
    
CHECK_LOWER:
    ; 检查是否为小写字母 a-z
    CMP AL, 61H              ; 'a'
    JL NOT_LETTER
    CMP AL, 7AH              ; 'z'
    JG NOT_LETTER
    
    ; 是小写字母，转换为大写
    SUB AL, 20H
    JMP OUTPUT_RESULT
    
NOT_LETTER:
    ; 非字母字符，保持不变
    ; AL中已经是原字符
    
OUTPUT_RESULT:
    ; 换行
    CALL NEWLINE
    
    ; 显示输出提示
    PUSH AX                  ; 保存转换后的字符
    LEA DX, MSG_OUTPUT
    MOV AH, 09H
    INT 21H
    POP AX                   ; 恢复转换后的字符
    
    ; 显示转换后的字符
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    
    ; 继续输入
    JMP INPUT_LOOP
    
EXIT_PROGRAM:
    ; 换行并显示退出信息
    CALL NEWLINE
    LEA DX, MSG_EXIT
    MOV AH, 09H
    INT 21H
    
    ; 退出程序
    MOV AH, 4CH
    INT 21H

; 换行子程序
NEWLINE PROC
    PUSH AX
    PUSH DX
    MOV DL, 0DH              ; 回车
    MOV AH, 02H
    INT 21H
    MOV DL, 0AH              ; 换行
    MOV AH, 02H
    INT 21H
    POP DX
    POP AX
    RET
NEWLINE ENDP

CODE ENDS
    END START