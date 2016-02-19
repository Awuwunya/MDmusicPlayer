	include "exe/macro.asm"
	include "exe/smps2asm.asm"
Maincode	section org(0)
	include "asmfile equ.asm"
	include	"\drv\/smps2asm equ.asm"; include smps2asm macros

	selectdrv \drv
	incmusasmonly	\fl

	END
