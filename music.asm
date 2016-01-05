; here is the list of included drivers.
	musinit		; initialize variables
; format:                driver   file      name
; explanation
; driver: the name of the sound driver to use
; file: the filename of the music file to include. must not contain spaces
; name: name to be displayed as information for this file. max 32 characters
	incmusbin	S1_SMPS, ghz, "Green Hill Zone"



; ===========================================================================
; the following will construct all the drivers with the information needed.
; Do not touch this.
; ===========================================================================
MusicFileArrays:
	musfile		; include pointers for all music file

; ===========================================================================
; special entry to display info about stopping music.
MusicStop:
		asc2.w $8000,"Stop music sfx"
		dc.w -1; stop sfx token
; ===========================================================================
; write music name string to screen
; input;
; a5 = pointer to MusPlaying flag
; ===========================================================================
WriteMusicString:
		moveq	#0,d4			; x-position
		moveq	#27,d5			; y-position
		jsr	SetupStringWrite.w	; set position to write to

		moveq	#0,d5			; clear d5
		moveq	#(32/2)-1,d4		; set repeat count
.clr		move.l	d5,(a6)			; clear next 2 letters
		dbf	d4,.clr			; keep clearing

		move.w	(a5),d7			; get music ID
		lea	MusicFileArrays,a0	; get music file array
		move.l	(a0,d7.w),a0		; get the music string data to a0

		moveq	#0,d4			; x-position
		moveq	#27,d5			; y-position
		jmp	WriteString1.w		; display it
