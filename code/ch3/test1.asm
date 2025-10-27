	;从键盘输入一位十六进制数，并将其转换为十进制数显示输出
CODE SEGMENT
ASSUME CS:CODE
START:
	MOV AH, 1H                   ;准备键盘输入
	INT 21H                      ;调用DOS中断
    CALL NEWLINE                 ;换行显示输入结果
	
	CMP AL, 30H                  ;比较是否小于'0'
	JL EXIT                      ;非法输入，退出
	CMP AL, 39H                  ;比较是否大于'9'
	JLE dig                      ;输入是0~9之间的数字，跳转处理

	CMP AL, 41H                  ;比较是否小于'A'
	JL EXIT                      ;非法输入，退出
	CMP AL, 46H                  ;比较是否大于'F'
	JLE print                    ;输入是A~F之间的字母，跳转处理
	
	CMP AL, 61H                  ;比较是否小于'a'
	JL EXIT                      ;非法输入，退出
	CMP AL, 66H                  ;比较是否大于'f'
	JG EXIT                      ;非法输入，退出
	
	SUB AL, "1"					 ;将小写字母'a'~'f'转换为对应数值
	JMP out1
print:
	SUB AL, 11H                  ;将大写字母'A'~'F'转换为对应数值
	
out1:
	MOV DL, 31H					;02H会显示dl中的字符
	MOV AH, 02H
	PUSH AX
	INT 21H                      ;十位显示1
	POP AX
	
dig:
	MOV DL, AL
	MOV AH, 02H
	INT 21H                      ;显示十进制数
	
EXIT:
	MOV AH, 4CH
	INT 21H                      ;退出程序

; 换行子程序
NEWLINE PROC
    PUSH AX
    PUSH DX

    MOV DL,0DH        ; 回车
    MOV AH, 02H		   
    INT 21H

    MOV DL, 0AH        ; 换行
    MOV AH, 02H
    INT 21H
	
    POP DX
    POP AX
    RET
NEWLINE ENDP
CODE ENDS
	END START
