	include "..\exe\macro.asm"

StartOfRom:	dc.l Stack, EntryPoint
HBlank:		rte		; used to be bus error pointer
		bra.s	*	; bus error can't be caused by software
		dc.l AddressError, IllegalInstr, ZeroDivide, ChkInstr, TrapvInstr
		dc.l PrivilegeViol, Trace, Line1010Emu,	Line1111Emu
		dc.l ErrorExcept, ErrorExcept, ErrorExcept, ErrorExcept
		dc.l ErrorExcept, ErrorExcept, ErrorExcept, ErrorExcept
		dc.l ErrorExcept, ErrorExcept, ErrorExcept, ErrorExcept
		dc.l ErrorExcept, ErrorTrap, ErrorTrap,	ErrorTrap
		dc.l HBlank,	ErrorTrap, VBlank, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
		dc.l ErrorTrap,	ErrorTrap, ErrorTrap, ErrorTrap
Console:	dc.b 'SEGA MEGA DRIVE ' ; Hardware system ID
		dc.b 'NATSUMI 2016-JAN' ; Release date
		dc.b "NATSUMI'S SEGA MEGA DRIVE SMPS PLAYER DEMO      " ; Domestic name
		dc.b "NATSUMI'S SEGA MEGA DRIVE SMPS PLAYER DEMO      " ; International name
		dc.b 'UNOFFICIAL-00 '   ; Serial/version number
		dc.w 0
		dc.b 'J               ' ; I/O support
		dc.l StartOfRom		; ROM start
		dc.l EndOfRom-1		; ROM end
		dc.l $FF0000		; RAM start
		dc.l $FFFFFF		; RAM end
		dc.l 'NO SRAM     '
		dc.b 'OPEN SOURCE SOFTWARE. YOU ARE WELCOME TO MAKE YOUR  '
		dc.b 'JUE ' ; Region
		dc.b 'OWN MODIFICATIONS. PLEASE CREDIT WHEN USED.'

	include crash.asm
	include init.asm
EndOfRom:
		END