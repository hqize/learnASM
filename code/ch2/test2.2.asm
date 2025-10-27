DATA SEGMENT
	mess1 db 'ChangE 00000001$'
	mess2 db 'HouYi 00000001$'
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE, DS:DATA
start:
	mov ax, DATA                 ; 把数据段地址加载到AX
	mov ds, ax                   ; DS指向数据段（数据段寄存器）
	mov es, ax                   ; ES指向数据段（额外段寄存器）
	
    lea si, mess1                ; SI指向第一个字符串的起始地址
	lea di, mess2                ; DI指向第二个字符串的起始地址
	
	mov cx, 20                   ; 设置比较字节数为20
	cld                          ; 清除方向标志（正向比较，地址递增）
	
    repe cmpsb                   ; 重复比较字节
	                             ; repe = repeat while equal
	                             ; cmpsb = compare string byte
	                             ; 作用：比较DS:[SI]和ES:[DI]的内容
	                             ; 如果相等则继续，不相等则停止
	
	
	jz YES                       ; 如果ZF标志=1（相等），跳转到YES
	mov dl, 'N'                  ; 否则设置DL='N'（不相等）
	jmp DISP
YES:
	mov dl, 'Y'                  ; 相等则设置DL='Y'
DISP:
	mov ah, 02h                  ; 02号功能：显示单个字符
    int 21h                      ; 显示DL中的字符

	mov ah, 4ch
	int 21h
CODE ENDS
END start
