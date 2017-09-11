@echo off
..\..\bin\asm68k /p drivers/simple.asm, drivers/simple.unc, , drivers/simple.lst
..\..\bin\asm68k /p drivers/dual.asm, drivers/dual.unc, , drivers/dual.lst
..\..\bin\asm68k /p data/PCMSamples.asm, data/PCMSamples.unc, , data/PCMSamples.lst
if exist drivers/simple.unc GOTO build
:nexist
pause
exit

:build
if not exist drivers/dual.unc GOTO nexist
..\..\bin\asm68k /p 68k.asm, drv.unc, , 68k.lst
if exist drv.unc GOTO compress
pause
exit

:compress
..\..\bin\FW_KENSC\koscmp.exe drv.unc drv.68k
del drv.unc
pause
