global mouse
global printf
global setdta
global ffile

group dgroup
section code

mouse:
	push bp
	mov bp,sp
	mov ax,[bp+12]
	int 33h
	mov si,[bp+10]
	mov [si],bx
	mov si,[bp+8]
	mov [si],cx
	mov si,[bp+6]
	mov [si],dx	
	pop bp	
	retf 8
	
printf:
	push bp
	mov bp,sp
	mov ax,0a000h
	mov fs,ax
	lgs di,[bp+6]
	mov dx,[bp+12]	;y
	mov ax,80
	mul dx
	mov si,[bp+14]	;x
	shr si,3
	add si,ax	
	mov bx,[bp+10]
	mov cx,[bx]
	mov bx,[bx+2]	
	label:

		push di		
		
		;cmp [bx],32		
		;jb	lbl
		;cmp [bx],126
		;ja lbl	
		
		mov ax,[bx]
		sub ax,32
		mov dl,11
		mul dl
		add di,ax		
		push cx
		push si		
		mov cx,11
		label1:
			mov al,[gs:di]
			;xor al,[fs:si]
			mov [fs:si],al						
			add si,80
			inc di			
			loop label1
		pop si
		pop cx
				
		lbl:
		
		pop di		
		inc bx	
		inc si		
		loop label
	pop bp	
	retf 10
	
setdta:
	push bp
	mov bp,sp
	push ds
	lds dx,[bp+6]
	mov ax,01a00h
	int 21h
	pop ds
	pop bp
	retf 4	
	
ffile:
	push bp
	mov bp,sp
	mov dx,[bp+6]
	mov cx,[bp+8]
	mov si,[bp+10]
	mov ax,[si]	
	int 21h
	mov [si],ax	
	pop bp
	retf 6
