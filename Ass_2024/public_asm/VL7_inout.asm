;==============================================================
 .386
 .model flat,stdcall
 option casemap:none
;========================================================
;Demo Code für LV7 - Makros, Funktionen und Stack
;========================================================

; falls masm32 nicht auf C: installiert ist, aus dem Intranet
; das Verzeichnis masm32 nach H: kopieren
; dann aber H: vor die include-Dateien schreiben!

include \masm32\include\masm32rt.inc
include \masm32\macros\macros.asm

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data
	ausgabe1 db "Bitte drücken Sie eine beliebige Taste...",10,0
	ausgabe2 db "Bitte drücken Sie 'n' oder 'j' um fortzufahren:",10,0
	ausgabe2a db "Sie haben 'n' gewählt",10,0
	ausgabe2b db "Sie haben 'j' gewählt",10,0
	ausgabe3 db "Bitte geben Sie nacheinander zwei Ziffern ein, die addiert werden sollen",10,0
	ausgabe4 db "Bitte geben Sie einen beliebigen Text ein (maximal 100 Zeichen)",10,0
	eingabe db 100 dup(?),0

.code
inout:
	mov eax,0
	push offset ausgabe1
	call StdOut
	inkey
	repeatIn:
	print offset ausgabe2
	getkey
	cmp al,'n'
	je neinOut
	cmp al,'j'
	jz jaOut
	jmp repeatIn
	neinOut:
		printf("%s", offset ausgabe2a)
		jmp afterSelect
	jaOut:
		printf("%s", offset ausgabe2b)
	afterSelect:
	push offset ausgabe3
	call StdOut
	mov eax, 0
	getkey
	sub eax, 30h
	mov ebx, eax
	getkey
	sub eax, 30h
	add ebx, eax
	printf("Die Addition beider Zahlen ergibt: %d \n", ebx)
	mov ebx, input("Bitte geben Sie einen beliebigen Text ein: ")
	printf("Sie haben diesen Text eingegeben: %s \n", ebx)	
	push offset ausgabe4
	call StdOut
	push 100
	push offset eingabe
	call StdIn
	printf("Sie haben nun diesen Text eingegeben: %s \n", offset eingabe)
	push 0
	call ExitProcess
end inout