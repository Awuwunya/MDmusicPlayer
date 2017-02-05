; /=========================================================================\
	include "..\..\code\macro.asm"

	org $FFFF0000		; pretend we are in RAM
		rts		; no 68k code
		END
