@echo off
..\exe\asm68k /p main.asm, s1.bin
if exist s1.bin GOTO compress
pause
exit

:compress
..\FW_KENSC\koscmp.exe s1.bin s1.kos
..\build.bat