;==============================================================
 .386
 .model flat,stdcall
 option casemap:none
;========================================================

include \masm32\include\masm32rt.inc
include \masm32\macros\macros.asm

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib


.data
	inputVar db 100 dup(?), 0
	first dd ?
	second dd ?
	result db 100 dup(?), 0 ; change it into array of ints
	char_to_add db ?
.code

greet_and_take:
	printf("Jakub Ciszak, 0112228\n")
	printf("Enter some text: ")
	
	; Define string size
	push 100

	; Define where to put it (address)
	push offset inputVar
	call StdIn

klausur2022:
	mov eax, 0
	mov ebx, 0
	mov edx, 0
	
	jmp greet_and_take

end klausur2022