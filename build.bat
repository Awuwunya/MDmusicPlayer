@echo off
exe\asm68k /p /m main.asm, player.bin, , .lst
if exist player.bin GOTO:eof
pause