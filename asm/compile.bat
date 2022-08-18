nasmw -i \..\nasm\inc\ -fobj fill.asm
alink -L \..\nasm\inc\ -oPE  fill.obj win32.lib
del *.obj