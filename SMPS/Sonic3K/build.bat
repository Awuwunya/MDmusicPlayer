@echo off
..\..\bin\asm68k /p 68k.asm, drv.unc, , 68k.lst
if exist drv.unc GOTO compress1
pause
exit

:compress1
..\bin\FW_KENSC\koscmp.exe drv.unc drv.68k
del drv.unc

..\..\bin\asm68k /p z80.asm, drv.unc, , z80.lst
if exist drv.unc GOTO compress2
pause
exit

:compress2
..\..\bin\FW_KENSC\koscmp.exe drv.unc drv.z80
del drv.unc