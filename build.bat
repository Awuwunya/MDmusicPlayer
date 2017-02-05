@echo off
bin\MusicTool.exe
bin\asm68k /p /m Code/main.asm, player.md, , .lst>.build.log
type .build.log
if exist player.bin GOTO:eof
pause