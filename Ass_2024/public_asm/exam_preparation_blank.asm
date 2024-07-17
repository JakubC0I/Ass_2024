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
	
  example_mac macro param1, param2, back_param1
  	;do something
    jmp test2   ; test ist eine vordefinierte Funktion! - kann nicht als Label verwendet werden
    test2:
    exitm
  endm
  
procs:

  example_proc proc
  	push ebp
    mov ebp, esp
    ; do something
    ; params at [ebp+8] an beyond
    mov esp, ebp
    pop ebp
    ret ; 4 x #params
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
  push 0
  call ExitProcess
end klausur