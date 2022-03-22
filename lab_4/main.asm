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
	input DB 	10, 0
	output db 10 DUP('$')
SEGDATA ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSEG, DS:SEGDATA, SS:STACKSEG
main:
	mov 	ax, SEGDATA
	mov 	ds, ax

	mov		ah, 0Ah
	mov		dx, offset input
	int 	21h
	call 	move_three	
	mov		dx, 0
	mov		ah, 9
	int 	21h
	mov AH, 7
    INT 21h
	mov 	ax, 4c00h
	int 	21h
CSEG ENDS

END main