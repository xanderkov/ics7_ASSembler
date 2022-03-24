; прямоугольная цифровая матрица
; удваинвание четных элементов и утраивание нечентных.
; Вывести только последние цифры новых значений


PUBLIC N
PUBLIC M
PUBLIC MATRIX
PUBLIC DECR

EXTRN newline: near
EXTRN print_matrix: near
EXTRN print_space: near

STACKSEG SEGMENT PARA STACK 'STACK'
    DB 200 DUP(0)
STACKSEG ENDS
SEGDATA SEGMENT PARA COMMON 'DATA'
    input_msg1 db 'Enter matrix rows and columns: $'
    input_msg2 DB 'Enter matrix:$'
    N DB 1
    M DB 1
    MATRIX db 200 DUP("0")
    DECR DW 0
    error_msg1 db 'Input not a number!$'
SEGDATA ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSEG, DS:SEGDATA, SS:STACKSEG


multiply_even:

    ja go_back
multiply_odd:
    
    ja go_back
main:
    MOV AX, SEGDATA
    MOV DS, AX

    ; Вывод приглашения о вводе
    MOV AH, 9
    MOV DX, OFFSET input_msg1
    INT 21H

    ; Ввоод размеров матрицы с проверкаой
    MOV AH, 1
    INT 21H
    MOV N, AL
    SUB N, "0"

    SUB AL, "0"
    CMP AL, 10

    JA  print_error

    CALL print_space

    mov ah, 1
    INT 21H
    MOV M, AL
    SUB M, "0"

    SUB AL, "0"
    CMP AL, 10
    JA  print_error

    call newline
    ; Вывод пригашения о вводе матрицы
    MOV AH, 9
    MOV DX, OFFSET input_msg2
    INT 21H

    call newline

    MOV AL, N
    MUL M
    MOV CX, AX

    MOV SI, 0

    MOV BX, 0
    MOV CL, N
    INMAT:
        MOV CL, M 
        INROW:
            MOV AH, 1
            INT 21H
            MOV MATRIX[BX], AL
            INC BX 
            CALL PRINT_SPACE
            LOOP INROW
        CALL newline
        MOV CL, N 
        SUB CX, SI 
        INC si 
        LOOP INMAT

    call newline
    call print_matrix


    MOV SI, 0
    MOV BX, 0
    MOV CL, N
    CHANGEMAT:
        MOV CL, M 
        CHANGEROW:
            mov ax, MATRIX[BX]

            mov bl, 2
            div bl

            cmp ah, 0
            je multiply_even
            cmp ah, 1
            je multiply_odd

            go_back:
            INC BX 
            LOOP CHANGEROW
        CALL newline
        MOV CL, N 
        SUB CX, SI 
        INC si 
        LOOP CHANGEMAT

    jmp end_programm

print_error:
    call newline
    mov ah, 09h
    mov dx, offset error_msg1
    int 21h
    jmp end_programm
    
end_programm:
    mov ax, 4c00h
    int 21h

CSEG ENDS

END main