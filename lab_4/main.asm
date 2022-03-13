;из двух модулей, в которых объявить по сегменту кода, которые
;должны объединяться в единый. В первом ввести строку
;чередующихся символов и цифр вида СЦСЦСЦСЦ, во втором -
;сдвинуть 3-й символ на количество позиций алфавита, равное
;значению следующей за ним цифры.


EXTRN output_X: near

STK SEGMENT PARA STACK 'STACK'
	db 100 dup(0)
STK ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSEG, DS:DSEG, SS:STK
main:
	mov ax, DSEG
	mov ds, ax

	call output_X	

	mov ax, 4c00h
	int 21h
CSEG ENDS


END main