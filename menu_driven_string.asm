data segment
msg1 db 'Enter the string:- $'
str db 80
    db 0
    db 80 dup (?)
msg2 db 'Number of vowels:- $'
msg3 db 'Palindrome$'
msg4 db 'Not Palindrome$'
msg5 db '1.Number of vowels 2.Check Palindrome Enter your choice:- $'
data ends

extra segment
rev db 80 dup (?)
extra ends

code segment
assume cs:code,ds:data,es:extra
start:  mov ax,data
        mov ds,ax
		
        mov ax,extra
        mov es,ax
		
        lea dx,msg1
        mov ah,09h
        int 21h
		
        lea dx,str
        mov ah,0Ah
        int 21h
		
        mov ah,02h
        mov dl,0Ah
        int 21h
		
        lea dx,msg5
        mov ah,09h
        int 21h
		
        mov ah,01h
        int 21h
		
        cmp al,31h
        je vwlcnt
        cmp al,32h
        je palchk
        jmp toend

vwlcnt: mov ah,02h
        mov dl,0Ah
        int 21h
		
        mov ah,09h
        lea dx,msg2
        int 21h
		
        lea si,str
        inc si
        mov cl,[si]
        inc si
        mov bl,00h
        cld
vcnt:   mov bh,61h
        cmp [si],bh
        je cnt
        mov bh,65h
        cmp [si],bh
        je cnt
        mov bh,69h
        cmp [si],bh
        je cnt
        mov bh,6Fh
        cmp [si],bh
        je cnt
        mov bh,75h
        cmp [si],bh
        je cnt
        jmp nxt
cnt:    inc bl
nxt:    inc si
        loop vcnt
        cmp bl,09h
        jg crct
        add bl,30h
        mov dl,bl
        mov ah,02h
        int 21h
        jmp toend
crct:   add bl,06h
        mov cx,0000h
        mov cl,bl
        and bl,0Fh
        and cl,0F0h
        rol cl,01
        rol cl,01
        rol cl,01
        rol cl,01
        add cl,30h
        add bl,30h
        mov ah,02h
        mov dl,cl
        int 21h
        mov dl,bl
        int 21h
        jmp toend

palchk: mov ah,02h
        mov dl,0Ah
        int 21h
        mov cx,0000h
        lea si,str
        inc si
        mov cl,[si]
        inc si
        lea di,rev
        mov al,00h
        add si,cx
        inc cl
cpy:    std
        lodsb
        cld
        stosb
        loop cpy
        mov cl,[si]
        cld
        inc si
        sub di,cx
pchk:   cmpsb
        jne npal
        loop pchk
        mov ah,09h
        lea dx,msg3
        int 21h
        jmp toend
npal:   mov ah,09h
        lea dx,msg4
        int 21h

toend:  mov ah,4ch
        int 21h
code ends
end start

