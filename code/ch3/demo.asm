;键盘输入1~4, 跳转到不同的分支
CODE SEGMENT
ASSUME CS:CODE, DS:CODE
START:
	MOV AX, CODE
	MOV DS, AX
	
	MOV AH, 01H                  ;键盘输入有回显
	INT 21H                      ;调用DOS中断
	
	CMP AL, 31H
	JL EXIT                      ;非法输入
	CMP AL, 34H
	JG EXIT                      ;非法输入
	
	MOV DL, AL                   ;放入dl, 带显示
	MOV BL, AL
	SUB BL, 31H                  ;转换ASCII码为数值
	
	SHL BL, 1                    ;乘2, 指向分支向量表中某地址
	
	MOV BH, 0
	JMP BRANCH[BX]               ;跳转到分支向量表
	
r1: MOV AH, 2
	INT 21H                      ;显示输入数字
	JMP EXIT
	
r2: MOV AH, 02H
	INT 21H                      ;显示输入数字
	JMP EXIT
	
r3: MOV AH, 02H
	INT 21H                      ;显示输入数字
	JMP EXIT
	
r4: MOV AH, 02H
	INT 21H                      ;显示输入数字
	JMP EXIT
	
EXIT: MOV AH, 4CH
	INT 21H
	
	BRANCH DW r1, r2, r3, r4
CODE ENDS
	END START
