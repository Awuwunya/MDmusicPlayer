VBlank:
		movem.l	d0-a6,-(sp)
		bsr.s	ReadControllers			; read controller input

		tst.b	LoadedDriver			; has driver been loaded?
		bmi.s	.nope				; branch if not
		bsr.w	FakeDMA				; do a fake DMA to VRAM and stop z80
		jsr	Driver68K			; run sound driver code
.draw		jsr	DrawChaninfo			; draw information about active channels
		movem.l	(sp)+,d0-a6
		rte

.nope		clr.w	ActiveChn.w			; clear active channel list
	dma68kToVDP MainPalette,0,$80,CRAM	; DMA palette to CRAM
	dma68kToVDP VScrollRAM, 0, 80,VSRAM	; DMA Vertical scrolling to VSRAM
		bra.s	.draw
; ===========================================================================

ReadControllers:
		lea	Ctrl1Held.w,a0		; get held buttons array
		lea	HW_Port_1_Data,a1
		bsr.s	.readone		; poll first controller
		addq.w	#2,a1			; poll second controller

.readone	move.b	#0,(a1)			; Poll controller data port
		nop
		nop
		move.b	(a1),d0			; Get controller port data (start/A)
		lsl.b	#2,d0
		andi.b	#$C0,d0
		move.b	#$40,(a1)		; Poll controller data port again
		nop
		nop
		move.b	(a1),d1			; Get controller port data (B/C/Dpad)
		andi.b	#$3F,d1
		or.b	d1,d0			; Fuse together into one controller bit array
		not.b	d0
		move.b	(a0),d1			; Get press button data
		eor.b	d0,d1			; Toggle off buttons that are being held
		move.b	d0,(a0)+		; Put raw controller input (for held buttons) in F604/F606
		and.b	d0,d1
		move.b	d1,(a0)+		; Put pressed controller input in RAM
		rts
; End of function Poll_Controller
; ===========================================================================

InitControllers:
;	stopZ80
		moveq	#$40,d0
		move.b	d0,(HW_Port_1_Control).l
		move.b	d0,(HW_Port_2_Control).l
		move.b	d0,(HW_Expansion_Control).l
;	startZ80
		rts
; End of function Init_Controllers
; ===========================================================================

VSync:
		stop	#$2300		; enable ints and stop CPU
		rts			; return
; ===========================================================================

FakeDMA:
	stopZ80				; stop z80 for the duration of the experiment

		move.w	DMAlen.w,d0	; get DMA length setting
		move.w	.offs(pc,d0.w),d1; get offset to the routine
		jmp	.offs(pc,d1.w)	; jump to it
; ===========================================================================
.offs	dc.w .0xD0-.offs
	if extremeDMA=1
		dc.w .0x4000-.offs
		dc.w .0x2000-.offs
	endif
	dc.w .0x1000-.offs
	dc.w .0x900-.offs
	dc.w .0x680-.offs
; ===========================================================================

	if extremeDMA=1
.0x4000		dma68kToVDP 0,$400*32,$1000,VRAM
		dma68kToVDP 0,$400*32,$1000,VRAM
.0x2000		dma68kToVDP 0,$400*32,$2000-$1000,VRAM
	endif
.0x1000	dma68kToVDP 0,$400*32,$1000-$900,VRAM
.0x900	dma68kToVDP 0,$400*32,$900-$680,VRAM
.0x680	dma68kToVDP 0,$400*32,$900-$680,VRAM
.0xD0	dma68kToVDP VScrollRAM, 0, 80,VSRAM	; DMA Vertical scrolling to VSRAM
	dma68kToVDP MainPalette,0,$80,CRAM	; DMA palette to CRAM
	startZ80			; start z80 up!
		rts

FakeDMAsz:
	asc.w 0,'00D0'; minimal
	if extremeDMA=1
		asc.w 0,'4000'; extremely a lot
		asc.w 0,'2000'; very lot
	endif
	asc.w 0,'1000'; a lot
	asc.w 0,'0900'; usual max
	asc.w 0,'0680'; normal
