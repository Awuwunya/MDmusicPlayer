Hattari_Header:
	sHeaderInit
	sHeaderPatch	Hattari_Patches
	sHeaderCh	$07, $03
	sHeaderTempo	$01, $29
	sHeaderDAC	Hattari_DAC
	sHeaderFM	Hattari_FM1, $FF, $04
	sHeaderFM	Hattari_FM2, $FF, $08
	sHeaderFM	Hattari_FM3, $FF, $08
	sHeaderFM	Hattari_FM4, $00, $23
	sHeaderFM	Hattari_FM5, $00, $23
	sHeaderFM	Hattari_FM6, $00, $0D
	sHeaderPSG	Hattari_PSG1, $DC, $09, ModEnv_00, $00
	sHeaderPSG	Hattari_PSG2, $DC, $09, ModEnv_00, $00
	sHeaderPSG	Hattari_PSG3, $00, $02, ModEnv_00, VolEnv_03

Hattari_PSG3:
	sNoisePSG	$E7
	dc.b nRst, $30, nRst, nRst, $24

Hattari_Loop3:
Hattari_Jump4:
	sNoteTimeOut	$01
	dc.b nRst, $12
	sVolEnvPSG	VolEnv_01
	dc.b nA5, $06
	sVolEnvPSG	VolEnv_02
	dc.b nA5
	sVolEnvPSG	VolEnv_04
	dc.b nA5, nA5, nA5
	sLoop		$00, $10, Hattari_Loop3
	dc.b nRst, $30, nRst, nRst, nRst
	sJump		Hattari_Jump4
	; Unused
	dc.b $F2

Hattari_DAC:
	dc.b nRst, $18, dC1, $12, d81, $06, dBE, $06
	dc.b dBE, dBE, dBE, d8C, $18, d87, $04, d87
	dc.b d87, dBE, $06, dBE, $0C, dBB, $06
Hattari_Jump1:
	dc.b d8B, $12, d81, $06, dBC, $18, nRst, $06
	sPan		spCenter, $00
	dc.b dB6
	sPan		spCenter, $00
	dc.b d8B, $0C, d86, $18, d81, dBE, nRst, $06
	dc.b dB4, d8B, $0C, d86, d96, d8B, $12, d81
	dc.b $06, dBC, $18, nRst, $06
	sPan		spCenter, $00
	dc.b dB6
	sPan		spCenter, $00
	dc.b d8B, $0C, d86, $18, d81, dBE, nRst, $06
	dc.b dB4, d8B, $0C, d86, d96, d8B, $12, d81
	dc.b $06, dBC, $18, nRst, $06
	sPan		spCenter, $00
	dc.b dB6
	sPan		spCenter, $00
	dc.b d8B, $0C, d86, $18, d81, dBE, nRst, $06
	dc.b dB4, d8B, $0C, d86, d96, d8B, $12, d81
	dc.b $06, dBC, $18, nRst, $06
	sPan		spCenter, $00
	dc.b dB6
	sPan		spCenter, $00
	dc.b d8B, $0C, d86, $18, d81, dBE, nRst, $06
	dc.b dB4, d8B, $0C, d86, $06, d86, d96, $0C
	dc.b dB6, $09, nRst, $03, nRst, $0C, dB6, $09
	dc.b nRst, $03, nRst, $0C, dB6, $09, nRst, $03
	dc.b nRst, $0C, dB6, $09, nRst, $03, nRst, $0C
	dc.b dAF, $06, dAF, dAF, dAF, d98, $0C, dAD
	dc.b $06, dAD, dAD, dAD, d96, $0C, dAA, $06
	dc.b dAA, dAA, dAA
	sJump		Hattari_Jump1
	; Unused
	dc.b $F2

Hattari_FM1:
	dc.b nRst, $30, nRst, nRst, $24
	saDetune	$F6
	sPatFM		$06

Hattari_Jump2:
	sCall		Hattari_Call1
	sNoteTimeOut	$04
	dc.b nG4, $06
	sPatFM		$01
	saVolFM		$FB
	sNoteTimeOut	$01
	dc.b nG4, $06, nG3
	saVolFM		$05
	sPatFM		$06
	sNoteTimeOut	$03
	dc.b nG4, $06, nG4, nD4, nE4, nRst, nF4
	sPatFM		$01
	saVolFM		$FB
	sNoteTimeOut	$01
	dc.b nG3, $06, nG4
	saVolFM		$05
	sPatFM		$06
	sNoteTimeOut	$03
	dc.b nRst, $06, nRst, $0C
	sPatFM		$01
	saVolFM		$FB
	sNoteTimeOut	$01
	dc.b nG3, $06, nG4
	saVolFM		$05
	saVolFM		$FF
	sNoteTimeOut	$02
	dc.b nG3, $06
	saVolFM		$01
	sPatFM		$06
	sNoteTimeOut	$0A
	dc.b nG4, $06
	saVolFM		$03
	dc.b nFs4, $03
	saVolFM		$04
	dc.b nF4
	saVolFM		$04
	dc.b nE4
	saVolFM		$05
	dc.b nEb4, $01, nRst, $02
	saVolFM		$F0
	sNoteTimeOut	$02
	dc.b nD4, $06, nRst, nE4, nRst
	sNoteTimeOut	$03
	dc.b nF4, nRst, nF4, nRst
	sNoteTimeOut	$00
	dc.b nF4, $06, nF4, $02, sHold, nFs4
	ssMod68k	$01, $01, $DD, $88
	dc.b sHold, nG4, $06, sHold, nFs4, $02
	saVolFM		$01
	dc.b sHold, nF4
	saVolFM		$02
	dc.b sHold, nE4
	saVolFM		$02
	dc.b sHold, nEb4
	sModOff
	saVolFM		$FB
	sCall		Hattari_Call1
	sNoteTimeOut	$04
	dc.b nG4, $06
	sPatFM		$01
	saVolFM		$FB
	sNoteTimeOut	$01
	dc.b nG4, $06, nG3
	saVolFM		$05
	sPatFM		$06
	sNoteTimeOut	$03
	dc.b nG4, $06, nG4, nD4, nE4, nRst, nF4
	sPatFM		$01
	saVolFM		$FB
	sNoteTimeOut	$01
	dc.b nG3, $06, nG4
	saVolFM		$05
	sPatFM		$06
	sNoteTimeOut	$03
	dc.b nRst, $06, nRst, $0C
	sPatFM		$01
	saVolFM		$FB
	sNoteTimeOut	$01
	dc.b nG3, $06, nG4
	saVolFM		$05

Hattari_Loop1:
	saVolFM		$FF
	sNoteTimeOut	$02
	dc.b nG3, $06
	saVolFM		$01
	sPatFM		$06
	sNoteTimeOut	$09
	dc.b nG4, $0C
	sNoteTimeOut	$03
	dc.b nG4, $06
	saTranspose	$01
	sLoop		$00, $03, Hattari_Loop1
	saTranspose	$01
	saVolFM		$FF
	sNoteTimeOut	$02
	dc.b nG3, $06
	saVolFM		$01
	sPatFM		$06
	sNoteTimeOut	$00
	dc.b nG4, $0C, nFs4, $02, nF4, nE4
	saTranspose	$FC
	dc.b nRst, $30, nRst, nRst, nRst
	sJump		Hattari_Jump2
	; Unused
	dc.b $F2

Hattari_Call1:
	sNoteTimeOut	$04
	dc.b nG4, $06
	sPatFM		$01
	saVolFM		$FB
	sNoteTimeOut	$01
	dc.b nG4, $06, nG3
	saVolFM		$05
	sPatFM		$06
	sNoteTimeOut	$03
	dc.b nG4, $06, nG4, nD4, nE4, nRst, nF4
	sPatFM		$01
	saVolFM		$FB
	sNoteTimeOut	$01
	dc.b nG3, $06, nG4
	saVolFM		$05
	sPatFM		$06
	sNoteTimeOut	$03
	dc.b nRst, $06, nRst, $0C
	sPatFM		$01
	saVolFM		$FB
	sNoteTimeOut	$01
	dc.b nG3, $06, nG4
	saVolFM		$05
	saVolFM		$FF
	sNoteTimeOut	$02
	dc.b nG3, $06
	saVolFM		$01
	sPatFM		$06
	sNoteTimeOut	$0A
	dc.b nG4, $06
	saVolFM		$03
	dc.b nFs4, $03
	saVolFM		$04
	dc.b nF4
	saVolFM		$04
	dc.b nE4
	saVolFM		$05
	dc.b nEb4, $01, nRst, $02
	saVolFM		$F0
	sNoteTimeOut	$02
	dc.b nD4, $06, nRst, nE4, nRst
	sNoteTimeOut	$03
	dc.b nF4, nRst, $0C, nRst, $06, nRst, $0C
	sPatFM		$01
	saVolFM		$FF
	sNoteTimeOut	$02
	dc.b nG3, $06, nG4
	saVolFM		$01
	sPatFM		$06
	sRet

Hattari_FM2:
	dc.b nRst, $30, nRst, nRst, $24
	saDetune	$F6
	saTranspose	$F4
	sPatFM		$08
	dc.b nFs3, $02, nG3, $10
	sPatFM		$07
	dc.b nG4, $06
	sNoteTimeOut	$05
	sPatFM		$08
	dc.b nF4, nE4, nB3, nC4, nD4, nCs4, nC4, nB3
	dc.b nBb3
	sNoteTimeOut	$00
	dc.b nF3, $12
	sNoteTimeOut	$05
	sPatFM		$08
	dc.b nG3, $06, nG3
	sPatFM		$07
	dc.b nG4, $0C
	sPatFM		$08
	dc.b nA3, $06, nA3
	sPatFM		$07
	dc.b nA4, $0C
	sPatFM		$08
	dc.b nBb3, $06, nBb3
	sPatFM		$07
	dc.b nBb4, $0C
	sPatFM		$08
	dc.b nB3, $06
	sNoteTimeOut	$00
	sPatFM		$07
	dc.b nB4, $12
	sPatFM		$08
	dc.b nC4, $12
	sPatFM		$07
	dc.b nC5, $06, nRst, nC5, nRst
	sNoteTimeOut	$06
	sPatFM		$08
	dc.b nC4
	sPatFM		$07
	dc.b nC5
	sPatFM		$08
	dc.b nC4, nBb4, nB4, nFs4, nG4, nB3, nC4, nD4
	dc.b nD4
	sPatFM		$07
	dc.b nD5
	sPatFM		$08
	dc.b nD4, nE4
	sPatFM		$07
	dc.b nE5
	sPatFM		$08
	dc.b nE4, nE4
	sPatFM		$07
	dc.b nF5
	sPatFM		$08
	dc.b nF4, nF4
	sNoteTimeOut	$00
	sPatFM		$07
	dc.b nFs5, $06, sHold, $18
	sStop

Hattari_FM3:
	dc.b nRst, $30, nRst, nRst, $24
	saDetune	$F6
	sPatFM		$01

Hattari_Loop2:
Hattari_Jump3:
	sNoteTimeOut	$01
	dc.b nG3, $06, nRst, nG3, nG4
	sLoop		$00, $20, Hattari_Loop2
	dc.b nRst, $30, nRst, nRst, nRst
	sJump		Hattari_Jump3
	; Unused
	dc.b $F2

Hattari_FM4:
	sStop

Hattari_FM5:
	sStop

Hattari_FM6:
	sStop

Hattari_PSG1:
	sStop

Hattari_PSG2:
	sStop

Hattari_Patches:
	; Patch $00
	; $38
	; $08, $03, $03, $01,	$5F, $5F, $5F, $1F
	; $0A, $0A, $0A, $14,	$00, $00, $00, $05
	; $F5, $F5, $F5, $37,	$28, $1E, $23, $80
	spAlgorithm	$00
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$08, $03, $03, $01
	spRateScale	$01, $01, $01, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0A, $0A, $0A, $14
	spSustainRt	$00, $00, $00, $05
	spSustainLv	$0F, $0F, $0F, $03
	spReleaseRt	$05, $05, $05, $07
	spTotalLv	$28, $23, $1E, $00

	; Patch $01
	; $3C
	; $73, $08, $41, $01,	$8F, $AF, $0F, $AF
	; $10, $1F, $0A, $0F,	$06, $00, $00, $00
	; $0F, $0A, $FC, $FF,	$03, $80, $33, $8A
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$07, $04, $00, $00
	spMultiple	$03, $01, $08, $01
	spRateScale	$02, $00, $02, $02
	spAttackRt	$0F, $0F, $0F, $0F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$10, $0A, $1F, $0F
	spSustainRt	$06, $00, $00, $00
	spSustainLv	$00, $0F, $00, $0F
	spReleaseRt	$0F, $0C, $0A, $0F
	spTotalLv	$03, $33, $00, $0A

	; Patch $02
	; $38
	; $02, $01, $01, $03,	$1F, $1F, $1F, $1F
	; $0A, $14, $0A, $0C,	$00, $03, $00, $00
	; $F5, $57, $F5, $F7,	$1C, $0A, $1E, $80
	spAlgorithm	$00
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$02, $01, $01, $03
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0A, $0A, $14, $0C
	spSustainRt	$00, $00, $03, $00
	spSustainLv	$0F, $0F, $05, $0F
	spReleaseRt	$05, $05, $07, $07
	spTotalLv	$1C, $1E, $0A, $00

	; Patch $03
	; $38
	; $58, $33, $53, $31,	$5F, $5F, $1C, $5F
	; $09, $0A, $06, $02,	$00, $00, $00, $08
	; $F6, $F9, $F8, $08,	$27, $1D, $22, $81
	spAlgorithm	$00
	spFeedback	$07
	spDetune	$05, $05, $03, $03
	spMultiple	$08, $03, $03, $01
	spRateScale	$01, $00, $01, $01
	spAttackRt	$1F, $1C, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$09, $06, $0A, $02
	spSustainRt	$00, $00, $00, $08
	spSustainLv	$0F, $0F, $0F, $00
	spReleaseRt	$06, $08, $09, $08
	spTotalLv	$27, $22, $1D, $01

	; Patch $04
	; $38
	; $05, $07, $02, $01,	$1F, $1F, $1F, $1F
	; $10, $10, $0F, $0A,	$03, $03, $03, $01
	; $F3, $F3, $F2, $A8,	$27, $25, $27, $80
	spAlgorithm	$00
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$05, $02, $07, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$10, $0F, $10, $0A
	spSustainRt	$03, $03, $03, $01
	spSustainLv	$0F, $0F, $0F, $0A
	spReleaseRt	$03, $02, $03, $08
	spTotalLv	$27, $27, $25, $00

	; Patch $05
	; $21
	; $12, $73, $43, $21,	$DC, $5F, $DF, $9F
	; $05, $07, $03, $02,	$04, $04, $04, $01
	; $F3, $21, $21, $14,	$2A, $25, $23, $80
	spAlgorithm	$01
	spFeedback	$04
	spDetune	$01, $04, $07, $02
	spMultiple	$02, $03, $03, $01
	spRateScale	$03, $03, $01, $02
	spAttackRt	$1C, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$05, $03, $07, $02
	spSustainRt	$04, $04, $04, $01
	spSustainLv	$0F, $02, $02, $01
	spReleaseRt	$03, $01, $01, $04
	spTotalLv	$2A, $23, $25, $00

	; Patch $06
	; $2A
	; $21, $38, $31, $74,	$BE, $AF, $1F, $1F
	; $15, $14, $02, $05,	$05, $08, $03, $06
	; $3F, $3F, $0F, $6F,	$51, $0C, $1C, $88
	spAlgorithm	$02
	spFeedback	$05
	spDetune	$02, $03, $03, $07
	spMultiple	$01, $01, $08, $04
	spRateScale	$02, $00, $02, $00
	spAttackRt	$1E, $1F, $0F, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$15, $02, $14, $05
	spSustainRt	$05, $03, $08, $06
	spSustainLv	$03, $00, $03, $06
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$51, $1C, $0C, $08

	; Patch $07
	; $3A
	; $60, $66, $60, $61,	$1F, $94, $DF, $5F
	; $0F, $10, $05, $0D,	$07, $06, $06, $07
	; $5F, $4F, $1F, $5F,	$1E, $0E, $1D, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$06, $06, $06, $06
	spMultiple	$00, $00, $06, $01
	spRateScale	$00, $03, $02, $01
	spAttackRt	$1F, $1F, $14, $1F
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$0F, $05, $10, $0D
	spSustainRt	$07, $06, $06, $07
	spSustainLv	$05, $01, $04, $05
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1E, $1D, $0E, $00

	; Patch $08
	; $3A
	; $06, $06, $00, $72,	$12, $12, $12, $1E
	; $00, $00, $00, $08,	$00, $00, $00, $00
	; $0F, $3F, $1F, $1F,	$34, $27, $18, $88
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$00, $00, $00, $07
	spMultiple	$06, $00, $06, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$12, $12, $12, $1E
	spAmpMod	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $08
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$00, $01, $03, $01
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$34, $18, $27, $08
