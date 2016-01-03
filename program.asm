MainProgramLoop:
		jsr	VSync.w			; wait for next VBlank
		bsr.s	ControlPrg		; routine which handles controller input
		bsr.s	DebugMode		; check debug controls and print debug info
		bsr.s	ChkForErrors		; ensures program continues execution without errors
		bra.s	MainProgramLoop		; do next frame
; ===========================================================================

ChkForErrors:
		tst.l	StackUflowRAM.w		; check if underflow happened
		beq.s	.chkover		; if not, check for overflow
		error	StackUnderflow.w	; stack underflow error

.chkover
		tst.l	StackUflowRAM.w		; check if overflow happened
		beq.s	.rts			; if not, branch
		error	StackOverflow.w		; stack overflow error

.rts		rts
; ===========================================================================

ControlPrg:
		move.w	Ctrl1Held.w,d0		; get player 1 controller input
		or.w	Ctrl2Held.w,d0		; get player 2 controller input
		move.w	d0,Ctrl0Held.w		; save as controller 0 input (both controllers combined)
		rts
; ===========================================================================

DebugMode:
		tst.b	Ctrl0Held.w		; is start held?
		bpl.s	.nochg			; if not, branch
		btst	#6,Ctrl0Press.w		; is A pressed?
		beq.s	.nochg			; if not, branch
		bchg	#7,DebugFlag.w		; change most significant bit of debug mode flag

.nochg		tst.b	DebugFlag.w		; is debug active?
		bpl.s	.rts			; branch if not.
		; TODO: insert code here
		nop

.rts		rts
; ===========================================================================

