		lea	MegaPCM_DAC(pc),a1
		lea	Z80_RAM+$210,a0
		moveq	#(MegaPCM_DAC_End-MegaPCM_DAC)-1,d0

.loop		move.b	(a1)+,(a0)+
		dbf	d0,.loop
		rts

		include "MegaPCM/MegaPCM.asm"
