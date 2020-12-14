@echo off
set /p fl=Enter file name:%=%
set /p drv=Enter driver name:%=%
del "%fl%.bin"
echo drv EQUS "%drv%" > "ASMfile equ.asm"
echo fl EQUS "%fl%" >> "ASMfile equ.asm"
bin\asm68k /p /m ASMfile.asm, %fl%.bin, , .lst
if exist "%fl%.bin" GOTO:eof
pause
