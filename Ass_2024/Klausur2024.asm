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
	result_year dd ? ; as number
	result_year_string db 4 dup(?), 0
	result_year_int db 4 dup(?)
	char_to_add db ?
.code

check_if_number macro value
	; required to declare which labels are local to a macro
	LOCAL stufe_zwei, is_a_number, skip, goodbye_macro

		cmp value, 48
		jge stufe_zwei

		jmp skip

		stufe_zwei:
			cmp value, 57
			jle is_a_number
skip:
	mov ecx, 0
	jmp goodbye_macro

is_a_number:
	; from string to number
	; sub value, 48
	mov ecx, value
goodbye_macro:
	exitm
	endm

from_str_to_int_arr proc
	push ebp
	mov ebp, esp

	mov ebx, [ebp + 8] ; source
	lea si, [ebx]
	mov ebx, [ebp + 12] ; destination
	lea di, [edi]

	swap:
		lodsb

		cmp al, 0
		je done_result

		sub al, 48
		mov [edi], al
		inc edi
	jmp swap

	done_result:
		mov esp, ebp
		pop ebp
		ret 8 ; 4 x #input_params
from_str_to_int_arr endp

make_a_year proc
	push ebp
	mov ebp, esp
	
	mov ebx, [ebp + 8] ; source
	lea si, [ebx]

	mov ebx, [ebp + 12] ; destination
	mov cx, 10

	year:
		lodsb
		imul cx
		imul cx
		imul cx
		add [ebx], eax
		xor eax, eax
		
		lodsb
		imul cx
		imul cx
		add [ebx], eax
		xor eax, eax
		
		lodsb
		imul cx
		add [ebx], eax
		xor eax, eax
		
		lodsb
		add [ebx], eax

		mov ebx, [ebx]

	done_result:
		mov esp, ebp
		pop ebp
		ret 8 ; 4 x #input_params
make_a_year endp

handle proc ;use parameters
	push ebp
	mov ebp, esp

	mov eax, [ebp + 12]

	lea si, [eax]
	xor eax, eax
	scan_string:
		lodsb ; load first byte from an input string

		cmp al, 0
		je return_and_bye

		jmp first_n

		jmp scan_string
		

	return_and_bye:
		mov esp, ebp
		pop ebp
		ret 8 ; 4 x #input_params


	first_n:
		check_if_number(eax)
		cmp ecx, 0
		je scan_string
		dec esi
		movsb

	second_n:
		mov al, [esi]
		check_if_number(eax)
		cmp ecx, 0
		je scan_string
		movsb

	third_n:
		mov al, [esi]
		check_if_number(eax)
		cmp ecx, 0
		je scan_string
		movsb

	fourth_n:
		mov al, [esi]
		check_if_number(eax)
		cmp ecx, 0
		je scan_string
		movsb

	fivth_not_a_number:
		mov al, [esi]
		check_if_number(eax)
		cmp ecx, 0
		je return_and_bye
		jmp scan_string

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
	mov bx, 10
	lea di, result_year_string
	
	jmp greet_and_take

after_greet:

	push offset inputVar
	push offset result_year
	call handle

goodbye:
	inc di
	mov [edi], eax
	push offset result_year_int ; destination [ebp + 12]
	push offset result_year_string ; source [ebp + 8]
	
	call from_str_to_int_arr

	push offset result_year ; destination [ebp + 12]
	push offset result_year_int ; source [ebp + 8]

	call make_a_year

	printf("Result is: %d", result_year)
	exit


end klausur2024