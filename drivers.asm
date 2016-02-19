; here is the list of included drivers.
	drvinit		; initialize variables
; format:     directory   name  compression
; explanation
; directory: The directory driver files are in. Must not contain spaces.
; name: ID to be referred by when including SMPS files.
; compression: the compression of the sound driver. See macro.asm for further details.
	incdrv	S1_SMPS, cmp_kos
	incdrv	MegaPCM, cmp_kos
	incdrv	S3K_SMPS, cmp_kos
	incdrv	DyHe_SMPS, cmp_kos


; ===========================================================================
; the following will construct all the drivers with the information needed.
; Do not touch this.
; ===========================================================================
DriverImageArrays:
	drvimg		; include pointers for all driver images

; ===========================================================================
; this is the code to load a sound driver.
; input;
; d7 = music file ID
; ===========================================================================
LoadSoundDriver:
		lea	MusicFileArrays,a3	; get music file array
		move.l	(a3,d7.w),a3		; get the music string data to a0
		move.w	(a3),d0			; get string size to d0
		addq.w	#2,d0			; skip string size and first letter
		add.w	d0,d0			; double it
		add.w	d0,a3			; add the string size to a0
		move.w	(a3)+,d0		; get sound driver ID
		move.w	d0,-(sp)		; store sound driver to stack
		move.l	a3,-(sp)		; store music file address

		cmp.b	LoadedDriver.w,d0	; check if driver was loaded already
		beq.s	.alreadyloaded		; branch if was already loaded
		tst.w	d0
		bmi.s	.loadstop		; special case: load stop sfx driver
		move.b	#-1,LoadedDriver.w	; disable sound driver

		lea	DrvLoadCodes,a0		; sound driver load code array
		move.l	(a0,d0.w),a2		; get pointer to a2

		lea	DriverImageArrays,a0	; get sound driver array
		move.l	(a0,d0.w),a0		; get the sound driver data to a0
		move.w	(a0)+,d0		; get compression format

		lea	CompressionFormats,a1	; get compression format array to a1
		move.l	(a1,d0.w),a1		; get compression routine to a1

		move.w	#$100,Z80_bus_request
		move.w	#$100,Z80_reset
		jsr	(a1)			; run decompressor code
		jsr	(a2)			; run load code

		move.w	#0,Z80_reset
	rept 4
		nop
	endr
		move.w	#$100,Z80_reset
	startZ80			; return z80 bus
		move.b	5(sp),LoadedDriver.w	; set loaded driver

.alreadyloaded	move.l	(sp)+,d7		; get music file from stack
		addq.w	#2,sp			; pop driver from stack
		rts
; ===========================================================================

.loadstop	move.b	#-1,LoadedDriver.w	; no sound driver loaded
		addq.w	#6,sp			; pop stack stuff
		lea	$A04000,a0		; get faster access to RAM

	; stop all the sound on FM channels
		moveq	#2,d3		; 3 FM channels for each YM2612 parts
		moveq	#$28,d0		; FM key on/off register

.noteoffloop	move.b	d3,d1
		jsr	WriteFMI(pc)
		addq.b	#4,d1		; Move to YM2612 part 1
		jsr	WriteFMI(pc)
		dbf	d3,.noteoffloop

		moveq	#$40,d0		; Set TL on FM channels...
		moveq	#$7F,d1		; ... to total attenuation...
		moveq	#2,d4		; ... for all 3 channels...
.channelloop	moveq	#3,d3		; ... for all operators on each channel...

.channeltlloop	jsr	WriteFMI(pc)	; ... for part 0...
		jsr	WriteFMII(pc)	; ... and part 1.
		addq.w	#4,d0		; Next TL operator
		dbf	d3,.channeltlloop

		subi.b	#$F,d0		; Move to TL operator 1 of next channel
		dbf	d4,.channelloop

	; stop all the sound on PSG channels
		lea	PSG_input,a0
		move.b	#$9F,(a0)	; Silence PSG 1
		move.b	#$BF,(a0)	; Silence PSG 2
		move.b	#$DF,(a0)	; Silence PSG 3
		move.b	#$FF,(a0)	; Silence noise channel
		rts

; ===========================================================================
WriteFMI:
	stopZ80
	waitYM	a0
		move.b	d0,(a0)
	waitYM	a0
		move.b	d1,1(a0)
	waitYM	a0
		move.b	#$2A,(a0)
	startZ80
		rts

WriteFMII:
	stopZ80
	waitYM	a0
		move.b	d0,2(a0)
	waitYM	a0
		move.b	d1,3(a0)
	waitYM	a0
		move.b	#$2A,(a0)
	startZ80
		rts

; ===========================================================================
; decompressing code for sound drivers
CompressionFormats:
		dc.l DrvDecom_Unc, DrvDecom_Kos

; ===========================================================================
; copy bytes to RAM
DrvDecom_Unc:
		move.w	(a0)+,d6	; get length of copy
		lea	Driver68K,a1	; get 68k driver address

.68kloop	move.l	(a0)+,(a1)+	; copy longword at a time
		dbf	d6,.68kloop	; loop until done

		move.w	(a0)+,d6	; get length of copy
		lea	Z80_RAM,a1	; get z80 driver address

.z80loop	move.l	(a0)+,(a1)+	; copy longword at a time
		dbf	d6,.z80loop	; loop until done
		rts

; ===========================================================================
; decompress from kosinski
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
; code to play a music file
; input:
; d7 = music file address
; ===========================================================================
PlayMusicFile:
		moveq	#0,d0
		move.b	LoadedDriver.w,d0	; get sound driver to d0
		bmi.s	.nope			; special case: load stop sfx driver

		move.l	DrvPlayCodes(pc,d0.w),a1; get the right entry to a1
	stopZ80				; request z80 bus
		jsr	(a1)			; run play music code
	startZ80			; return z80 bus
.nope		rts
; ===========================================================================
DrvPlayCodes:
	drvplay

DrvLoadCodes:
	drvload

; ===========================================================================
