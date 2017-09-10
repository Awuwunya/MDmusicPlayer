Maincode	section org(0)
	include "code/macro.asm"
	include "code/smps2asm.asm"
	include "asmfile equ.asm"
	include	"smps/\drv\/smps2asm.asm"; include smps2asm macros

	opt ae-
	include	"music/\fl\.asm"
	END
