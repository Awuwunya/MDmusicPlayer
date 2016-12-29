DrawChaninfo:
		move	#$2700,sr			; disable interruptions
		jsr	DriverUpdate(pc)		; update driver data
		jsr	DrawChannels(pc)		; draw active channels
		jsr	UpdateDACProperties(pc)		; updates DAC info
		jsr	UpdateChanProperties(pc)	; update FM and PSG properties
		jsr	UpdateDrvProperties(pc)		; update sound druver properties
		move	#$2300,sr			; enable interruptions
		rts

; ===========================================================================
UpdateDACProperties:
		btst	#1,ActiveChn.w
		beq.s	.noDAC			; branch if DAC is not active

		lea	DACnumber.w,a0		; get DAC data to a0
		moveq	#5,d4
		moveq	#13,d5
		move.b	(a0)+,d3		; get DAC number
		jsr	WriteNumberByte1.w

		move.w	#0,(a6)			; advance to next number
		move.b	(a0)+,d3		; get DAC timer
		jmp	WriteNumberByte2.w

.noDAC		moveq	#0,d7
		moveq	#5,d4
		moveq	#13,d5
		jsr	SetupStringWrite.w	; setup string write
		move.l	d7,(a6)
		move.l	d7,(a6)
		move.l	d7,(a6)			; clear entire DAC area
		rts

; ===========================================================================
UpdateChanProperties:
		lea	ChannelPositions(pc),a0	; get the position of channel data
		movem.l (a0)+,d7/a4-a5		; get aaaaalll the shit from the table
		move.w	ActiveChn.w,d5		; get active channels
		moveq	#9-1,d0			; get the number of channels

.chanloop	moveq	#5-1,d1			; get number of elements
		move.l	(a0)+,(a5)		; get VRAM pointer from table
		btst	d0,d5			; check if the channel is active
		bne.s	.loop			; if is, branch

.clrloop	move.l	d7,(a6)			; clear 2 words
		move.l	d7,(a6)			; clear 2 words
		move.l	d7,(a6)			; clear 2 words
		move.l	d7,(a6)			; clear 2 words
		move.l	d7,(a6)			; clear 2 words
		move.l	d7,(a6)			; clear 2 words
		move.l	d7,(a6)			; clear 2 words
		dbf	d0,.chanloop		; loop for all channels
		rts

.loop		move.b	(a4)+,d3		; get next byte
		jsr	WriteNumberByte2.w	; write to screen

		move.w	d7,(a6)			; add empty space
		dbf	d1,.loop		; loop until done
		dbf	d0,.chanloop		; loop for all channels
		rts
; ===========================================================================

UpdateDrvProperties:
		lea	DriverPropertyData(pc),a0; get data array
		movem.w	(a0)+,d7		; get loads of data

.loop		move.l	(a0)+,(a5)		; set VDP command
		jsr	WriteString3.w		; write the string to screen
		movem.w	(a0)+,d0/d5/a4		; get next 3 words

.infoloop	move.l	(a0)+,(a5)		; set VDP command
		jsr	UDP_Byte(pc,d0.w)	; jump to appropriate code
		dbf	d5,.infoloop		; loop til done
		dbf	d7,.loop		; loop for all
		rts

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

; ===========================================================================
DriverPropertyData:
		dc.w 0			; d7
	vdpComm dc.l,(2*$40)+$C000,VRAM,WRITE
	asc2.w 0,"TEMPO $00  TICK MUL $00"

		dc.w 0, 1, Tempo	; a0/d5/a4
	vdpComm dc.l,(2*$40)+$C00E,VRAM,WRITE
	vdpComm dc.l,(2*$40)+$C02A,VRAM,WRITE
; ===========================================================================

ChannelPositions:
		dc.l 0		; d7
		dc.l PSG3tmul, VDP_control_port ; a4-a5
	vdpComm dc.l,(12*$40)+$C00A,VRAM,WRITE
	vdpComm dc.l,(11*$40)+$C00A,VRAM,WRITE
	vdpComm dc.l,(10*$40)+$C00A,VRAM,WRITE
	vdpComm dc.l,(9*$40)+$C00A,VRAM,WRITE
	vdpComm dc.l,(8*$40)+$C00A,VRAM,WRITE
	vdpComm dc.l,(7*$40)+$C00A,VRAM,WRITE
	vdpComm dc.l,(6*$40)+$C00A,VRAM,WRITE
	vdpComm dc.l,(5*$40)+$C00A,VRAM,WRITE
	vdpComm dc.l,(4*$40)+$C00A,VRAM,WRITE
; ===========================================================================
; draws the ASCII of what channels are active
; ===========================================================================
DrawChannelData:
		dc.l 10-1, 0	; d0-d1
		dc.l VDP_data_port, VDP_control_port, ActiveChnLast	; a1-a3

	vdpComm dc.l,(13*$40)+$C000,VRAM,WRITE
	asc.w 0," DAC"

	vdpComm dc.l,(12*$40)+$C000,VRAM,WRITE
	asc.w 0,"PSG3"

	vdpComm dc.l,(11*$40)+$C000,VRAM,WRITE
	asc.w 0,"PSG2"

	vdpComm dc.l,(10*$40)+$C000,VRAM,WRITE
	asc.w 0,"PSG1"

	vdpComm dc.l,(9*$40)+$C000,VRAM,WRITE
	asc.w 0," FM6"

	vdpComm dc.l,(8*$40)+$C000,VRAM,WRITE
	asc.w 0," FM5"

	vdpComm dc.l,(7*$40)+$C000,VRAM,WRITE
	asc.w 0," FM4"

	vdpComm dc.l,(6*$40)+$C000,VRAM,WRITE
	asc.w 0," FM3"

	vdpComm dc.l,(5*$40)+$C000,VRAM,WRITE
	asc.w 0," FM2"

	vdpComm dc.l,(4*$40)+$C000,VRAM,WRITE
	asc.w 0," FM1"
; ===========================================================================

DrawChannels:
		lea	DrawChannelData(pc),a0
		movem.l (a0)+,d0-d1/a1-a3	; get aaaaalll the shit from the table

		cmpm.w	(a3)+,(a3)+		; compare if last active channels = current active channels
		beq.s	.rts			; if so, branch
		move.w	-(a3),-(a3)		; else copy now active channels to last active channels
		move.w	(a3),d4

.loop		move.l	(a0)+,(a2)		; get the control address
		btst	d0,d4			; check if channel is used
		beq.s	.nochan			; branch if not

		move.l	(a0)+,(a1)		; copy long to VRAM
		move.l	(a0)+,(a1)		; copy long to VRAM
		dbf	d0,.loop		; loop until done
		rts

.nochan		move.l	d1,(a1)			; copy null to VRAM
		move.l	d1,(a1)			; copy null to VRAM
		addq.w	#8,a0
		dbf	d0,.loop		; loop until done
.rts		rts
; ===========================================================================

DriverUpdate:
		moveq	#0,d0
		move.b	LoadedDriver.w,d0	; get sound driver to d0
		bmi.s	.nope			; special case: load stop sfx driver

		move.l	DrvUpdateCodes(pc,d0.w),a1; get the right entry to a1
	stopZ80					; request z80 bus
		jsr	(a1)			; run driver update code
	startZ80				; return z80 bus
.nope		rts

; ===========================================================================
DrvUpdateCodes:		drvupd
