Aladdin_play:
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

Aladdin_dmaon:
		jmp	gemsdmastart

Aladdin_dmaoff:
		jmp	gemsdmaend

Aladdin_update:
		jmp	GEMS_Common_Update

Aladdin_load:
		jsr	GEMS_Load_Driver
		pea	Aladdin_sampbank
		pea	Aladdin_seqbank(pc)
		pea	Aladdin_envbank(pc)
		pea	Aladdin_patchbank(pc)
		jsr	gemsinit
		add.w	#16,sp
		rts

	gSetup Aladdin
Aladdin_patchbank:	gInclude pbank.asm
Aladdin_envbank:	gInclude mbank.asm
Aladdin_seqbank:	gInclude sbank.asm
Aladdin_sampbank:	gInclude dbank.asm
	even
	opt ae+
