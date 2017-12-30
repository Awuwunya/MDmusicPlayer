; ===========================================================================
; ---------------------------------------------------------------------------
; Load the GEMS sound driver (v2.1 maybe)
; ---------------------------------------------------------------------------

GEMS_Load_Driver:
		move.w	#$100,Z80_bus_request
		move.w	#$100,Z80_reset

		lea	GEMS_Sound_68K(pc),a0
		lea	Driver68K,a1		; get 68k driver address
		jsr	KosDec.w		; kosinski decompress

		lea	GEMS_Sound_Z80(pc),a0
		lea	Z80_RAM,a1		; get z80 driver address
		jsr	KosDec.w		; kosinski decompress

		move.w	#$2000,d0		; prepare RAM size
		sub.w	a1,d0			; sub the address we decompressed to
		subq.w	#1,d0			; sub 1 for dbf
		bmi.s	.noclear		; if negative, do not clear
		moveq	#0,d1

.clear		move.b	d1,(a1)+
		dbf	d0,.clear

.noclear	move.w	#0,Z80_reset
	rept 4
		nop
	endr
		move.w	#$100,Z80_reset
	startZ80				; return z80 bus

		move.b	#TYPE_GEMS,DriverType.w
		move.l	#gDriverPropertyData,DisplayList.w
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Update GEMS status codes for the core
; ---------------------------------------------------------------------------

GEMS_Common_Update:
		lea	gSeq.w,a1
		lea	Z80_RAM+$1B80,a0	; CCB

		moveq	#16-1,d0		; 16 channels
		moveq	#0,d1
		moveq	#0,d2			; chnum
	stopZ80

		move.b	$8BE-$1B80(a0),gTempo+1.w
		move.b	$8BF-$1B80(a0),gTempo.w
		move.b	$15CF-$1B80(a0),gVolume.w

.loop		btst	#0,6(a0)		; CCBFLAGS - check if ch is active
		beq.s	.next			; if not, branch
		bset	d2,d1			; enable channel

		move.b	14(a0),(a1)		; CCBSNUM
		move.b	6(a0),1(a1)		; CCBFLAGS
		move.b	28(a0),2(a1)		; CCBPRIO
		move.b	13(a0),3(a1)		; CCBPNUM
		move.b	30(a0),4(a1)		; CCBATN
		move.b	8(a0),5(a1)		; CCBTIMERH
		move.b	7(a0),6(a1)		; CCBTIMERL
;		move.b	3(a0),7(a1)		; CCBTAGL

.next		addq.w	#8,a1
		addq.w	#1,d2			; next channel
		lea	32(a0),a0
		dbf	d0,.loop
		move.w	d1,ActiveChn.w		; set active channels

		move.w	gTempo.w,d0
		mulu	#$80,d0			; mul by 0x80
		and.l	#$FFFF,d0		; keep upper byte clear (oops high tempos?)
		divu	#218,d0			; divide by 218 (ld DE,218 // call MULTIPLY)
		addq.w	#1,d0			; add 1 to tempo (rounding whee)
		move.w	d0,gTempo.w		; save tempo

	startZ80
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to manipulate certain aspects of the GEMS driver, Can be used
; for testing purposes to just fucking with it randomly!
; ---------------------------------------------------------------------------

GEMSmanipulate:
		move.w	Ctrl1Held.w,d7		; get player 1 controller input
		or.w	Ctrl2Held.w,d7		; or with player 2 controller input
		lea	gCursor.w,a0		; get cursor to a0

		btst	#5,d7			; check if C was pressed
		beq.s	.noC			; if not, keep the same program
		cmp.w	#-1,Ctrl0Held.w		; check if we have taken control
		bne.s	.gain			; if we have not, continue

		clr.w	Ctrl0Held.w		; release control

	vdpcomm	move.l,$D800,VRAM,WRITE,4(a6)	; write to sprite layer
		move.w	#0,(a6)			; clear sprite y-pos
		rts

.gain		move.w	#-1,Ctrl0Held.w		; gain control

.noC		cmp.w	#-1,Ctrl0Held.w		; check if we have taken control
		bne.w	.end			; if not, exit

	; now we are inside the program
		btst	#0,d7			; check if up is held
		beq.s	.noUp			; if not, branch

		subq.b	#1,(a0)			; sub 1 from cursor pos
		bpl.s	.drawcursor		; if ok, draw the cursor
		move.b	#19-1,(a0)		; reset to max pos
		bra.s	.drawcursor

.noUp		btst	#1,d7			; check if up is held
		beq.s	.drawcursor		; if not, branch

		addq.b	#1,(a0)			; sub 1 from cursor pos
		cmp.b	#19,(a0)		; check against max value
		blo.s	.drawcursor		; if ok, draw the cursor
		clr.b	(a0)			; reset to max pos

.drawcursor	moveq	#0,d0			; clear d0
		move.b	(a0),d0			; get cursor pos
		add.w	d0,d0
		add.w	d0,d0			; quadruple

	vdpcomm	move.l,$D800,VRAM,WRITE,4(a6)	; write to sprite layer
		move.w	.cursorpos(pc,d0.w),(a6); set sprite y-pos
		move.l	#$4F,(a6)		; arrow sprite and no link or size
		move.w	.cursorpos+2(pc,d0.w),(a6); set sprite x-pos
		bra.s	.gettype		; continue normally
; ===========================================================================

.cursorpos	dc.w $80+(2*8), $80+(7*8)	; TEMPO
		dc.w $80+(2*8), $80+(17*8)	; VOL
		dc.w $80+(2*8), $80+(27*8)	; SEQ

.ch =	0
	rept 16
		dc.w $80+((.ch+4)*8), $90	; CH#
.ch =		.ch+1
	endr
; ===========================================================================

.gettype	btst	#7,d7			; check if start was pressed
		beq.s	.nostart		; if no, branch
		bchg	#7,Drv68Kmem.w		; check if music is paused
		beq.s	.paused			; if was, branch

		jsr	gemsresumeall		; unpause all music
		bra.s	.nostart
.paused		jsr	gemspauseall		; resume all music

.nostart	tst.b	(a0)
		beq.w	.tempo
		cmp.b	#1,(a0)
		beq.w	.vol
		cmp.b	#2,(a0)
		beq.w	.seq

		moveq	#0,d6
		move.b	(a0),d6			; get the channel to d6
		subq.w	#3,d6

		btst	#6,d7			; check if A was pressed
		beq.s	.noA2			; if no, branch
		move.w	gMutedChs.w,d5		; get muted channels

		moveq	#0,d0
		bchg	d6,d5			; check if channel is muted
		bne.s	.unmute			; if was, branch
		moveq	#1,d0

.unmute		move.l	d0,-(sp)		; push mute value in stack
		move.l	d6,-(sp)		; push channel
		move.w	d5,gMutedChs.w		; set muted channels

		lsl.w	#3,d6			; *8
		add.w	#gSeq,d6		; add the RAM offset to d6
		move.w	d6,a0			; get to a0
		move.b	(a0),d0			; get the channel number
		move.l	d0,-(sp)		; push the sequence number

		jsr	gemsmute
		add.w	#12,sp			; pop
		rts
; ===========================================================================

.noA2		btst	#4,d7			; check if B was pressed
		beq.s	.noB2			; if no, branch
		move.w	gSustain.w,d5		; get sustained channels

		moveq	#0,d0
		bchg	d6,d5			; check if channel is sustained
		bne.s	.unsustain		; if was, branch
		moveq	#$80,d0

.unsustain	move.l	d0,-(sp)		; push mute value in stack
		move.l	d6,-(sp)		; push channel
		move.w	d5,gSustain.w		; set sustained channels

		jsr	gemsretrigenv
		addq.w	#8,sp			; pop
		rts
; ===========================================================================

.noB2		bsr.w	.getDelta		; get movement delta from l/r inputs
		move.w	d6,d4			; copy channel ID

		lsl.w	#3,d6			; *8
		add.w	#gPatch,d6		; add the RAM offset to d6
		move.w	d6,a0			; get to a0

		moveq	#0,d0
		move.b	(a0),d0			; get the current patch
		add.w	d5,d0			; add offset
		and.w	#$7F,d0

		move.l	d0,-(sp)		; push the new patch
		move.l	d4,-(sp)		; push channel ID
		jsr	gemsprogchange
		addq.w	#8,sp			; pop
.end		rts
; ===========================================================================

.seq		lea	gCurSeq.w,a0		; for quicker access
		btst	#6,d7			; check if A was pressed
		beq.s	.noA			; if no, branch

		move.w	a0,-(sp)		; push a0
		jsr	gemsstopall		; stop all sequences
		move.w	(sp)+,a0		; pop a0

.play		moveq	#0,d0
		move.b	(a0),d0			; get sequence ID
		move.l	d0,-(sp)		; push ID

		jsr	gemsstartsong		; start sequence
		clr.l	gMutedChs.w		; clear muted channels
		addq.w	#4,sp			; pop
		rts
; ===========================================================================

.noA		btst	#4,d7			; check if B was pressed
		beq.s	.noB			; if no, branch
		btst	#3+8,d7			; check if right was pressed
		bne.s	.add10			; if no, branch
		btst	#2+8,d7			; check if left was pressed
		beq.s	.play			; if no, branch
		sub.b	#$20,(a0)		; sub $10 from sequence ID

.add10		add.b	#$10,(a0)		; add $10 to sequence ID
		bra.s	.noRight

.noB		btst	#2,d7			; check if left was pressed
		beq.s	.noLeft			; if no, branch
		subq.b	#1,(a0)			; sub 1 from sequence ID

.noLeft		btst	#3,d7			; check if right was pressed
		beq.s	.noRight		; if no, branch
		addq.b	#1,(a0)			; sub 1 from sequence ID

.noRight	and.b	#$7F,(a0)		; keep in range
		rts
; ===========================================================================

.vol		bsr.w	.getDelta		; get movement delta from l/r inputs
		moveq	#0,d0
		move.b	gVolume-gCursor(a0),d0	; get actual volume
		add.w	d5,d0			; add delta
		move.l	d0,-(sp)		; push

		jsr	gemsnatmastervol
		addq.w	#4,sp			; pop
		rts
; ===========================================================================

.tempo		lea	gTempo.w,a0		; for quicker access
		moveq	#0,d6			; condition false

		btst	#2,d7			; check if left was pressed
		beq.s	.noLeft2		; if no, branch
		tas	d6			; tempo updated
		subq.w	#1,(a0)			; sub 1 from tempo

.noLeft2	btst	#3,d7			; check if right was pressed
		beq.s	.noRight2		; if no, branch
		addq.w	#1,(a0)			; sub 1 from tempo
		tas	d6			; tempo updated

.noRight2	move.w	VintTime.w,d0		; get v-int timer
		and.w	#7,d0			; run code only every 4 frames
		bne.s	.noLeft3		; if fail, branch

		btst	#2+8,d7			; check if left was held
		beq.s	.noLeft3		; if no, branch
		subq.w	#2,(a0)			; sub 1 from tempo
		tas	d6			; tempo updated

.noLeft3	move.w	VintTime.w,d0		; get v-int timer
		and.w	#3,d0			; run code only every 4 frames
		bne.s	.noRight3		; if fail, branch

		btst	#3+8,d7			; check if right was held
		beq.s	.noRight3		; if no, branch
		tas	d6			; tempo updated
		addq.w	#1,(a0)			; sub 1 from tempo

.noRight3	tas	d6			; check if tempo needs update
		bpl.s	.noUpdate		; if does not, branch

		moveq	#0,d0
		move.w	(a0),d0			; get tempo
		move.l	d0,-(sp)		; push tempo
		jsr	gemssettempo		;
		addq.w	#4,sp			; pop
.noUpdate	rts
; ===========================================================================

.getDelta	moveq	#0,d5
		btst	#2,d7			; check if left was pressed
		beq.s	.noLeft4		; if no, branch
		moveq	#-1,d5
		bra.s	.found

.noLeft4	btst	#3,d7			; check if right was pressed
		beq.s	.noRight4		; if no, branch
		moveq	#1,d5
		bra.s	.found

.noRight4	move.w	VintTime.w,d0		; get v-int timer
		and.w	#7,d0			; run code only every 4 frames
		bne.s	.chkp			; if fail, branch

		btst	#2+8,d7			; check if left was held
		beq.s	.noLeft5		; if no, branch
		moveq	#-1,d5

.noLeft5	btst	#3+8,d7			; check if right was held
		beq.s	.chkp			; if no, branch
		moveq	#1,d5

.chkp		tst.w	d5			; check if was changed
		bne.s	.found			; if not, branch
		addq.w	#4,sp			; no return to caller
.found		rts
; ===========================================================================
