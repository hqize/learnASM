DATA SEGMENT
	mess db 'ChangE 00000001$'
DATA ENDS
EXT SEGMENT                  ;定义额外段存放目标串
	buff db 20 DUP(?)        ;空格和美元符号$都占一个字节
EXT ENDS
CODE SEGMENT
ASSUME CS:CODE, DS:DATA, ES:EXT
start:
	mov ax, DATA                 ;赋地址段
	mov ds, ax
	mov ax, EXT                  ;赋段地址
	mov es, ax
	
	lea si, mess                 ;赋偏移地址
	lea di, buff
	mov cx, 20                   ;串长
	cld                          ;设置DF的方向
	rep movsb                    ;完成串传送
	mov bx, es                   ;准备显示buff字符串
	mov ds, bx                   ;ds:dx指向待显示串的地址
	lea dx, buff
	mov ah, 09h
	int 21h
	mov ah, 4ch
	int 21h
	
	
CODE ENDS
END start
