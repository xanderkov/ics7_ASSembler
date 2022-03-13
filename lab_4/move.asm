PUBLIC move_three
EXTRN X: byte

DS2 SEGMENT AT 0b800h

DS2 ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSEG, ES:DS2
move_three proc near
	ret
move_three endp
CSEG ENDS
END