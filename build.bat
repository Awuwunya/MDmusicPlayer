@echo off
bin\MusicTool
bin\asm68k /p /m Code/main.asm, player.md, .sym, .lst>.build.log
type .build.log
if exist player.md GOTO comp
pause
exit

:comp
bin\convsym .sym .symcmp
copy /B player.md+.symcmp player.md /Y
del .sym
del .symcmp