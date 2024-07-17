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
proc add			;add Programmname schon verwendet! - proc zuletzt!
	push ebp		;esp sichern!
	mov eax, [ebp + 4]	; falscher Index
	cmp eax, 0
	jl kleiner
	jmp groesser
	kleiner:
		mov ebx, -1
		mul ebx
	groesser:
	mov edx, eax		; ersten Wert zwischenspeichern - nicht in edx! sondern ecx
	mov eax, [ebp + 8]
	cmp eax, 0
	jmp kleiner2		; kein bedingter Sprung
	jg groesser2
	kleiner2:
		mov ebx, -1
		mul ebx
	groesser2:
	add eax, edx
	mov [ebp + 12], eax		; Rückgabewert an falscher Adresse
	pop ebp
	ret 8
endp			;Programmname vor endp

up_no_errors:
	; Aufgabe: lesen sie zwei Zahlen (max. 3 Zeichen) in Assembler ein und addieren Sie deren Betrag! in einem Unterprogramm
	; Die Parameter sowie das Ergebnis sollen über den Stack übergeben werden
	; ============================================
	; Dieses Programm enthält viel zu viele Fehler für diese Aufgabenstellung...
	; Wie viele seht ihr?
	zahl_makro 3, zahl1
	zahl_makro 3, zahl2
	mov eax, zahl1
	mov ebx, -1
	mul ebx
	mov zahl1, eax			; Zahl1 negieren
	; kein Platz für Rückgabewert
	push zahl1
	push zahl2
	call add_betrag
	pop eax
	printf("|%d| + |%d| = %d", zahl1, zahl2, eax)
	push 0
	call ExitProcess
end main			; das Einstiegslabel ist nicht "main"