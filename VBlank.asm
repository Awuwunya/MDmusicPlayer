VBlank:
		movem.l	d0-a6,-(sp)
	dma68kToVDP	MainPalette, 0, $80, CRAM	; DMA palette to CRAM
	dma68kToVDP	VScrollRAM, 0, 80, VSRAM	; DMA Vertical scrolling to VSRAM

		bsr.s	ReadControllers			; read controller input
		tst.b	LoadedDriver			; has driver been loaded?
		bmi.s	.nope				; branch if not
		jsr	Driver68K			; run sound driver code
		jsr	DrawChaninfo			; draw information about active channels

		btst	#5,Ctrl1Press.w
		beq.s	.nope
		eori.w	#-1,ActiveChn.w

.nope		movem.l	(sp)+,d0-a6
		rte
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
; ======================================		=====================================
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

