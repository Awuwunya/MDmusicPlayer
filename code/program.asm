; ===========================================================================
; ---------------------------------------------------------------------------
; Main loop of the entire program
; ---------------------------------------------------------------------------

MainProgramLoop:
		stop	#$2300			; enable ints and stop CPU
		bsr.s	ControlPrg		; routine which handles controller input
		bsr.s	ChkForErrors		; ensures program continues execution without errors
		bra.s	MainProgramLoop		; do next frame
; ===========================================================================
; ---------------------------------------------------------------------------
; Check for error conditions ánd cause a crash to happen if they are detected
; ---------------------------------------------------------------------------

ChkForErrors:
		tst.l	StackUflowRAM.w		; check if underflow happened
		beq.s	.chkover		; if not, check for overflow
		jmp	StackUnderflow		; stack underflow error

.chkover	tst.l	StackUflowRAM.w		; check if overflow happened
		beq.s	.rts			; if not, branch
		jmp	StackOverflow		; stack overflow error

.rts		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Routine for controlling the program
; ---------------------------------------------------------------------------

ControlPrg:
		cmp.w	#-1,Ctrl0Held.w		; check if another code has taken control
		beq.w	.noplay			; if has, exit
		moveq	#0,d2			; no or
		moveq	#0,d1			; clear redraw flag
		move.w	Ctrl1Held.w,d0		; get player 1 controller input
		or.w	Ctrl2Held.w,d0		; or with player 2 controller input
		move.w	d0,Ctrl0Held.w		; save as controller 0 input (both controllers combined)

		btst	#6,d0			; was A pressed?
		beq.s	.noA			; if not, branch
		subq.w	#2,DMAlen.w		; change DMA length
		bpl.s	.aw			; if positive, write the length

	if extremeDMA=0
		move.w	#6,DMAlen.w		; set to 6
	else
		move.w	#10,DMAlen.w		; set to 10
	endif

.aw		move.w	DMAlen.w,d6		; get the offset
		add.w	d6,d6			; double it
		add.w	d6,d6			; double it
		lea	FakeDMAsz,a0
		lea	(a0,d6.w),a0		; get the DMA size

		moveq	#4-1,d6			; text length
		moveq	#14,d4			; text x-position
		moveq	#22,d5			; text y-position
		jsr	WriteString2.w		; display it

.noA		lea	MusSelection.w,a5	; get music selection RAM to a5
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
		moveq	#24,d5			; y-position
		moveq	#14,d4			; x-position
		bset	#15,d2			; to high plane
		jsr	WriteNumberWord1.w	; write word to screen
		jsr	WriteMusicString	; write music name string to screen

.noredraw	tst.b	d0			; was start pressed?
		bpl.s	.noplay			; if not, don't play music

		move.w	(a5),d3			; get music selection ID
		move.w	d3,MusPlaying-MusSelection(a5); copy music selection to music playing
		move.w	d3,d7			; copy sound driver to d7
		lsr.w	#2,d3			; shift right twice (divide by 4)

		moveq	#23,d5			; y-position
		moveq	#21,d4			; x-position
		jsr	WriteNumberWord1.w	; write word to screen
		jsr	LoadSoundDriver		; load target sound driver
		jmp	PlayMusicFile		; play music file

.noplay		rts
; ===========================================================================
