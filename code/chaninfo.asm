; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to clear onscreen info about songs
; ---------------------------------------------------------------------------

ResetChanText:
	dmaFillVRAM 0,$C000,32*22*2
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to render onscreen info about the current song
; ---------------------------------------------------------------------------

DrawChaninfo:
		move	#$2700,sr			; disable interruptions
		jsr	DriverUpdate(pc)		; update driver data

		bsr.s	.update				; update screen data
.skip		move	#$2300,sr			; enable interruptions
		rts
; ===========================================================================

.update		lea	VDP_data_port,a6
		move.l	DisplayList.w,a0	; get list addr
		move.w	(a0)+,d7		; get loads of data
		bmi.s	.rts			; if negative, branch

.loop		move.w	(a0)+,d0		; get bit to test
		bmi.s	.active			; if negative, skip test
		move.w	ActiveChn.w,d5		; get active channel list
		btst	d0,d5			; check if is active
		bne.s	.active			; if is, branch

		move.l	(a0)+,4(a6)		; set VDP command
		moveq	#0,d0			; fill with 0
	rept 40/2
		move.l	d0,(a6)			; write null to VDP
	endr

		move.w	(a0)+,d0		; get the string len
		addq.w	#1,d0			; +1
		add.w	d0,d0			; double it.
		add.w	d0,a0			; then skip over these bytes

		movem.w	(a0)+,d5/a4		; get next 2 words
		addq.w	#1,d5			; +1
		add.w	d5,d5			; double it.
		move.w	d5,d0			; copy it
		add.w	d5,d5			; x4
		add.w	d0,d5			; x6
		add.w	d5,a0			; then skip over these bytes
		dbf	d7,.loop		; loop for all
		rts

.active		move.l	(a0)+,4(a6)		; set VDP command
		jsr	WriteString3.w		; write the string to screen
		movem.w	(a0)+,d5/a4		; get next 2 words

.infoloop	move.w	(a0)+,d0		; get type
		move.l	(a0)+,4(a6)		; set VDP command
		jsr	UDP_Byte(pc,d0.w)	; jump to appropriate code
		dbf	d5,.infoloop		; loop til done
		dbf	d7,.loop		; loop for all
.rts		rts

UDP_Nibble:	; nibble
		move.b	(a4)+,d3		; get data to write
		jmp	WriteNumberNibble2.w	; write it down

UDP_Byte:	; byte
		move.b	(a4)+,d3		; get data to write
		jmp	WriteNumberByte2.w	; write it down

UDP_Word:	; word
		move.w	(a4)+,d3		; get data to write
		jmp	WriteNumberWord2.w	; write it down

UDP_Addr:	; address
		move.l	(a4)+,d3		; get data to write
		jmp	WriteNumberAddr2.w	; write it down

UDP_Long:	; longword
		move.l	(a4)+,d3		; get data to write
		jmp	WriteNumberLong2.w	; write it down

udp_s = 0
	rept 3
udp_n = 0
		rept 8

UDP_Dec\#udp_s\\#udp_n
			moveq	#udp_n,d6
			moveq	#0,d3

			if udp_s=0
				move.b	(a4)+,d3
				and.b	#$f,d3
			elseif udp_s=1
				move.b	(a4)+,d3
			elseif udp_s=2
				move.w	(a4)+,d3
			endif
udp_n = 		udp_n+1

			if udp_s=2
				if udp_n<>8
					bra.s	UDP_Dec
				endif
			else
				bra.w	UDP_Dec
			endif
		endr
udp_s =		udp_s+1
	endr

UDP_Dec:
		jmp	WriteDecMain.w		; write it down
; ===========================================================================
; ---------------------------------------------------------------------------
; SMPS single-PCM update data structure
; ---------------------------------------------------------------------------

sDriverPropertyData:
		dc.w 11-1		; d7
		dc.w -1
	vdpCoord $C000,2,2,WRITE
	asc2.w 0,"TEMPO $00  TICK MUL $00"

		dc.w 2-1, sTempo	; d5/a4
	propdat 0, $C000,9,2,WRITE
	propdat 0, $C000,23,2,WRITE

.fm =	1
.dat =	sFM1
	rept 6
			dc.w .fm
		vdpCoord $C000,2,(.fm+3),WRITE
		asc2.w 0," FM\#.fm"

			dc.w 6-1, .dat		; d5/a4
		propdat 0, $C000,8,(.fm+3),WRITE
		propdat 0, $C000,11,(.fm+3),WRITE
		propdat 0, $C000,14,(.fm+3),WRITE
		propdat 0, $C000,17,(.fm+3),WRITE
		propdat UDP_Word-UDP_Byte, $C000,20,(.fm+3),WRITE
		propdat UDP_Word-UDP_Byte, $C000,25,(.fm+3),WRITE
.fm =	.fm+1
.dat =	.dat-8
	endr

.psg =	1
	rept 3
			dc.w .psg+6
		vdpCoord $C000,2,(.psg+9),WRITE
		asc2.w 0,"PSG\#.psg"

			dc.w 6-1, .dat		; d5/a4
		propdat 0, $C000,8,(.psg+9),WRITE
		propdat 0, $C000,11,(.psg+9),WRITE
		propdat 0, $C000,14,(.psg+9),WRITE
		propdat 0, $C000,17,(.psg+9),WRITE
		propdat UDP_Word-UDP_Byte, $C000,20,(.psg+9),WRITE
		propdat UDP_Word-UDP_Byte, $C000,25,(.psg+9),WRITE
.psg =	.psg+1
.dat =	.dat-8
	endr

		dc.w 0
	vdpCoord $C000,2,13,WRITE
	asc2.w 0," DAC"

		dc.w 6-1, sDAC1		; d5/a4
		propdat 0, $C000,8,13,WRITE
		propdat 0, $C000,11,13,WRITE
		propdat 0, $C000,14,13,WRITE
		propdat 0, $C000,17,13,WRITE
		propdat UDP_Word-UDP_Byte, $C000,20,13,WRITE
		propdat UDP_Word-UDP_Byte, $C000,25,13,WRITE
; ===========================================================================
; ---------------------------------------------------------------------------
; SMPS dual-PCM update data structure
; ---------------------------------------------------------------------------

sDualDriverPropertyData:
		dc.w 12-1		; d7
		dc.w -1
	vdpCoord $C000,2,2,WRITE
	asc2.w 0,"TEMPO $00  TICK MUL $00"

		dc.w 2-1, sTempo	; d5/a4
	propdat 0, $C000,9,2,WRITE
	propdat 0, $C000,23,2,WRITE

.fm =	1
.dat =	sFM1
	rept 6
			dc.w .fm+1
		vdpCoord $C000,2,(.fm+3),WRITE
		asc2.w 0," FM\#.fm"

			dc.w 6-1, .dat		; d5/a4
		propdat 0, $C000,8,(.fm+3),WRITE
		propdat 0, $C000,11,(.fm+3),WRITE
		propdat 0, $C000,14,(.fm+3),WRITE
		propdat 0, $C000,17,(.fm+3),WRITE
		propdat UDP_Word-UDP_Byte, $C000,20,(.fm+3),WRITE
		propdat UDP_Word-UDP_Byte, $C000,25,(.fm+3),WRITE
.fm =	.fm+1
.dat =	.dat-8
	endr

.psg =	1
	rept 3
			dc.w .psg+7
		vdpCoord $C000,2,(.psg+9),WRITE
		asc2.w 0,"PSG\#.psg"

			dc.w 6-1, .dat		; d5/a4
		propdat 0, $C000,8,(.psg+9),WRITE
		propdat 0, $C000,11,(.psg+9),WRITE
		propdat 0, $C000,14,(.psg+9),WRITE
		propdat 0, $C000,17,(.psg+9),WRITE
		propdat UDP_Word-UDP_Byte, $C000,20,(.psg+9),WRITE
		propdat UDP_Word-UDP_Byte, $C000,25,(.psg+9),WRITE
.psg =	.psg+1
.dat =	.dat-8
	endr

		dc.w 0
	vdpCoord $C000,2,13,WRITE
	asc2.w 0,"DAC1"

		dc.w 6-1, sDAC1		; d5/a4
		propdat 0, $C000,8,13,WRITE
		propdat 0, $C000,11,13,WRITE
		propdat 0, $C000,14,13,WRITE
		propdat 0, $C000,17,13,WRITE
		propdat UDP_Word-UDP_Byte, $C000,20,13,WRITE
		propdat UDP_Word-UDP_Byte, $C000,25,13,WRITE

		dc.w 1
	vdpCoord $C000,2,14,WRITE
	asc2.w 0,"DAC2"

		dc.w 6-1, sDAC2		; d5/a4
		propdat 0, $C000,8,14,WRITE
		propdat 0, $C000,11,14,WRITE
		propdat 0, $C000,14,14,WRITE
		propdat 0, $C000,17,14,WRITE
		propdat UDP_Word-UDP_Byte, $C000,20,14,WRITE
		propdat UDP_Word-UDP_Byte, $C000,25,14,WRITE
; ===========================================================================
; ---------------------------------------------------------------------------
; GEMS update data structure
; ---------------------------------------------------------------------------

gDriverPropertyData:
		dc.w 19-1		; d7
		dc.w -1
	vdpCoord $C000,2,2,WRITE
	asc2.w 0,"TEMPO "

		dc.w 1-1, gTempo	; d5/a4
	propdat UDP_Dec22-UDP_Byte, $C000,8,2,WRITE

		dc.w -1
	vdpCoord $C000,14,2,WRITE
	asc2.w 0,"VOL "

		dc.w 1-1, gVolume	; d5/a4
	propdat 0, $C000,18,2,WRITE

		dc.w -1
	vdpCoord $C000,24,2,WRITE
	asc2.w 0,"SEQ "

		dc.w 1-1, gCurSeq	; d5/a4
	propdat 0, $C000,28,2,WRITE

.ch =	0
.dat =	gSeq
	rept 16
			dc.w .ch
		vdpCoord $C000,2,(.ch+4),WRITE
		asc2.w 0," CH\$.ch"

			dc.w 7-1, .dat	; d5/a4
		propdat 0, $C000,7,(.ch+4),WRITE
		propdat 0, $C000,10,(.ch+4),WRITE
		propdat 0, $C000,13,(.ch+4),WRITE
		propdat 0, $C000,16,(.ch+4),WRITE
		propdat 0, $C000,19,(.ch+4),WRITE
		propdat 0, $C000,22,(.ch+4),WRITE
		propdat 0, $C000,25,(.ch+4),WRITE
.ch =	.ch+1
.dat =	.dat+8
	endr
; ===========================================================================
