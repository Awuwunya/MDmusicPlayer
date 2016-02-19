@echo off
..\exe\asm68k /p 68k.asm, drv.unc, , 68k.lst
if exist drv.unc GOTO compress1
pause
exit

:compress1
..\FW_KENSC\koscmp.exe drv.unc drv.68k
del drv.unc

..\exe\vasmz80 -Fbin -maxerrors=25 -nocase -L z80.lst -o drv.unc z80.asm
if exist drv.unc GOTO compress2
pause
exit

:compress2
..\FW_KENSC\koscmp.exe drv.unc drv.z80