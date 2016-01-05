; here is the list of included drivers.
	drvinit		; initialize variables
; format:     directory   name  compression
; explanation
; directory: The directory driver files are in. Must not contain spaces.
; name: ID to be referred by when including SMPS files.
; compression: the compression of the sound driver. See macro.asm for further details.
	incdrv	S1_drv, S1_SMPS, cmp_kos



; ===========================================================================
; the following will construct all the drivers with the information needed.
; Do not touch this.
; ===========================================================================
DriverImageArrays:
	drvimg		; include pointers for all driver images

; ===========================================================================
; this is the code to load a sound driver.
; input;
; d7 = sound driver ID
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

		lea	DriverImageArrays,a0	; get sound driver array
		move.l	(a0,d0.w),a0		; get the sound driver data to a0
		move.w	(a0)+,d0		; get compression format

		lea	CompressionFormats,a1	; get compression format array to a1
		move.l	(a1,d0.w),a1		; get compression routine to a1
	stopZ80				; request z80 bus
		jsr	(a1)			; run decompressor code
	startZ80			; return z80 bus
		move.b	1(sp),LoadedDriver.w	; set loaded driver

.alreadyloaded	move.l	(sp)+,d7		; get music file from stack
		addq.w	#2,sp			; pop driver from stack
		rts

.loadstop	move.b	#-1,LoadedDriver.w	; no sound driver loaded
		addq.w	#6,sp			; pop stack stuff
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
		move.l	(a0)+,-(sp)	; store z80 pointer to stack
		lea	Driver68K,a1	; get 68k driver address
		jsr	KosDec		; kosinski decompress
		move.l	(sp)+,a0	; get z80 pointer from stack
		lea	Z80_RAM,a1	; get z80 driver address
		jmp	KosDec		; kosinski decompress

; ===========================================================================
; code to play a music file
; input:
; a3 = music file address
; ===========================================================================
PlayMusicFile:
		moveq	#0,d0
		move.b	LoadedDriver.w,d0	; get sound driver to d0
		bmi.s	.nope			; special case: load stop sfx driver

		lea	DrvPlayCodes,a1		; get music playing code array
		move.l	(a1,d0.w),a1		; get the right entry to a1
	stopZ80				; request z80 bus
		jsr	(a1)			; run decompressor code
	startZ80			; return z80 bus
.nope		rts
; ===========================================================================
DrvPlayCodes:
	drvplay

; ===========================================================================
