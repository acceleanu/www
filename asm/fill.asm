%include "win32n.inc"

EXTERN CreateFileA
EXTERN WriteFile
EXTERN CloseHandle
EXTERN MessageBoxA
EXTERN ExitProcess

%macro invoke 2-* 
%define _j %1 
%rep %0-1 
	%rotate -1 
	push dword %1 
%endrep 
	call _j 
%endmacro 

[SECTION CODE USE32 CLASS=CODE]
..start:
;initialize buffer
	cld
	xor	eax, eax
	mov	edi, buffer
	mov	ecx, 65536
	rep	stosd
;create file
	invoke	CreateFileA,filename,GENERIC_WRITE,0,0,CREATE_ALWAYS,FILE_ATTRIBUTE_ARCHIVE,NULL

	cmp	EAX, INVALID_HANDLE_VALUE
	jz	myexit
	mov	[filehnd],eax
repeat:
;write file
	invoke	WriteFile,[filehnd],buffer,16384,wcnt,0

	cmp	eax, TRUE
	jz	repeat
;close file
	invoke	CloseHandle, eax
;display msgbox
	invoke	MessageBoxA,NULL,box_msg,box_ttl,MB_OK
myexit:
	invoke	ExitProcess, NULL

[SECTION DATA USE32 CLASS=DATA]
box_msg		db 'Zero Fill Completed Successfully ...',13,10,0
box_ttl		db 'Fill',0

filename	db	'fill.bin', 0
filehnd		dd	0
wcnt		dd	0
buffer		resd	10000h
