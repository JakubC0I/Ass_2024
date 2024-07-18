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
	inputVar db 1000 dup(?), 0
	debugger_msg db "debug modus anschalten? (j - ja / n - nein)",10, 0 ; 10 is a newline and 0 is string end
	flag dd ?
	result db 100 dup(?), 0 ; change it into array of ints
	char_to_add db ?
.code

handle proc ;use parameters
	push ebp
	mov ebp, esp

	lea si, inputVar
	scan_string:
		lodsb ; load first byte from an input string

		cmp al, 0
		je return_and_bye

		printf("%c", al)

		jmp scan_string

	return_and_bye:
		mov esp, ebp
		pop ebp
		ret 4 ; 4 x #input_params

handle endp

greet_and_take:
	printf("Jakub Ciszak, 0112228\n")
	printf("Enter some text: ")
	
	; Define string size
	push 1000

	; Define where to put it (address)
	push offset inputVar
	call StdIn
	jmp after_greet


klausur2024:
	mov eax, 0
	
	jmp greet_and_take

after_greet:
;#####################JUST CHANGE WELECOMING MESSAGE
	push offset debugger_msg
	call StdOut
;#####################GET 1 KEY
	getkey() ; takes one key input and saves it in al
	push eax
	call handle
	
	cmp al, 0
	je goodbye

	jmp after_greet

goodbye:
	xor eax, eax
	exit


end klausur2024