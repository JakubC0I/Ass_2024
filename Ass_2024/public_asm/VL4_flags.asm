;==============================================================
 .386
 .model flat,stdcall
 option casemap:none
;========================================================
;Demo Code für LV4 - Struktur und Flussbefehle
;========================================================
include \masm32\include\windows.inc

; falls masm32 nicht auf C: installiert ist, aus dem Intranet
; das Verzeichnis masm32 nach H: kopieren
; dann aber H: vor die include-Dateien schreiben!

include \masm32\include\masm32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data
	my_data dd 11111111h
 
.code
arith:
	mov ebx, offset my_data
	mov byte ptr [ebx], 10
	mov my_data, 11111111h
	mov word ptr [ebx], 10
	mov my_data, 11111111h
	mov dword ptr [ebx], 10
	mov ax, 1400h
	mov bx, 14h
	add ax, bx
	mov bh, 10h
	mov bl, 9h
	sub bl, bh			;Sign(PL)=1 Carry(CY)=1

	mov ax, 200h
	mov bx, 5h
	mul bx

	mov ax, 18h
	mov dx, 0
	mov bx, 4h
	div bx

	mov ax, 4000h
	mov bx, 4h
	mul bx				;Overflow(OV)=1 Carry(CY)=1 DX=1

	mov ax, 20h
	mov dx, 0			;Important to reset DX for 16bit division
	mov bx, 3h
	div bx				;DX=2 AX=10

flags:
	mov ax,00010010b
	mov bx,00010000b
	test ax,bx			;Sign(PL)=0 Zero(ZR)=0 Parity(PE)=0
	and ax,bx

	mov ax,00010010b
	mov bx,00010010b
	test ax,bx			;Sign(PL)=0 Zero(ZR)=0 Parity(PE)=1
	and ax,bx

	mov ax,10110010b
	mov bx,01001101b
	test ax,bx			;Sign(PL)=0 Zero(ZR)=1 Parity(PE)=1
	and ax,bx

	mov ax,1000000000100001b
	mov bx,1111111111111111b
	test ax,bx		;Sign(PL)=1 Zero(ZR)=0 Parity(PE)=1
	and ax,bx

logic:
	mov bl, 10h
	mov bh, 14h
	and bl, bh		;bl=10h
	or bl, bh		;bl=14h
	mov bl, 10h
	xor bl, bh		;bl=04h

move:
	mov ebx,10000001b
	shl bl,1
	mov bl,10000001b
	sal bl,1
	mov bl,10000001b
	shr bl,1
	mov bl,10000001b
	sar bl,1

	mov bl,01000001b
	shl bl,1
	mov bl,01000001b
	sal bl,1
	mov bl,10000010b
	shr bl,1
	mov bl,10000010b
	sar bl,1

rotate:
	mov bl,10000001b
	rol bl,1
	mov bl,10000001b
	ror bl,1
	mov bl,10000001b
	rcl bl,1
	mov bl,10000001b
	rcr bl,1
	
	rcr bl,1			;mit Carry Reset zu 0
	mov bl,10000001b
	rcl bl,1
	rcl bl,1
	mov bl,10000001b
	rcr bl,1

	push 0
	call ExitProcess
end arith