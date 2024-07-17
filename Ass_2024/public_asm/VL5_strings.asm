;==============================================================
 .386
 .model flat,stdcall
 option casemap:none
;========================================================
;Demo Code für LV5 - Stringoperationen, Sprünge und Prozeduren
;========================================================

; falls masm32 nicht auf C: installiert ist, aus dem Intranet
; das Verzeichnis masm32 nach H: kopieren
; dann aber H: vor die include-Dateien schreiben!

include \masm32\include\masm32rt.inc
include \masm32\macros\macros.asm

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data
	var1 dw 12,23,34,?
	source_length dd 15
	source_string db "Uebertrag mich!"
	destination_string db 15 dup (?)
	compare_string db "Uebertrbg mich nicht!"
	find_me_first db '?'
	find_me db 'r'
	caesar_source db "Jhkhlpqdfkulfkw",0
	caesar_destination db 15 dup (?),0
	ja_symbol db 'j'
	nein_symbol db 'n'

.code

makros:
	check_ja macro
		echo Check Ja Makro wird expandiert
		;Prozedur prüft ob 'ja' eingegeben wurde
		;erwartet Adresse der Eingabe
		;
		neue_eingabe:
			printf("Suche beenden? (nur 'j' oder 'n' werden akzeptiert)\n")
			getkey

			cmp al, ja_symbol
			jz ja_eingabe

			cmp al, nein_symbol
			jz nein_eingabe
			jmp neue_eingabe

		ja_eingabe:
			mov ebx, 0
			jmp check_end

		nein_eingabe:
			mov ebx, 1
		
		check_end:
			exitm

	endm

caesar proc
	push ebp
	mov ebp, esp
	;Loop für CäsarVerschlüsselung:
	;	mit 'lods' von Quellstring nach 'al'
	;	Erhöhung von 'al' um 1
	;	mit 'stos' von 'al' nach Zielstring
	;	Loop bis CX = 0 (verringern in jedem Durchgang)
	;	Wort ausgeben.
	;	Eingabe für Fortsetzung: wenn 'ja' (in Methode prüfen) dann weiter, wenn 'nein' dann beenden
	printf("Starte Caesar-Entschluesselung\n")
	caesar_start:
		printf("Aktueller Quellstring: %s\n", offset caesar_source)
		mov ecx, source_length
		lea esi, caesar_source
		lea edi, caesar_destination

	caesar_loop:
		lods caesar_source
		dec al
		stos caesar_destination
		dec ecx
		jz ja_check
		jmp caesar_loop
	
	ja_check:
		printf("Gefundenes Wort nach Verschiebung um -1: %s\n", offset caesar_destination)
		check_ja
		cmp ebx, 0
		jz caesar_ende
	
		mov ecx, source_length
		lea esi, caesar_destination
		lea edi, caesar_source
		rep movs caesar_source, caesar_destination

		jmp caesar_start

	caesar_ende:
		printf("Korrektes Ergebnis: %s\n", offset caesar_destination)

	mov esp, ebp
	pop ebp
	ret
caesar endp

offset1:
	mov ax, var1			;direkte Zuweisung
	mov bx, [var1+2]		;direkte Zuweisung mit Offset
	mov ebx, offset var1	;der Befehl 'offset' gibt die Adresse der Variable zurück
	lea ebx, var1[2]		;der Befehl 'lea' erlaubt dabei auch Verschiebungen

	lea esi, source_string						;für Stringoperationen sind die Pointer
	lea edi, destination_string					;'si' (Quelle) und 'di' (Ziel) relevant
	movs destination_string, source_string		;'movs' kopiert ein Symbol vom
	movs destination_string, source_string		;Quellstring zum Zielstring
	mov ecx, source_length						;Länge des Quellstrings (15)
	sub ecx, 2						;15-2 --> 13 Wiederholungen für 'rep' ähnliche Befehle
	rep movs destination_string, source_string	;mit 'rep' kann 'movs' wiederholt werden

	lea esi, source_string
	lea edi, destination_string
	mov ecx, source_length						;'cmps' vergleicht Quelle und Ziel
	repz cmps destination_string, source_string	;'repz' wdhl. solange Z=1 und 'ecx' > 0 ist

	lea esi, compare_string						;'Uebertrag mich nicht!'
	lea edi, destination_string					;'Uebertrag mich!'
	mov ecx, source_length
	repz cmps destination_string, compare_string	;'cmps' wird vorzeitig abgebrochen

	lea edi, destination_string
	mov ebx, edi								;Ziel-Pointer zwischenspeichern
	mov ecx, source_length
	mov al, find_me_first						;'?' (existiert nicht im Ziel-String)
	repnz scas destination_string				;bricht ab sobald 'ecx' = 0
	mov eax, edi								;da Vergleich immer Z != 0 liefert
	sub eax, ebx		;liefert Anzahl Zeichen nach denen der Vergleich beendet wurde

	lea edi, destination_string
	mov ebx, edi
	mov ecx, source_length
	mov al, find_me								;'r' (existiert im Ziel-String)
	repnz scas destination_string
	mov eax, edi
	sub eax, ebx		;Stelle an der der String gefunden wurde (Alternative?)

	call caesar

	push 0
	call ExitProcess
end offset1