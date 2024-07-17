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
	zeichenkette2 db 100 dup (0)

.code
input_no_errors:
	; Aufgabe: lesen Sie eine Zeichenkette in
	; Assembler ein mit maximal 100 Zeichen
	; Sie können davon ausgehen, dass jedes Zeichen entweder ein
	; Buchstabe zwischen a und y ist, ein Leerzeichen, oder eine Ziffer
	; zwischen 1 und 9. Geben Sie die Leerzeichen unverändert wieder aus, 
	; die einzelnen Ziffern um 1 reduziert, sowie Buchstaben
	; um eine Stelle im Alphabet verschoben wieder aus.
	; Beispiel: Eingabe: "asdf 123" --> Ausgabe: "bteg 012"
	; ============================================
	; Das folgende Programm setzt die Aufgabenstellung bestens um!
	; Weitere Ideen: jmp statt je, stack übergabe falsche Reihenfolge,
	; ret Zahl zu gross, stack pointer nicht gesichert und Arbeit mit Stack
	; printf Fehler (%s mit Zahl oder umgekehrt), Zugriff auf falsche Werte
	; mit ebp + ..., dw oder db Werte an Stack übergeben

	push 100
	push offset zeichenkette2
	call StdIn
	lea esi, zeichenkette2
	mov eax, 0
	mov ecx, 100
	out_loop2:
		lods zeichenkette2
		cmp al, 0
		je program_end2
		push ecx
		cmp al, 20h
		je leerzeichen2
		cmp al, 40h
		jl ziffer2
		jg buchstabe2
		ziffer2:
			sub eax, 31h
			printf("%d", eax)
			jmp done2
		buchstabe2:
			add eax, 1
			printf("%c", eax)
			jmp done2
		leerzeichen2:
			printf(" ")
		done2:
		pop ecx
		loop out_loop2
	program_end2:
		push 0
		call ExitProcess
end input_no_errors