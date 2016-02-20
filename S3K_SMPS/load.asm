		lea	Z80_RAM+$D6,a0
		lea	S3KZ80DACBanks,a1
		moveq	#S3KZ80DACBanks_End-S3KZ80DACBanks-1,d0

.replaceDAC	move.b	(a1)+,(a0)+
		dbf	d0,.replaceDAC		; replace all DAC bank ptr's with actual ones

		btst	#6,HWVersion.w		; is this NTSC Genesis?
		beq.s	.isNTSC			; if is, branch
		move.b	#1,Z80_RAM+$1C02	; set PAL mode
.isNTSC		rts

	opt ae-		; each DAC setup entry is 5 bytes, and ae+ will screw us up
; ===========================================================================
; creates Z80 bank ID from ROM address
MakeBankID	macro addr
	rept narg
		dc.b ((addr&$7F8000)/$8000)
		shift
	endr
    endm
; ===========================================================================
; macro to create multiple pointers with macro below
Z80PtrROMBank	macro addr
	rept narg
		Z80PtrROM2 \addr
		shift
	endr
    endm

; creates a single Z80 pointer (relative to bank) to a lable of choice
Z80PtrROM2	macro addr, lable
	if narg>1
\lable
	endif

	dc.w	(((((addr-z80BankAddr)&$7FFF)+$8000)<<8)&$FF00)+((((addr-z80BankAddr)&$7FFF)+$8000)>>8)
    endm

; ===========================================================================
; alignments possible to use with the macros
Z80BankAlign_None =	0
Z80BankAlign_Start =	1
Z80BankAlign_End =	2
Z80BankAlign_Both =	3

; declares start of a bank, and sets some variables
Z80Bank_Start	macro	alignbits, name
	if (\alignbits&Z80BankAlign_Start)<>0
		align $8000
	endif

z80BankAddr =	(offset(*)&$FF8000)
z80BankName 	equs \name
z80BankAlign =	alignbits
    endm

; macro to do everything needed for end of bank.
; also warns if the bank overflows
Z80Bank_End	macro
	if offset(*)>z80BankAddr+$8000
		inform 1,"Z80 bank %s is too large! Its size is $%h, $%h bytes larger than max.", "\z80BankName", offset(*)-z80BankAddr, (offset(*)-z80BankAddr)-$8000
	else
		inform 0,"Z80 bank %s has $%h free bytes.", "\z80BankName", $8000-(offset(*)-z80BankAddr)
	endif

	if (z80BankAlign&Z80BankAlign_End)<>0
		align $8000
	endif
    endm

; ===========================================================================
; simple macro to create little endian word values
littleEndian2	macro value, lable
\lable equ 	(((value)<<8)&$FF00)|(((value)>>8)&$FF)
    endm

; simple macro to put a Z80 pointer (relative to bank) to a lable of choice
Z80PtrDo	macro addr, lable
\lable =	(((((addr-z80BankAddr)&$7FFF)+$8000)<<8)&$FF00)+((((addr-z80BankAddr)&$7FFF)+$8000)>>8)
    endm

; ===========================================================================
; macro used to set up a DAC definition (pitch, length, pointer)
DAC_Setup macro rate, dacptr
	dc.b	\rate
	dc.w	DAC_\dacptr\_Len
	dc.w	DAC_\dacptr\_Ptr
    endm

; ===========================================================================
; special macro for including a DAC. This not only includes the file,
; but also creates the length and pointer information for later use in DAC_Setup
incDAC		macro name, ext
DAC_\name\_Inc =	offset(*)
	incbin 'S3K_SMPS/DAC/\name\.\ext'
		littleEndian2 offset(*)-DAC_\name\_Inc, DAC_\name\_Len
		Z80PtrDo DAC_\name\_Inc, DAC_\name\_Ptr
    endm

; ===========================================================================
; this macro lists the universal DAC list definitions for each bank
; used to simplify the disassembly view.
DACBank_Defs	macro	id
	Z80Bank_Start Z80BankAlign_Start,"DACS3K0\id"
	Z80PtrROMBank	DAC_81_Setup\id, DAC_82_Setup\id, DAC_83_Setup\id, DAC_84_Setup\id
	Z80PtrROMBank	DAC_85_Setup\id, DAC_86_Setup\id, DAC_87_Setup\id, DAC_88_Setup\id
	Z80PtrROMBank	DAC_89_Setup\id, DAC_8A_Setup\id, DAC_8B_Setup\id, DAC_8C_Setup\id
	Z80PtrROMBank	DAC_8D_Setup\id, DAC_8E_Setup\id, DAC_8F_Setup\id

	Z80PtrROMBank	DAC_90_Setup\id, DAC_91_Setup\id, DAC_92_Setup\id, DAC_93_Setup\id
	Z80PtrROMBank	DAC_94_Setup\id, DAC_95_Setup\id, DAC_96_Setup\id, DAC_97_Setup\id
	Z80PtrROMBank	DAC_98_Setup\id, DAC_99_Setup\id, DAC_9A_Setup\id, DAC_9B_Setup\id
	Z80PtrROMBank	DAC_9C_Setup\id, DAC_9D_Setup\id, DAC_9E_Setup\id, DAC_9F_Setup\id

	Z80PtrROMBank	DAC_A0_Setup\id, DAC_A1_Setup\id, DAC_A2_Setup\id, DAC_A3_Setup\id
	Z80PtrROMBank	DAC_A4_Setup\id, DAC_A5_Setup\id, DAC_A6_Setup\id, DAC_A7_Setup\id
	Z80PtrROMBank	DAC_A8_Setup\id, DAC_A9_Setup\id, DAC_AA_Setup\id, DAC_AB_Setup\id
	Z80PtrROMBank	DAC_AC_Setup\id, DAC_AD_Setup\id, DAC_AE_Setup\id, DAC_AF_Setup\id

	Z80PtrROMBank	DAC_B0_Setup\id, DAC_B1_Setup\id, DAC_B2_Setup\id, DAC_B3_Setup\id
	Z80PtrROMBank	DAC_B4_Setup\id, DAC_B5_Setup\id, DAC_B6_Setup\id, DAC_B7_Setup\id
	Z80PtrROMBank	DAC_B8_B9_Setup\id, DAC_B8_B9_Setup\id, DAC_BA_Setup\id, DAC_BB_Setup\id
	Z80PtrROMBank	DAC_BC_Setup\id, DAC_BD_Setup\id, DAC_BE_Setup\id, DAC_BF_Setup\id

	Z80PtrROMBank	DAC_C0_Setup\id, DAC_C1_Setup\id, DAC_C2_Setup\id, DAC_C3_Setup\id
	Z80PtrROMBank	DAC_C4_Setup\id
; ===========================================================================

DAC_81_Setup\id:	DAC_Setup $04,81
DAC_82_Setup\id:	DAC_Setup $0E,82_85
DAC_83_Setup\id:	DAC_Setup $14,82_85
DAC_84_Setup\id:	DAC_Setup $1A,82_85
DAC_85_Setup\id:	DAC_Setup $20,82_85
DAC_86_Setup\id:	DAC_Setup $04,86
DAC_87_Setup\id:	DAC_Setup $04,87
DAC_88_Setup\id:	DAC_Setup $06,88
DAC_89_Setup\id:	DAC_Setup $0A,89
DAC_8A_Setup\id:	DAC_Setup $14,8A_8B
DAC_8B_Setup\id:	DAC_Setup $1B,8A_8B
DAC_8C_Setup\id:	DAC_Setup $08,8C
DAC_8D_Setup\id:	DAC_Setup $0B,8D_8E
DAC_8E_Setup\id:	DAC_Setup $11,8D_8E
DAC_8F_Setup\id:	DAC_Setup $08,8F
DAC_90_Setup\id:	DAC_Setup $03,90_93
DAC_91_Setup\id:	DAC_Setup $07,90_93
DAC_92_Setup\id:	DAC_Setup $0A,90_93
DAC_93_Setup\id:	DAC_Setup $0E,90_93
DAC_94_Setup\id:	DAC_Setup $06,94_97
DAC_95_Setup\id:	DAC_Setup $0A,94_97
DAC_96_Setup\id:	DAC_Setup $0D,94_97
DAC_97_Setup\id:	DAC_Setup $12,94_97
DAC_98_Setup\id:	DAC_Setup $08,98_9A
DAC_99_Setup\id:	DAC_Setup $13,98_9A
DAC_9A_Setup\id:	DAC_Setup $16,98_9A
DAC_9B_Setup\id:	DAC_Setup $16,9B
DAC_A2_Setup\id:	DAC_Setup $0A,A2
DAC_A3_Setup\id:	DAC_Setup $18,A3
DAC_A4_Setup\id:	DAC_Setup $18,A4
DAC_A5_Setup\id:	DAC_Setup $0C,A5
DAC_A6_Setup\id:	DAC_Setup $09,A6
DAC_A7_Setup\id:	DAC_Setup $18,A7
DAC_A8_Setup\id:	DAC_Setup $18,A8
DAC_A9_Setup\id:	DAC_Setup $0C,A9
DAC_AA_Setup\id:	DAC_Setup $0A,AA
DAC_AB_Setup\id:	DAC_Setup $0D,AB
DAC_AC_Setup\id:	DAC_Setup $06,AC
DAC_AD_Setup\id:	DAC_Setup $10,AD_AE
DAC_AE_Setup\id:	DAC_Setup $18,AD_AE
DAC_AF_Setup\id:	DAC_Setup $09,AF_B0
DAC_B0_Setup\id:	DAC_Setup $12,AF_B0
DAC_B1_Setup\id:	DAC_Setup $18,B1
DAC_B2_Setup\id:	DAC_Setup $16,B2_B3
DAC_B3_Setup\id:	DAC_Setup $20,B2_B3
DAC_B4_Setup\id:	DAC_Setup $0C,B4C1_C4
DAC_B5_Setup\id:	DAC_Setup $0C,B5
DAC_B6_Setup\id:	DAC_Setup $0C,B6
DAC_B7_Setup\id:	DAC_Setup $18,B7
DAC_B8_B9_Setup\id:	DAC_Setup $0C,B8_B9
DAC_BA_Setup\id:	DAC_Setup $18,BA
DAC_BB_Setup\id:	DAC_Setup $18,BB
DAC_BC_Setup\id:	DAC_Setup $18,BC
DAC_BD_Setup\id:	DAC_Setup $0C,BD
DAC_BE_Setup\id:	DAC_Setup $0C,BE
DAC_BF_Setup\id:	DAC_Setup $1C,BF
DAC_C0_Setup\id:	DAC_Setup $0B,C0
DAC_C1_Setup\id:	DAC_Setup $0F,B4C1_C4
DAC_C2_Setup\id:	DAC_Setup $11,B4C1_C4
DAC_C3_Setup\id:	DAC_Setup $12,B4C1_C4
DAC_C4_Setup\id:	DAC_Setup $0B,B4C1_C4
DAC_9C_Setup\id:	DAC_Setup $0A,9C
DAC_9D_Setup\id:	DAC_Setup $18,9D
DAC_9E_Setup\id:	DAC_Setup $18,9E
DAC_9F_Setup\id:	DAC_Setup $0C,9F
DAC_A0_Setup\id:	DAC_Setup $0C,A0
DAC_A1_Setup\id:	DAC_Setup $0A,A1
    endm

; ===========================================================================
	DACBank_Defs 0	; create ROM pointers and setup information about DACs
	incDAC 86, bin
	incDAC 81, bin
	incDAC 82_85, bin
	incDAC 94_97, bin
	incDAC 90_93, bin
	incDAC 88, bin
	incDAC 8A_8B, bin
	incDAC 8C, bin
	incDAC 8D_8E, bin
	incDAC 87, bin
	incDAC 8F, bin
	incDAC 89, bin
	incDAC 98_9A, bin
	incDAC 9B, bin
	incDAC B2_B3, bin
	Z80Bank_End

; ===========================================================================
	DACBank_Defs 1	; create ROM pointers and setup information about DACs
	incDAC 9C, bin
	incDAC 9D, bin
	incDAC 9E, bin
	incDAC 9F, bin
	incDAC A0, bin
	incDAC A1, bin
	incDAC A2, bin
	incDAC A3, bin
	incDAC A4, bin
	incDAC A5, bin
	incDAC A6, bin
	incDAC A7, bin
	incDAC A8, bin
	incDAC A9, bin
	incDAC AA, bin
	Z80Bank_End

; ===========================================================================
	DACBank_Defs 2	; create ROM pointers and setup information about DACs
	incDAC AB, bin
	incDAC AC, bin
	incDAC AD_AE, bin
	incDAC AF_B0, bin
	incDAC B0_Unused, bin
	incDAC B1, bin
	incDAC B2_B3_S3, bin
	incDAC B4C1_C4, bin
	incDAC B5, bin
	incDAC B6, bin
	incDAC B7, bin
	incDAC B8_B9, bin
	incDAC BA, bin
	incDAC BB, bin
	incDAC BC, bin
	incDAC BD, bin
	incDAC BE, bin
	incDAC BF, bin
	incDAC C0, bin
	Z80Bank_End

; ===========================================================================
S3KZ80DACBanks:
	MakeBankID DAC_81_Inc, DAC_82_85_Inc, DAC_82_85_Inc, DAC_82_85_Inc
	MakeBankID DAC_82_85_Inc, DAC_86_Inc, DAC_87_Inc, DAC_88_Inc
	MakeBankID DAC_89_Inc, DAC_8A_8B_Inc, DAC_8A_8B_Inc, DAC_8C_Inc
	MakeBankID DAC_8D_8E_Inc, DAC_8D_8E_Inc, DAC_8F_Inc, DAC_90_93_Inc
	MakeBankID DAC_90_93_Inc, DAC_90_93_Inc, DAC_90_93_Inc, DAC_94_97_Inc
	MakeBankID DAC_94_97_Inc, DAC_94_97_Inc, DAC_94_97_Inc, DAC_98_9A_Inc
	MakeBankID DAC_98_9A_Inc, DAC_98_9A_Inc, DAC_9B_Inc, DAC_9C_Inc
	MakeBankID DAC_9D_Inc, DAC_9E_Inc, DAC_9F_Inc, DAC_A0_Inc
	MakeBankID DAC_A1_Inc, DAC_A2_Inc, DAC_A3_Inc, DAC_A4_Inc
	MakeBankID DAC_A5_Inc, DAC_A6_Inc, DAC_A7_Inc, DAC_A8_Inc
	MakeBankID DAC_A9_Inc, DAC_AA_Inc, DAC_AB_Inc, DAC_AC_Inc
	MakeBankID DAC_AD_AE_Inc, DAC_AD_AE_Inc, DAC_AF_B0_Inc, DAC_AF_B0_Inc
	MakeBankID DAC_B1_Inc, DAC_B2_B3_Inc, DAC_B2_B3_Inc, DAC_B4C1_C4_Inc
	MakeBankID DAC_B5_Inc, DAC_B6_Inc, DAC_B7_Inc, DAC_B8_B9_Inc
	MakeBankID DAC_B8_B9_Inc, DAC_BA_Inc, DAC_BB_Inc, DAC_BC_Inc
	MakeBankID DAC_BD_Inc, DAC_BE_Inc, DAC_BF_Inc, DAC_C0_Inc
	MakeBankID DAC_B4C1_C4_Inc, DAC_B4C1_C4_Inc, DAC_B4C1_C4_Inc, DAC_B4C1_C4_Inc
S3KZ80DACBanks_End:
; ===========================================================================
	opt ae+		; return automatic evens because yes
