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
	inputVarDebug db "|A|", 1500 dup(?), 0
	debugger_msg db "debug modus anschalten? (j - ja / n - nein)",10, 0 ; 10 is a newline and 0 is string end
	words dd ?
	words_result dd ?
	characters_result dd ?
	string_end db "|E| |A|"
	string_result_end db "|E|", 0

.code

; flag, #words, #characters
handle_debug proc 
	push ebp
	mov ebp, esp

	mov eax, [ebp + 16] ; eax contains the flag
	; xor esi, esi
	
	lea si, inputVar
	mov ebx, esi

retry_debug:
	cmp al, 'j'
	je ja_debug

	cmp al, 'n'
	je nein_debug

	jmp return_results

nein_debug:
	printf("Debugger mode deactivated\n")

conti_no_debug:
	xor al, al
	lodsb

	cmp al, ' ' ;compare to space to add it as a word
	je add_word_no_debug

	cmp al, 0 ;compare to end of a string
	je return_results
	
	jmp conti_no_debug


add_word_no_debug:
	inc words

	jmp conti_no_debug

ja_debug:
	printf("Debugger mode activated\n")
	lea di, inputVarDebug
	add di, 3
	xor ebx, ebx

conti_debug:
	xor al, al
	mov al, [esi]
	movsb
	inc ebx

	cmp al, ' ' ;compare to space to add it as a word
	je add_word_debug

	cmp al, 0 ;compare to end of a string
	je return_results_debug
	
	jmp conti_debug

add_word_debug:
	inc words
	push esi
	dec di
	lea si, string_end
	movsb
	movsb
	movsb

	movsb
	movsb
	movsb
	movsb

	pop esi

	jmp conti_debug

return_results_debug:
	lea si, string_result_end
	dec di
	movsb
	movsb
	movsb
	movsb

	mov edx, [ebp + 8] ; #characters
	dec ebx ; minus 0 at the end of a string
	mov [edx], ebx

	
	
	mov ecx, [words]
	inc ecx ; add first word / number of spaces + 1
	mov ebx, [ebp + 12] ;This is confusing why this has to be done this way
	mov [ebx], ecx ; number of words	
	
	
	pop ebp
	ret 12 ; 4 x #input_params

return_results:
	sub esi, ebx
	dec esi ; starts with 1 and counts 0 at the end
	dec esi

	; TODO make it use pop instead
	mov ecx, [words]
	inc ecx ; add first word / number of spaces + 1
	mov ebx, [ebp + 12] ;This is confusing why this has to be done this way
	mov [ebx], ecx ; number of words

	inc esi
	mov ebx, [ebp + 8]
	mov [ebx], esi ; number of characters

	mov esp, ebp
	pop ebp
	ret 12 ; 4 x #input_params
handle_debug endp

greet_and_take:
	printf("Jakub Ciszak, 0112228\n")
	printf("Enter some text: ")
	
	; Define string size
	push 1000

	; Define where to put it (address)
	push offset inputVar
	call StdIn
	jmp after_greet

klausur2022:
	xor eax, eax
	xor ebx, ebx

	
	jmp greet_and_take

after_greet:
	push offset debugger_msg
	call StdOut

	getkey() ; takes one key input and saves it in al
	
	push eax
	push offset words_result
	push offset characters_result
	
	call handle_debug

	cmp eax, 0
	je goodbye

	jmp after_greet

goodbye:
	push offset inputVarDebug
	call StdOut
	printf("Number of characters: %d\nNumber of words: %d", characters_result, words_result)

	xor eax, eax
	exit


end klausur2022