Vectorman_play:
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

Vectorman_dmaon:
		jmp	gemsdmastart

Vectorman_dmaoff:
		jmp	gemsdmaend

Vectorman_update:
		jmp	GEMS_Common_Update

Vectorman_load:
		jsr	GEMS_Load_Driver
		pea	Vectorman_sampbank
		pea	Vectorman_seqbank(pc)
		pea	Vectorman_envbank(pc)
		pea	Vectorman_patchbank(pc)
		jsr	gemsinit
		add.w	#16,sp
		rts

	gSetup Vectorman
Vectorman_patchbank:	gInclude pbank.asm
Vectorman_envbank:	gInclude mbank.asm
Vectorman_seqbank:	gInclude sbank.asm
Vectorman_sampbank:	gInclude dbank.asm
	even
	opt ae+
