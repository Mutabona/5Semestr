mvi h, 02H
mvi l, 00H

mvi b, 1EH ;Количество элементов

mvi m, 01H
inr l
mvi m, 05H
inr l
mvi m, 04H
inr l
mvi m, 06H
inr l
mvi m, 00H
inr l
mvi m, 01H
inr l
mvi m, 05H
inr l
mvi m, 04H
inr l
mvi m, 06H
inr l
mvi m, 00H
inr l
mvi m, 01H
inr l
mvi m, 05H
inr l
mvi m, 04H
inr l
mvi m, 06H
inr l
mvi m, 00H
inr l
mvi m, 01H
inr l
mvi m, 05H
inr l
mvi m, 04H
inr l
mvi m, 06H
inr l
mvi m, 00H
inr l
mvi m, 01H
inr l
mvi m, 05H
inr l
mvi m, 04H
inr l
mvi m, 03H
inr l
mvi m, 00H
inr l
mvi m, 02H
inr l
mvi m, 15H
inr l
mvi m, 11H
inr l
mvi m, F1H
inr l
mvi m, AAH

mvi h, 02H
mvi l, 00H

count:
	mov d, l
	mov l, m
	mvi h, 03H
	inr m
	mvi h, 02h
	mov l, d
	inr l
	dcr b
	jnz count

mvi h, 03H
mvi l, 00H
mov b, m
mvi e, 00H
mvi d, 00H
mvi a, FEH
mov c, l
jz sort

savel:
	mov d, l
write:
	mvi h, 04H
	mov l, e
	mov m, d
	inr e
	dcr b
	jnz write
	inr c

sort:
	mvi h, 03H
	mov l, c
	mov b, m
	inr b
	dcr b
	jnz savel
	inr c
	cmp c
	jnc sort

end:
hlt

