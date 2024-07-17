;==============================================================
 .386
 .model flat,stdcall
 option casemap:none
;========================================================
;Fehler, die beim Einsatz von Unterprogrammen auftreten können
;========================================================

; falls masm32 nicht auf C: installiert ist, aus dem Intranet
; das Verzeichnis masm32 nach H: kopieren
; dann aber H: vor die include-Dateien schreiben!

include \masm32\include\masm32rt.inc
include \masm32\macros\macros.asm
include zahl_makro.asm

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data
	zahl1 dd 0
	zahl2 dd 0

.code
add2 proc
	push ebp
	mov ebp, esp
	mov eax, [ebp + 8]
	cmp eax, 0
	jl kleiner
	jmp groesser
	kleiner:
		mov ebx, -1
		mul ebx
	groesser:
	mov ecx, eax		; ersten Wert zwischenspeichern
	mov eax, [ebp + 12]
	cmp eax, 0
	jg groesser2
	jmp kleiner2
	kleiner2:
		mov ebx, -1
		mul ebx
	groesser2:
	add eax, ecx
	mov [ebp + 16], eax
	mov esp, ebp
	pop ebp
	ret 8
add2 endp

up_errors:
	; Aufgabe: lesen sie zwei Zahlen (max. 3 Zeichen) in Assembler ein und addieren Sie deren Betrag! in einem Unterprogramm
	; Die Parameter sowie das Ergebnis sollen über den Stack übergeben werden
	; ============================================
	; Dieses Programm enthält viel zu viele Fehler für diese Aufgabenstellung...
	; Wie viele seht ihr?
	zahl_makro 3, zahl1
	zahl_makro 3, zahl2
	push zahl1
	push zahl2
	call add2
	pop eax
	printf("%d + %d = %d", zahl1, zahl2, eax)
	push 0
	call ExitProcess
end up_errors