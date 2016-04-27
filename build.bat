@echo off
exe\asm68k /p /m main.asm, player.bin, , .lst>.build.log
type .build.log
if exist player.bin GOTO:eof
pause