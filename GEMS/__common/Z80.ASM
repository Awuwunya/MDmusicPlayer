	include "..\..\code\LANG Z80.ASM"
	org 0
	z80prog 0

; GEMS Driver - 2.5 5/21/92 (pz.s projector version 7)
; Copyright (c) 1991,1992 SEGA
; All Rights Reserved
;Z80Code		proc	;export	; NAT: This is not needed anymore
************************************* MACRO SECTION ******************************************

; NAT: There are some macros missing from the source. I took them from GEMSSCD.
; Thanks to ValleyBell for linking this archive. Translated from SNASM68K (I am assuming)

* Requires H = data, L = register number
FMwrgl	macro
	bit	7,(IY+0)	; test fm chip status
	jr	NZ,*-4		; wait for clear
	ld	A,L
	ld	(4000H),A	; write global register number
	ld	A,H
	ld	(4001H),A	; write data
	endm                    ; done

FMwait	macro
	bit	7,(IY+0)	; test fm chip status
	jr	NZ,*-4		; wait for clear
	endm                    ; done

* FMWrite and FMWrch expect IY to contain either 4000H or 4002H
* destroys A
FMWrite	macro reg, data
	ld	A,\data		; load data
	bit	7,(IY+0)	; test fm chip status
	jr	NZ,*-4		; wait for clear
	ld	(IY+0),\reg	; write register number
	ld	(IY+1),A	; write data
	endm			; done

* destroys A
FMWrch	macro reg, ch, data
	bit	7,(IY+0)	; test fm chip status
	jr	NZ,*-4		; wait for clear
	ld	A,\ch		; load channel number
	zadd	A,\reg		; add register number
	ld	(IY+0),A	; write register number
	ld	A,\data		; load data
	ld	(IY+1),A	; write data
	endm			; done

FMWr		macro reg, data
		ld	L,0		; point initially at status register
		ld	A,\reg		; get reg num for this channel
		zadd	A,E
		ld	B,A		; B <- register number (parameter) offset for this channel
		ld	C,\data
		ld	A,80H		; mask for busy bit

		zand	(HL)		; test fm chip status
		jp	M,*-2		; still busy - wait for clear

		ld	L,D		; point at appropriate bank
		ld	(HL),B		; write regnum
		inc	L		; point to data
		ld	(HL),C		; write data

		endm			; done

************************************* RESET VECTOR *******************************************

Z80CODEBASE
		di
		im      1
		ld	SP,STACKINIT
		jp      init

*********************************** 60 Hz Interrupt ******************************************

* but first, let's squeeze in a few variables...

psgcom		db	00H,00H,00H,00H		;  0 command 1 = key on, 2 = key off, 4 = stop snd
psglev		db	0ffH,0ffH,0ffH,0ffH	;  4 output level attenuation (4 bit)
psgatk		db	00H,00H,00H,00H		;  8 attack rate
psgdec		db	00H,00H,00H,00H		; 12 decay rate
psgslv		db	00H,00H,00H,00H		; 16 sustain level attenuation
psgrrt		db	00H,00H,00H,00H		; 20 release rate
psgenv		db	00H,00H,00H,00H		; 24 envelope mode 0 = off, 1 = attack, 2 = decay, 3 = sustain, 4
psgdtl		db	00H,00H,00H,00H		; 28 tone bottom 4 bits, noise bits
psgdth		db      00H,00H,00H,00H		; 32 tone upper 6 bits
psgalv		db      00H,00H,00H,00H		; 36 attack level attenuation
whdflg		db      00H,00H,00H,00H		; 40 flags to indicate hardware should be updated

		db	0

CMDWPTR		db	0			; cmd fifo wptr @ $36
CMDRPTR		db	0			; read pointer @ $37

*** psg command processor/envelope emulator

COM		equ	0
LEV		equ	4
ATK		equ	8
DKY		equ	12
SLV		equ	16
RRT		equ	20
MODE		equ	24
DTL		equ	28
DTH		equ	32
ALV		equ	36
FLG		equ	40

VBLINT
		ld	(TICKFLG),SP		; msb of SP in TICKFLG+1 will be >0
		reti                    	; leave disabled - will be enabled by CHECKTICK

TICKFLG		dw	0			; (TICKFLG+1) set by ^^
TICKCNT		db	0			; tick accumulated by CHECKTICK

CHECKTICK					; (if TICKFLG+1 is set, then ints are disabled!)
		di
		push	AF
		push	HL
		ld	HL,TICKFLG+1
		ld	A,(HL)			; check TICKFLG+1
		zor	A
		jr	Z,ctnotick		; return if not set yet

						; at this point, can't reenable ints until we're
						; sure VBL (64 uS) has gone away, so do some
						; DACMEs and a delay (in case DACME is off)

		ld	(HL),0			; clear flag (ints are disabled!)
		inc	HL			; point to counter
		inc	(HL)			; and inc it

		call	DACME

		push	DE
		ld	HL,(SBPTACC)		; add sub beats per tick to its accumulator
		ld	DE,(SBPT)
		zadd	HL,DE
		ld	(SBPTACC),HL		; this is all 8 frac bits, so (SBPTACC+1)
		pop	DE				;   is the # of subbeats gone by

		call	DACME
ctnotick
		pop	HL
		pop	AF
		ei
		ret

DOPSGENV
		ld      IY,psgcom		; load psg pseudo registers
		ld      HL,7F11H		; load hardware register address
		ld      D,80H			; load command mask
		ld      E,4			; load loop counter

vloop		call	DACME
		ld	C,(IY+COM)		; load command bits
		ld      (IY+COM),0		; clear command bits

stop		bit     2,C             	; test bit 2
		jr      Z,ckof          	; nope...
		ld      (IY+LEV),0FFH   	; reset output level
		ld      (IY+FLG),1      	; flag hardware update
		ld      (IY+MODE),0     	; shut off envelope processing
		ld	A,1
		cp	E			; was this TG4 (noise)
		jr	NZ,ckof
		ld	IX,PSGVTBLTG3		; yes - clear locked bit in TG3
		res	5,(IX+0)		; NAT: Was (IX)

ckof		bit     1,C             	; test bit 1
		jr      Z,ckon          	; nope...
		ld      A,(IY+MODE)     	; load envelope mode
		cp      0               	; check for key on
		jr      Z,ckon          	; nope...
		ld      (IY+FLG),1      	; flag hardware update
		ld      (IY+MODE),4     	; switch to envelope release phase

ckon		bit     0,C             	; test bit 0
		jr      Z,envproc       	; nope...
		ld      (IY+LEV),0FFH   	; reset level
		ld      A,(IY+DTL)      	; load tone lsb
		zor     D               	; mix with command stuff
		ld      (HL),A          	; write tone lsb or noise data
		ld	A,1               	; check for last channel ***BAS***
		cp      E               	; is it?
		jr      Z,nskip         	; skip msb set (noise channel)
		ld      A,(IY+DTH)      	; load tone msb
		ld      (HL),A          	; write tone msb
nskip		ld      (IY+FLG),1      	; flag hardware update
		ld      (IY+MODE),1     	; initiate envelope processing (attack phase)

envproc		call	DACME
		ld      A,(IY+MODE)     	; load envelope phase
		cp      0               	; test for on/off
		jp      Z,vedlp         	; off.
		cp      1               	; attack mode?
		jr      NZ,chk2         	; nope...

mode1		ld      (IY+FLG),1      	; flag hardware update
		ld      A,(IY+LEV)      	; load level
		ld      B,(IY+ALV)      	; load attack level
		zsub    (IY+ATK)        	; subtract attack rate
		jr      C,atkend        	; attack finished
		jr      Z,atkend        	; attack finished
		cp      B               	; test level
		jr      C,atkend        	; attack finished
		jr      Z,atkend        	; attack finished
		ld      (IY+LEV),A      	; save new level
		jp      vedlp           	; done
atkend		ld      (IY+LEV),B      	; save attack level as new level
		ld      (IY+MODE),2     	; switch to decay mode
		jp      vedlp           	; done

chk2		cp      2               	; decay mode?
		jp      NZ,chk4         	; nope...

mode2		ld      (IY+FLG),1      	; flag hardware update
		ld      A,(IY+LEV)      	; load level
		ld      B,(IY+SLV)      	; load sustain level
		cp      B               	; compare levels
		jr      C,dkadd         	; add to decay
		jr      Z,dkyend        	; decay finished
		zsub     (IY+DKY)        	; subtract decay rate
		jr	C,dkyend		; if the sub caused a wrap then we're done
		cp      B               	; compare levels
		jr      C,dkyend        	; decay finished
		jr      dksav          		; save decay
dkadd		zadd     A,(IY+DKY)     	; add decay rate
		jr	C,dkyend		; caused a wrap - we're done
		cp      B               	; compare levels
		jr      NC,dkyend       	; decay finished
dksav		ld      (IY+LEV),A      	; save level
		jr      vedlp           	; done
dkyend		ld      (IY+LEV),B      	; save sustain level
		ld      (IY+MODE),3     	; set sustain mode
		jr      vedlp           	; done

chk4		cp      4               	; check for sustain phase
		jr      NZ,vedlp        	; nope
mode4		ld      (IY+FLG),1      	; flag hardware update
		ld      A,(IY+LEV)      	; load level
		zadd    A,(IY+RRT)      	; add release rate
		jr      C,killenv       	; release finished
		ld      (IY+LEV),A      	; save new level
		jr      vedlp           	; done
killenv		ld      (IY+LEV),0FFH   	; reset level
		ld      (IY+MODE),0     	; reset envelope mode
		ld	A,1
		cp	E			; was this TG4 we just killed?
		jr	NZ,vedlp
		ld	IX,PSGVTBLTG3		; yes - clear locked bit in TG3
		res	5,(IX+0)		; NAT: Was (IX)

vedlp		inc     IY              	; point to next channel registers
		ld      A,20H           	; for tone command byte fixup
		zadd     A,D             	; add tone command byte
		ld      D,A             	; move back into D
		dec     E              		; decrement counter
		jp      NZ,vloop        	; until done ***BAS***

		call	DACME

		ld      IY,psgcom       	; reset psg envelope pointer

uch1		bit     0,(IY+FLG)      	; test update flag
		jr      Z,uch2          	; next channel
		ld      (IY+FLG),0      	; clear update flag
		ld      A,(IY+LEV)      	; load level
		srl     A
		srl     A
		srl     A
		srl     A
		zor      90H            	; set command bits
		ld      (HL),A          	; write new level

uch2		bit     0,(IY+FLG+1)    	; test update flag
		jr      Z,uch3          	; next channel
		ld      (IY+FLG+1),0    	; clear update flag
		ld      A,(IY+LEV+1)    	; load level
		srl     A
		srl     A
		srl     A
		srl     A
		zor      0B0H            	; set command bits
		ld      (HL),A          	; write new level

uch3		bit     0,(IY+FLG+2)    	; test update flag
		jr      Z,uch4          	; next channel
		ld      (IY+FLG+2),0    	; clear update flag
		ld      A,(IY+LEV+2)    	; load level
		srl     A
		srl     A
		srl     A
		srl     A
		zor	0D0H			; set command bits
		ld      (HL),A          	; write new level

uch4		bit     0,(IY+FLG+3)    	; test update flag
		jr      Z,vquit         	; next channel
		ld      (IY+FLG+3),0    	; clear update flag
		ld      A,(IY+LEV+3)    	; load level
		srl     A
		srl     A
		srl     A
		srl     A
		zor      0F0H			; set command bits
		ld      (HL),A          	; write new level

vquit		call	DACME
		ret


****************************** Command FIFO (from 68000) *************************************

*
*  GETCBYTE - returns the next command byte in the fifo from the 68k. will wait
*    for one if the queue is empty when called.
*
*	parameters:	NONE
*	returns:	A	byte from queue
*

GETCBYTE	push	BC
		push	HL

getcbytel	call	DACME
		call	FILLDACFIFO

		ld	A,(CMDWPTR)
		ld	B,A
		ld	A,(cmdrptr)		; compare read and write pointers
		cp	B
		jr	Z,getcbytel		; loop if equal

		ld	B,0
		ld	C,a			; BC gets 16 bit read ptr
		ld	HL,cmdfifo		; IX points at fifo

		call	DACME

		zadd	HL,BC			; add 'em
		inc	A			; increment read ptr
		zand	3FH			;  (mod 64)
		ld	(cmdrptr),A
		ld	A,(HL)			; read actual entry
		pop	HL
		pop	BC
		ret

**************************************  XFER68K  *****************************************

*
*  XFER68K - transfers 1 to 255 bytes from 68000 space to Z80. handles 32k block crossings.
*
*	parameters:		A	68k source address [23:16]
*				HL	68k source address [15:0]
*				DE	Z80 dest address
*				C	byte count (0 is illegal!)
*
*	trashes:		B
*

x68ksrclsb	db	0			; for storing lsw of src addr
x68ksrcmid	db	0

XFER68K

	call	DACME

		push	IX			; save IX - use it to point to DMA block flags
		ld	IX,MBOXES

		ld	(x68ksrclsb),HL		; save src addr[15:0]
		res	7,H			; HL <- src addr[14:0]
		ld	B,0
		dec	C			; BC <- count-1
		zadd	HL,BC			; HL addr within 32k byte bank of last byte to xfer
		bit	7,H			; is it in the next bank?
		jr	NZ,x68kcrosses

		ld	HL,(x68ksrclsb)		; single bank - easy: get back src addr[15:0]
		inc	C			; C <- byte count
		ld	B,A			; B <- src addr msb

		call	xfer68ksafe

		pop	IX
		ret

x68kcrosses					; C = count-1, L=over-1
		ld	B,A			; B <- src addr msb
		push	BC			; push src addr msb (B)
		push	HL			; push over-1 (L)
		ld	A,C
		zsub	L
		ld	C,A			; C <- C - L = count - over (byte count for 1st part)
		ld	HL,(x68ksrclsb)		; HL <- src addr[15:0]

		call	xfer68ksafe		; xfer away

		pop	HL			; L <- over-1
		pop	BC			; B <- src addr msb
		ld	C,L
		inc	C			; C <- over count
		ld	A,(x68ksrcmid)
		zand	80H
		zadd	A,80H
		ld	H,A
		ld	L,0			; HL <- lsw of start of next bank
		jr	NC,x68knocarry
		inc	B			; inc msb if lsw carried
x68knocarry
		call	xfer68ksafe		; xfer away

		pop	IX
		ret

* xfer68kinner - inner loop of XFER68K
*
*	parameters:		B	68k source address [23:16]
*				HL	68k source address [15:0]
*				DE	Z80 dest address
*				C	byte count (0 is illegal, as is any count which would
*					  result in a 32k block crossing in 68k space
*	trashes:		A

xfer68ksafe
xfer68kinner

	call	DACME
		push	DE
		ld	DE,6000H		; point to bank select register
		ld	A,H
		rlc	A			; send addr[15]
		ld	(DE),A
		ld	A,B
		ld	(DE),A			; send addr[16] to addr[23]
		rra
		ld	(DE),A
		rra
		ld	(DE),A
		rra
		ld	(DE),A
		rra
		ld	(DE),A
		rra
		ld	(DE),A
		rra
		ld	(DE),A
		rra
		ld	(DE),A			; 32k byte bank is now selected

		pop	DE			; DE <- dest addr
		zset	7,H			; HL <- source addr, in 32k byte bank window
		ld	A,C			; A <- byte count
		ld	B,0			; clear msb of BC

	call	DACME

		zset	0,(IX+1)		; MBOX[1] tells 68k that Z80 might be xfering

		zsub	7			; count > maxcnt ?
;		zsub	13			; count > maxcnt ?
		jr	C,x68klast
x68kloop
		ld	C,6			; yes - xfer maxcnt bytes
;		ld	C,12			; yes - xfer maxcnt bytes
		bit	0,(IX+0)		; MBOX[0] is block flag from 68k	; NAT: Was (IX)
		jr	NZ,x68klpwt
x68klpcont
		ldir

	call	DACME

		zsub	6			; more than maxcnt left?
;		zsub	12			; more than maxcnt left?
		jr	NC,x68kloop		; yes - loop back
x68klast
		zadd	A,7			; last maxcnt or less - xfer them
;		zadd	A,13			; last maxcnt or less - xfer them
		ld	C,A
		bit	0,(IX+0)		; MBOX[0] is block flag from 68k	; NAT: Was (IX)
		jr	NZ,x68klstwt
x68klstcont
		ldir

	call	DACME

		res	0,(IX+1)

		ret

x68klpwt
		res	0,(IX+1)		; clear unsafe flag until unblocked
x68klpwtlp
		call	DACME			; wait for block flag to clear, sending samples
		bit	0,(IX+0)		; NAT: Was (IX)
		jr	NZ,x68klpwtlp
		zset	0,(IX+1)
		jr	x68klpcont

x68klstwt
		res	0,(IX+1)
x68klstwtlp
		call	DACME			; wait for block flag to clear, sending samples
		bit	0,(IX+0)		; NAT: Was (IX)
		jr	NZ,x68klstwtlp
		zset	0,(IX+1)
		jr	x68klstcont

**************************************  DIGITAL STUFF  *************************************

*
*  DACME - do that DAC thing. assumes the the alternate registers are set up as follows
*
*			B	15H (reset cmd to timer) + CH3 mode bits
*			C	control pattern for processing (compression, oversampling)
*			DE	pointing into DACFIFO (1F00-1FFF)
*			HL	4000H
*

DACMEJRINST	dw	0			; for saving the DACME inst for slow sample rates
DACME4BINST	dw	0			; for saving the DACMEPROC inst for processing

DACME		jr	DACMEALT		; change to EXX/EX AF to enable, RET to disable

;		ret				; change to EXX (0D9H) to enable this routine
;		ex	AF,AF			; switch register set

		ld	(HL),27H		; point FM chip at timer control register
dacmespin
		bit	0,(HL)			; spin till Timer A overflows
		jp	Z,dacmespin

		inc	L			; point HL to FM data register
		ld	(HL),B			; reset timer (sets CH3 mode bits)
		dec	L
		ld	A,(DE)			; get next byte from fifo

DACMEPROC
		jr	DACMEDSP		; change to 2 nops for normal (non processed samples)
;		znop
;		znop

		znop
		inc	E

DACMEOUT	ld	(HL),02AH		; point FM chip at DAC data register
		inc	HL
		ld	(HL),A			; output sample
		dec	L
		ex	AF,AF
		exx
DACMERET	ret				; change to ZNOP for DACME's every other call
						; for (slow sample rates)

		ex	AF,AF			; changes DACME to jump to DACMEALT next time
		ld	A,(DACMEJRINST)
		ld	(DACME),A
		ld	A,(DACMEJRINST+1)
		ld	(DACME+1),A
		ex	AF,AF
		ret

DACMEALT
		ex	AF,AF			; changes DACME back to working next time
		ld	A,0D9H			; D9 = exx
		ld	(DACME),A
		ld	A,008H			; 08 = ex af,af
		ld	(DACME+1),A
		ex	AF,AF
		ret

DACMEDSP
		rrc	C			; which sample (high nibble or low)
		jr	C,DACME4BHI		; high

		rla				; here for low nibble - 1st half
		rla
		rla
		rla
DACME4BMSK
		zand	0F0H
		jr	DACMEOUT
DACME4BHI					; here for hi nib - 2nd half - inc ptr
		inc	E
		jr	DACME4BMSK


*
*  FILLDACFIFO - gets the next 128 bytes of sample from the 68000 into the DACFIFO
*

DACFIFOWPTR	db	0

SAMPLEPTR	db	0,0,0
SAMPLECTR	dw	0
FDFSTATE	db	0

FILLDACFIFO
		ret				; replace with 0 (nop) to enable DAC fills
		push	AF
		ld	A,(DACFIFOWPTR)		; is DAC reading from bank to be filled ?
		exx
		xor	E
		exx
		zand	80H
		jr	NZ,FDFneeded

		pop	AF
		ret				; yes - return

FORCEFILLDF

		call	CHECKTICK

		push	AF

FDFneeded
		call	DACME

		push	BC
		push	DE
		push	HL

		ld	A,(FDFSTATE)		; sample refill FSM state
		cp	7
		jp	NC,FDF7

FDF4N5N6					; states 4, 5, and 6
		ld	HL,(SAMPLECTR)
		ld	BC,128
		scf
		ccf
		sbc	HL,BC			; HL <- samplectr - 128

		jr	C,FDF4DONE
		jr	Z,FDF4DONE
FDF4NORM
		ld	(SAMPLECTR),HL

		ld	D,1FH			; xfer next 128 samples from (SAMPLEPTR)
		ld	A,(DACFIFOWPTR)
		ld	E,A			; DE <- dest addr
		zadd	A,128			; increment dest addr for next time
		ld	(DACFIFOWPTR),A
		ld	HL,(SAMPLEPTR)		; HL <- src addr lsw
		ld	A,(SAMPLEPTR+2)		; A <- src addr msb
		call	XFER68K			; reload FIFO

		ld	HL,(SAMPLEPTR)
		ld	A,(SAMPLEPTR+2)
		ld	BC,128
		zadd	HL,BC
		adc	A,0
		ld	(SAMPLEPTR),HL
		ld	(SAMPLEPTR+2),A		; SAMPLEPTR <- SAMPLEPTR + 128
		jp	FDFreturn
FDF4DONE					; for now, loop back
		ld	A,L
		zadd	A,128
		ld	C,A			; xfer the samples that are left
		ld	B,0
		push	BC			; save # xfered here
		ld	D,1FH
		ld	A,(DACFIFOWPTR)
		ld	E,A			; DE <- dest addr
		zadd	A,128			; increment dest addr for next time
		ld	(DACFIFOWPTR),A
		ld	HL,(SAMPLEPTR)		; HL <- src addr lsw
		ld	A,(SAMPLEPTR+2)		; A <- src addr msb
		call	XFER68K			; reload FIFO - leaves DE at next to write
		pop	BC			; C <- # just xfered

		; needs to xfer the next few if needed, for now, just loop back

		ld	A,(FDFSTATE)
		cp	5
		jp	NZ,FDF7

		ld	HL,(SAMPLEPTR)
		ld	A,(SAMPLEPTR+2)
		push	BC
		zadd	HL,BC
		adc	A,0			; add to sample pointer
		ld	BC,(SAMPLOOP)
		scf
		ccf
		sbc	HL,BC
		sbc	A,0			; then subtract loop length
		ld	(SAMPLEPTR),HL		; store new (beginning of loop ptr)
		ld	(SAMPLEPTR+2),A
		ld	(SAMPLECTR),BC

		pop	BC
		ld	A,128
		zsub	C
		ld	C,A			; BC <- numer to complete this 128byte bank
		jp	Z,FDFreturn		; none to xfer

		ld	HL,(SAMPLECTR)
		scf
		ccf
		sbc	HL,BC			; subtract these few samples from ctr
		ld	(SAMPLECTR),HL
						; DE still hangin out where it left off
		ld	HL,(SAMPLEPTR)		; HL <- src addr lsw
		ld	A,(SAMPLEPTR+2)		; A <- src addr msb
		push	BC
		call	XFER68K			; reload FIFO
		pop	BC

		ld	HL,(SAMPLEPTR)
		ld	A,(SAMPLEPTR+2)
		zadd	HL,BC
		adc	A,0
		ld	(SAMPLEPTR),HL
		ld	(SAMPLEPTR+2),A		; SAMPLEPTR <- SAMPLEPTR + 128

		jr	FDFreturn

FDF7						; state 7 - just off for now

		ld	A,0C9H			; opcode "ret"
		ld	(DACME),A		; disable DACME routine
		ld	(FILLDACFIFO),A		; disable FILLDACFIFO
		ld	HL,4000H		; disable DAC mode
		ld	(HL),02BH
		inc	HL
		ld	(HL),0
		ld	HL,FMVTBLCH6
		ld	(HL),0C6H		; mark voice free, unlocked, and releasing
		inc	HL
		inc	HL
		inc	HL
		inc	HL
		ld	(HL),0			; clear any pending release timer value
		inc	HL
		ld	(HL),0


FDFreturn
		pop	HL
		pop	DE
		pop	BC
		pop	AF

		ret



************************************* SEQUENCER CODE ***************************************

* CCB Entries:	2,1,0	tag addr of 1st byte in 32-byte channel buffer
*		5,4,3	addr of next byte to fetch
*				so: 0 <= addr-tag <= 31 means hit in buffer
*		6	flags
*		8,7	timer (contains 0-ticks to delay)
*		10,9	delay
*		12,11	duration

CCBTAGL		equ	0	; lsb of addr of 1st byte in 32-byte sequence buffer
CCBTAGM		equ	1	; mid of "
CCBTAGH		equ	2	; msb of "
CCBADDRL	equ	3	; lsb of addr of next byte to read from sequence
CCBADDRM	equ	4	; mid of "
CCBADDRH	equ	5	; msb of "
CCBFLAGS	equ	6	; 80 = sustain
				; 40 = env retrigger
				; 20 = lock (for 68k based sfx)
				; 10 = running (not paused)
				; 08 = use sfx (150 bpm) timebase
				; 02 = muted (running, but not executing note ons)
				; 01 = in use
CCBTIMERL	equ	7	; lsb of 2's comp, subbeat (1/24th) timer till next event
CCBTIMERH	equ	8	; msb of "
CCBDELL		equ	9	; lsb of registered subbeat delay value
CCBDELH		equ	10	; msb of "
CCBDURL		equ	11	; lsb of registered subbeat duration value
CCBDURH		equ	12	; msb of "
CCBPNUM		equ	13	; program number (patch)
CCBSNUM		equ	14	; sequence number (in sequence bank)
CCBVCHAN	equ	15	; MIDI channel number within sequence CCBSNUM
CCBLOOP0	equ	16	; loop stack (counter, lsb of start addr, mid of start addr)
CCBLOOP1	equ	19
CCBLOOP2	equ	22
CCBLOOP3	equ	25
CCBPRIO		equ	28	; priority (0 lowest, 127 highest)
CCBENV		equ	29	; envelope number
CCBATN		equ	30	; channel attenuation (0=loud, 127=quiet)
CCBy		equ	31

*
*  GETSBYTE - get the channel's sequence byte pointed to by the CCB
*
*	parameters:		IX		points to the current channel's CCB
*				(CHBUFPTR)	points to the current channel's buffer
*	returns:		A		data
*

;BUFSIZE		equ	16

GETSBYTE

	call	DACME

		push	BC
		push	HL

		ld	A,(IX+CCBADDRL)
		zsub	(IX+CCBTAGL)
		ld	C,A			; C <- lsb of addr-tag
		ld	A,(IX+CCBADDRM)
		sbc	A,(IX+CCBTAGM)		; A <- midbyte of addr-tag
		jr	NZ,gsbmiss		; if non-zero, its a miss!
		ld	A,(IX+CCBADDRH)
		sbc	A,(IX+CCBTAGH)		; A <- high byte of addr-tag
		jr	NZ,gsbmiss		; if non-zero, its a miss!
		ld	A,C
		cp	16			; if mid and msb ok, is lsb < 16 ?
		jr	NC,gsbmiss		; no - its a miss
gsbhit
	call	DACME

		ld	B,0			; hit!
		ld	HL,(CHBUFPTR)
		zadd	HL,BC			; HL <- ptr to byte in buffer
		ld	A,(HL)			; A <- byte from buffer

		inc	(IX+CCBADDRL)		; increment addr[23:0]
		jr	NZ,gsbincdone
		inc	(IX+CCBADDRM)
		jr	NZ,gsbincdone
		inc	(IX+CCBADDRH)
gsbincdone
		pop	HL
		pop	BC

	call	DACME

		ret
gsbmiss

	call	DACME
;	call	FILLDACFIFO
	call	CHECKTICK
;	call	DACME

		push	DE			; here to refill buffer w/ next 32 bytes in seq
		ld	DE,(CHBUFPTR)		; DE <- pointer to buffer
		ld	L,(IX+CCBADDRL)
		ld	(IX+CCBTAGL),L
		ld	H,(IX+CCBADDRM)		; HL <- src addr lsw
		ld	(IX+CCBTAGM),H
		ld	A,(IX+CCBADDRH)		; A <- src addr msg
		ld	(IX+CCBTAGH),A		; tag <- addr
		ld	C,16		; C <- byte count
		call	XFER68K			; refill away
		pop	DE
		ld	C,0
		jr	gsbhit			; and hit on first byte (since we just refilled here)


*
*  UPDSEQ - go through the CCB's, updating any enabled channels
*

CHBUFPTR	dw	0			; pointer to current channel's sequence buffer
CHPATPTR	dw	0			; pointer to current channel's patch buffer

UPDSEQ		ld	IX,CCB
		ld	HL,CH0BUF		; initialize seq buf ptr
		ld	(CHBUFPTR),HL
		ld	HL,PATCHDATA
		ld	(CHPATPTR),HL
		ld	A,(TBASEFLAGS)
		ld	C,A
		ld	A,16			; loop counter
		ld	B,0			; make it channel 0
		jr	updseqloop1
updseqloop
	call	DACME
		ld	DE,32			; go to next CCB
		zadd	IX,DE
		ld	HL,(CHBUFPTR)
		ld	E,16
		zadd	HL,DE
		ld	(CHBUFPTR),HL
		ld	HL,(CHPATPTR)
		ld	E,39
		zadd	HL,DE
		ld	(CHPATPTR),HL
updseqloop1
		bit	4,(IX+CCBFLAGS)		; is channel running (vs. paused or free)
		jr	Z,updseqloop2
		bit	3,(IX+CCBFLAGS)		; is it sfx tempo based?
		jr	NZ,updseqsfx
		bit	1,C			; music tempo based - beat gone by?
		jr	NZ,updseqdoit		; yes - sequence it
		jr	updseqloop2		; no - skip it
updseqsfx
		bit	0,C			; sfx tempo based - tick gone by?
		jr	Z,updseqloop2		; no - skip it

updseqdoit
	call	DACME
		push	AF
		push	BC

	call	FILLDACFIFO

		call	SEQUENCER
		pop	BC
		pop	AF
updseqloop2
		inc	B
		dec	A
		jr	NZ,updseqloop
		ret

*
*  SEQUENCER - if the channel has timed out, then execute the next set of sequencer cmds
*
*	parameters:		IX	points to channel control block (CCB)
*				B	channel
*				C	timerbase flags ([0] = sfx, [1] = music)
*

SEQUENCER
		inc	(IX+CCBTIMERL)			; increment channel timer
		ret	NZ
		inc	(IX+CCBTIMERH)
		ret	NZ
seqcmdloop0
		call	GETSBYTE		; timed out! - do the next sequence commands
seqcmdloop
		bit	7,A			; dispatch on cmd type
		jp	Z,seqnote
		bit	6,A
		jr	Z,seqdur
seqdel						; process delay commands
		zand	3FH			; get data bits into DE
		ld	E,A
		ld	D,0
seqdelloop
		call	GETSBYTE		; is next command also a delay cmd?
		bit	7,A
		jr	Z,seqdeldone
		bit	6,A
		jr	Z,seqdeldone

		sla	E			; yes, shift in its data as the new lsbs
		rl	D
		sla	E
		rl	D
		sla	E
		rl	D
		sla	E
		rl	D
		sla	E
		rl	D
		sla	E
		rl	D
		zand	3FH
		zor	E
		ld	E,A
		jr	seqdelloop
seqdeldone
		ld	H,A
		ld	A,E
		cpl
		ld	E,A
		ld	A,D
		cpl
		ld	D,A
		inc	DE			; negate delay value before storing
		ld	(IX+CCBDELL),E
		ld	(IX+CCBDELH),D
		ld	A,H
		jr	seqcmdloop
seqdur						; process duration commands
		zand	3FH			; get data bits into DE
		ld	E,A
		ld	D,0
seqdurloop
		call	GETSBYTE		; is next command also a duration cmd?
		bit	7,A
		jr	Z,seqdurdone
		bit	6,A
		jr	NZ,seqdurdone

		sla	E			; yes, shift in its data as the new lsbs
		rl	D
		sla	E
		rl	D
		sla	E
		rl	D
		sla	E
		rl	D
		sla	E
		rl	D
		sla	E
		rl	D
		zand	3FH
		zor	E
		ld	E,A
		jr	seqdurloop
seqdurdone
		ld	H,A
		ld	A,E
		cpl
		ld	E,A
		ld	A,D
		cpl
		ld	D,A
		inc	DE			; negate duration value before storing
		ld	(IX+CCBDURL),E
		ld	(IX+CCBDURH),D
		ld	A,H
		jp	seqcmdloop

seqnote						; process a note or command
		cp	96			; commands are 96-127
		jr	NC,seqcmd
		bit	1,(IX+CCBFLAGS)		; is this channel muted?
		jr	NZ,seqdelay		; yup - don't note on
		push	BC
		push	IX
		ld	C,A			; C <- note; B is already channel
		call	NOTEON
		pop	IX
		pop	BC
seqdelay

	call	DACME

		ld	E,(IX+CCBDELL)
		ld	D,(IX+CCBDELH)		; DE <- delay
		ld	A,D
		zor	E
		jp	Z,seqcmdloop0		; zero delay - do another command
		ld	(IX+CCBTIMERL),E	; non-zero delay - set channel timer
		ld	(IX+CCBTIMERH),D
		ret
seqcmd
		zsub	96
		jp	Z,seqeos		; 96 = eos
		dec	A
		jp	Z,seqpchange		; 97 = pchange
		dec	A
		jp	Z,seqenv		; 98 = env
		dec	A
		jp	Z,seqdelay		; 99 = nop (triggers another delay)
		dec	A
		jp	Z,seqsloop		; 100 = loop start
		dec	A
		jp	Z,seqeloop		; 101 = loopend
		dec	A
		jp	Z,seqretrig		; 102 = retrigger mode
		dec	A
		jp	Z,seqsus		; 103 = sustain
		dec	A
		jp	Z,seqtempo		; 104 = tempo
		dec	A
		jp	Z,seqmute		; 105 = mute
		dec	A
		jp	Z,seqprio		; 106 = priority
		dec	A
		jp	Z,seqssong		; 107 = start song
		dec	A
		jp	Z,seqpbend		; 108 = pitch bend
		dec	A
		jp	Z,seqsfx		; 109 = use sfx timebase
		dec	A
		jp	Z,seqsamprate		; 110 = set sample plbk rate
		dec	A
		jp	Z,seqgoto		; 111 = goto
		dec	A
		jp	Z,seqstore		; 112 = store
		dec	A
		jp	Z,seqif			; 113 = if
		dec	A
		jp	Z,seqseekrit		; 114 = seekrit codes


*** THIS COULD USE SOME FANCY ERROR DETECTION RIGHT ABOUT NOW

		jp	seqcmdloop0

seqenv
		call	GETSBYTE
		ld	(IX+CCBENV),A
		bit	6,(IX+CCBFLAGS)		; immediate mode envelopes?
		jp	NZ,seqdelay
		push	BC
		push	IX
		ld	E,B			; E <- channel
		ld	C,(IX+CCBENV)
		call	TRIGENV
		pop	IX
		pop	BC
		jp	seqdelay
seqretrig
		call	GETSBYTE
		zor	A			; retrigger on?
		jp	NZ,seqrton
		res	6,(IX+CCBFLAGS)
		jp	seqdelay
seqrton
		zset	6,(IX+CCBFLAGS)
		jp	seqdelay
seqsus
		call	GETSBYTE
		zor	A
		jr	NZ,seqsuson
		res	7,(IX+CCBFLAGS)
		jp	seqdelay
seqsuson
		zset	7,(IX+CCBFLAGS)
		jp	seqdelay
seqeos
		ld	(IX+CCBFLAGS),0		; end of sequence - disable CCB (free it)
		ld	(IX+CCBDURL),0
		ld	(IX+CCBDURH),0
		ret
seqpchange
		call	GETSBYTE
		ld	(IX+CCBPNUM),A
		push	BC
		call	FETCHPATCH
		pop	BC
		jp	seqdelay
seqsloop
		push	IX
		pop	IY
		ld	DE,16			; CCBLOOP0
		zadd	IY,DE			; IY <- first loop stack entry for this CCB
		ld	DE,3
seqsllp
		ld	A,(IY+0)		; is this stack entry free?
		zor	A
		jr	Z,seqslfound
		zadd	IY,DE			; no - try the next one
		jr	seqsllp
seqslfound
		call	GETSBYTE		; yes - store loop count and addr[15:0]
		ld	(IY+0),A
		ld	A,(IX+CCBADDRL)
		ld	(IY+1),A
		ld	A,(IX+CCBADDRM)
		ld	(IY+2),A
		jp	seqcmdloop0
seqeloop
		push	IX
		pop	IY
		ld	DE,25			; CCBLOOP3
		zadd	IY,DE			; IY <- last loop stack entry for this CCB
		ld	DE,0FFFDH		; -3
seqellp
		ld	A,(IY+0)		; is this stack entry free?
		zor	A
		jr	NZ,seqelfound
		zadd	IY,DE			; yes - try the previous one
		jr	seqellp
seqelfound
		cp	127			; endless loop - go back
		jr	Z,seqelgobk
		dec	A
		ld	(IY+0),A
		jp	Z,seqcmdloop0		; end of finite loop - don't go back
seqelgobk
		ld	L,(IY+1)		; loop addr lsb
		ld	E,(IX+CCBADDRL)		; current addr lsb
		ld	(IX+CCBADDRL),L
		ld	H,(IY+2)		; HL <- loop back addr lsw
		ld	D,(IX+CCBADDRM)		; DE <- current addr lsw
		ld	(IX+CCBADDRM),H		; current addr lsw <- loop back addr lsw
		scf
		ccf
		sbc	HL,DE
		jr	C,seqelnoc		; if loop back lsw > current addr
		dec	(IX+CCBADDRH)		;   then dec current addr msb
seqelnoc
		jp	seqcmdloop0

seqtempo
		call	GETSBYTE		; tempo value is offset by -40
		zadd	A,40
		call	SETTEMPO
		jp	seqdelay

seqmute
		call	GETSBYTE		; [4] is 1 for mute, [3:0] is midi channel
		ld	H,A
		ld	L,16
		ld	IY,CCB
		ld	DE,32
seqmutelp
		bit	0,(IY+CCBFLAGS)		; channel in use?
		jr	Z,seqmutenext
		ld	A,(IY+CCBSNUM)		; running this sequence?
		cp	(IX+CCBSNUM)
		jr	NZ,seqmutenext
		ld	A,H			; and the desired channel?
		zand	0FH
		cp	(IY+CCBVCHAN)
		jr	Z,seqmuteit
seqmutenext					; try the next chan
		dec	L
		jp	Z,seqdelay		; all dun
		zadd	IY,DE
		jr	seqmutelp
seqmuteit
		bit	4,H			; mute or unmute?
		jr	NZ,sequnmute
		zset	1,(IY+CCBFLAGS)
		jp	seqdelay
sequnmute
		res	1,(IY+CCBFLAGS)
		jp	seqdelay

seqprio
		call	GETSBYTE
		ld	(IX+CCBPRIO),A
		jp	seqdelay

seqssong	call	GETSBYTE
		push	IX
		push	BC
		call	STARTSEQ
		pop	BC
		pop	IX
		jp	seqdelay

seqpbend
		ld	IY,PBTBL
		ld	E,B
		ld	D,0
		zadd	IY,DE			; IY <- pointer to this ch's pitch bend data

		call	GETSBYTE		; 16 bit signed pitch bend (8 frac bits, semitones)
		ld	(IY+PBPBL),A
		call	GETSBYTE
		ld	(IY+PBPBH),A
		zset	0,(IY+PBRETRIG)
		ld	A,1
		ld	(NEEDBEND),A
		jp	seqdelay
seqsfx
		zset	3,(IX+CCBFLAGS)		; set sfx timebase flag in CCB
		jp	seqdelay
seqsamprate
		call	GETSBYTE
		ld	D,A
		ld	HL,(CHPATPTR)
		ld	A,(HL)			; is this a digital patch?
		cp	1
		jp	NZ,seqdelay		; no - no effect
		inc	HL			; yes - update sample rate value
		ld	(HL),D
		jp	seqdelay
seqgoto
		call	GETSBYTE		; get 16 signed offset
		ld	L,A
		call	GETSBYTE
		ld	H,A
		rla
		ld	A,0
		sbc	A,0
		ld	D,A
seqbranch					; jump to addr + 24 bit offset in DHL
		ld	A,(IX+CCBADDRL)
		zadd	A,L
		ld	(IX+CCBADDRL),A
		ld	A,(IX+CCBADDRM)
		adc	A,H
		ld	(IX+CCBADDRM),A
		ld	A,(IX+CCBADDRH)
		adc	A,D
		ld	(IX+CCBADDRH),A
		jp	seqcmdloop0
seqstore
		call	seqmboxstart		; HL <- ptr to mbox, A <- next byte in op
		ld	(HL),A			; store value in mbox
		jp	seqdelay
seqif
		call	seqmboxstart		; HL <- ptr to mbox, A <- next byte in op
		ld	D,A			; save relation in D
		call	GETSBYTE		; A <- value
		dec	D
		jr	NZ,seqif0
seqifne
		cp	(HL)			; V-M: if M<>V then NZ
		jr	NZ,seqifdoit
		jr	seqifpunt
seqif0
		dec	D
		jr	NZ,seqif1
seqifgt
		cp	(HL)			; V-M: if M>V then C
		jr	C,seqifdoit
		jr	seqifpunt
seqif1
		dec	D
		jr	NZ,seqif2
seqifgte
		cp	(HL)			; V-M: if M>=V then C|Z
		jr	C,seqifdoit
		jr	Z,seqifdoit
		jr	seqifpunt
seqif2
		dec	D
		jr	NZ,seqif3
seqiflt
		cp	(HL)			; V-M: if M<V then NZ & NC
		jr	C,seqifpunt
		jr	Z,seqifpunt
		jr	seqifdoit
seqif3
		dec	D
		jr	NZ,seqifeq
seqiflte
		cp	(HL)			; V-M: if M<=V then NC
		jr	NC,seqifdoit
		jr	seqifpunt
seqifeq
		cp	(HL)
		jr	Z,seqifdoit
seqifpunt
		call	GETSBYTE
		ld	L,A
		ld	H,0
		ld	D,0
		jr	seqbranch
seqifdoit
		call	GETSBYTE
		jp	seqcmdloop0

seqmboxstart
		call	GETSBYTE		; get  mailbox num
		ld	E,A
		ld	D,0
		ld	HL,MBOXES+2
		zadd	HL,DE			; HL <- pointer to mailbox
		call	GETSBYTE		; get next byte
		ret

seqseekrit					; extra functions (like a generic ctrllr)
		call	GETSBYTE		; get code
		ld	D,A
		call	GETSBYTE		; get value
		ld	E,A
		ld	A,D			; dispatch on code
		cp	0
		jp	Z,seqstopseq
		cp	1
		jp	Z,seqpauseseq
		cp	2
		jp	Z,seqresume
		cp	3
		jp	Z,seqpauselmusic
		cp	4
		jr	Z,seqatten
		cp	5
		jr	Z,seqchatten
		jp	seqdelay

seqatten
		ld	A,E
		ld	(MASTERATN),A
		jp	seqdelay

seqchatten
		ld	(IX+CCBATN),E
		jp	seqdelay

seqstopseq
		push	IX
		push	BC
		ld	A,E
		call	STOPSEQ
		pop	BC
		pop	IX
		jp	seqdelay

seqpauseseq
		ld	A,E
seqpausecom
		push	IX
		push	BC
		call	PAUSESEQ
		pop	BC
		pop	IX
		jp	seqdelay

seqpauselmusic
		ld	A,(MBOXES+2)
		jr	seqpausecom

seqresume
		push	IX
		push	BC
		call	RESUMEALL
		pop	BC
		pop	IX
		jp	seqdelay

*
*  VTIMER - updates the voice timers - first note on and then release values
*

VTIMER
		ld	DE,7
		ld	A,(TBASEFLAGS)
		ld	B,A			; B <- tbase flags
		ld	H,0			; indicates FM voices
		ld	IX,FMVTBL
		call	vtimerloop
		inc	H			; indicates PSG voices
		ld	IX,PSGVTBL
		call	vtimerloop
		ld	IX,PSGVTBLNG
		call	vtimerloop
		ret
vtimerloop0
		zadd	IX,DE
vtimerloop
		ld	A,(IX+0)
		cp	0FFH			; if eot
		ret	Z			;   return
	call	DACME
		bit	3,A			; sfx tempo driven?
		jr	NZ,vtimersfx
		bit	1,B			; no - music beat flag set?
		jr	Z,vtimerloop0
		jr	vtimerdoit
vtimersfx
		bit	0,B
		jr	Z,vtimerloop0
vtimerdoit
		bit	6,A			; if in release
		jr	Z,vtimerloop2
		dec	(IX+6)			;   decrement release timer
		jr	NZ,vtimerloop0		;   not at zero, loop
		res	6,A			;   turn off release flag
		ld	(IX+0),A
		jr	vtimerloop0
vtimerloop2
		bit	4,A			; self timed note?
		jr	Z,vtimerloop0
		zand	7			; yes - save voice # in C
		ld	C,A
		inc	(IX+4)			; inc lsb of timer
		jr	NZ,vtimerloop0
		inc	(IX+5)			; if zero (carry), inc msb
		jr	NZ,vtimerloop0

		res	4,(IX+0)		; timed out - clear self timer bit
		res	3,(IX+0)		;   and clear sfx bit
		ld	A,(IX+0)		; A <- note flags
		zand	2FH			; mask lock and voice number
		cp	26H			; is it voice 6 (must be FM) and locked?
		jr	Z,vtnoteoffdig		;   yes - its a digital noteoff
		zset	6,(IX+0)		;   no - set release bit
		zset	7,(IX+0)		;        set free bit
vtnoteoff					; note off...
		bit	0,H			; voice type?
		jr	Z,vtnoteofffm

		ld	E,C			; psg - DE <- psg voice num
		ld      IY,psgcom		; load psg register table
		zadd	IY,DE			; point to correct register
		ld	E,7			; restore DE to 7
		zset	1,(IY+0)		; set key off command
		jr	vtimerloop0
vtnoteofffm
		ld      IY,4000H        	; load fm register address
		FMWrite 28H,C           	; key off
		jr	vtimerloop0
vtnoteoffdig
		call	NOTEOFFDIG
		jr	vtimerloop0		; for now, note off don't effect digital

**************************************  MAIN LOOP  *****************************************

*
* GETCCBPTR - gets one byte from command queue for channel number, multiplies by 32,
*	and returns pointer to that channel's CCB in IX, as well as the channel #
*	in A
* GETCCBPTR2 - alternate entry point to providing channel # in A (skips GETCBYTE)
*
*	trashes DE
*

GETCCBPTR
		call	GETCBYTE
GETCCBPTR2
		ld	D,0
		ld	E,A
		sla	E
		sla	E
		sla	E
		sla	E
		sla	E
		rl	D			; DE <- 32 * channel
		ld	IX,CCB
		zadd	IX,DE			; IX <- pointer to this channel's CCB
		ret

*
*  main - initialize command fifo, dispatch on commands
*

SBPT		dw	204			; sub beats per tick (8frac), default is 120bpm
SBPTACC		dw	0			; accumulates ^^ each tick to track sub beats
TBASEFLAGS	db	0

; NAT: Was originally "main". Changed because ASM68K was being anal about it
init						; ints are disabled upon entry here
		exx				; initialize alternate regs for DACME calls
		ld	B,15H			; timer reset command (also hold CH3 mode bits)
		ld	D,1FH			; read pointer from DACFIFO - msb always = 1FH
		ld	HL,4000H		; points to base of FM chip
		exx
		ei

		ld	HL,7F11H		; silence the psg voices
		ld	(HL),09FH
		ld	(HL),0BFH
		ld	(HL),0DFH
		ld	(HL),0FFH

		ld	HL,PATCHDATA		; set all patch buffers to undefined
		ld	DE,39
		ld	B,16
pinitloop
		ld	(HL),0FFH
		zadd	HL,DE
		dec	B
		jr	NZ,pinitloop

		ld	HL,(DACME)		; save the jr in DACME to slow sample rate mode
		ld	(DACMEJRINST),HL
		ld	HL,(DACMEPROC)		; save the jr for enabling processing
		ld	(DACME4BINST),HL

		ld	A,0C9H			; opcode "RET"
		ld	(DACME),A		; and disable for now

		;export	loop
loop
		call	CHECKTICK

		call	DACME

		call	FILLDACFIFO

		call	DACME

		call	CHECKTICK

		ld	B,0			; b[0] if 60Hz tick, b[1] if 1/24 beat tick

		ld	A,(TICKCNT)		; check tick counter
		zsub	1
		jr	C,noticks

		ld	(TICKCNT),A		; a tick's gone by...
		call	DOPSGENV		;   do PSG envs and set tick flag
		call	CHECKTICK
		ld	B,1			;   set tick flag
noticks
		call	DACME

		ld	A,(SBPTACC+1)		; check beat counter (scaled by tempo)
		zsub	1
		jr	C,nobeats

		ld	(SBPTACC+1),A		; a beat (1/24 beat) 's gone by...
		zset	1,B			;   set beat flag
nobeats
		ld	A,B
		zor	A
		jr	Z,neithertick
		ld	(TBASEFLAGS),A

		call	DOENVELOPE		; call the envelope processor
		call	CHECKTICK
		call	VTIMER			; update voice timers
		call	CHECKTICK
		call	UPDSEQ			; update sequencers
		call	CHECKTICK
neithertick
		call	APPLYBEND		; check if bends need applying

		ld	A,(CMDWPTR)		; check for command bytes...
		ld	B,A
		ld	A,(cmdrptr)		; compare read and write pointers
		cp	B
		jp	Z,loop			; loop if no command bytes waiting

		call	GETCBYTE		; main loop
		cp	0FFH			; start of command?
		jp	NZ,loop			; no, wait for one

		call	GETCBYTE		; get command
		cp	0			; note on?
		jp	Z,cmdnoteon
		cp	1
		jp	Z,cmdnoteoff
		cp	2
		jp	Z,cmdpchange
		cp	3
		jp	Z,cmdpupdate
		cp	4
		jp	Z,cmdpbend
		cp	5
		jp	Z,cmdtempo
		cp	6
		jp	Z,cmdenv
		cp	7
		jp	Z,cmdretrig
		cp	11
		jp	Z,cmdgetptrs
		cp	12
		jp	Z,cmdpause
		cp	13
		jp	Z,cmdresume
		cp	14
		jp	Z,cmdsussw
		cp	16
		jp	Z,cmdstartseq
		cp	18
		jp	Z,cmdstopseq
		cp	20
		jp	Z,cmdsetprio
		cp	22
		jp	Z,cmdstopall
		cp	23
		jp	Z,cmdmute
		cp	26
		jp	Z,cmdsamprate
		cp	27
		jp	Z,cmdstore
		cp	28
		jp	Z,cmdlockch
		cp	29
		jp	Z,cmdunlockch
		cp	30
		jp	Z,cmdpbendvch
		cp	31
		jp	Z,cmdvolume
		cp	32
		jp	Z,cmdmasteratn
		jp	loop

cmdnoteon
		call	GETCCBPTR		; GETCBYTE for channel, IX <- CCB ptr, A <- channel
		ld	B,A			; B <- channel
		call	GETPATPTR		; HL <- PATCHDATA + 39 * A
		ld	(CHPATPTR),HL		; set pointer to this channel's patch buffer

		call	GETCBYTE
		ld	C,A			; C <- note
		call	NOTEON
		jp	loop

cmdnoteoff
		call	GETCBYTE		; yes
		ld	B,A			; B <- channel
		call	GETCBYTE
		ld	C,A			; C <- note
		call	NOTEOFF
		jp	loop

cmdpchange
		call	PCHANGE
		jp	loop

cmdpupdate
		call	GETCBYTE
		call	PATCHLOAD
		jp	loop

cmdpbend
		call	GETCBYTE		; get midi channel
		call	DOPITCHBEND		; PITCHBEND gets its own bend data from the cmd queue
		jp	loop

cmdpbendvch
		call	GETCBYTE
		ld	C,A			; C <- seq #
		call	GETCBYTE
		ld	H,A			; H <- midi ch #
		ld	L,0			; L <- gems ch # (CCB num)

		ld	IX,CCB			; start with CCB 0
		ld	DE,32
		ld	B,16			; only 16 CCB's to try
pbvchloop
		bit	0,(IX+CCBFLAGS)		; is this channel in use?
		jr	Z,pbvchskip		; no - skip it
		ld	A,(IX+CCBSNUM)		; yes - is it for this seq number?
		cp	C
		jr	NZ,pbvchskip
		ld	A,(IX+CCBVCHAN)		; yes - for this channel ?
		cp	H
		jr	NZ,pbvchskip
		ld	A,L			; yes - bend this channel
		call	DOPITCHBEND
		jp	loop
pbvchskip
		zadd	IX,DE
		inc	L
		dec	B
		jr	NZ,pbvchloop
		call	GETCBYTE
		call	GETCBYTE
		jp	loop

cmdtempo
		call	GETCBYTE
		call	SETTEMPO
		jp	loop

cmdenv
		call	GETCCBPTR		; GETCBYTE for channel, IX <- CCB ptr, A <- channel
		ld	B,A			; B <- channel
		call	GETCBYTE		; A <- envelope number
		ld	(IX+CCBENV),A		; store new env number
		bit	6,(IX+CCBFLAGS)		; retrigger mode?
		jp	NZ,loop

		ld	C,A			; C <- env num
		ld	E,B			; E <- channel
		call	TRIGENV			; no - trigger immediately
		jp	loop

cmdretrig
		call	GETCCBPTR		; GETCBYTE for channel, IX <- CCB ptr, A <- channel
		call	GETCBYTE		; A <- 80h for retrigg, 0 for immediate
		zor	A			; set retrigger?
		jr	Z,retrigclr
		zset	6,(IX+CCBFLAGS)
		jp	loop
retrigclr
		res	6,(IX+CCBFLAGS)
		jp	loop

cmdstartseq					; start a sequence
		call	GETCBYTE
		call	STARTSEQ
		jp	loop

cmdstopseq
		call	GETCBYTE		; get sequencer number to stop
		call	STOPSEQ
		jp	loop

cmdgetptrs
		ld	HL,PTBL68K
		ld	B,12			; read 12 bytes into the pointer variables
getptrslp
		call	GETCBYTE
		ld	(HL),A
		inc	HL
		djnz	getptrslp
		jp	loop

PTBL68K		db	0,0,0			; 24-bit 68k space pointer to patch table
ETBL68K		db	0,0,0			; 24-bit 68k space pointer to envelope table
STBL68K		db	0,0,0			; 24-bit 68k space pointer to sequence table
DTBL68K		db	0,0,0			; 24-bit 68k space pointer to digital sample table

cmdpause					; pause all CCB's current running
		ld	IX,CCB
		ld	B,16
		ld	DE,32
cmdpsloop					; go through CCB's
		res	4,(IX+CCBFLAGS)		; shut off running flags
		zadd	IX,DE
		dec	B
		jr	NZ,cmdpsloop
		call	CLIPALL
		jp	loop

cmdresume
		call	RESUMEALL
		jp	loop

cmdsussw					; set sustain flag for this channel
		call	GETCCBPTR		; GETCBYTE for channel, IX <- CCB ptr, A <- channel
		call	GETCBYTE
		zor	A			; switch on?
		jr	Z,cmdsusoff
		zset	7,(IX+CCBFLAGS)		; yes
		jp	loop
cmdsusoff
		res	7,(IX+CCBFLAGS)		; no
		jp	loop

cmdsetprio
		call	GETCCBPTR		; GETCBYTE for channel, IX <- CCB ptr, A <- channel
		call	GETCBYTE		; set priority for this channel
		ld	(IX+CCBPRIO),A
		jp	loop

cmdstopall
		ld	IX,CCB			; start with CCB 0
		ld	DE,32
		ld	B,16			; only 16 CCB's to try
stopallloop
		ld	(IX+CCBFLAGS),0		; yes - make it free, no retrig, no sustain
		ld	(IX+CCBDURL),0		; clear duration to enable live play
		ld	(IX+CCBDURH),0
		zadd	IX,DE
		dec	B
		jr	NZ,stopallloop
		call	CLIPALL			; chop off all notes
		jp	loop

cmdmute
		call	GETCBYTE
		ld	C,A			; C <- seq #
		call	GETCBYTE
		ld	H,A			; H <- ch #
		call	GETCBYTE
		ld	L,A			; L <- 1 to mute, 0 to unmute

		ld	IX,CCB			; start with CCB 0
		ld	DE,32
		ld	B,16			; only 16 CCB's to try
muteseqloop
		bit	0,(IX+CCBFLAGS)		; is this channel in use?
		jr	Z,muteseqskip		; no - skip it
		ld	A,(IX+CCBSNUM)		; yes - is it for this seq number?
		cp	C
		jr	NZ,muteseqskip
		ld	A,(IX+CCBVCHAN)		; yes - for this channel ?
		cp	H
		jr	NZ,muteseqskip
		bit	0,L			; mute or unmute?
		jr	NZ,muteit
		res	1,(IX+CCBFLAGS)		; unmute
		jr	muteseqskip
muteit
		zset	1,(IX+CCBFLAGS)		; mute
muteseqskip
		dec	B
		jp	Z,loop
		zadd	IX,DE
		jr	muteseqloop
cmdsamprate
		call	GETCBYTE		; A <- channel
		call	GETPATPTR		; HL <- PATCHDATA + 39 * A

		call	GETCBYTE
		ld	B,A			; B <- new rate value

		ld	A,(HL)			; is this a digital patch?
		cp	1
		jp	NZ,loop			; no - no effect
		inc	HL			; yes - update sample rate value
		ld	(HL),B
		jp	loop
cmdstore
		call	GETCBYTE
		ld	D,0
		ld	E,A
		ld	HL,MBOXES+2
		zadd	HL,DE
		call	GETCBYTE
		ld	(HL),A
		jp	loop
cmdlockch
		call	GETCCBPTR		; GETCBYTE for channel, IX <- CCB ptr, A <- channel
		zset	5,(IX+CCBFLAGS)
		jp	loop
cmdunlockch
		call	GETCCBPTR		; GETCBYTE for channel, IX <- CCB ptr, A <- channel
		res	5,(IX+CCBFLAGS)
		jp	loop

RESUMEALL					; resume all enabled CCB's
		ld	IX,CCB
		ld	B,16
		ld	DE,32
cmdresloop					; go through CCB's
		bit	5,(IX+CCBFLAGS)		; locked? then dont resume
		jr	NZ,cmdresnext
		bit	0,(IX+CCBFLAGS)
		jr	Z,cmdresnext
		zset	4,(IX+CCBFLAGS)		; set any enabled CCB's running again
cmdresnext
		dec	B
		ret	Z
		zadd	IX,DE
		jr	cmdresloop

cmdvolume
		call	GETCCBPTR		; GETCBYTE for channel, IX <- CCB ptr, A <- channel
		call	GETCBYTE		; get attenuation value
		ld	(IX+CCBATN),A
		jp	loop

cmdmasteratn
		call	GETCBYTE
		ld	(MASTERATN),A
		jp	loop

*
*  STARTSEQ - starts a multi channel sequence. a free CCB is allocated for each channel
*    in the sequence.
*
*	parameters		A	sequence number
*
*	trashes		everything!
*

;stseqx		ds.b	33			; 33 byte scratch area for starting a sequence

stseqx		db	0,0,0,0,0,0,0,0		; 33 byte scratch area for starting a sequence
		db	0,0,0,0,0,0,0,0
		db	0,0,0,0,0,0,0,0
		db	0,0,0,0,0,0,0,0
		db	0

stseqsnum	db	0

STARTSEQ
		ld	D,0
		ld	(stseqsnum),A
		ld	E,A
		sla	E			; DE <- snum * 2
		ld	HL,(STBL68K)
		ld	A,(STBL68K+2)		; AHL <- pointer to seq table in 68k space
		zadd	HL,DE
		adc	A,0			; AHL <- pointer to this seq's offset
		ld	C,2			; read 2 byte offset, into...
		ld	DE,stseqx		; scratch
		call	XFER68K

		ld	DE,(stseqx)		; DE <- the offset
		ld	HL,(STBL68K)
		ld	A,(STBL68K+2)
		zadd	HL,DE
		adc	A,0			; AHL <- pointer to seq hdr data
		ld	C,33			; xfer the max 33 byte seq hdr into
		ld	DE,stseqx		; scratch
		call	XFER68K

*** this should probably be something different!

		ld	A,(stseqx)
		zor	A
		ret	Z			; return if empty sequence

		ld	IX,CCB			; start with CCB 0
		ld	IY,PBTBL
		ld	DE,32
		ld	C,0			; C <- channel count
		ld	HL,stseqx+1		; track pointers start at stseqx+1
		ld	B,16			; only 16 CCB's to try
chkstseqloop
		ld	A,(IX+CCBFLAGS)
		zand	21H			; check in use and locked flags
		jr	NZ,stseqskipccb		; if either set, skip ch
		ld	(IX+CCBFLAGS),11H	; yes - set enable and running bits

		ld	A,(STBL68K)		; addr of this track is 24 bit base pointer
		zadd	A,(HL)			; plus 16 bit offset in descriptor
		inc	HL
		ld	(IX+CCBADDRL),A

		ld	A,(STBL68K+1)
		adc	A,(HL)
		inc	HL
		ld	(IX+CCBADDRM),A

		ld	A,(STBL68K+2)
		adc	A,0
		ld	(IX+CCBADDRH),A

		ld	(IX+CCBTAGL),0FFH	; invalidate tags
		ld	(IX+CCBTAGM),0FFH
		ld	(IX+CCBTAGH),0FFH
		ld	(IX+CCBTIMERL),0FFH
		ld	(IX+CCBTIMERH),0FFH	; set timer to -1 to trigger sequencer next tick
		ld	A,(stseqsnum)
		ld	(IX+CCBSNUM),A		; save sequence number
		ld	(IX+CCBVCHAN),C		; save virtual channel number
		ld	(IX+CCBLOOP0),0		; clear loop stack
		ld	(IX+CCBLOOP1),0
		ld	(IX+CCBLOOP2),0
		ld	(IX+CCBLOOP3),0
		ld	(IX+CCBENV),0		; clear envelope
		ld	(IX+CCBPRIO),0
		ld	(IX+CCBATN),0		; clear channel attenuation
		ld	(IY+PBEBL),0		; clear pitchbend, envelope bend
		ld	(IY+PBEBH),0
		ld	(IY+PBPBL),0
		ld	(IY+PBPBH),0
		inc	C
		ld	A,(stseqx)
		cp	C
		ret	Z			; return if all tracks started
stseqskipccb
		dec	B
		ret	Z			; return if out of CCB's
		zadd	IX,DE
		inc	IY
		jr	chkstseqloop

*
*  STOPSEQ - stops a multi channel sequence (actually, all occurances of it)
*
*	parameters		A	sequence number
*
*	trashes		everything!
*

STOPSEQ
		ld	IX,CCB			; start with CCB 0
		ld	DE,32
		ld	B,16			; only 16 CCB's to try
stopseqloop
		bit	0,(IX+CCBFLAGS)		; is this channel in use?
		jr	Z,stopseqskip		; no - skip it
		bit	5,(IX+CCBFLAGS)		; is this channel in locked?
		jr	NZ,stopseqskip		; yes - skip it
		cp	255			; stop song 255 means stop all
		jr	Z,stopseqstopit
		cp	(IX+CCBSNUM)		; yes - is it for this seq number?
		jr	NZ,stopseqskip
stopseqstopit
		ld	(IX+CCBFLAGS),0		; yes - make it free, no retrig, no sustain
		ld	(IX+CCBDURL),0		; clear duration to enable live play
		ld	(IX+CCBDURH),0
stopseqskip
		zadd	IX,DE
		dec	B
		jr	NZ,stopseqloop
		call	CLIPALL
		ret

*
*  PAUSESEQ - pause a multi channel sequence (actually, all occurances of it)
*
*	parameters		A	sequence number
*
*	trashes		everything!
*

PAUSESEQ
		ld	IX,CCB			; start with CCB 0
		ld	DE,32
		ld	B,16			; only 16 CCB's to try
pauseseqloop
		bit	0,(IX+CCBFLAGS)		; is this channel in use?
		jr	Z,pauseseqskip		; no - skip it
		bit	5,(IX+CCBFLAGS)		; is this channel in locked?
		jr	NZ,pauseseqskip		; yes - skip it
		cp	(IX+CCBSNUM)		; yes - is it for this seq number?
		jr	NZ,pauseseqskip
		res	4,(IX+CCBFLAGS)		; shut off running flags
pauseseqskip
		zadd	IX,DE
		dec	B
		jr	NZ,pauseseqloop
		call	CLIPALL
		ret

*
*  CLIPALL - called by STOPALL and PAUSEALL - cancels all envelopes, voices
*
*	scans voice tables, clipping off notes from inactive (not running channels)
*

CLIPVNUM	db	0

CLIPALL
		ld	IX,FMVTBL		; do fm voices
		ld	E,0
		call	CLIPLOOP
		ld	IX,PSGVTBL
		ld	E,1
		call	CLIPLOOP
		ld	IX,PSGVTBLNG
		ld	E,1
		call	CLIPLOOP

		ld	IY,ECB-1		; now clip envelopes
clipenvloop
		inc	IY
		ld	A,(IY+ECBCHAN)
		bit	7,A			; end of list?
		ret	NZ
		bit	6,A			; in use?
		jr	NZ,clipenvloop
		ld	B,0
		sla	A
		sla	A
		sla	A
		sla	A
		sla	A
		ld	C,A
		rl	B
		ld	HL,CCB+CCBFLAGS
		zadd	HL,BC
		bit	4,(HL)			; running?
		jp	NZ,clipenvloop		; yes - don't clip this env
		zset	6,(IY+ECBCHAN)
		jr	clipenvloop


* IX <- voice table, E <- 0 for fm, 1 for psg

CLIPLOOP
		ld	A,(IX+VTBLFLAGS)	; get vtbl entry
		cp	0FFH
		ret	Z

		ld	D,A			; save it

		ld	B,0
		ld	C,(IX+VTBLCH)		; see if this ccb is running
		sla	C
		sla	C
		sla	C
		sla	C
		sla	C
		rl	B
		ld	HL,CCB+CCBFLAGS
		zadd	HL,BC
		bit	4,(HL)			; running?
		jp	NZ,clipnxt		; yes - don't clip

		ld	A,D
		zand	7			; get voice num
		zor	80H			; add free flag
		ld	(IX+VTBLFLAGS),A	; update table
		ld	(IX+VTBLDL),0		; clear release and duration timers
		ld	(IX+VTBLDH),0
		ld	(IX+VTBLRT),0

		zand	7			; get voice num back
		ld	(CLIPVNUM),A
		bit	0,E			; fm or psg?
		jp	NZ,clippsg

		bit	5,D			; fm - digital mode?
		jr	Z,clipfm
clipdig
		ld	A,0C9H			; opcode "ret"
		ld	(DACME),A		; disable DACME routine
		ld	(FILLDACFIFO),A		; disable FILLDACFIFO
		ld	HL,4000H		; disable DAC mode
		ld	(HL),02BH
		inc	HL
		ld	(HL),0
		jp	clipnxt
clipfm
		ld	D,0			; point to bank 0
		cp	3			; is voice in bank 1 ?
		jr	C,clpafm0
		zsub	4			; yes, subtract 4 (map 4-6 >> 0-2)
		ld	D,2			; point to bank 1
clpafm0
		push	DE
		ld	E,A			; E <- channel within bank
		ld	H,40H
		FMWr	040H,7FH		; clamp all EGs
		FMWr	044H,7FH
		FMWr	048H,7FH
		FMWr	04CH,7FH
		pop	DE

		ld	A,(CLIPVNUM)
		ld	IY,4000H
		FMWrite 28H,A           	; key off
clipnxt
		ld	BC,7
		zadd	IX,BC
		jp	CLIPLOOP
clippsg
		ld      IY,psgcom		; load psg register table
		ld      C,A			; BC <- 0A
		ld      B,0
		zadd	IY,BC			; point to correct register
		ld      (IY+COM),4		; set stop command
		jr	clipnxt


*
*  SETTEMPO - sets the (1/24 beat) / (1/60 sec) ratio in SBPT (Sub Beat Per Tick)
*	SBPT is 16 bits, 8 of em fractional
*
*	parameters:		A	beats per minute
*
*	trashes:		DE,HL
*

SETTEMPO
		ld	DE,218
		call	MULTIPLY

		xor	A
		sla	L
		rl	H
		rla				; AH <- sbpt, 8 fracs
		ld	L,H
		ld	H,A			; HL <- AH
		ld	(SBPT),HL
		ret

*
*  TRIGENV - initialize an envelope
*
*	parameters:		C	envelope number
*				E	midi channel
*				IX	pointer to CCB
*
*	trashes:		everything
*

TRIGENV
		ld	B,(IX+CCBFLAGS)		; save channel's flags (for sfx tempo flag) in B
		ld	D,0
		ld	IY,PBTBL
		zadd	IY,DE
		ld	IX,ECB			; point at the envelope control blocks
retrigloop
		ld	A,(IX+ECBCHAN)		; first see if an ECB already exists for this channel
		bit	7,A			; end of list?
		jr	NZ,tryfree
		cp	E
		jr	Z,trigger
		inc	IX
		jr	retrigloop
tryfree
		ld	IX,ECB
trigloop					; then try to find a free ECB
		ld	A,(IX+ECBCHAN)		; A <- channel number and flags
		bit	7,A			; end of list?
		ret	NZ			; yup - return
		bit	6,A			; active ?
		jr	NZ,trigger		; nope - go allocate
		inc	IX
		jr	trigloop
trigger						; tigger envelope
		bit	3,B			; sfx flag set in CCB?
		jr	Z,trigger1
		zset	5,E			; yes - set sfx flag in ECB
trigger1
		ld	(IX+ECBCHAN),E		; set channel
		ld	(IX+ECBCTR),0		; clear counter to trigger segment update

		ld	B,0
		sla	C			; BC <- 2 * envelope #
		ld	HL,(ETBL68K)
		ld	A,(ETBL68K+2)		; AHL <- pointer to env table in 68k space
		zadd	HL,BC
		adc	A,0			; AHL <- pointer to this env's offset
		ld	C,2			; read 2 byte offset, into...
		ld	DE,fpoffset		; local fpoffset (shared w/ fetchpatch)
		call	XFER68K

		ld	DE,(fpoffset)		; DE <- the offset
		ld	HL,(ETBL68K)
		ld	A,(ETBL68K+2)
		zadd	HL,DE
		adc	A,0			; AHL <- pointer to env data
		ld	C,32			; xfer the 32 byte env into
		ld	D,01EH
		ld	E,(IX+ECBBUFP)		; this ECB's envelope buffer
		call	XFER68K

		ld	D,01EH
		ld	E,(IX+ECBBUFP)		; DE <- ptr to this ECB's envelope buffer

		ld	A,(DE)			; initialize envelope bend value
		ld	(IY+PBEBL),A
		inc	DE
		ld	A,(DE)
		ld	(IY+PBEBH),A
		inc	DE

		ld	(IX+ECBPTRL),E		; point ECB at envelope after initial value
		ld	(IX+ECBPTRH),D

		ret

*
*  DOENVELOPE - update the pitch envelope processor
*
*		trashes:	everything
*

		;export	ECB

ECB		db	040H,040H,040H,040H	; 4 envelopes worth of control blocks (ECB's)
		db	0FFH
		db	0,0,0,0
		db	0,0,0,0
		db	0,0,0,0
		db	0,0,0,0
		db	0,0,0,0
		db	80H,0A0H,0C0H,0E0H

ECBCHAN		equ	0			; offset to 4 envelopes' channel numbers and flags
						; [7]=eot, [6]=free, [5]=sfx tempo
ECBPTRL		equ	5			;	"		 segment ptr LSBs
ECBPTRH		equ	9			;	"		 segment ptr MSBs
ECBCTR		equ	13			; 	"		 segment ctrs
ECBDELL		equ	17			;	"		 segment delta LSBs
ECBDELH		equ	21			;	"		 segment delta MSBs
ECBBUFP		equ	25			; LSB of pointer to 32 byte envelope buffer

DOENVELOPE
		ld	IX,ECB			; point at the envelope control blocks
envloop
	call	DACME
		ld	C,(IX+ECBCHAN)		; C <- channel number and flags
		bit	7,C			; end of list?
		ret	NZ			; yup - return
		bit	6,C			; active ?
		jr	Z,envactive
envnext						; nope - loop
		inc	IX
		jr	envloop
envactive					; check if this envelope's timebase has ticked
		ld	A,(TBASEFLAGS)
		bit	5,C			; sfx timebase?
		jr	NZ,envsfx
		bit	1,A			; no - check music tick flag
		jr	NZ,envticked
		jr	envnext
envsfx
		bit	0,A			; yes - check sfx tick flag
		jr	Z,envnext
envticked
		ld	A,(IX+ECBCTR)
		zsub	1			; ctr at 0?
		jr	NC,envseg		; no - process segment
envnextseg
		ld	L,(IX+ECBPTRL)		; yes -
		ld	H,(IX+ECBPTRH)		; HL <- ptr to segment data
		ld	A,(HL)			; A <- counter value for next segment
		zsub	1
		jr	C, envdone
		inc	HL
		ld	B,(HL)
		ld	(IX+ECBDELL),B
		inc	HL
		ld	B,(HL)
		ld	(IX+ECBDELH),B		; ECB's delta <- this segment's delta
		inc	HL
	call	DACME
		ld	(IX+ECBPTRL),L		; ECB's segment ptr <- ptr to next segment
		ld	(IX+ECBPTRH),H
envseg						; process segment
		ld	IY,PBTBL
		ld	B,0
		res	5,C
		zadd	IY,BC			; IY <- ptr to this channel's pitchbend entries
		ld	(IX+ECBCTR),A		; save ECB's counter
		ld	A,(IY+PBEBL)
		zadd	A,(IX+ECBDELL)
		ld	(IY+PBEBL),A
		ld	A,(IY+PBEBH)
		adc	A,(IX+ECBDELH)
		ld	(IY+PBEBH),A		; this ch's envelope bend += this envelope's delta
envneedupd
		zset	0,(IY+PBRETRIG)
		ld	A,1
		ld	(NEEDBEND),A
		jr	envnext

envdone
		ld	IY,PBTBL
		ld	B,0
		res	5,C
		zadd	IY,BC			; IY <- ptr to this channel's pitchbend entries
		ld	(IY+PBEBL),0		; zero the envelope bend on this channel
		ld	(IY+PBEBH),0
		ld	(IX+ECBCHAN),040H	; shut off this envelope
		jr	envneedupd

*
*  DOPITCHBEND- updates the (pitchbend) value for the gems channel (= MIDI channel during perf
*
*	inputs:		A				CCB number (0-15)
*			(next 2 bytes in cmd queue)	pbend value
*

DOPITCHBEND
		ld	C,A
		ld	B,0
		ld	IX,PBTBL
		zadd	IX,BC			; IX <- ptr to this ch's bends
		call	GETCBYTE		; get pitch bend in half steps (8 fracs) into
		ld	(IX+PBPBL),A		; pitch bend for channel 0
		call	GETCBYTE
		ld	(IX+PBPBH),A
		zset	0,(IX+PBRETRIG)
		ld	A,1
		ld	(NEEDBEND),A
		ret

*
*  APPLYBEND - if NEEDBEND is set, apply the pitch and envelope bends to all channels,
*	and reset NEEDBEND
*
*	trashes:	everything
*

NEEDBEND	db	0			; set to 1 to trigger a need to bend

PBTBL		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0	; pitch bend LSB
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0	; pitch bend MSB
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0	; env bend LSB
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0	; env bend MSB
		db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0	; [0]=apply bend - set by pbend/mod,
							; cleared by applybend

PBPBL		equ	0			; offset in PBTBL to 16 channels' pitchbend LSB
PBPBH		equ	16			; offset in PBTBL to 16 channels' pitchbend MSB
PBEBL		equ	32			; offset in PBTBL to 16 channels' envelopebend LSB
PBEBH		equ	48			; offset in PBTBL to 16 channels' envelopebend MSB
PBRETRIG	equ	64			; offset in PBTBL to 16 channels' retrigger flag

APPLYBEND
		ld	A,(NEEDBEND)		; return if no bend needed
		zor	A
		ret	Z
		xor	A
		ld	(NEEDBEND),A		; clear the flag and go for it

		call	CHECKTICK

		ld	IY,FMVTBL		; go through FM voice table
pbfmloop
		call	DACME
		ld	A,(IY+0)
		cp	0FFH			; eot?
		jr	Z,pbpsg			; yup - all done
		zand	7
		ld	B,A			; B <- voice number
		ld	C,(IY+2)		; C <- note number
		ld	E,(IY+3)			; E <- channel number
		ld	A,0			; indicate FM type voice

;FOR TESTING ONLY
;		jr	pbfmskip

		ld	IX,PBTBL
		ld	D,0
		zadd	IX,DE			; IX <- ptr to pitch/envelope bend for this ch
		bit	0,(IX+PBRETRIG)		; check for change in bend on this channel
		jr	Z,pbfmskip

		call	GETFREQ			; get the new freq num for this voice
		ld	(noteonffreq),DE	; save freq number

		ld	D,0			; indicates bank 0 to FMWr
		ld	A,B
		cp	3			; is voice in bank 1 ?
		jr	C,pbfmbank0
		zsub	4			; yes, subtract 4 (map 4-6 >> 0-2)
		ld	D,2			; indicates bank 1 to FMWr
pbfmbank0
		ld	E,A			; E <- channel within bank
		ld	H,40H
		push	IY
		ld	IY,noteonffreq		; IY <- ptr to freq number from GETFREQ
		FMWr	0A4H,(IY+1)		; set frequency msb
		FMWr	0A0H,(IY+0)		; set frequency lsb
		pop	IY

pbfmskip
		ld	DE,7
		zadd	IY,DE
		jr	pbfmloop

* New Register Usage ^^^
*   H <- 40H (MSB of FM chip register address)
*   D <- 0 for bank 0 (channels 0,1,2) or 2 for bank 1 (channels 3,4,5)
*   E <- channel within bank (0-2)
* FMWrch uses these plus A,B,C,L
*

pbpsg
		ld	IY,PSGVTBL		; go through PSG voice table
pbpsgloop
		call	DACME
		ld	A,(IY+0)
		cp	0FFH			; eot?
		jr	Z,pbdone		; yup - all done
		zand	7
		ld	B,A			; B <- voice number
		ld	C,(IY+2)			; C <- note number
		ld	E,(IY+3)			; DE <- channel number
		ld	A,1			; flag psg type voice

;FOR TESTING ONLY
;		jr	pbpsgskip

		ld	IX,PBTBL
		ld	D,0
		zadd	IX,DE			; IX <- ptr to pitch/envelope bend for this ch
		bit	0,(IX+PBRETRIG)		; check for change in bend on this channel
		jr	Z,pbpsgskip

		call	GETFREQ			; get the new freq num for this voice

		call	DACME

		rrc	B
		rrc	B
		rrc	B
		ld	A,E
		zand	0FH
		zor	80H
		zor	B

		ld	(07F11H),A
		srl	D
		rr	E
		srl	D
		rr	E
		srl	D
		rr	E
		srl	D
		rr	E
		ld	A,E
		ld      (07F11H),A		; write tone msb
pbpsgskip
		ld	DE,7
		zadd	IY,DE
		jr	pbpsgloop

pbdone
		ld	HL,PBTBL+PBRETRIG
		ld	A,16
pbdoneloop
		ld	(HL),0
		inc	HL
		dec	A
		jr	NZ,pbdoneloop

		ret

*  GETFREQ - gets a frequency (for FM) or wavelength (for PSG) value from a note
*	number and a channel # (for adding pitch and envelope bends)
*
*	parameters:	A	0 for FM, 1 for PSG
*			C	note (0=C0, 95=B7)
*			E	channel
*			IX	pointer to this channel's PBTBL entry

*	returns:	DE	freq or wavelength value
*
*	trashs:		A,IX

gfpbend		dw	0			; local pitch bend

GETFREQ
		push	BC
		push	HL

		call	DACME

		ld	B,A			; B <- voice type

		ld	A,(IX+PBPBL)
		zadd	A,(IX+PBEBL)
		ld	E,A
		ld	A,(IX+PBPBH)
		adc	A,(IX+PBEBH)
		ld	D,A			; DE <- pitchbend(IX+0) + envelopebend(IX+0)
		ld	(gfpbend),DE		; save pitch bend

		call	DACME

		ld	A,C
		zadd	A,D			; A <- semitone + semitone portion of bend
		cp	96			; is it outside 0..95?
		jr	C,gflookup		; no - go to lookup
		bit	7,D			; yes - was bend up or down?
		jr	Z,gftoohi
		ld	A,0			; down - peg at 0 (C0)
		ld	(gfpbend),A
		jr	gflookup
gftoohi
		ld	A,0FFH
		ld	(gfpbend),A
		ld	A,95			; up - peg at 95 (B7) and max frac pbend
gflookup
		call	DACME
		bit	0,B			; voice type ? (dictates lookup method)
		jr	NZ,gflupsg
gfllufm						; fm style lookup
		ld	C,0			; C <- A / 12; A <- A % 12
		cp	48
		jr	C,nobit2
		zsub	48
		zset	2,C
nobit2		cp	24
		jr	C,nobit1
		zsub	24
		zset	1,C
nobit1		cp	12
		jr	C,nobit0
		zsub	12
		zset	0,C
nobit0
		ld	IX,fmftbl
		jr	gfinterp
gflupsg						; psg style lookup
		zsub	33			; lowest note for PSG is A2
		jr	NC,gflupsg1
		ld	A,0
		ld	(gfpbend),A
gflupsg1
		ld	IX,psgftbl
gfinterp					; interpolate up from value at (IX+0) by (gfpbend)
		rlca
		ld	E,A			; DE <- 2 * A
		ld	D,0
		zadd	IX,DE			; (IX+0) <- ptr in appropriate table (clears carry)

		call	DACME

		ld	A,(IX+2)
		zsub	(IX+0)
		ld	E,A
		ld	A,(IX+3)
		sbc	A,(IX+1)
		ld	D,A			; DE <- next table entry - this table entry

		ld	A,(gfpbend)		; A <- frac part of pitch bend
		call	MULTIPLY		; HL <- (DE (table delta) * A (frac bend) ) * 256

		call	DACME

		ld	L,0			; L <- 8 bits sign extention of H
		bit	7,H
		jr	Z,gfnoextnd
		ld	L,0FFH
gfnoextnd
		ld	A,(IX+0)
		zadd	A,H
		ld	E,A
		ld	A,(IX+1)
		adc	A,L
		ld	D,A			; DE <- this entry + (delta * frac)

		bit	0,B			; voice type ?
		jr	NZ,gfdone		; all done for PSG

		ld	A,C			; for FM, put octave in F number 13:11
		rlca
		rlca
		rlca
		zor	D
		ld	D,A
gfdone
		pop	HL
		pop	BC
		call	DACME
		ret


*
*  MULTIPLY - unsigned 8 x 16 multiply: HL <- A * DE
*	MULADD entry point: for preloading HL with an offset
*	GETPATPTR entry point: HL <- PATCHDATA + 39 * A


GETPATPTR
		ld	HL,PATCHDATA
		ld	DE,39
		jr	MULADD
MULTIPLY
		ld	HL,0
MULADD
		srl	A
		jr	NC,mulbitclr
		zadd	HL,DE
mulbitclr
		ret	Z
		sla	E			; if more bits still set in A, DE*=2 and loop
		rl	D
		jr	MULADD


*
*  NOTEON - note on (key on)
*
*	parameters:	B		midi channel
*			C		note number: 0..95 = C0..B7
*			IX		pointer to this channel's CCB
*			(CHPATPTR)	pointer to this channel's patch
*
*	trashes:	all registers
*

* fmftbl contains a 16 bit freq number for each half step in a single octave (C-C)

fmftbl		dw	644,682,723,766,811,859,910,965,1022,1083,1147,1215,1288

* psgftbl contains the 16 bit wavelength numbers for the notes A2 thru B7 (33-95)

psgftbl		dw	       03F9H, 03C0H, 038AH	; A2 > B2

		dw	0357H, 0327H, 02FAH, 02CFH	; C3 > B3
		dw	02A7H, 0281H, 025DH, 023BH
		dw	021BH, 01FCH, 01E0H, 01C5H

		dw	01ACH, 0194H, 017DH, 0168H	; C4 > B4
		dw	0153H, 0140H, 012EH, 011DH
		dw	010DH, 00FEH, 00F0H, 00E2H

		dw	00D6H, 00CAH, 00BEH, 00B4H	; C5 > B5
		dw	00AAH, 00A0H, 0097H, 008FH
		dw	0087H, 007FH, 0078H, 0071H

		dw	006BH, 0065H, 005FH, 005AH	; C6 > B6
		dw	0055H, 0050H, 004CH, 0047H
		dw	0043H, 0040H, 003CH, 0039H

		dw	0035H, 0032H, 002FH, 002DH	; C7 > B7 (not very accurate!)
		dw	002AH, 0028H, 0026H, 0023H
		dw	0021H, 0020H, 001EH, 001CH

		dw	001CH				; extra value for interpolation of B7

noteonnote	db	0			; note on note (keep these together - stored as BC)
noteonch	db	0			; note on channel
noteonvoice	db	0			; allocated voice
noteonatten	db	0			; attenuation for this voice

NOTEON
		call	DACME

;; LAST MINUTE FIX FOR TAZ LEVELS - down 7
		ld	A,(MASTERATN)
;;		zadd	A,10
		zadd	A,(IX+CCBATN)		; sum channel and master attenuations, limit to 127
		jp	P,legalatten
		ld	A,127
legalatten
		ld	(noteonatten),A

		ld	(noteonnote),BC		; save note and channel

		call	FILLDACFIFO
		call	CHECKTICK

		ld	HL,(CHPATPTR)
		ld	A,(HL)			; A <- patch type (byte 0 of patch)
		cp	0
		jp	Z,noteonfm		; 0 for fm patches
		cp	1
		jp	Z,noteondig		; 1 for digital patches
		cp	2
		jp	Z,noteontone
		cp	3
		jp	Z,noteonnoise
		ret

* here to allocate a voice for a PSG patch

noteonnoise
		ld	IY,PSGVTBLNG		; try to get TG4 (noise ch)
		call	ALLOCSPEC
		jr	noteoneither
noteontone
		ld	IY,PSGVTBL
		call	ALLOC
noteoneither
		cp	0FFH
		ret	Z			; return if unable to allocate a voice

		call	VTANDET			; call code shared by FM and PSG to update
						;   VoiceTable AND Envelope Trigger
		ld	A,1			; indicates PSG
		ld	E,B			; E <- channel
		ld	IX,PBTBL
		ld	D,0
		zadd	IX,DE			; IX <- ptr to pitch/envelope bend for this ch
		call	GETFREQ

		ld	IX,(CHPATPTR)		; IX <- patch pointer
		inc	IX

		ld	A,(noteonvoice)		; A <- PSG voice number
		ld      C,A
		ld      B,0
		ld      IY,psgcom
		zadd	IY,BC			; IY <- psg control registers for this voice

		ld	A,E
		zand	0FH
		ld      (IY+DTL),A		; write tone lsb
		srl	D
		rr	E
		srl	D
		rr	E
		srl	D
		rr	E
		srl	D
		rr	E
		ld      (IY+DTH),E		; write tone msb

		ld	A,(noteonvoice)
		cp	3
		jr	NZ,pskon		; for TG1-TG3, go on to rest of control regs

		ld	HL,PSGVTBLTG3		; assume TG3 is not locked by this noise patch
		res	5,(HL)

; NAT: Was originally IX-1. For some reason, the instruction was assembled as if it was IX+0, even though here it clearly
; says -1. This may be a bug!
		ld	A,(IX+0);(IX-1)		; its TG4 - is it clocked by TG3?
		zand	3
		cp	3
		jr	NZ,psgnoise

		ld	HL,7F11H		; yes - move the frequency directly to TG3
		ld	A,(IY+DTL)
		zor	0C0H
		ld	(HL),A
		ld	A,(IY+DTH)
		ld	(HL),A

		ld	HL,PSGVTBLTG3		; in the voice table...
		ld	(HL),0A2H		; show TG3 free and locked
		inc	HL
		inc	HL
		ld	BC,(noteonnote)
		ld	(HL),C			; and store note and channel (for pitch mod)
		inc	HL
		ld	(HL),B

		ld	HL,psgcom+2		; and send a stop command to TG3 env processor
		ld	(HL),4
psgnoise
		ld      A,(IX+0)		; load noise data
		ld      (IY+DTL),A		; write noise data

pskon      	ld      A,(IX+1)		; load attack rate
		ld      (IY+ATK),A		; write attack rate
		ld      A,(IX+2)		; load sustain level
		sla     A			; fix significance (<<4)
		sla     A
		sla     A
		sla     A
		ld      (IY+SLV),A		; write sustain level
		ld      A,(IX+3)		; load attack level
		sla     A			; fix significance (<<4)
		sla     A
		sla     A
		sla     A
		ld      (IY+ALV),A		; write attack level
		ld      A,(IX+4)		; load decay rate
		ld      (IY+DKY),A		; write decay rate
		ld      A,(IX+5)		; load release rate
		ld      (IY+RRT),A		; write release rate
		zset     0,(IY+COM)		; key on command

		ret

* here for a digital patch note on

noteondig
		ld	IY,FMVTBLCH6		; try to get FM voice 6 (DAC)
		call	ALLOCSPEC
		cp	0FFH
		ret	Z			; return if unable to allocate

		bit	7,A			; was it in use?
		jr	NZ,noteondig2
		ld	A,0C9H			; yes - disable DACME in case it was on to speed noteondig
		ld	(DACME),A
		ld	A,(HL)			; get flags back
		bit	5,A			; yes - was it FM?
		jr	NZ,noteondig2
		zand	7			; yes - do a keyoff
		ld	IY,4000H
		FMWrite	28H,A
		ld	A,(HL)			; get flags back
noteondig2
		call	VTANDET			; call code shared by FM and PSG to update
						;   VoiceTable AND Envelope Trigger
		ld	HL,FMVTBLCH6
		zset	5,(HL)			; lock the voice from FM allocation

; at this point, C is note number - C4 >> B7 equals samples  0 through 47 (for back compatibil
;				    C0 >> B3 equals samples 48 through 96
; trigger sample by reading sample bank table for header

		ld	A,C			; map note num to sample num
		zsub	48
		jr	NC,noteondig21
		zadd	A,96
noteondig21
		ld	C,A
		ld	B,0			; BC <- sample number
		ld	HL,(DTBL68K)		; AHL <- pointer to sample table
		ld	A,(DTBL68K+2)
		sla	C
		rl	B
		sla	C
		rl	B			; BC <- 4*sampno
		zadd	HL,BC
		adc	A,0
		sla	C
		rl	B			; BC <- 8*sampno
		zadd	HL,BC			; AHL <- pointer to this sample in table (sampno*12)
		adc	A,0

		ld	C,12			; read 12 byte header, into...
		ld	DE,SAMPFLAGS		; sample header cache
		call	XFER68K

		ld	BC,(SAMPFIRST)		; check for non-zero sample length
		ld	A,B
		zor	C
		jr	NZ,sampleok
		ld	HL,FMVTBLCH6
		ld	(HL),0C6H		; empty sample - mark voice 6 free and releasing
		ret
sampleok

; now check for sample playback rate override (2nd byte of patch != 4) - override rate in SAMP

		ld	HL,(CHPATPTR)
		inc	HL
		ld	A,(HL)
		cp	4
		jr	Z,sampleok1
		ld	B,A
		ld	A,(SAMPFLAGS)
		zand	0F0H			; replace counter value in flags (controls freq)
		zor	B
		ld	(SAMPFLAGS),A
sampleok1
		exx

		ld	E,0			; reset FIFO read ptr to start of buffer

		ld	(HL),024H		; set timer A msb
		inc	HL
		ld	A,(SAMPFLAGS)
		zand	0FH
		zneg
		sra	A
		sra	A
		ld	(HL),A
		dec	HL

		ld	(HL),025H		; timer A lsb
		inc	HL
		ld	A,(SAMPFLAGS)
		zand	0FH
		zneg
		zand	3
		ld	(HL),A
		dec	HL

		ld	(HL),02BH		; enable the dac
		inc	HL
		ld	(HL),080H
		dec	HL

		ld	(HL),27H		; enable timer
		inc	HL
		ld	(HL),B
		dec	HL

		exx

		ld	IY,4002H
		FMWrite 0B6H,0C0H		; enable ch6 output to both R and L

		ld	BC,(DTBL68K)
		ld	A,(DTBL68K+2)
		ld	D,A			; DBC <- pointer to sample table
		ld	HL,(SAMPPTR)
		ld	A,(SAMPPTR+2)		; AHL <- 24-bit sample start offset
		zadd	HL,BC
		adc	A,D			; add em up to get ptr to sample start
		ld	BC,(SAMPSKIP)
		zadd	HL,BC			; add skip value to pointer for initial load
		adc	A,0
		ld	(SAMPLEPTR),HL		; store read pointer for FILLDACFIFO
		ld	(SAMPLEPTR+2),A

		ld	HL,(SAMPFIRST)
		ld	(SAMPLECTR),HL		; initialize counter

		ld	A,0
		ld	(FILLDACFIFO),A		; enable full FILLDACFIFO routine
		ld	(DACFIFOWPTR),A		; start fill at 1F00

		ld	A,(SAMPFLAGS)
		bit	4,A			; looped?
		ld	A,4			; FDF=4 to run nonloop sample
		jr	Z,notlooped
		inc	A			; FDF=5 to run loop sample
notlooped
		ld	(FDFSTATE),A

		call	FORCEFILLDF		; force the fill

		ld	A,0D9H			; opcode "EXX"
		ld	(DACME),A		; enable DACME routine
		ld	A,008H			; opcode "EX AF,AF"
		ld	(DACME+1),A

		ld	A,(SAMPFLAGS)		; check for slow dacme mode: samp rate = 5.2kHz
		zand	0FH
		cp	10			; samples rate <= 5.2?
		ld	A,0			; (if slow, put a NOP at DACMERET to enable toggling)
		jr	NC,useslowdacme
		ld	A,0C9H			; opcode "RET", to disable toggling
useslowdacme
		ld	(DACMERET),A

		ld	A,(SAMPFLAGS)		; compression on?
		bit	7,A
		ld	HL,0			; (2 nops for 8 bit mode)
		jr	Z,setprocinst

		ld	HL,(DACME4BINST)	; jump to DACMEDSP for DACMEPROC
		exx
		ld	C,0AAH			; pattern to control nibble selection in DACMEDSP
		exx
setprocinst
		ld	(DACMEPROC),HL		; set approriate inst(s) at DACMEPROC
		ret


SAMPFLAGS	db	0
SAMPPTR		db	0,0,0
SAMPSKIP	db	0,0
SAMPFIRST	db	0,0
SAMPLOOP	db	0,0
SAMPEND		db	0,0

* here to allocate a voice for an FM patch

noteonffreq	dw	0

noteonfm
		inc	HL
		inc	HL
		ld	D,(HL)			; (D <- CH3 mode byte)
		bit	6,D
		jr	Z,noteonfm1

		ld	IY,FMVTBLCH3		; only CH3 will do for a CH3 mode patch
		call	ALLOCSPEC
		jr	noteonfm15
noteonfm1
		ld	IY,FMVTBL
		call	ALLOC
noteonfm15

	call	DACME

		cp	0FFH
		ret	Z			; return if unable to allocate a voice

		bit	7,A			; was it in use?
		jr	NZ,noteonfm2
		zand	7			; yes - do a keyoff
		ld	IY,4000H
		FMWrite	28H,A
		ld	A,(HL)			; get flags back
noteonfm2
		push	DE
		call	VTANDET
		pop	DE

		bit	6,D			; skip freq computation for CH3 mode
		jr	NZ,noteonfm3

		ld	A,0			; FM type voice
		ld	E,B			; E <- channel

		ld	IX,PBTBL
		ld	D,0
		zadd	IX,DE			; IX <- ptr to pitch/envelope bend for this ch
		call	GETFREQ
		ld	(noteonffreq),DE	; save freq number

		call	DACME

noteonfm3
		ld	IX,(CHPATPTR)		; IX <- patch pointer + 1 (past type byte)
		inc	IX
		ld	A,(noteonvoice)
		ld	C,A			; C  <- key on code

		ld	IY,4000H		; IY <- FM chip

		cp	2			; channel 3 ?
		jr	NZ,noteonfm4
		ld	A,(IX+1)		; yes - add CH3 mode bits to DACME's reset cmd
		zor	15H
		exx
		ld	B,A			;  which is kept in B'
		exx

		ld	A,(IX+1)		; CH3 mode bits again, plus bits to
		zor	5			; KEEP TIMER A ENABLED AND RUNNING, but not reset
		ld	H,A
		ld	L,27H			; send now
		FMWrgl

noteonfm4
		ld	D,0			; indicates bank 0 to FMWr
		ld	A,C
		cp	3			; is voice in bank 1 ?
		jr	C,fmbank0
		zsub	4			; yes, subtract 4 (map 4-6 >> 0-2)
		ld	D,2			; indicates bank 1 to FMWr
fmbank0
		ld	E,A			; E <- channel within bank
		ld      H,(IX+0)		; load lfo data
		bit	3,H			; only load if LFO on in this patch
		jr	Z,fmlfodis
		ld      L,22H			; load register number
		FMWrgl				; write lfo register
fmlfodis
		push	BC		; save C (note on number)

		ld	HL,CARRIERTBL
		ld	B,0
		ld	A,(IX+2)		; lookup up carrier mask by alg number
		zand	7
		ld	C,A
		zadd	HL,BC
		ld	A,(HL)
		ld	(CARRIERS),A		; bit 0 for op 1 carrier, bit 1 for op 2 carrier...

		ld	H,40H
		ld	BC,FMADDRTBL
		call	WRITEFM

		;export FOO2
FOO2


		bit     6,(IX+1)		; check channel 3 mode
		jr      NZ,fmc3on		; go set channel 3 frequency
		ld	IY,noteonffreq		; IY <- ptr to freq number from GETFREQ
		FMWr	0A4H,(IY+1)		; set frequency msb
		FMWr	0A0H,(IY+0)		; set frequency lsb
		jp      fmkon			; go key on

fmc3on
		ld	IY,4000H
		FMWrite 0A6H,(IX+28)		; ch3 op1 msb
		FMWrite 0A2H,(IX+29)		; ch3 op1 lsb
		FMWrite 0ACH,(IX+30)		; ch3 op2 msb
		FMWrite 0A8H,(IX+31)		; ch3 op2 lsb
		FMWrite 0ADH,(IX+32)		; ch3 op3 msb
		FMWrite 0A9H,(IX+33)		; ch3 op3 lsb
		FMWrite 0AEH,(IX+34)		; ch3 op4 msb
		FMWrite 0AAH,(IX+35)		; ch3 op4 lsb

fmkon:		ld      A,(IX+36)		; load operator on mask
		sla     A			; fix significance
		sla     A
		sla     A
		sla     A
		pop	BC		; UGLY!!!!!
		zor	C			; mix with channel code
		ld      IY,4000H		; global fm register
		FMWrite 28H,A			; key on

		ret

CARRIERTBL	db	08H		; alg 0, op 4 is carrier
		db	08H		; alg 1, op 4 is carrier
		db	08H		; alg 2, op 4 is carrier
		db	08H		; alg 3, op 4 is carrier
		db	0AH		; alg 4, op 2 and 4 are carriers
		db	0EH		; alg 5, op 2 and 3 and 4 are carriers
		db	0EH		; alg 6, op 2 and 3 and 4 are carriers
		db	0FH		; alg 7, all ops carriers

CARRIERS	db	0

		;export	MASTERATN
MASTERATN	db	0		; master attenuation is 7 frac bits (0 = full volume)

*
* WRITEFM - write a string of values to the FM chip. BC points to a null-terminated
*   list of reg/data pairs, where data is an offset off of IX. if data is 0, the
*   indirection is skipped and a 0 written (for the "proprietary register")
*   H <- 40H (MSB of FM chip register address)
*   D <- 0 for bank 0 (channels 0,1,2) or 2 for bank 1 (channels 3,4,5)
*   E <- channel within bank (0-2)
*
		;export	WRITEFM
WRITEFM
		ld	A,(BC)			; get reg num
		zor	A
		ret	Z			; (0 = EOT)
		inc	BC

		ld	L,0			; point to 4000
		bit	7,(HL)			; spin on busy bit
		jr	NZ,*-2

		ld	L,D			; point at bank's addr port
		zadd	A,E			; add voice num to point at correct register
		ld	(HL),A
		inc	L			; point at data port
		ld	A,(BC)			; get data offset
		zor	A			; if data offset 0, just write 0
		jp	Z,writefm0
		jp	P,nottl			; msb indicates total level values

		zand	7FH			; mask off tl flag
		push	HL
		ld	HL,CARRIERS		; is this a carrier?
		rr	(HL)
		jp	NC,nottl0		; no - normal output
		push	DE
		ld	(SELFMOD2+2),A		; modify LD instruction with this offset
		ld	A,127
SELFMOD2	zsub	(IX+0)			; becomes ld A,(IX+dataoffset)
		push	AF			; save level (0=soft, 127=loud)
		sla	A
		ld	E,A
		ld	D,0			; DE is level (0=soft, 254=loud)
		ld	A,(noteonatten)
		call	MULTIPLY
		pop	AF			; get back level
		zsub	H			; reduce by attenuation amount
		ld	H,A
		ld	A,127
		zsub	H
		pop	DE
		pop	HL
		jr	writefm0
nottl0
		pop	HL
nottl
		ld	(SELFMOD+2),A		; modify LD instruction with this offset
SELFMOD		ld	A,(IX+0)		; becomes ld A,(IX+dataoffset)

writefm0	ld	(HL),A
		inc	BC
		jp	WRITEFM

FMADDRTBL
		db	0B0H,2		; set feedback, algorithm
		db	0B4H,3		; set output, ams, fms
		db	30H,4		; operator 1 - set detune, mult
		db	40H,133		;5+128	; set total level
		db	50H,6		; set rate scaling, attack rate
		db	60H,7		; set am enable, decay rate
		db	70H,8		; set sustain decay rate
		db	80H,9		; set sustain level, release rate
		db	90H,0		; set proprietary register
		db	38H,16		; operator 2 - set detune, mult
		db	48H,145		;17+128	; set total level
		db	58H,18		; set rate scaling, attack rate
		db	68H,19		; set am enable, decay rate
		db	78H,20		; set sustain decay rate
		db	88H,21		; set sustain level, release rate
		db	98H,0		; set proprietary register
		db	34H,10		; operator 3 - set detune, mult
		db	44H,139		;11+128	; set total level
		db	54H,12		; set rate scaling, attack rate
		db	64H,13		; set am enable, decay rate
		db	74H,14		; set sustain decay rate
		db	84H,15		; set sustain level, release rate
		db	94H,0		; set proprietary register
		db	3CH,22		; operator 4 - set detune, mult
		db	4CH,151		;23+128	; set total level
		db	5CH,24		; set rate scaling, attack rate
		db	6CH,25		; set am enable, decay rate
		db	7CH,26		; set sustain decay rate
		db	8CH,27		; set sustain level, release rate
		db	9CH,0			; set proprietary register
		db	0

		;export	EOWRITEFM
EOWRITEFM

*
*  VTANDET - code shared between FM and PSG note on routines for stuffing the
*    voice table entry and checking for envelope retrigger
*

VTANDET
		zand	7			; clear flags
		ld	(noteonvoice),A		; save allocated voice
		ld	(HL),A

		ld	E,(IX+CCBDURL)
		ld	D,(IX+CCBDURH)
		ld	A,D
		zor	E
		jr	Z,noselftime		; if non-zero duration, set self-time flag
		zset	4,(HL)
noselftime
		bit	3,(IX+CCBFLAGS)		; sfx tempo based?
		jr	Z,nosfxtempo
		zset	3,(HL)			;  yes - set voice tbl sfx flag
nosfxtempo
		inc	HL
		ld	A,(IX+CCBPRIO)
		ld	(HL),A
		ld	BC,(noteonnote)		; C <- note, B <- channel
		inc	HL			; store note and channel in table
		ld	(HL),C
		inc	HL
		ld	(HL),B
		inc	HL
		ld	(HL),E
		inc	HL
		ld	(HL),D
		inc	HL
		ld	(HL),254		; init release timer

	call	DACME

		bit	6,(IX+CCBFLAGS)		; envelope retrigger on?
		ret	Z
		push	BC			; yes - trigger the envelope
		ld	C,(IX+CCBENV)
		ld	E,B
		call	TRIGENV
		call	DACME
		pop	BC
		ret

*
*  NOTEOFF - note off (key off)
*
*	parameters:	B	midi channel
*			C	note number: bits 6:4 = octave, bits 3:0 = note (0-11)
*
*	trashes:	all registers
*

noteoffnote	db	0
noteoffch	db	0

NOTEOFF
		ld	(noteoffnote),BC

		ld	IX,FMVTBL
		call	DACME
		call	DEALLOC

		cp	0FFH			; was note found?
		jr	Z,trypsg
		zand	27H			; yes - locked channel six?
		cp	26H
		jr	Z,digoff		;   yes - do digital note off
		zand	7			;   no - get note number
		ld      IY,4000H        	; load fm register address
		FMWrite 28H,A           	; key off
		ret
digoff
		call	NOTEOFFDIG
		ret

trypsg		ld	BC,(noteoffnote)
		ld	IX,PSGVTBL
		call	DACME
		call	DEALLOC

		cp	0FFH
		jr	Z,trynoise

		zand	3
		ld      IX,psgcom		; load psg register table
		ld      C,A			; BC <- 0A
		ld      B,0
		zadd	IX,BC			; point to correct register
		zset	1,(IX+0)		; set key off command
		ret
trynoise
		ld	BC,(noteoffnote)
		ld	IX,PSGVTBLNG
		call	DACME
		call	DEALLOC

		cp	0FFH
		ret	Z

		zand	3
		ld      IX,psgcom		; load psg register table
		ld      C,A			; BC <- 0A
		ld      B,0
		zadd	IX,BC			; point to correct register
		zset	1,(IX+0)		; set key off command
		ret

NOTEOFFDIG
		ld	A,(SAMPFLAGS)
		bit	5,A			; is clip@noteoff set?
		jr	NZ,noteoffdig1		; yes - shut down digitial
		bit	4,A			; is it looped?
		ret	Z
		ld	A,6			; yes - indicate end of loop
		jr	noteoffdig2
noteoffdig1
		ld	A,7
noteoffdig2
		ld	(FDFSTATE),A
		ret

*
*  PCHANGE - program change
*
*	trashes:	all registers
*

fpoffset	dw	0

PCHANGE
		call	GETCCBPTR		; GETCBYTE for channel, IX <- CCB ptr, A <- channel
		call	GETPATPTR		; HL <- PATCHDATA + 39 * A
		ld	(CHPATPTR),HL		; set pointer to this channel's patch buffer

		call	GETCBYTE
		ld	(IX+CCBPNUM),A		; set program number in CCB
FETCHPATCH
		ld	D,0
		ld	E,(IX+CCBPNUM)
		sla	E			; DE <- pnum * 2
		ld	HL,(PTBL68K)
		ld	A,(PTBL68K+2)		; AHL <- pointer to patch table in 68k space
		zadd	HL,DE
		adc	A,0			; AHL <- pointer to this patch's offset
		ld	C,2			; read 2 byte offset, into...
		ld	DE,fpoffset		; local fpoffset
		call	XFER68K

		ld	DE,(fpoffset)		; DE <- the offset
		ld	HL,(PTBL68K)
		ld	A,(PTBL68K+2)
		zadd	HL,DE
		adc	A,0			; AHL <- pointer to patch data
		ld	C,39			; xfer the 39 byte patch into
		ld	DE,(CHPATPTR)		; this channel's patch buffer
		call	XFER68K

		ret

PATCHLOAD
		ld	B,A			; B <- patchnum
		ld	C,16			; C <- loop counter
		ld	IX,CCB
		ld	HL,PATCHDATA
		ld	(CHPATPTR),HL
plloop
		ld	A,B
		cp	(IX+CCBPNUM)
		jr	NZ,plloop1
		push	BC
		call	FETCHPATCH
		pop	BC
plloop1
		ld	DE,32
		zadd	IX,DE
		ld	DE,39
		ld	HL,(CHPATPTR)
		zadd	HL,DE
		ld	(CHPATPTR),HL
		dec	C
		jr	NZ,plloop

		ret


***************************  Dynamic Voice Allocation ***************************

		;export	FMVTBL
		;export	PSGVTBL

*  FMVTBL - contains (6) 7-byte entires, one per voice:
*    byte 0: FRLxxVVV	flag byte, where F=free, R=release phase, L=locked, VVV=voice num
*                       VVV is numbered (0,1,2,4,5,6) for writing directly to key on/off reg
*    byte 1: priority	only valid for in-use (F=0) voices
*    byte 2: notenum	    "
*    byte 3: channel	    "
*    byte 4: lsb of duration timer (for sequenced notes)
*    byte 5: msb of duration timer
*    byte 6: release timer


FMVTBL		db	080H,0,050H,0,0,0,0		; fm voice 0
		db	081H,0,050H,0,0,0,0		; fm voice 1
		db	084H,0,050H,0,0,0,0		; fm voice 3
		db	085H,0,050H,0,0,0,0		; fm voice 4
FMVTBLCH6	db	086H,0,050H,0,0,0,0		; fm voice 5 (supports digital)
FMVTBLCH3	db	082H,0,050H,0,0,0,0		; fm voice 2 (supports CH3 poly mode)
		db	0FFH

PSGVTBL		db	080H,0,050H,0,0,0,0		; normal type voice, number 0
		db	081H,0,050H,0,0,0,0		; normal type voice, number 1
PSGVTBLTG3	db	082H,0,050H,0,0,0,0		; normal type voice, number 2
		db	0FFH

PSGVTBLNG	db	083H,0,050H,0,0,0,0		; noise type voice, number 3
		db	0FFH


*  ALLOC     - dynamic voice allocation routine
*  ALLOCSPEC - special entry point for only allocating or not the single voice at (IY)
*
*	parameters:	B	channel
*			IX	pointer to this channel's CCB
*			IY	first entry in appropriate voice table
*
*	uses:		?????
*
*	returns:	A	flags of voice allocated, or FF if none allocated
*			HL	pointer to entry allocated

avlowestp	dw	0			; pointer to lowest priority
avfreestp	dw	0			; pointer to longest free

VTBLFLAGS	equ	0
VTBLPRIO	equ	1
VTBLCH		equ	3
VTBLDL		equ	4
VTBLDH		equ	5
VTBLRT		equ	6

ALLOC

;	call	DACME
;	push	IY
;	pop	HL
;	ld	A,(HL)
;	ret

		ld	C,0FFH			; C <- lowest prio so far (max actually 7FH)
		ld	L,0FFH			; L <- freest so far (max actually 0FE)
		ld	DE,7			; for incrementing HL to next entry
		ld	H,(IX+CCBFLAGS)		; bit 7 is sustain
		jr	avstart
avloop
		zadd	IY,DE			; point to next entry
avstart

	call	DACME

		ld	A,(IY+VTBLFLAGS)
		cp	0FFH			; end of table?
		jr	Z,aveot			;   yes - look into taking an in use voice
		bit	5,A			; channel locked?
		jr	NZ,avloop		; yup - skip it
		bit	7,A			; check free/used
		jr	NZ,avfree		;

		ld	A,(IY+VTBLPRIO)		; in use - check priority against lowest so far
		cp	C			; lower than lowest so far?
		jr	NC,avloop
		ld	C,A			; yes - so make this lowest
		ld	(avlowestp),IY
		jr	avloop
avfree
		ld	A,(IY+VTBLCH)		; its free - same channel is requester?
		cp	B
		jr	NZ,avdiffch
		bit	7,H			; yes - sustain on?
		jr	NZ,avdiffch

		push	IY
		pop	HL
		ld	A,(HL)			; yes return A and HL
		ret
avdiffch
		ld	A,(IY+VTBLRT)		; freer than freest so far?
		cp	L
		jr	NC,avloop
		ld	L,A			; yes - so make this the freest
		ld	(avfreestp),IY
		jr	avloop
aveot
		ld	A,L
		cp	0FFH			; any found free?
		jr	Z,avtakeused
		ld	HL,(avfreestp)		; yes take freest
		ld	A,(HL)
		ret
avtakeused
		ld	A,C			; no free ones - check lowest so far priority
avspecprio
		cp	(IX+CCBPRIO)		; compare to priority of this channel
		jr	Z,avtakeit
		jr	C,avtakeit		; this channel >= lowest priority
		ld	A,0FFH			; failed to allocate
		ret
avtakeit
		ld	HL,(avlowestp)
		ld	A,(HL)
		ret

ALLOCSPEC

	call	DACME

;	push	IY
;	pop	HL
;	ld	A,(HL)
;	ret

		ld	A,(IY+VTBLFLAGS)	; here to only try to allocate the voice at (IY)
		bit	7,A			; free?
		jr	Z,avspecused
		push	IY
		pop	HL
		ret				; yes - take it
avspecused
		ld	A,(IY+VTBLPRIO)		; no - have to check priority first
		ld	(avlowestp),IY
		jr	avspecprio


*  DEALLOC - deallocate a voice by searching for a match on notenum and channel.
*    for now - for digital do nuthing
*    if release timer (byte 6) is zero, then set free bit immediately, otherwise
*    set release bit (a 60 Hz routine will count this down and set free when its zero)
*
*	parameters:	B	channel
*			C	note
*			IX	top of voice table
*
*	uses:		D,E,H
*
*	returns:	A	flags byte of deallocated voice, or
*				  0FFH if note not found

DEALLOC
		ld	DE,7
		jr	dvstart
dvloop
		zadd	IX,DE
dvstart
		ld	A,(IX+0)		; get flags
		ld	H,A			; save em
		cp	0FFH
		ret	Z			; eot - return FF in A for not found
		bit	7,A
		jr	NZ,dvloop		; if if free skip this voice
		ld	A,(IX+2)
		cp	C
		jr	NZ,dvloop		; did note match?
		ld	A,(IX+3)
		cp	B			; yes - check channel
		jr	NZ,dvloop

		ld	A,H
		zand	27H			; check for digital - locked and voice num=6
		cp	26H
		jr	Z,deallocdig

		zand	027H			; keep lock and vnum
		zor	0C0H			; set free and release

		ld	(IX+0),A		; save flags

deallocdig
		ld	A,H
		ret


		;export	Z80End
Z80End

**************************************  DATA AREA  ***************************************

		;export	PATCHDATA
PATCHDATA


EOPATCHDATA	equ	PATCHDATA + (39*16)

;STACKINIT-(patchdata=39*16) = $18B0

STACKINIT	equ	$1B20			; inialize stack pointer right below here
MBOXES		equ	$1B20			; 32 bytes for mail boxes
CMDFIFO		equ	$1B40			; command fifo - 64 bytes
CCB		equ	$1B80			; CCB - 512 bytes
CH0BUF		equ	$1D80			; channel cache - 256 bytes
ENV0BUF		equ	$1E80			; envelope buffers - 128 bytes
DACFIFO		equ	$1F00			; DAC data FIFO - 256 bytes
	z80prog
