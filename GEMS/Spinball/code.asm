; ===========================================================================
; ---------------------------------------------------------------------------
; Play a sequence
; ---------------------------------------------------------------------------

Spinball_play:
		move.l	d7,a0			; put address to a0
		move.b	1(a0),gCurSeq.w		; set currently playing sequence
		move.w	(a0),-(sp)		; push the music ID
		clr.w	-(sp)			; then push 0 to stack

		jsr	gemsstopall		; stop all music
	; num is already in stack
		jsr	gemsstartsong		; start song
		addq.w	#4,sp			; pop
		clr.l	gMutedChs.w		; clear muted channels
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Enable DMA
; ---------------------------------------------------------------------------

Spinball_dmaon:
		jmp	gemsdmastart
; ===========================================================================
; ---------------------------------------------------------------------------
; Disable DMA
; ---------------------------------------------------------------------------

Spinball_dmaoff:
		jmp	gemsdmaend
; ===========================================================================
; ---------------------------------------------------------------------------
; Update GEMS
; ---------------------------------------------------------------------------

Spinball_update:
		jmp	GEMS_Common_Update
; ===========================================================================
; ---------------------------------------------------------------------------
; Load GEMS bank data
; ---------------------------------------------------------------------------

Spinball_load:
		jsr	GEMS_Load_Driver
		pea	Spinball_sampbank
		pea	Spinball_seqbank(pc)
		pea	Spinball_envbank(pc)
		pea	Spinball_patchbank(pc)
		jsr	gemsinit
		add.w	#16,sp
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Setup GEMS data
; ---------------------------------------------------------------------------

	gSetup Spinball
Spinball_patchbank:	gInclude pbank.asm
Spinball_envbank:	gInclude mbank.asm
Spinball_seqbank:	gInclude sbank.asm
Spinball_sampbank:	gInclude dbank.asm
	even
	opt ae+
; ===========================================================================
