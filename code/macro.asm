; ===========================================================================
; ---------------------------------------------------------------------------
; Assembler options
; ---------------------------------------------------------------------------
	opt ae+		; automatic even's
	opt l+		; . is local lable symbol
	opt w-		; don't print warnings
	opt op+		; optimize PC relative addressing
	opt os+		; optimize short branches
	opt ow+		; optimize absolute long addressing
	opt oz+		; optimize zero displacements
	opt oaq+	; optimize addq
	opt osq+	; optimize subq
	opt omq+	; optimize moveq

; ===========================================================================
; ---------------------------------------------------------------------------
; Macro for aligning code
; ---------------------------------------------------------------------------
align macro
	if narg>=2
		cnop \2,\1
	else
		cnop 0,\1
	endif
	endm

; ===========================================================================
; ---------------------------------------------------------------------------
; Macro for generating VDP commands
; ---------------------------------------------------------------------------

vdpComm		macro ins,addr,type,rwd,end,end2
	if narg=5
		\ins #(((\type&\rwd)&3)<<30)|((\addr&$3FFF)<<16)|(((\type&\rwd)&$FC)<<2)|((\addr&$C000)>>14), \end

	elseif narg=6
		\ins #(((((\type&\rwd)&3)<<30)|((\addr&$3FFF)<<16)|(((\type&\rwd)&$FC)<<2)|((\addr&$C000)>>14))\end, \end2

	else
		\ins (((\type&\rwd)&3)<<30)|((\addr&$3FFF)<<16)|(((\type&\rwd)&$FC)<<2)|((\addr&$C000)>>14)
	endif
    endm
; ===========================================================================
; ---------------------------------------------------------------------------
; Macro for generating VDP command according to coordinates
; ---------------------------------------------------------------------------

vdpCoord	macro base,x,y,rwd
.addr =		(\base+\x+\x+(\y*$40))
	dc.l (((VRAM&\rwd)&3)<<30)|((.addr&$3FFF)<<16)|(((VRAM&\rwd)&$FC)<<2)|((.addr&$C000)>>14)
    endm
; ===========================================================================
; ---------------------------------------------------------------------------
; Macro for generating property data
; ---------------------------------------------------------------------------

propdat		macro typ, base,x,y,rwd
	dc.w \typ
	vdpCoord \base, \x, \y, \rwd
    endm

; ===========================================================================
; Values for the type argument
VRAM =  %100001
CRAM =  %101011
VSRAM = %100101

; Values for the rwd argument
READ =  %001100
WRITE = %000111
DMA =   %100111
; ===========================================================================
; ---------------------------------------------------------------------------
; Tells the VDP to copy a region of 68k memory to VRAM or CRAM or VSRAM
; ---------------------------------------------------------------------------

dma68kToVDP macro source,dest,length,type
		lea	VDP_control_port,a5
		move.l	#(($9400|((((length)>>1)&$FF00)>>8))<<16)|($9300|(((length)>>1)&$FF)),(a5)
		move.l	#(($9600|((((source)>>1)&$FF00)>>8))<<16)|($9500|(((source)>>1)&$FF)),(a5)
		move.w	#$9700|(((((source)>>1)&$FF0000)>>16)&$7F),(a5)
	vdpComm	move.l,\dest,\type,DMA,(a5)
    endm
; ===========================================================================
; ---------------------------------------------------------------------------
; Tells the VDP to fill a region of VRAM with a certain byte
; ---------------------------------------------------------------------------

dmaFillVRAM macro byte,addr,length,wait
	lea	VDP_control_port,a5
	move.w	#$8F01,(a5) ; VRAM pointer increment: $0001
	move.l	#(($9400|((((length)-1)&$FF00)>>8))<<16)|($9300|(((length)-1)&$FF)),(a5) ; DMA length ...
	move.w	#$9780,(a5) ; VRAM fill
	move.l	#$40000080|(((addr)&$3FFF)<<16)|(((addr)&$C000)>>14),(a5) ; Start at ...
	move.w	#(byte)<<8,(VDP_data_port).l ; Fill with byte

	if narg<4
.loop\@		move.w	(a5),d1
		btst	#1,d1
		bne.s	.loop\@	; busy loop until the VDP is finished filling...
		move.w	#$8F02,(a5) ; VRAM pointer increment: $0002
	endif
    endm
; ===========================================================================
; ---------------------------------------------------------------------------
; Macro to declare string to be converted to character map or mappings
; ---------------------------------------------------------------------------

asc2	macro	or, str
	dc.w strlen(\str)-1
	asc	\or, \str
    endm

asc	macro	or, str
.lc = 0
	rept strlen(\str)
.cc		substr .lc+1,.lc+1,\str

		if '\.cc'=' '
			dc.\0 0|or			; whitespace

		elseif ('\.cc'>='0')&('\.cc'<='9')
			dc.\0 ('\.cc'-'0'+1)|or		; 0-9

		elseif ('\.cc'>='a')&('\.cc'<='z')
			dc.\0 ('\.cc'-'a'+$2B)|or	; a-z

		elseif ('\.cc'>='A')&('\.cc'<='Z')
			dc.\0 ('\.cc'-'A'+$B)|or	; A-Z

		elseif '\.cc'='!'
			dc.\0 $25|or	; !

		elseif '\.cc'='?'
			dc.\0 $26|or	; ?

		elseif '\.cc'='.'
			dc.\0 $27|or	; .

		elseif '\.cc'=','
			dc.\0 $28|or	; ,

		elseif '\.cc'=':'
			dc.\0 $29|or	; :

		elseif '\.cc'=';'
			dc.\0 $2A|or	; ;

		elseif '\.cc'='^'
			dc.\0 $45|or	; ^

		elseif '\.cc'='/'
			dc.\0 $46|or	; /

		elseif '\.cc'='\\'
			dc.\0 $47|or	; \

		elseif '\.cc'='*'
			dc.\0 $48|or	; *

		elseif '\.cc'='-'
			dc.\0 $49|or	; -

		elseif '\.cc'='|'
			dc.\0 $4A|or	; _ (wider)

		elseif '\.cc'='$'
			dc.\0 $4B|or	; $

		elseif '\.cc'='%'
			dc.\0 $4C|or	; %

		elseif '\.cc'='#'
			dc.\0 $4D|or	; #

		elseif '\.cc'='+'
			dc.\0 $4E|or	; +

		elseif '\.cc'='}'
			dc.\0 $4F|or	; ->

		elseif '\.cc'='{'
			dc.\0 $50|or	; <-

		elseif '\.cc'='@'
			dc.\0 $51|or	; @

		elseif '\.cc'='_'
			dc.\0 $52|or	; _

		elseif '\.cc'='('
			dc.\0 $53|or	; (

		elseif '\.cc'=')'
			dc.\0 $54|or	; )

		elseif '\.cc'='['
			dc.\0 $55|or	; [

		elseif '\.cc'=']'
			dc.\0 $56|or	; ]

		elseif '\.cc'='>'
			dc.\0 $57|or	; >

		elseif '\.cc'='<'
			dc.\0 $58|or	; <

		elseif '\.cc'='&'
			dc.\0 $59|or	; &

		elseif '\.cc'='~'
			dc.\0 $5A|or	; ~

		elseif '\.cc'="'"
			dc.\0 $5B|or	; '

		elseif '\.cc'='"'
			dc.\0 $5C|or	; "

		elseif '\.cc'='='
			dc.\0 $5D|or	; =

		elseif '\.cc'='`'
			dc.\0 $5E|or	; `

		else
			inform 2,"ASCII value failure: \.cc %d", .cc
		endif

.lc =		.lc+1
	endr
    endm
; ===========================================================================
; ---------------------------------------------------------------------------
; Tells the Z80 to stop, and waits for it to finish stopping (acquire bus)
; ---------------------------------------------------------------------------

stopZ80 macro
		move.w	#$100,Z80_bus_request	; stop the Z80
.loop\@		btst	#0,Z80_bus_request
		bne.s	.loop\@			; loop until it says it's stopped
    endm
; ===========================================================================
; ---------------------------------------------------------------------------
; Tells the Z80 to start again
; ---------------------------------------------------------------------------

startZ80 macro
		move.w	#0,Z80_bus_request	; start the Z80
    endm
; ===========================================================================
; ---------------------------------------------------------------------------
; Waits for YM
; ---------------------------------------------------------------------------

waitYM        macro	reg
.wait\@:	move.b	(\reg),d2
		btst	#7,d2
		bne.s	.wait\@
        endm
; ===========================================================================

	rsreset		; set __rs to 0
cmp_none	rs.l 1	; no data
cmp_unc		rs.l 1	; uncompressed driver image
cmp_kos		rs.l 1	; kosinski compressed driver image
cmp_comp	rs.l 1	; comper compressed driver image
cmp_nem		rs.l 1	; nemesis compressed driver image
cmp_eni		rs.l 1	; enigma compressed driver image
; ===========================================================================
; ---------------------------------------------------------------------------
; Macro for including a sound driver
; ---------------------------------------------------------------------------

    if ~def(incdrv)
incdrv	macro	type, folder, comp
\folder	=	drvnum		; equate driver name with it's ID
Driver_Folder_\#drvnum	equs "\folder"; get the folder the driver is installed on

	dc.l \folder\_dmaon
	dc.l \folder\_dmaoff
	dc.l \folder\_load
	dc.l \folder\_play
	dc.l \folder\_update

Driver68k_\#drvnum:
	dc.w \comp		; set compression mode

	if \comp<>cmp_none	; if compression is none, dont include any files
	if \comp=cmp_unc	; set size of the driver if uncompressed
		dc.w ((DriverZ80_\#drvnum-DriverZ80_End_\#drvnum-4)/4)-1
	else			; if not uncompressed, set a pointer to z80 driver
		dc.l DriverZ80_\#drvnum
	endif
	incbin	"\type\/\folder\/drv.68k"; include the actual driver code
Driver68k_End_\#drvnum:		; set ending point for the driver (uncompressed only)

DriverZ80_\#drvnum:
	if \comp=cmp_unc	; set size of the driver if uncompressed
		dc.w ((DriverZ80_\#drvnum-DriverZ80_End_\#drvnum-4)/4)-1
	endif
	incbin	"\type\/\folder\/drv.z80"; include the actual driver code
DriverZ80_End_\#drvnum:		; set ending point for the driver (uncompressed only)
	endif

	include	"\type\/\folder\/code.asm"; finally include play, load and update code

drvnum	=	drvnum+4	; next driver ID
    endm
	endif
; ===========================================================================
; ---------------------------------------------------------------------------
; Macro for creating a list of sound driver
; ---------------------------------------------------------------------------

drvimg	macro
rvar	= 0			; reset driver ID
	rept	drvnum/4	; do for all installed drivers
		dc.l Driver68k_\#rvar; set pointer to driver data

rvar	= rvar+4		; next driver
	endr
    endm
; ===========================================================================
; ---------------------------------------------------------------------------
; Driver type definition
; ---------------------------------------------------------------------------

		rsset 0
TYPE_NULL	rs.w 1
TYPE_SMPS	rs.w 1
TYPE_GEMS	rs.w 1
; ===========================================================================
; ---------------------------------------------------------------------------
; Z80 addresses
; ---------------------------------------------------------------------------

Z80_RAM =			$A00000 ; start of Z80 RAM
Z80_RAM_end =			$A02000 ; end of non-reserved Z80 RAM
Z80_bus_request =		$A11100
Z80_reset =			$A11200

SRAM_access =			$A130F1
Security_addr =			$A14000
; ===========================================================================
; ---------------------------------------------------------------------------
; I/O addresses
; ---------------------------------------------------------------------------

HW_Version =			$A10001
HW_Port_1_Data =		$A10003
HW_Port_2_Data =		$A10005
HW_Expansion_Data =		$A10007
HW_Port_1_Control =		$A10009
HW_Port_2_Control =		$A1000B
HW_Expansion_Control =		$A1000D
HW_Port_1_TxData =		$A1000F
HW_Port_1_RxData =		$A10011
HW_Port_1_SCtrl =		$A10013
HW_Port_2_TxData =		$A10015
HW_Port_2_RxData =		$A10017
HW_Port_2_SCtrl =		$A10019
HW_Expansion_TxData =		$A1001B
HW_Expansion_RxData =		$A1001D
HW_Expansion_SCtrl =		$A1001F
; ===========================================================================
; ---------------------------------------------------------------------------
; VDP addresses
; ---------------------------------------------------------------------------

VDP_data_port =			$C00000
VDP_control_port =		$C00004
PSG_input =			$C00011
; ===========================================================================
; ---------------------------------------------------------------------------
; RAM mappings
; ---------------------------------------------------------------------------

	rsset	$FFFF0000
Z80music	equ __rs+2	; if z80 driver, this is the address of the music file.
Driver68K	rs.b $8000	; 68k driver ROM. if Z80 driver, this is rte
Drv68Kmem	rs.b 0		; memory for the 68k driver.
NemDecBuffer	rs.b $1C00	; used when decompressing Nemesis format sound drivers
HBlankRAM	rs.b $400	; code to run in HBlank. Can also be used as extra RAM for sound driver
		rs.l 3		; stack overflow area
StackUflowRAM	rs.l 1		; stack overflow area
StackStart	rs.b $100	; 68k stack
Stack		rs.b 0		; 68k stack pointer
StackOflowRAM	rs.l 4		; stack underflow area
MainPalette	rs.b $80	; current palette of the program
VScrollRAM	rs.b 80		; Vertical scrolling RAM
ActiveChnLast	rs.w 1		; active sound channels for last frame
ActiveChn	rs.w 1		; currently active sound channels. Bits 0-5 = FM1-FM6, Bits 6-9 = PSG1-PSG3, Bit 10 = DAC
MusSelection	rs.w 1		; current song selection
MusPlaying	rs.w 1		; current song playing
DMAlen		rs.w 1		; current fake DMA mode
DisplayList	rs.l 1		; address of display data to load
LoadedDriver	rs.b 1		; currently loaded sound driver
DriverType	rs.b 1		; the type of the sound driver loaded
HWVersion	rs.b 1		; determines the region of the machine
VintTime	rs.w 1		; V-int timer in frames
Ctrl1Held	rs.b 1		; controller 1 held buttons
Ctrl1Press	rs.b 1		; controller 1 pressed buttons
Ctrl2Held	rs.b 1		; controller 2 held buttons
Ctrl2Press	rs.b 1		; controller 2 pressed buttons
Ctrl0Held	rs.b 1		; controller 0 held buttons
Ctrl0Press	rs.b 1		; controller 0 pressed buttons
ChanDat		rs.b 8+(16*6)	; total amount of space for channel data

; SMPS Channel data
	rsset ChanDat
sTempo		rs.b 1		; tempo of the driver
sTickMul	rs.b 1		; tick multiplier of the driver

; format:
; 0 - tick mul
; 1 - instrument
; 2 - volume
; 3 - timeout
; 4-5 - freq
; 6-7 - freq + mod + det

sPSG3		rs.b 8
sPSG2		rs.b 8
sPSG1		rs.b 8
sFM6		rs.b 8
sFM5		rs.b 8
sFM4		rs.b 8
sFM3		rs.b 8
sFM2		rs.b 8
sFM1		rs.b 8
sDAC1		rs.b 8
sDAC2		rs.b 8

; GEMS Channel data
	rsset ChanDat
gTempo		rs.w 1		; current bpm
gVolume		rs.b 1		; master volume
gCurSeq		rs.b 1		; sequence number (used in GEMS manipulate mode!)
gSeq		rs.b 1		; current sequence(!)
gFlags		rs.b 1		; channel flags
gPrio		rs.b 1		; current priority
gPatch		rs.b 1		; current patch id
gVol		rs.b 1		; how loud the channel is
gTime		rs.w 1		; timer for next event
gNote		rs.b 1		; doesnt seem to be possible ;(
		rs.b 8*16	; do the same for the rest of the channels

gMutedChs	rs.w 1		; muted channels list
gSustain	rs.w 1		; sustained channels list
gCursor		rs.b 1		; current cursor position for manipulate menu
; ===========================================================================
; ---------------------------------------------------------------------------
; Various flags
; ---------------------------------------------------------------------------

pal60mod =	0	; Set to 1 if you want to enable 60hz PAL mode for all sound drivers (note; some may not correctly play music)
			; NOTE: Drivers are modified in order to support this feature.
extremeDMA =	0	; set to 1 to unlock extreme ($4000 bytes!!!) DMA mode.
			; You must acknowledge however, that most drivers can not cope with this and it will cause all kinds of crazy glitches.
			; this is nonstandard and no driver is designed to be able to deal with this.
; ===========================================================================
