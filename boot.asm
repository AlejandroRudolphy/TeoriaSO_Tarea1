[BITS 16]

[ORG 0X7C00]

_start:
	jmp word load_kernel


welcome		db "*Tarea 1 sistemas operativos       *",13,10,0		
message1	db "*Integrantes:                      *",13,10,0
message2        db "*	         Alejandro Rudolphy    *",13,10,0
message3	db "*	         Sebastian Gonzalez    *",13,10,0
message4        db "*	         Ignacio Miranda       *",13,10,0
message5	db "*	         Pablo Molina          *",13,10,0
readdisk	db "Leyendo diskette",13,10,0

load_kernel:
	call clear

	mov si, welcome
	call puts
	mov si, message1
	call puts
	mov si, message2
	call puts
	mov si, message3
	call puts
	mov si, message4
	call puts
	mov si, message5
 	call puts
	jmp read_disk
	hlt

clear:
	mov	al, 02h
	mov	ah, 00h
	int 	10h
	ret

puts:
	mov ah, 0Eh
.repeat:
	lodsb
	cmp al,0
	je .done
	int 10h
	jmp .repeat

.done:

	ret

read_disk:
	mov ah,0
	int 13h
	or ah, ah
	jnz read_disk
	mov ax, 0 
	mov ax, 0
	mov es, ax
	mov bx, 0x1000

	mov ah, 02h
	mov al, 12h
	mov dl, 0x0
	mov ch, 0
	mov cl, 2
	mov dh, 0
	int 13h
	or ah, ah
	jnz load_kernel
	cli

	mov si, readdisk
	call puts

enter_pm:
	xor ax, ax
	mov ds, ax

	lgdt [gdt_desc]

	mov eax, cr0
	or eax, 1
	mov cr0, eax

	jmp 08h:kernel_segments

[BITS 32]
kernel_segments:
	mov ax, 10h
	mov ds, ax
	mov ss, ax
	mov esp, 090000h

	jmp 08h:0x1000

gdt:

gdt_null:
	dd 0
	dd 0

gdt_kernel_code:
	dw 0FFFFh
	dw 0
	db 0
	db 09Ah
	db 0CFh
	db 0

gdt_kernel_data:
	dw 0FFFFh
	dw 0
	db 0
	db 092h
	db 0CFh
	db 0

gdt_interrupts:
	dw 0FFFFh
	dw 01000h
	db 0
	db 10011110b
	db 11001111b
	db 0

gdt_end:

gdt_desc:
	dw gdt_end - gdt - 1
	dd gdt

times 510-($-$$) db 0

dw 0AA55h




	

