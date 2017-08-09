	include "code/macro.asm"
	include "code/smps2asm.asm"
	include "GEMS/__common/a"
	include "GEMS/__common/macro.asm"
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
; ===========================================================================
	even
SystemPalette:
	incbin  'code/main.pal'		; system main palette
	even

	include 'Code/string.asm'	; string display library
	include 'Code/crash.asm'	; crash handlers and debuggers
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
EndOfRom:
		END
