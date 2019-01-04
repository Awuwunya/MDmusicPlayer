
; this macro is created to emulate enum in AS
enum	macro	num, lable
; copy initial number for referencing later
.num =	num

	rept narg-1
\lable		set .num
.num =	.num+1
	shift
	endr
    endm

; simple macro to create a Z80 pointer (relative to bank)
Z80PtrROM	macro addr
	rept narg
		dc.w	(((\addr)<<8)&$FF00)|(((\addr)>>8)&$FF)|$80
		shift
	endr
    endm

; simple macro to create little endian word values
littleEndian	macro value
	rept narg
		dc.w	(((\value)<<8)&$FF00)|(((\value)>>8)&$FF)
		shift
	endr
    endm
; ---------------------------------------------------------------------------------------------
; Note Equates
	enum $00,    nRst,nC0,nCs0,nD0,nEb0,nE0,nF0,nFs0,nG0,nAb0,nA0,nBb0,nB0,nC1,nCs1,nD1
	enum nD1+1,  nEb1,nE1,nF1,nFs1,nG1,nAb1,nA1,nBb1,nB1,nC2,nCs2,nD2,nEb2,nE2,nF2,nFs2
	enum nFs2+1, nG2,nAb2,nA2,nBb2,nB2,nC3,nCs3,nD3,nEb3,nE3,nF3,nFs3,nG3,nAb3,nA3,nBb3
	enum nBb3+1, nB3,nC4,nCs4,nD4,nEb4,nE4,nF4,nFs4,nG4,nAb4,nA4,nBb4,nB4,nC5,nCs5,nD5
	enum nD5+1,  nEb5,nE5,nF5,nFs5,nG5,nAb5,nA5,nBb5,nB5,nC6,nCs6,nD6,nEb6,nE6,nF6,nFs6
	enum nFs6+1, nG6,nAb6,nA6,nBb6,nB6,nC7,nCs7,nD7,nEb7,nE7,nF7,nFs7,nG7,nAb7,nA7,nBb7

; ---------------------------------------------------------------------------------------------
; Helper macros

	rsset 0
gPatFM		rs.b 1
gPatDAC		rs.b 1
gPatPSG		rs.b 1
gPatNoise	rs.b 1

; macro to setup index ptr
gSetOffset	macro
gcof =	offset(*)
	opt ae-
    endm

; macro to set base path of ginclude
gSetup		macro path
gipat	EQUS '\path'
    endm

gIncbin		macro path
	incbin "GEMS/\gipat\/\path"
    endm

gInclude	macro path
	include "GEMS/\gipat\/\path"
    endm

; macro for setting offsets
gOffset		macro off, index
	if narg=1
		littleEndian \off-gcof
	else
		littleEndian \off-\index
	endif
    endm

gOffset3	macro off, index
	littleEndian \off-\index
	dc.b (\off-\index)>>16
    endm

; ---------------------------------------------------------------------------------------------
; Header macros

gdLoop =	1<<4
gdNoteStop =	1<<5

gSample		macro ptr, skip, len, loop, end, type
	dc.b \type
	gOffset3 \ptr, gcof
	littleEndian \skip, \len, \loop, \end
    endm

gChannel	macro ptr, arg1
	gOffset \ptr, gcof
    endm

gChannel3	macro ptr, arg1
	gOffset3 \ptr, gcof
    endm

; ---------------------------------------------------------------------------------------------
; Sequence macros

; 60 - Stops playing the channel (End of Stream)
gStop		macro
	dc.b 96			; seqeos
    endm

; 61xx - Sets the patch to use for this channel. xx is the id
gsPatch		macro id
	dc.b 97, \id		; seqpchange
    endm

; 62xx - Sets the envelope to use for this channel. xx is the id
gsEnv		macro id
	dc.b 98, \id		; seqenv
    endm

; 63 - Retrigger delay
gNop		macro
	dc.b 99			; seqdelay
    endm

; 64xx - Loop start point. Loop xx times. If xx is $7F or greater, it is an infinite loop
gLoopStart	macro count
	if narg=0
		dc.b 100, $7F	; seqsloop
	else
		dc.b 100, \count
	endif
    endm

; 65 - Loop end point
gLoopEnd	macro
	dc.b 101		; seqeloop
    endm

; 66 - Toggle retrigger mode
gRetrig		macro
	dc.b 102		; seqretrig
    endm

; 67 - Toggle sustain mode
gHold		macro
	dc.b 103		; seqsus
    endm

; 68 - Set sequence tempo
gsTempo		macro tempo
	dc.b 104, \tempo-40	; seqtempo
    endm

; 69xx - Mute channel. xx is channel id
gMute		macro ch
	dc.b 105, \ch|$10	; seqmute
    endm

; 69xx - Unmute channel. xx is channel id
gUnmute		macro ch
	dc.b 105, \ch		; seqmute
    endm

; 6Axx - Set channel priority to xx
gsPrio		macro val
	dc.b 106, \val		; seqprio
    endm

; 6Bxx - Starts a sequence with ID xx
gStartSeq	macro id
	dc.b 107, \id		; seqssong
    endm

; 6Cxxxx - Set pitch bend to xxxx
gPitBend	macro val
	dc.b 108		; seqpbend
	littleEndian	\val
    endm

; 6D - Uae SFX-based timer
gSFX		macro
	dc.b 109		; seqsfx
    endm

; 6Exx - Set sample rate to xx
; if xx is 04, then use default sample rate
; 05 - 10.4 KHz
; 06 -  8.7 KHz
; 07 -  7.3 KHz
; 08 -  6.5 KHz
; 09 -  5.8 KHz
; 0A -  5.2 KHz
gsSampleRate	macro rete
	dc.b 110, \rete		; seqsamprate
    endm

; 6Fxxxx - Call data at $+xxxx
gCall		macro ptr
	dc.b 111		; seqgoto
	gOffset \ptr, offset(*)
    endm

; 70xxyy - Put value yy to mailbox xx
gStore		macro box, value
	dc.b 112, \box, \value	; seqstore
    endm

; 71xxccyyzz - Check if mailbox xx contains value yy, with condition cc
; if succeeds, jump to $+00zz
;   cc - condition
;   xx - mailbox
;   yy - compare with value yy
;   zz - offset to jump to if condition succeeds ($+00zz)

gIfeq		macro box, value, ptr
	dc.b 113, \box, 0, \value, \ptr-offset(*)	; seqifeq
    endm

gIfne		macro box, value, ptr
	dc.b 113, \box, 1, \value, \ptr-offset(*)	; seqifne
    endm

gIfgt		macro box, value, ptr
	dc.b 113, \box, 2, \value, \ptr-offset(*)	; seqifgt
    endm

gIfge		macro box, value, ptr
	dc.b 113, \box, 3, \value, \ptr-offset(*)	; seqifgte
    endm

gIflt		macro box, value, ptr
	dc.b 113, \box, 4, \value, \ptr-offset(*)	; seqiflt
    endm

gIfle		macro box, value, ptr
	dc.b 113, \box, 5, \value, \ptr-offset(*)	; seqiflte
    endm

; 7200xx - Stop the sequence xx
gStopSeq	macro id
	dc.b 114, 0, \id	; seqstopseq
    endm

; 7201xx - Pause the sequence xx
gPauseSe	macro id
	dc.b 114, 1, \id	; seqpauseseq
    endm

; 7202xx - Unpause the sequence xx
gUnpauseSeq	macro id
	dc.b 114, 2, \id	; seqresume
    endm

; 7203xx - Pause the sequence in mailbox
gPauseSeq2	macro
	dc.b 114, 3		; seqpauselmusic
    endm

; 7204xx - Set global attentunation to xx
gsVolumeAll	macro id
	dc.b 114, 4, \id	; seqatten
    endm

; 7205xx - Set channel attentunation to xx
gsVolume	macro id
	dc.b 114, 5, \id	; seqchatten
    endm
