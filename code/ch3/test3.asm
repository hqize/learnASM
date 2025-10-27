;分离字数的正负数，分别存入不同数组，并统计正负数个数
DATA SEGMENT
    ARRARY DW 10, -1, 5, -6, 3, 8, -2, 7
    ARRLEN EQU ($ - ARRARY) / 2
    ORG 100H
    PDATA  DW 10 DUP (?)
    ORG 110H
    NDATA  DW 10 DUP (?)
    ORG 120H
    POSITIVE_COUNT DB 0
    NEGATIVE_COUNT DB 0
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
START:
    MOV AX, DATA
    MOV DS, AX

    MOV CX, ARRLEN         ; 循环次数 = 元素个数
    LEA SI, ARRARY         ; SI → 输入数组
    LEA DI, PDATA          ; DI → 正数数组
    LEA BX, NDATA          ; BX → 负数数组

COUNT_LOOP:
    MOV AX, [SI]           ; AX = 当前元素
    CMP AX, 0
    JL IS_NEGATIVE         ; 如果是负数，跳转到 IS_NEGATIVE

    ; 正数
    MOV [DI], AX
    ADD DI, 2
    INC POSITIVE_COUNT
    JMP NEXT

IS_NEGATIVE:
    MOV [BX], AX
    ADD BX, 2
    INC NEGATIVE_COUNT

NEXT:
    ADD SI, 2              ; 下一个输入元素
    LOOP COUNT_LOOP

    INT 3              ; 设置断点，调试时执行g命令会停在这里
    MOV AH, 4CH
    INT 21H
CODE ENDS
END START
