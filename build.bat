@echo off
exe\MusicTool.exe
exe\asm68k /p /m main.asm, player.md, , .lst>.build.log
type .build.log
if exist player.bin GOTO:eof
pause