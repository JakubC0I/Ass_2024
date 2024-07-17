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
	m_ret1 dd ?
	m_param1 dd ?
	m_param2 dd ?
	f_ret1 dd ?
	f_param1 dd ?
	f_param2 dd ?

.code

add_macro macro param1, param2, return1
	push ebx
	mov ebx, param1
	add ebx, param2
	mov return1, ebx
	pop ebx
	exitm
endm

add_func proc
	push ebp
	mov ebp, esp
	push eax
	mov eax, [ebp+8]
	add eax, [ebp+12]
	mov [ebp+16], eax
	pop eax
	mov esp, ebp
	pop ebp
	ret 8
add_func endp


mafunc:
	printf("Parameterübergabe mit Macro:\n\n")
	mov m_param1, sval(input("Bitte erste Zahl eingeben: "))
	mov m_param2, sval(input("Bitte zweite Zahl eingeben: "))
	add_macro m_param1, m_param2, m_ret1
	printf("Das Ergebnis der Addition lautet: %d", m_ret1)

	printf("\n\n\nParameterübergabe mit Funktion:\n\n")
	mov f_param1, sval(input("Bitte erste Zahl eingeben: "))
	mov f_param2, sval(input("Bitte zweite Zahl eingeben: "))
	mov eax, f_ret1
	push eax
	mov eax, f_param2
	push eax
	mov eax, f_param1
	push eax
	call add_func
	pop eax
	mov f_ret1, eax
	printf("Das Ergebnis der Addition lautet: %d", f_ret1)
	
	exit
end mafunc