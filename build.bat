@echo off
exe\asm68k /p main.asm, player.bin
if exist s1.bin GOTO :eof
pause