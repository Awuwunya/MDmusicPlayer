		btst	#6,HWVersion.w		; is this NTSC Genesis?
		beq.s	.isNTSC			; if is, branch
		st	Driver68K+$21		; set PAL mode
.isNTSC		rts
