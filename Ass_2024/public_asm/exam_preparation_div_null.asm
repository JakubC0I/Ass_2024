;==============================================================
 .386
 .model flat,stdcall
 option casemap:none
;========================================================
;Demo Code für Aufgabe 10
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
	divident dd 0
	divisor dd 0

.code

div_null:
	printf("Bitte geben Sie eine beliebige Zahl ein (zwischen 0 und 9999999): ")
	zahl_makro 7, divident
	printf("\nBitte geben Sie eine weitere Zahl ein (zwischen 0 und 999): ")
	zahl_makro 3, divisor
	mov ebx, divisor
	cmp ebx, 0
	je divisor_null
	mov eax, divident
	mov edx, 0
	div ebx
	printf("\n%d / %d = %d, R: %d", divident, divisor, eax, edx)
	jmp div_null_end
	divisor_null:
		printf("Division durch 0 nicht erlaubt!");
	div_null_end:
		push 0
		call ExitProcess
end div_null