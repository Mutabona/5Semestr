org 100h

start:
    ; Calculate X = 3 * (A - 2 * B) + 50 - C / 2
    mov dx, a    ; DX = A
    shl b, 1     ; B = 2 * B
    sub dx, b    ; DX = A - 2 * B
    mov ax, dx    ; AX = A - 2 * B
    mov dx, 3
    imul dx   ; AX = 3 * (A - 2 * B)
    add ax, 50    ; AX = 3 * (A - 2 * B) + 50
    mov dx, c    ; DX = C
    shr dx, 1     ; DX = C / 2
    sub ax, dx    ; AX = 3 * (A - 2 * B) + 50 - C / 2

    ; Store result in memory for further use if needed
    mov result, ax

    ; Exit program
    mov ax, 4C00h
    int 21h

result dw 0 
a dw 1
b dw 2
c dw 2