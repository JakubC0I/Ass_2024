;==============================================================
 .386
 .model flat,stdcall
 option casemap:none
;========================================================
;Demo Code für LV3 - Grundlegende Elemente
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
	nums db 1,4,8,12,?,?,?,?
	numbs dw 12,23,34,45
	numbers dd 1234,5678
	matrix dd 11,12,13,14,21,22,23,24,31,32,33,34,41,42,43,44
	dd_row dd 16		;Größe einer Zeile
	dd_column dd 4		;Größe einer Spalte
 
.code
demo:
	push ebx
	push edi

 	mov ax,200				;Unmittelbare Adressierung
	mov al,[nums+1]			;Direkte Adressierung mit Verschiebung
	mov al,nums+1			;...
	mov bx,[numbs+1]		;Länge des Bezeichners ist zu beachten
	mov edi,2				
	mov bx,numbs[edi]		;Direkt indizierte Adressierung mit korrekter Länge
	
	monate = 12				;Lokale Bezeichner
	mov ecx,monate
	months equ monate
	mov eax,months
	mul ecx
	adr equ matrix+4
	mov ebx,adr
							;Zugriff auf Matrix
	mov eax,3				;um drei Zeilen verschieben
	mul dd_row				;wie groß ist eine Zeile (...)
	mov ebx,eax
	mov eax,2				;um zwei Spalten verschieben
	mul dd_column			;wie groß ist eine Spalte
	mov edi,eax
	mov eax,matrix[ebx][edi]	;Basis indizierte Adressierung mit Verschiebung

	pop edi
	pop ebx

	push 0
	call ExitProcess 
end demo