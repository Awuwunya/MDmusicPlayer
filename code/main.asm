; ===========================================================================
	include "code/macro.asm"
	include "GEMS/__common/a"
	include "GEMS/__common/macro.asm"
; ===========================================================================

Maincode	section org(0)

StartOfRom:	dc.l Stack, EntryPoint, BusError, AddressError
		dc.l IllegalInstr, ZeroDivide, ChkInstr, TrapvInstr
		dc.l PrivilegeViol, Trace, Line1010Emu,	Line1111Emu
		dc.l ErrorExcept, ErrorExcept, ErrorExcept, ErrorExcept
		dc.l ErrorExcept, ErrorExcept, ErrorExcept, ErrorExcept
		dc.l ErrorExcept, ErrorExcept, ErrorExcept, ErrorExcept
		dc.l ErrorExcept, ErrorTrap, ErrorTrap,	ErrorTrap
		dc.l HBlankRAM,	ErrorTrap, VBlank, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
Console:	dc.b 'SEGA MEGA DRIVE ' ; Hardware system ID
		dc.b 'NATSUMI 2016-FEB' ; Release date
		dc.b "NATSUMI'S SEGA MEGA DRIVE SMPS PLAYER DEMO      " ; Domestic name
		dc.b "NATSUMI'S SEGA MEGA DRIVE SMPS PLAYER DEMO      " ; International name
		dc.b 'UNOFFICIAL-00 '   ; Serial/version number
		dc.w 0
		dc.b 'J               ' ; I/O support
		dc.l StartOfRom		; ROM start
		dc.l EndOfRom-1		; ROM end
		dc.l $FF0000		; RAM start
		dc.l $FFFFFF		; RAM end
		dc.b 'NO SRAM     '
		dc.b 'OPEN SOURCE SOFTWARE. YOU ARE WELCOME TO MAKE YOUR  '
		dc.b 'JUE '
		dc.b 'OWN MODIFICATIONS. PLEASE CREDIT WHEN USED'
	even
; ===========================================================================

SystemPalette:
	incbin  'code/main.pal'		; system main palette
	even

	include 'Code/string.asm'	; string display library
	include 'Code/init.asm'		; initialization code and main loop
	include 'Code/program.asm'	; main program (must be after init.asm)
	include 'Code/VBlank.asm'	; Vertical Blanking code & controller polling
	include 'Code/decompressors.asm'; decompressors used
; ===========================================================================

	include 'Code/drivers.asm'	; include all sound driver data
	include 'Code/chaninfo.asm'	; Draws information about channels during VBlank
; ===========================================================================

	include "GEMS/__common/load.asm"

GEMS_Sound_68K:
	incbin "GEMS/__common/drv.68k"

GEMS_Sound_Z80:
	incbin "GEMS/__common/drv.z80"

SystemFont:
	incbin  'code/font.kos'		; System font - made by Bakayote
; ===========================================================================

	align $8000	; NOTE: I am may try to find a better solution later.
			; til then, basically fuck you and deal with this padding
MusicOff:
	incbin "_temp/music"		; include output from music tool
; ===========================================================================
; ---------------------------------------------------------------------------
; Error handling module
; ---------------------------------------------------------------------------

BusError:	jsr	ErrorHandler(pc)
		dc.b	"BUS ERROR",0			; text
		dc.b	1				; extended stack frame
		even

AddressError:	jsr	ErrorHandler(pc)
		dc.b	"ADDRESS ERROR",0		; text
		dc.b	1				; extended stack frame
		even

ErrorTrap:	jsr	ErrorHandler(pc)
		dc.b	"ERROR TRAP",0			; text
		dc.b	0				; extended stack frame
		even

IllegalInstr:	jsr	ErrorHandler(pc)
		dc.b	"ILLEGAL INSTRUCTION",0		; text
		dc.b	0				; extended stack frame
		even

ZeroDivide:	jsr	ErrorHandler(pc)
		dc.b	"ZERO DIVIDE",0  		; text
		dc.b	0				; extended stack frame
		even

ChkInstr:	jsr	ErrorHandler(pc)
		dc.b	"CHK INSTRUCTION",0  		; text
		dc.b	0				; extended stack frame
		even

TrapvInstr:	jsr	ErrorHandler(pc)
		dc.b	"TRAPV INSTRUCTION",0  		; text
		dc.b	0				; extended stack frame
		even

PrivilegeViol:	jsr	ErrorHandler(pc)
		dc.b	"PRIVILEGE VIOLATION",0  	; text
		dc.b	0				; extended stack frame
		even

Trace:		jsr	ErrorHandler(pc)
		dc.b	"TRACE",0 	  		; text
		dc.b	0				; extended stack frame
		even

Line1010Emu:	jsr	ErrorHandler(pc)
		dc.b	"LINE 1010 EMULATOR",0  	; text
		dc.b	0				; extended stack frame
		even

Line1111Emu:	jsr	ErrorHandler(pc)
		dc.b	"LINE 1111 EMULATOR",0  	; text
		dc.b	0				; extended stack frame
		even

ErrorExcept:	jsr	ErrorHandler(pc)
		dc.b	"ERROR EXCEPTION",0    		; text
		dc.b	0				; extended stack frame
		even

StackUnderflow:	jsr	ErrorHandler(pc)
		dc.b	"STACK UNDERFLOW",0    		; text
		dc.b	0				; extended stack frame
		even

StackOverflow:	jsr	ErrorHandler(pc)
		dc.b	"STACK OVERFLOW",0    		; text
		dc.b	0				; extended stack frame
		even

ErrorHandler:	incbin	"code/ErrorHandler.bin"
; ===========================================================================

EndOfRom:	END
