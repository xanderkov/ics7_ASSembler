PUBLIC move_three

CSEG SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSEG

move_three proc near
	mov 	dh, ds:7
	sub		dh, 48
	add		dh, ds:6
	mov 	ds:6, dh
	ret
move_three endp

CSEG ENDS
END