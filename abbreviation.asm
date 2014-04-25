data segment
str dw 80
    dw 0
    dw 80 dup (?)
msg dw 80
	dw 0
	dw 80 dup(?)
jugaad db '$'
data ends

code segment
assume cs:code,ds:data
start:  mov ax,data
        mov ds,ax
		
		mov dx,offset str
        mov ah,0Ah
        int 21h
		
		mov cx,0ffh
		lea si,str+2
		lea di,msg+2
		mov bl,[si]
		mov [di],bl
		inc si
		inc di
		up:
		mov al,[si]
		cmp al,20h
		je put
		return:inc si
		dec cx
		cmp cx,00h
		jne up
		jmp print
		put:
		inc si
		mov bl,[si]
		mov [di],bl
		inc di
		jmp return
		print:
		
		mov dl,0ah
		mov ah,02h
		int 21h
		
		mov dx,offset msg
		mov ah,09h
		int 21h
		
		mov ah,4ch
		int 21h
		
code ends
end start
