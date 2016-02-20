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
align macro
	if narg>=2
		cnop \2,\1
	else
		cnop 0,\1
	endif
	endm

; ===========================================================================
; general purpose macro to turn a variable into string, for example
; to add after lable name.
numToStr	macro	var, nibbles
numc	= \var			; create temporary variable
outStr	equs ""			; this is our final output variables
	rept	\nibbles	; repeat for each required nibble
num	=	numc&$F		; get the nibble number
str	substr	num+1, num+1, "0123456789ABCDEF"; now transform it to string
outStr	equs "\str\\outStr"	; add it to out string
numc	= numc>>4		; finally shift the nibble out
	endr
    endm

; ===========================================================================
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
; values for the type argument
VRAM =  %100001
CRAM =  %101011
VSRAM = %100101

; values for the rwd argument
READ =  %001100
WRITE = %000111
DMA =   %100111

; ===========================================================================
; tells the VDP to copy a region of 68k memory to VRAM or CRAM or VSRAM
dma68kToVDP macro source,dest,length,type
		lea	VDP_control_port,a5
		move.l	#(($9400|((((length)>>1)&$FF00)>>8))<<16)|($9300|(((length)>>1)&$FF)),(a5)
		move.l	#(($9600|((((source)>>1)&$FF00)>>8))<<16)|($9500|(((source)>>1)&$FF)),(a5)
		move.w	#$9700|(((((source)>>1)&$FF0000)>>16)&$7F),(a5)
	vdpComm	move.w,\dest,\type,DMA,>>16)&$FFFF,(a5)
	vdpComm	move.w,\dest,\type,DMA,)&$FFFF,(a5)
    endm

; ===========================================================================
; tells the VDP to fill a region of VRAM with a certain byte
dmaFillVRAM macro byte,addr,length
	lea	VDP_control_port,a5
	move.w	#$8F01,(a5) ; VRAM pointer increment: $0001
	move.l	#(($9400|((((length)-1)&$FF00)>>8))<<16)|($9300|(((length)-1)&$FF)),(a5) ; DMA length ...
	move.w	#$9780,(a5) ; VRAM fill
	move.l	#$40000080|(((addr)&$3FFF)<<16)|(((addr)&$C000)>>14),(a5) ; Start at ...
	move.w	#(byte)<<8,(VDP_data_port).l ; Fill with byte
.loop\@	move.w	(a5),d1
	btst	#1,d1
	bne.s	.loop\@	; busy loop until the VDP is finished filling...
	move.w	#$8F02,(a5) ; VRAM pointer increment: $0002
    endm

; ===========================================================================
; allows you to declare string to be converted to character map or mappings
asc2	macro	or, str
	dc.W strlen(\str)-1
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
; tells the Z80 to stop, and waits for it to finish stopping (acquire bus)
stopZ80 macro
		move.w	#$100,Z80_bus_request	; stop the Z80
.loop\@		btst	#0,Z80_bus_request
		bne.s	.loop\@			; loop until it says it's stopped
    endm

; tells the Z80 to start again
startZ80 macro
		move.w	#0,Z80_bus_request	; start the Z80
    endm

; waits for YM
waitYM        macro	reg
.wait\@:	move.b	(\reg),d2
		btst	#7,d2
		bne.s	.wait\@
        endm

; ===========================================================================
	rsreset		; set __rs to 0
cmp_unc		rs.b 4	; uncompressed driver image
cmp_kos		rs.b 4	; kosinski compressed driver image
cmp_comp	rs.b 4	; comper compressed driver image
cmp_nem		rs.b 4	; nemesis compressed driver image
cmp_eni		rs.b 4	; enigma compressed driver image

; ===========================================================================
; resets variables which are responsible for dealing with adding drivers.
; the next macro includes the sound driver's into the mix and sets up
; variables specific to it.
drvinit	macro
drvnum		= 0
    endm

incdrv	macro	folder, comp
\folder	=	drvnum		; equate driver name with it's ID
	numToStr drvnum, 4
Driver68k_Folder_\outStr	equs "\folder"; get the folder the driver is installed on

Driver68k_\outStr:
	dc.w \comp		; set compression mode
	if \comp=cmp_unc	; set size of the driver if uncompressed
		dc.w ((DriverZ80_\outStr-DriverZ80_End_\outStr-4)/4)-1
	else			; if not uncompressed, set a pointer to z80 driver
		dc.l DriverZ80_\outStr
	endif
	incbin	"\folder\/drv.68k"; include the actual driver code
Driver68k_End_\outStr:		; set ending point for the driver (uncompressed only)

DriverZ80_\outStr:
	if \comp=cmp_unc	; set size of the driver if uncompressed
		dc.w ((DriverZ80_\outStr-DriverZ80_End_\outStr-4)/4)-1
	endif
	incbin	"\folder\/drv.z80"; include the actual driver code
DriverZ80_End_\outStr:		; set ending point for the driver (uncompressed only)

	include	"\folder\/smps2asm equ.asm"; include smps2asm macros

drvnum	=	drvnum+4	; next driver ID
    endm

; ===========================================================================
; following macros are all about including specific array's to driver images
; and specific data.
drvimg	macro
rvar	= 0			; reset driver ID
	rept	drvnum/4	; do for all installed drivers
		numToStr rvar, 4
		dc.l Driver68k_\outStr; set pointer to driver data

rvar	= rvar+4		; next driver
	endr
    endm

drvplay	macro
rvar	= 0			; reset driver ID
	rept	drvnum/4	; do for all installed drivers
		numToStr rvar, 4
		dc.l DrvPlay_\outStr; set pointer to driver data

rvar	= rvar+4		; next driver
	endr

rvar	= 0			; reset driver ID
	rept	drvnum/4	; do for all installed drivers
		numToStr rvar, 4
dir		equs Driver68k_Folder_\outStr
DrvPlay_\outStr:
	include	"\dir\/play.asm"

rvar	= rvar+4		; next driver
	endr
    endm

drvload	macro
rvar	= 0			; reset driver ID
	rept	drvnum/4	; do for all installed drivers
		numToStr rvar, 4
		dc.l DrvLoad_\outStr; set pointer to driver data

rvar	= rvar+4		; next driver
	endr

rvar	= 0			; reset driver ID
	rept	drvnum/4	; do for all installed drivers
		numToStr rvar, 4
dir		equs Driver68k_Folder_\outStr
DrvLoad_\outStr:
	include	"\dir\/load.asm"

rvar	= rvar+4		; next driver
	endr
    endm

drvupd	macro
rvar	= 0			; reset driver ID
	rept	drvnum/4	; do for all installed drivers
		numToStr rvar, 4
		dc.l DrvUpdate_\outStr; set pointer to driver data

rvar	= rvar+4		; next driver
	endr

rvar	= 0			; reset driver ID
	rept	drvnum/4	; do for all installed drivers
		numToStr rvar, 4
dir		equs Driver68k_Folder_\outStr
DrvUpdate_\outStr:
	include	"\dir\/update.asm"

rvar	= rvar+4		; next driver
	endr
    endm
; ===========================================================================
; following macros initialize music files and allows to add music files
; that can be played on the program.
musinit	macro
musnum		= 0
    endm

incmusbin	macro	driver, file, name, isZ80
	numToStr musnum, 4
	if isZ80=1
		if ((offset(*)+filesize("music/\file\.bin"))&$FF8000)>(offset(*)&$FF8000)
			align $8000
		endif
	endif
MusicFile_\outStr:
	asc2.w $8000, \name
	dc.w \driver
	incbin "music/\file\.bin"
	even

musnum		= musnum+4	; next music ID
    endm

; the following is for music that are in smps2asm format.
incmusasm	macro	driver, file, name, isZ80
	numToStr musnum, 4
	if isZ80=1
		if ((offset(*)&$7FFF)>$6000)
		align $8000	; can not check if align is needed
		endif
	endif
MusicFile_\outStr:
	asc2.w $8000, \name
	dc.w \driver

	opt ae-	; in asm format music, automatic evens will screw us over
	include "music/\file\.asm"
	opt ae+	; return automatic evens because yes
	even

musnum		= musnum+4	; next music ID
    endm

; the following is for music that are in smps2asm format with the special music only mode.
incmusasmonly	macro	file
	opt ae-	; in asm format music, automatic evens will screw us over
	include "music/\file\.asm"
    endm

; ===========================================================================
; following macros are all about including specific array's to music files.
musfile	macro
		dc.l MusicStop	; information for stop sfx (id 0)
rvar	= 0			; reset driver ID
	rept	musnum/4	; do for all installed drivers
		numToStr rvar, 4
		dc.l MusicFile_\outStr; set pointer to driver data

rvar	= rvar+4		; next driver
	endr
    endm

selectdrv	macro id
smpsdrv equs "\id"
	s2e_\id		; call the macro
    endm

; ===========================================================================
; Z80 addresses
Z80_RAM =			$A00000 ; start of Z80 RAM
Z80_RAM_end =			$A02000 ; end of non-reserved Z80 RAM
Z80_bus_request =		$A11100
Z80_reset =			$A11200

SRAM_access =			$A130F1
Security_addr =			$A14000
; ===========================================================================
; I/O Area
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
; VDP addresses
VDP_data_port =			$C00000
VDP_control_port =		$C00004
PSG_input =			$C00011
; ===========================================================================
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
LoadedDriver	rs.b 1		; currently loaded sound driver
HWVersion	rs.b 1		; determines the region of the machine
		rs.w 0		; make sure these addresses are even
Ctrl1Held	rs.b 1		; controller 1 held buttons
Ctrl1Press	rs.b 1		; controller 1 pressed buttons
Ctrl2Held	rs.b 1		; controller 2 held buttons
Ctrl2Press	rs.b 1		; controller 2 pressed buttons
Ctrl0Held	rs.b 1		; controller 0 held buttons
Ctrl0Press	rs.b 1		; controller 0 pressed buttons
DACnumber	rs.b 1		; the DAC ID we are playing currently
DACtime		rs.b 1		; timer for the currently playing DAC
		rs.w 0		; make sure these addresses are even
PSG3vol		rs.b 1		; PSG3 volume
PSG3inst	rs.b 1		; PSG3 instrument
PSG3note	rs.b 1		; PSG3 note
PSG3time	rs.b 1		; PSG3 timer
		rs.b 4*8	; do the same for the rest of the channels
; ===========================================================================
pal60mod =	0	; Set to 1 if you want to enable 60hz PAL mode for all sound drivers (note; some may not correctly play music)
			; NOTE: Drivers are modified in order to support this feature.
