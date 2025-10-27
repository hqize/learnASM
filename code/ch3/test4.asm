DATA SEGMENT
	MSG1 DB 'P1', 0AH, 0DH, '$'
	MSG2 DB 'P2', 0AH, 0DH, '$'
	MSG3 DB 'P3', 0AH, 0DH, '$'
	MSG4 DB 'P4', 0AH, 0DH, '$'
	MSG5 DB 'P5', 0AH, 0DH, '$'
	MSG6 DB 'P6', 0AH, 0DH, '$'
	MSG7 DB 'P7', 0AH, 0DH, '$'
	MSG8 DB 'P8', 0AH, 0DH, '$'
	
	PTABLE DW P1, P2, P3, P4, P5, P6, P7, P8    ;跳转表
DATA ENDS	
CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
START:
	MOV AX, DATA
	MOV DS, AX
	
	; 读取键盘输入（字符）
	MOV AH, 01H
	INT 21H                      ; AL = ASCII of '1' to '8'
	
	CMP AL, '1'
	JB EXIT                      ; 小于 '1'，退出
	CMP AL, '8'
	JA EXIT                      ; 大于 '8'，退出
	
	SUB AL, '0'                  ; 转为数字 1~8
	DEC AL                       ; 转为索引 0~7
	
	MOV AH, 0                    ; 清高字节
	SHL AX, 1                    ; AX = index * 2
	MOV SI, AX                   ; SI = 偏移量
	
	; 间接跳转：跳转到 PTABLE[SI] 指向的地址
	JMP PTABLE[SI]
	
P1:
	LEA DX, MSG1
	JMP DISPLAY
P2:
	LEA DX, MSG2
	JMP DISPLAY
P3:
	LEA DX, MSG3
	JMP DISPLAY
P4:
	LEA DX, MSG4
	JMP DISPLAY
P5:
	LEA DX, MSG5
	JMP DISPLAY
P6:
	LEA DX, MSG6
	JMP DISPLAY
P7:
	LEA DX, MSG7
	JMP DISPLAY
P8:
	LEA DX, MSG8
	JMP DISPLAY
	
DISPLAY:
	MOV AH, 09H
	INT 21H
	
EXIT:
	MOV AH, 4CH
	INT 21H
	
CODE ENDS
	 END START
