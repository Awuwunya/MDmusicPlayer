; ===========================================================================
EntryPoint:
		tst.l	HW_Port_1_Control-1	; test port A control
		bne.s	PortA_Ok
		tst.w	HW_Expansion_Control-1	; test port C control

PortA_Ok:
		bne.s	PortC_Ok
		lea	SetupValues(pc),a5
		movem.w	(a5)+,d5-d7
		movem.l	(a5)+,a0-a4
		move.b	-$10FF(a1),d0	; get hardware version
		andi.b	#$F,d0
		beq.s	SkipSecurity
		move.l	Console.w,$2F00(a1)

SkipSecurity:
		move.w	(a4),d0		; check	if VDP works
		moveq	#0,d0
		movea.l	d0,a6
		move.l	a6,usp		; set usp to $0

		moveq	#$17,d1
VDPInitLoop:
		move.b	(a5)+,d5	; add $8000 to value
		move.w	d5,(a4)		; move value to	VDP register
		add.w	d7,d5		; next register
		dbf	d1,VDPInitLoop

		move.l	(a5)+,(a4)
		move.w	d0,(a3)		; clear	the screen
		move.w	d7,(a1)		; stop the Z80
		move.w	d7,(a2)		; reset	the Z80

WaitForZ80:
		btst	d0,(a1)		; has the Z80 stopped?
		bne.s	WaitForZ80	; if not, branch
		moveq	#$25,d2
Z80InitLoop:
		move.b	(a5)+,(a0)+
		dbf	d2,Z80InitLoop

		move.w	d0,(a2)
		move.w	d0,(a1)		; start	the Z80
		move.w	d7,(a2)		; reset	the Z80
ClrRAMLoop:
		move.l	d0,-(a6)
		dbf	d6,ClrRAMLoop	; clear	the entire RAM

		move.l	(a5)+,(a4)	; set VDP display mode and increment
		move.l	(a5)+,(a4)	; set VDP to CRAM write
		moveq	#$1F,d3
ClrCRAMLoop:
		move.l	d0,(a3)
		dbf	d3,ClrCRAMLoop	; clear	the CRAM

		move.l	(a5)+,(a4)
		moveq	#$13,d4

ClrVDPStuff:
		move.l	d0,(a3)
		dbf	d4,ClrVDPStuff

		moveq	#3,d5
PSGInitLoop:
		move.b	(a5)+,$11(a3)	; reset	the PSG
		dbf	d5,PSGInitLoop

		move.w	d0,(a2)
		movem.l	(a6),d0-a6	; clear	all registers
		move	#$2700,sr	; set the sr

PortC_Ok:
		move.b	HW_Version,d0		; get System version bits
		andi.b	#$C0,d0
		move.b	d0,HWVersion.w		; save into RAM
		jsr	InitControllers		; initialize controllers
		bra.w	GameProgram

; ===========================================================================
SetupValues:	dc.w $8000		; XREF: PortA_Ok
		dc.w $3FFF
		dc.w $100

		dc.l $A00000		; start	of Z80 RAM
		dc.l $A11100		; Z80 bus request
		dc.l $A11200		; Z80 reset
		dc.l $C00000
		dc.l $C00004		; address for VDP registers

		dc.b 4,	4, $30, $3C	; values for VDP registers
		dc.b 7,	$6C, 0,	0
		dc.b 0,	0, $FF,	0
		dc.b 0, $37, 0, 1
		dc.b 0,	0, 0, $FF
		dc.b $FF, 0, 0,	$80

		dc.l $40000080

		dc.b $AF, 1, $D9, $1F, $11, $27, 0, $21, $26, 0, $F9, $77 ; Z80	instructions
		dc.b $ED, $B0, $DD, $E1, $FD, $E1, $ED,	$47, $ED, $4F
		dc.b $D1, $E1, $F1, 8, $D9, $C1, $D1, $E1, $F1,	$F9, $F3
		dc.b $ED, $56, $36, $E9, $E9

		dc.w $8174		; value	for VDP	display	mode
		dc.w $8F02		; value	for VDP	increment
NullUpdateList:
		dc.l $C0000000		; value	for CRAM write mode
		dc.l $40000010

		dc.b $9F, $BF, $DF, $FF	; values for PSG channel volumes

SoundSelectStr:	dc.w (ResetProgram-SoundSelectStr)/2-2
	asc.w $8000,'  DMA length:$00D0              '
	asc.w $8000,'  Currently playing:$0000       '
	asc.w $8000,'  Play music:$0000         Name:'
	asc.w $8000,'  Stop music'
; ===========================================================================

ResetProgram:
		move.w	SetupValues+2(pc),d1	; get length
		moveq	#0,d0			; get 0
		move.w	d0,a0			; set RAM start

.loop		move.l	d0,-(a0)		; clear next word of RAM
		dbf	d1,.loop		; clear entire RAM

GameProgram:
		move.w	#Stack,sp		; reset stack ptr
		lea	VScrollRAM.w,a0		; get vertical scroll RAM
		moveq	#(80/4)-1,d0		; amount of segments to write to
		moveq	#8*4,d1			; set Vscroll amount

.load1		move.l	d1,(a0)+		; copy 1 segment
		dbf	d0,.load1		; loop until done

		lea	SystemPalette.w,a0	; get system palette
		lea	MainPalette.w,a1	; get the palette file
		moveq	#3-1,d0			; get length

.load2		move.w	(a0)+,(a1)+		; copy 1 entry
		dbf	d0,.load2		; loop until done
		move.w	#$4E75,Driver68K	; put RTS in 68k RAM
		move.b	#-1,LoadedDriver.w	; no sound driver loaded
		move.b	#TYPE_NULL,DriverType.w	;
		move.l	#NullUpdateList,DisplayList.w; reset update list to no updates

	; fill Plane A+B with 0
		dmaFillVRAM 0,$4000,$C000,0

	; load system font
		lea	SystemFont,a0		; get system font
		lea	$FF0000,a1		; get start of RAM
		jsr	KosDec			; decompress the art

		lea	VDP_control_port,a6
.waitFillDone	move.w	(a6),d1
		btst	#1,d1
		bne.s	.waitFillDone
		move.w	#$8F02,(a6) 		; VRAM pointer increment: $0002

	dma68kToVDP $FF0000,$20,$BC0,VRAM	; DMA font art
		move	#$2300,sr		; enable vertical interrupts

	; right here we initialize what you see onscreen
		lea	SoundSelectStr(pc),a0	; get sound select string
		moveq	#22,d5			; text y-position
		moveq	#0,d4			; text x-position
		jsr	WriteString1.w		; display it

	; program start

