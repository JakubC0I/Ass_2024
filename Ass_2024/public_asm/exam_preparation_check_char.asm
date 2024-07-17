.386
.model flat, stdcall
option casemap:none

include \masm32\include\masm32rt.inc
include \masm32\macros\macros.asm

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data
    
.code

macros:
	
  check_char macro char1, num_tf
  	;do something
    cmp char1, 30h
    jl return_0m
    cmp char1, 39h
    jg return_0m
    return_1m:
        mov num_tf, 1
        jmp exit_macro
    return_0m:
        mov num_tf, 0
    exit_macro:
        exitm
  endm
  
procs:

  example_proc proc
  	push ebp
    mov ebp, esp
    ; do something
    ; Parameter liegen bei [ebp+8], [ebp+12], etc.
    ; Rückgabewerte sind zuerst übergeben Parameter (mit höchster Abweichung von ebp)
    mov ebx, [ebp+8] 
    cmp ebx, 30h
    jl return_0p
    cmp ebx, 39h
    jg return_0p
    return_1p:
        mov eax, 1
        jmp end_proc
    return_0p:
        mov eax, 0
    end_proc:
        mov [ebp+12], eax
        mov esp, ebp
        pop ebp
        ret 4; 4 x #input_params
  example_proc endp
  
klausur:
  ; do something
  ; output: StdOut, push 1 param (address)
  ; output: printf("%s %d %c", text (address), number, ASCII-Char) ! Zahlen in ASCII? --> 30h abziehen !
  ; input: StdIn, push 2 param (length + address)
  ; input: inkey (one char only --> in al)
  ; call macro: example_mac eax, ebx, result ! Wenn parameter nicht akzeptiert werden, bevorzugt Register verwenden !
  ; ! Am besten nur vorher getestete Makros verwenden, wenn nicht ausdrücklich in Aufgabenstellung gefordert !
  ; call proc: mov eax, 0 --> push eax (So oft wie es Rückgabewerte gibt) --> push parameters --> call example_proc
  ; ! Unbekannter Fehler: verwende ich vordefinierte Symbole für meine Label / Funktionen / Makros? (test, add, sub, end, ...) !
  ; ! Der Debugger ist Dein bester Freund !
  mov eax, 'f'
  check_char eax, ebx
  printf("Das Ergebnis im Makro ist: %d", ebx)
  mov ebx, 0
  push 0
  mov eax, 'f'
  push eax
  call example_proc
  pop ebx
  printf("\nDas Ergebnis im UP ist: %d", ebx)
  push 0
  call ExitProcess
end klausur