
; ===============================================================
; Mega PCM Driver Include File
; (c) 2012, Vladikcomper
; ===============================================================
	opt ae-
; ---------------------------------------------------------------
; Variables used in DAC table
; ---------------------------------------------------------------

; flags
panLR	= $C0
panL	= $80
panR	= $40
pcm	= 0
dpcm	= 4
loop	= 2
pri	= 1

; ---------------------------------------------------------------
; Macros
; ---------------------------------------------------------------

MPCM_z80word macro Value
	dc.w	((\Value)&$FF)<<8|((\Value)&$FF00)>>8
	endm

MPCM_DAC_Entry macro Pitch,Offset,Flags
	dc.b	\Flags					; 00h	- Flags
	dc.b	\Pitch					; 01h	- Pitch
	dc.b	(MegaPCM_\Offset>>15)&$FF		; 02h	- Start Bank
	dc.b	(MegaPCM_\Offset\_End>>15)&$FF		; 03h	- End Bank
	MPCM_z80word	(MegaPCM_\Offset)|$8000		; 04h	- Start Offset (in Start bank)
	MPCM_z80word	(MegaPCM_\Offset\_End-1)|$8000	; 06h	- End Offset (in End bank)
	endm

MPCM_IncludeDAC macro Name,Extension
MegaPCM_\Name:
	if strcmp('\extension','wav')
		incbin	'SMPS/MegaPCM/dac/\Name\.\Extension\',$3A
	else
		incbin	'SMPS/MegaPCM/dac/\Name\.\Extension\'
	endc
MegaPCM_\Name\_End:
	endm

; ---------------------------------------------------------------
; Driver's code
; ---------------------------------------------------------------

MegaPCM_DAC:
; ---------------------------------------------------------------
; DAC Samples Table
; ---------------------------------------------------------------

	MPCM_DAC_Entry	$08, Kick, dpcm		; $81 - Kick		- dMKick
	MPCM_DAC_Entry	$08, Snare, dpcm	; $82 - Snare		- dMSnare
	MPCM_DAC_Entry	$1B, Timpani, dpcm	; $83 - Timpani		- dMTimpani
	dc.l	0,0				; $84 - <Free>
	dc.l	0,0				; $85 - <Free>
	dc.l	0,0				; $86 - <Free>
	dc.l	0,0				; $87 - <Free>
	MPCM_DAC_Entry	$12, Timpani, dpcm	; $88 - Hi-Timpani	- dMHiTimpani
	MPCM_DAC_Entry	$15, Timpani, dpcm	; $89 - Mid-Timpani	- dMMidTimpani
	MPCM_DAC_Entry	$1B, Timpani, dpcm	; $8A - Mid-Low-Timpani - dMMidLowTimpani
	MPCM_DAC_Entry	$1D, Timpani, dpcm	; $8B - Low-Timpani	- dMLowTimpani

MegaPCM_DAC_End:

; ---------------------------------------------------------------
; DAC Samples Files
; ---------------------------------------------------------------

	MPCM_IncludeDAC	Kick, bin
	MPCM_IncludeDAC	Snare, bin
	MPCM_IncludeDAC	Timpani, bin
	even
	opt ae+
