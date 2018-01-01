; ===========================================================================
	include "drv.asm"			; include driver stuff

; ===========================================================================
; ---------------------------------------------------------------------------
; This code gets the correct pointer in the drivers table.
; ---------------------------------------------------------------------------

GetDrvTableAddr:
		moveq	#0,d0
		move.b	LoadedDriver.w,d0	; get sound driver to d0
		bmi.s	.nope			; special case: load stop sfx driver
		move.l	DriverImageArrays(pc,d0.w),a1; get pointer to a2
		rts

.nope		addq.w	#4,sp
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; The following will construct all the drivers with the information needed.
; Do not touch this.
; ---------------------------------------------------------------------------

DriverImageArrays:
	drvimg		; include pointers for all driver images
; ===========================================================================
; ---------------------------------------------------------------------------
; This is the code to load a sound driver.
; input;
; d7 = music file ID
; ---------------------------------------------------------------------------

LoadSoundDriver:
		move	#$2700,sr		; disable ints
		lea	MusicFileArrays,a3	; get music file array
		move.l	(a3,d7.w),a3		; get the music string data to a3

	rept 2					; do this segment twice
		move.w	(a3)+,d0		; get string size to d0
		add.w	d0,d0			; double it
		addq.w	#2,d0			; skip first letter
		add.w	d0,a3			; add the string size to a3
	endr

		move.w	(a3)+,d0		; get sound driver ID
		move.w	d0,-(sp)		; store sound driver to stack
		move.l	a3,-(sp)		; store music file address

		cmp.b	LoadedDriver.w,d0	; check if driver was loaded already
		beq.s	.alreadyloaded		; branch if was already loaded
		tst.w	d0
		bmi.w	.loadstop		; special case: load stop sfx driver
		move.b	#-1,LoadedDriver.w	; disable sound driver

		lea	DriverImageArrays(pc),a0; get sound driver array
		move.l	(a0,d0.w),a0		; get the sound driver data to a0
		move.l	-12(a0),a2		; get pointer to a2
		move.w	(a0)+,d0		; get compression format

		lea	CompressionFormats,a1	; get compression format array to a1
		move.l	(a1,d0.w),a1		; get compression routine to a1

		move.w	#$100,Z80_bus_request
		move.w	#$100,Z80_reset
		bsr.s	.unloadDriver		; unload the sound driver
		jsr	(a1)			; run decompressor code
		jsr	(a2)			; run load code

		move.w	#0,Z80_reset
	rept 4
		nop
	endr
		move.w	#$100,Z80_reset
	startZ80				; return z80 bus
		move.b	5(sp),LoadedDriver.w	; set loaded driver
		jsr	ResetChanText		; reset on-screen text

.alreadyloaded	move.l	(sp)+,d7		; get music file from stack
		addq.w	#2,sp			; pop driver from stack
		rts

.unloadDriver	lea	Driver68K,a6		; get 68K RAM to a6
		move.w	#(HBlankRAM-Driver68K)-1,d5; fill the entire driver RAM
		moveq	#0,d6			; fill with value 0
		bsr.s	.null			;

		lea	Z80_RAM,a6		; get Z80 ram to a6
		move.w	#$2000-1,d5		; fill entire RAM

.null		move.b	d6,(a6)+		; fill next 4 bytes with 0
		dbf	d5,.null		; loop until fully clear
		rts
; ===========================================================================

.loadstop	move.b	#-1,LoadedDriver.w	; no sound driver loaded
		move.l	#NullUpdateList,DisplayList.w; reset update list to no updates
		addq.w	#6,sp			; pop stack stuff

		lea	$A04000,a0		; get faster access to RAM
		move.w	#$100,Z80_bus_request
		move.w	#$100,Z80_reset

	; silence all the sound on FM channels
		moveq	#3-1,d3			; 3 FM channels for each YM2612 parts
		moveq	#$28,d0			; FM key on/off register

.keyoff		move.b	d3,d1			; copy value to d1
		jsr	WriteFMI(pc)		; do part 1
		addq.b	#4,d1			; Move to YM2612 part 1
		jsr	WriteFMI(pc)		; do part 2
		dbf	d3,.keyoff		; loop for all channels

		moveq	#$40,d0			; TL operator
		moveq	#$7F,d1			; set TL level to maximum (silence)
		moveq	#3-1,d4			; do all 3 channels (per part)

.chloop		moveq	#4-1,d3			; and each operator
.tlloop		jsr	WriteFMI(pc)		; do part 1
		jsr	WriteFMII(pc)		; do part 2

		addq.w	#4,d0			; Next TL operator
		dbf	d3,.tlloop		; do for all channels
		subi.w	#$F,d0			; Move to TL operator 1 of next channel
		dbf	d4,.chloop		; do chans

	; silence all the sound on PSG channels
		lea	PSG_input,a1
		move.b	#$9F,(a1)	; Silence PSG 1
		move.b	#$BF,(a1)	; Silence PSG 2
		move.b	#$DF,(a1)	; Silence PSG 3
		move.b	#$FF,(a1)	; Silence noise channel

		bsr.w	.unloadDriver	; unload the sound driver

	; write HALT instructions to stop processing
		move.b	#$76,Z80_RAM-$A04000(a0)
		move.b	#$76,(Z80_RAM+$38)-$A04000(a0)
		move.w	#0,Z80_reset
	rept 4
		nop
	endr
		move.w	#$100,Z80_reset
	startZ80				; return z80 bus
		jmp	ResetChanText		; reset on-screen text
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutines for writing to FM1 and FM2, used for muting FM when
; driver unloads
; ---------------------------------------------------------------------------
WriteFMI:
;	stopZ80
	waitYM	a0
		move.b	d0,(a0)
	waitYM	a0
		move.b	d1,1(a0)
	waitYM	a0
		move.b	#$2A,(a0)
;	startZ80
		rts

WriteFMII:
;	stopZ80
	waitYM	a0
		move.b	d0,2(a0)
	waitYM	a0
		move.b	d1,3(a0)
	waitYM	a0
		move.b	#$2A,(a0)
;	startZ80
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Decompressing code for sound drivers
; ---------------------------------------------------------------------------

CompressionFormats:
		dc.l DrvDecom_None, DrvDecom_Unc, DrvDecom_Kos
		dc.l DrvDecom_Comp, DrvDecom_Nem, DrvDecom_Eni
; ===========================================================================
; ---------------------------------------------------------------------------
; Copy bytes to RAM
; ---------------------------------------------------------------------------

DrvDecom_Unc:
		move.w	(a0)+,d6	; get length of copy
		lea	Driver68K,a1	; get 68k driver address

.68kloop	move.l	(a0)+,(a1)+	; copy longword at a time
		dbf	d6,.68kloop	; loop until done

		move.w	(a0)+,d6	; get length of copy
		lea	Z80_RAM,a1	; get z80 driver address

.z80loop	move.l	(a0)+,(a1)+	; copy longword at a time
		dbf	d6,.z80loop	; loop until done

DrvDecom_None:
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Decompress from kosinski
; ---------------------------------------------------------------------------

DrvDecom_Kos:
		move.l	a2,-(sp)	; store a2
		move.l	(a0)+,-(sp)	; store z80 pointer to stack
		lea	Driver68K,a1	; get 68k driver address
		jsr	KosDec.w	; kosinski decompress

		move.l	(sp)+,a0	; get z80 pointer from stack
		lea	Z80_RAM,a1	; get z80 driver address
		jsr	KosDec.w	; kosinski decompress
		move.l	(sp)+,a2	; restore a2
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Decompress from comper
; ---------------------------------------------------------------------------

DrvDecom_Comp:
		move.l	a2,-(sp)	; store a2
		move.l	(a0)+,-(sp)	; store z80 pointer to stack
		lea	Driver68K,a1	; get 68k driver address
		jsr	CompDec.w	; kosinski decompress

		move.l	(sp)+,a0	; get z80 pointer from stack
		lea	Z80_RAM,a1	; get z80 driver address
		jsr	CompDec.w	; kosinski decompress
		move.l	(sp)+,a2	; restore a2
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Decompress from nemesis
; WARNING: It is not suggested to use this compression method!
; Use at your own risk
; ---------------------------------------------------------------------------

DrvDecom_Nem:
		move.l	a2,-(sp)	; store a2
		move.l	(a0)+,-(sp)	; store z80 pointer to stack
		lea	Driver68K,a4	; get 68k driver address
		jsr	NemDec_RAM.w	; kosinski decompress

		move.l	(sp)+,a0	; get z80 pointer from stack
		lea	Z80_RAM,a4	; get z80 driver address
		jsr	NemDec_RAM.w	; kosinski decompress
		move.l	(sp)+,a2	; restore a2
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Decompress from nemesis
; WARNING: It is not suggested to use this compression method!
; Use at your own risk
; ---------------------------------------------------------------------------

DrvDecom_Eni:
		move.l	a2,-(sp)	; store a2
		moveq	#0,d0		; clear offset
		move.l	(a0)+,-(sp)	; store z80 pointer to stack
		lea	Driver68K,a1	; get 68k driver address
		jsr	EniDec.w	; kosinski decompress

		move.l	(sp)+,a0	; get z80 pointer from stack
		lea	Z80_RAM,a1	; get z80 driver address
		jsr	EniDec.w	; kosinski decompress
		move.l	(sp)+,a2	; restore a2
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Code to play a music file
; input:
; d7 = music file address
; ---------------------------------------------------------------------------

PlayMusicFile:
		jsr	GetDrvTableAddr(pc)	; get driver table address
		move.l	-8(a1),a1		; get the right entry to a1
	stopZ80					; request z80 bus
		jsr	(a1)			; run play music code
	startZ80				; return z80 bus
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Code to update driver data
; input:
; d7 = music file address
; ---------------------------------------------------------------------------

DriverUpdate:
		jsr	GetDrvTableAddr(pc)	; get driver table address
		move.l	-4(a1),a1		; get the right entry to a1
		jsr	(a1)			; run play music code
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Code to enable DMA for the driver
; ---------------------------------------------------------------------------

DriverDMAon:
		jsr	GetDrvTableAddr(pc)	; get driver table address
		move.l	-20(a1),a1		; get the right entry to a1
		jsr	(a1)			; run play music code
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Code to disable DMA for the driver
; ---------------------------------------------------------------------------

DriverDMAoff:
		jsr	GetDrvTableAddr(pc)	; get driver table address
		move.l	-16(a1),a1		; get the right entry to a1
		jsr	(a1)			; run play music code
		rts
; ===========================================================================

MusicFileArrays:
	dc.l MusicStop
	include "_temp/offs"	; and also the offsets, because we need em
; ===========================================================================
; ---------------------------------------------------------------------------
; Special entry to display info about stopping music.
; ---------------------------------------------------------------------------

MusicStop:
	asc2.w $8000,"Stop music"
	asc2.w $8000,""
	dc.w -1; stop token
; ===========================================================================
; ---------------------------------------------------------------------------
; Write music name string to screen
; input;
;   a5 = pointer to MusPlaying flag
; ---------------------------------------------------------------------------

WriteMusicString:
		moveq	#2,d4			; x-position
		moveq	#25,d5			; y-position
		jsr	SetupStringWrite.w	; set position to write to
		bsr.s	.clear			; clear this line

		moveq	#2,d4			; x-position
		moveq	#26,d5			; y-position
		jsr	SetupStringWrite.w	; set position to write to
		bsr.s	.clear			; clear this line

		move.w	(a5),d7			; get music ID
		lea	MusicFileArrays,a0	; get music file array
		move.l	(a0,d7.w),a0		; get the music string data to a0

		moveq	#2,d4			; x-position
		moveq	#25,d5			; y-position
		jsr	WriteString1.w		; display it

		moveq	#2,d4			; x-position
		moveq	#26,d5			; y-position
		jmp	WriteString1.w		; display it

.clear		moveq	#0,d5			; clear d5
		moveq	#(28/2)-1,d4		; set repeat count
.clr		move.l	d5,(a6)			; clear next 2 letters
		dbf	d4,.clr			; keep clearing
		rts
; ===========================================================================
