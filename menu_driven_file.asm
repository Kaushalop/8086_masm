data segment
msg1 db 'C:\two.txt',0
str db 80
	db 0
	db 80 dup(?)
str1 db 80
		db 0
		db 80 dup(?)
jugaad db '$'
msg db 'Enter 1.Write in a file 2.Read a file','$'
fhandle dw ?
msg2 db 'Enter String:-','$'
msg3 db 'Hi$'
len dw $-msg3
data ends

code segment
assume cs:code,ds:data
start:mov ax,data
	mov ds,ax

	
	
	mov dl,0ah        ;print enter
	mov ah,02h
	int 21h
	
	lea dx,msg2			;print for input
	mov ah,09h
	int 21h
	
	lea dx,str			;Input String
	mov ah,0ah
	int 21h
	
	mov dl,0ah        ;print enter
	mov ah,02h
	int 21h
	
	lea dx,msg			;print for options
	mov ah,09h
	int 21h
	
						
	mov ah,01h			;Input String
	int 21h
	
	cmp al,31h
	je write
	cmp al,32h
	je read
	cmp al,33h
	je append
	jmp exit
	
	write:
	
	mov cx,0000h    ;create
	mov dx,offset msg1
	mov ah,3ch
	int 21h
	
	mov bx,ax 		;move the file handle safely
	mov fhandle,ax
	
	
	mov dx,offset str+2
	mov cx,offset str+1
	add cx,30h
	;mov dx,offset msg3
	mov ah,40h
	int 21h
	
	jmp exit
	
	read:
	
	mov dx,offset msg1
		mov al,00h
		mov ah,3dh
		int 21h
		mov fhandle,ax
	
	mov bx,fhandle
	mov dx,offset str1+2
	mov cx,offset str+1
	mov ah,3fh
	int 21h
	
	mov dl,0ah        ;print enter
	mov ah,02h
	int 21h
	
	lea dx,str1			;print from file
	mov ah,09h
	int 21h
	jmp exit
	
	append:
	
		mov dx,offset msg1
		mov al,00h
		mov ah,3dh
		int 21h
		mov fhandle,ax
		mov bx,fhandle
		mov cx,0000h
        mov dx,0000h
        mov al,02h
        mov ah,42h
        int 21h         ;seek
		
        lea si,str+1
        mov cx,0000h
        mov cl,[si]
        lea dx,str+2
        mov ah,40h
        int 21h     
	
	exit:mov ah,4ch
		int 21h
		
		code ends
		end start
	
	
	
	
