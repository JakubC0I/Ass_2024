;==============================================================
 .386
 .model flat,stdcall
 option casemap:none
;========================================================
;Fehler, die beim Einlesen von Informationen auftreten können
;========================================================

; falls masm32 nicht auf C: installiert ist, aus dem Intranet
; das Verzeichnis masm32 nach H: kopieren
; dann aber H: vor die include-Dateien schreiben!

include \masm32\include\masm32rt.inc
include \masm32\macros\macros.asm

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data
	zeichenkette dw 100 dup (0)	;db statt dw für Zeichenketten

.code
input_errors:
	; Aufgabe: lesen Sie eine Zeichenkette in
	; Assembler ein mit maximal 100 Zeichen
	; Sie können davon ausgehen, dass jedes Zeichen entweder ein
	; Buchstabe zwischen a und y ist, ein Leerzeichen, oder eine Ziffer
	; zwischen 1 und 9. Geben Sie die Leerzeichen unverändert wieder aus, 
	; die einzelnen Ziffern um 1 reduziert, sowie Buchstaben
	; um eine Stelle im Alphabet verschoben wieder aus.
	; Beispiel: Eingabe: "asdf 123" --> Ausgabe: "bteg 012"
	; ============================================
	; Das folgende Programm setzt die Aufgabenstellung im Kern bereits
	; gut um, enthält aber 9 kleine bis große Fehler.
	; Finden und korrigieren Sie die Fehler.
	push offset zeichenkette
	push 100
	call StdIn					; Parameterreihenfolge!
	lea edi zeichenkette		;esi (+ Komma)
	mov eax, 0
	mov ecx, 100
	out_loop:
		lods zeichenkette
		; Schleifenabbruch fehlte
		cmp al, 20h
		je leerzeichen
		cmp al, 40h
		jl ziffer
		jg buchstabe
		ziffer:
			sub eax, 1		; Mit Zahlen 30h abziehen!
			printf("%d", eax)	; printf ändert eax, ecx, edx
		buchstabe:
			add eax, 1
			printf("%c", eax)
		leerzeichen:
			printf(" ")
		;endif wird benötigt (Abschlusslabel)
		loop out_loop
	program_end:
	; ExitProcess fehlt!
end input_errors