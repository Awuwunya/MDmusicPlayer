MainProgramLoop:
		jsr	VSync.w			; wait for next VBlank
		bsr.s	ControlPrg		; routine which handles controller input
		bsr.w	DebugMode		; check debug controls and print debug info
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
		moveq	#0,d2			; no or
		moveq	#0,d1			; clear redraw flag
		move.w	Ctrl1Held.w,d0		; get player 1 controller input
		or.w	Ctrl2Held.w,d0		; get player 2 controller input
		move.w	d0,Ctrl0Held.w		; save as controller 0 input (both controllers combined)

		lea	MusSelection.w,a5	; get music selection RAM to a5
		btst	#2,d0			; was right pressed?
		beq.s	.notright		; if not, branch
		addq.w	#4,(a5)			; go to next selection
		tas	d1			; set music change flag

		cmp.w	#musnum,(a5)		; check if max amount
		ble.s	.notright		; if less than, branch
		move.w	d2,(a5)			; clear selection

.notright	btst	#3,d0			; was left pressed?
		beq.s	.notleft		; if not, branch
		subq.w	#4,(a5)			; go to next selection
		tas	d1			; set music change flag
		bmi.s	.noredraw		; if was negative, then don't redraw

		tst.w	(a5)			; test if music selection is negative
		bpl.s	.notleft		; if positive, branch
		move.w	#musnum,(a5)		; set set sound test in range

.notleft	tst.b	d1			; was redraw flag set?
		bpl.s	.noredraw		; do not redraw if not set

		move.w	(a5),d3			; get music selection to d2
		lsr.w	#2,d3			; shift right twice (divide by 4)
		moveq	#26,d5			; y-position
		moveq	#12,d4			; x-position
		bset	#15,d2			; to high plane
		jsr	WriteNumberWord1.w	; write word to screen
		jsr	WriteMusicString	; write music name string to screen

.noredraw	tst.b	d0			; was start pressed?
		bpl.s	.noplay			; if not, don't play music

		lea	MusPlaying-MusSelection(a5),a4; get music playing RAM to a4
		move.w	(a5),d3			; get music selection ID
		move.w	d3,(a4)			; copy music selection to music playing
		move.w	d3,d7			; copy sound driver to d7
		lsr.w	#2,d3			; shift right twice (divide by 4)

		moveq	#25,d5			; y-position
		moveq	#19,d4			; x-position
		jsr	WriteNumberWord1.w	; write word to screen
		jsr	LoadSoundDriver		; load target sound driver
		jsr	PlayMusicFile		; play music file


.noplay		rts
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

