PUBLIC newline
PUBLIC print_matrix
PUBLIC print_space

EXTRN N: BYTE
EXTRN M: BYTE
EXTRN MATRIX: BYTE
EXTRN DECR: BYTE

SEGDATA SEGMENT PARA COMMON 'DATA'
SEGDATA ENDS


CSEG SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:CSEG, DS:SEGDATA

newline proc near
    MOV AH, 2
    MOV DL, 10
    INT 21H
    MOV DL, 13
    INT 21H

    RET
newline endp

print_matrix proc near
    MOV si, 0
    MOV BX, 0 ; Array index.
    MOV CL, N ; Cycle index.
    OUTMAT:
        MOV CL, M 
        OUTROW:
            MOV DL, MATRIX[BX]
            MOV AH, 2
            INT 21H
            INC BX 
            CALL PRINT_SPACE
            LOOP OUTROW
        CALL newline
        MOV CL, N 
        SUB CX, SI 
        INC si 
        LOOP OUTMAT
    ret

print_matrix endp

print_space proc near

    MOV AH, 2
    MOV DL, " "
    INT 21H

    RET
print_space endp



CSEG ENDS
END