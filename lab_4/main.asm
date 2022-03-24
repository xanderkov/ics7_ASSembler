;из двух модулей, в которых объявить по сегменту кода, которые
;должны объединяться в единый. В первом ввести строку
;чередующихся символов и цифр вида СЦСЦСЦСЦ, во втором -
;сдвинуть 3-й символ на количество позиций алфавита, равное
;значению следующей за ним цифры.


EXTRN move_three: near

STACKSEG SEGMENT PARA STACK 'STACK'
    DB 10h DUP(0)
STACKSEG ENDS

SEGDATA SEGMENT PARA COMMON 'DATA'
	DB 	10
SEGDATA ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSEG, DS:SEGDATA, SS:STACKSEG
main:
	mov 	ax, SEGDATA
	mov 	ds, ax

	mov		ah, 0Ah
	mov		dx, 0
	int 	21h
	mov		bx, dx
	mov		cl, [bx]+1
	mov 	dh, '$'
	mov 	ds:10, dh
	call 	move_three	
	mov		dx, 0
	mov		ah, 9
	int 	21h
	mov 	AH, 7
    INT 	21h
	mov 	ax, 4c00h
	int 	21h
CSEG ENDS

END main