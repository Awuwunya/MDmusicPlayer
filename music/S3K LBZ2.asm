LunchPlace_Header:
	sHeaderInit						; Z80 offset is $8DC8
	sHeaderPatch	LunchPlace_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $2F
	sHeaderDAC	LunchPlace_DAC
	sHeaderFM	LunchPlace_FM1, $00, $0C
	sHeaderFM	LunchPlace_FM2, $0C, $08
	sHeaderFM	LunchPlace_FM3, $00, $0C
	sHeaderFM	LunchPlace_FM4, $00, $0C
	sHeaderFM	LunchPlace_FM5, $0C, $0C
	sHeaderPSG	LunchPlace_PSG1, $F4, $02, $00, v00
	sHeaderPSG	LunchPlace_PSG2, $F4, $04, $00, v00
	sHeaderPSG	LunchPlace_PSG3, $00, $02, $00, v00

LunchPlace_FM1:
	sPatFM		$02
	dc.b nRst, $60, nRst, nRst, nRst

LunchPlace_Jump1:
	dc.b nRst, $60, nRst, nRst, nRst
	sCall		LunchPlace_Call1
	sCall		LunchPlace_Call2
	dc.b nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst

LunchPlace_Loop1:
	sCall		LunchPlace_Call2
	sLoop		$00, $02, LunchPlace_Loop1
	dc.b nRst, $0C, nC5, nRst, $48
	sJump		LunchPlace_Jump1

LunchPlace_Call1:
	sPatFM		$02
	dc.b nRst, $60, nRst, nRst, nRst, $48
	sPatFM		$03
	ssModZ80	$06, $01, $12, $01
	dc.b nEb5, $0C
	ssModZ80	$01, $01, $01, $04
	dc.b nEb5, $0C
	sRet

LunchPlace_Call2:
	sPatFM		$02
	dc.b nRst, $06, nEb4, nRst, $0C, nEb4, $12, nEb4
	dc.b $06, nRst, $18, nC4, $06, nBb3, nG3, nF3
	dc.b nRst, $18, nEb4, $12, nEb4, $06, nRst, $18
	sPatFM		$03
	ssModZ80	$01, $01, $03, $05
	dc.b nEb5
	ssModZ80	$01, $01, $01, $04
	sPatFM		$02
	dc.b nRst, $06, nEb4, nRst, $0C, nEb4, $12, nEb4
	dc.b $06, nRst, $18, nC4, $06, nBb3, nG3, nF3
	ssModZ80	$01, $01, $01, $04
	dc.b nRst, $18, nEb4, $12, nEb4, $06, nRst, $18
	sPatFM		$03
	ssModZ80	$06, $01, $12, $01
	dc.b nEb5, $0C
	ssModZ80	$01, $01, $01, $04
	dc.b nEb5, $0C
	sRet

LunchPlace_FM2:
	sPatFM		$00
	sCall		LunchPlace_Call3
	sLoop		$00, $04, LunchPlace_FM2

LunchPlace_Jump2:
	dc.b nRst, $60, nRst, nRst, nRst
	sCall		LunchPlace_Call4
	sCall		LunchPlace_Call5
	sCall		LunchPlace_Call4
	sCall		LunchPlace_Call4
	dc.b nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst
	sCall		LunchPlace_Call4
	sCall		LunchPlace_Call5
	sCall		LunchPlace_Call4
	sCall		LunchPlace_Call4
	dc.b nC2, nC1, nC3, nRst, $4E
	sJump		LunchPlace_Jump2

LunchPlace_Call3:
	dc.b nG1, $12, nD2, nA2, $1E, nD2, $06, nG2
	dc.b $0C, nD2
	sRet

LunchPlace_Call4:
	dc.b nC2, $06, nRst, nC2, $0C, nBb1, $12, nA1
	dc.b $06, nRst, $2A, nA1, $06, nF1, nRst, nF1
	dc.b $0C, nFs1, $12, nG1, $06, nRst, $18, nD2
	dc.b $0C, nG2, $06, nD2
	sRet

LunchPlace_Call5:
	dc.b nC2, nRst, nC2, $0C, nBb1, $12, nA1, $06
	dc.b nRst, $2A, nA1, $06, nF1, nRst, nF1, $0C
	dc.b nFs1, $12, nG1, $06, nRst, $18, nD2
	sRet

LunchPlace_FM3:
	sPatFM		$03
	dc.b nRst, $60, nRst, nRst, nRst

LunchPlace_Jump3:
	dc.b nRst, $60, nRst, nRst, nRst
	sPatFM		$03
	sCall		LunchPlace_Call6
	sCall		LunchPlace_Call7
	saVolFM		$06
	ssModZ80	$01, $01, $01, $06
	sPatFM		$01
	dc.b nF4, $48, nE4, $18, nD4, $5A, nRst, $06
	dc.b nF4, $48, nG4, $18, nD4, $5A, nRst, $06
	saVolFM		$FA
	dc.b nRst, $60, nRst, nRst, nRst

LunchPlace_Loop2:
	sPatFM		$03
	sCall		LunchPlace_Call7
	sLoop		$00, $02, LunchPlace_Loop2
	sPatFM		$03
	dc.b nRst, $0C, nC4, $0C, nRst, $48
	sJump		LunchPlace_Jump3

LunchPlace_Call6:
	dc.b nRst, $60, nRst, nRst, $60, nRst, $48
	saVolFM		$03
	ssModZ80	$06, $01, $12, $01
	dc.b nC5, $0C
	ssModZ80	$01, $01, $01, $04
	dc.b nC5, $0C
	saVolFM		$FD
	sRet

LunchPlace_Call7:
	dc.b nRst, $60, nRst, $48
	ssModZ80	$01, $01, $03, $05
	dc.b nC5, $18
	ssModZ80	$01, $01, $01, $04
	dc.b nRst, $60, nRst, $48
	saVolFM		$03
	ssModZ80	$06, $01, $12, $01
	dc.b nC5, $0C
	ssModZ80	$01, $01, $01, $04
	dc.b nC5, $0C
	saVolFM		$FD
	sRet

LunchPlace_FM4:
	sPatFM		$03
	dc.b nRst, $60, nRst, nRst, nRst

LunchPlace_Jump4:
	dc.b nRst, $60, nRst, nRst, nRst
	sPatFM		$03
	sCall		LunchPlace_Call8
	sCall		LunchPlace_Call9
	saVolFM		$09
	ssModZ80	$01, $01, $01, $06
	sPatFM		$01
	dc.b nRst, $05, nF4, $48, nE4, $18, nD4, $5A
	dc.b nRst, $06, nF4, $48, nG4, $18, nD4, $55
	dc.b nRst, $06
	saVolFM		$F7
	sPatFM		$03
	dc.b nRst, $60, nRst, nRst, nRst

LunchPlace_Loop3:
	sCall		LunchPlace_Call9
	sLoop		$00, $02, LunchPlace_Loop3
	sPatFM		$03
	dc.b nRst, $0C, nC4, $0C, nRst, $48
	sJump		LunchPlace_Jump4

LunchPlace_Call8:
	dc.b nRst, $60, nRst, nRst, $60, nRst, $48
	ssModZ80	$06, $01, $12, $01
	dc.b nBb4, $0C
	ssModZ80	$01, $01, $01, $04
	dc.b nBb4, $0C
	sRet

LunchPlace_Call9:
	dc.b nRst, $60, nRst, $48
	ssModZ80	$01, $01, $03, $05
	dc.b nBb4, $18
	ssModZ80	$01, $01, $01, $04
	dc.b nRst, $60, nRst, $48
	ssModZ80	$06, $01, $12, $01
	dc.b nBb4, $0C
	ssModZ80	$01, $01, $01, $04
	dc.b nBb4, $0C
	sRet

LunchPlace_FM5:
	sPatFM		$02
	dc.b nRst, $60, nRst, nRst, nRst

LunchPlace_Jump5:
	dc.b nRst, $60, nRst, nRst, nRst
	sCall		LunchPlace_Call10
	sCall		LunchPlace_Call11
	dc.b nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst

LunchPlace_Loop4:
	sCall		LunchPlace_Call11
	sLoop		$00, $02, LunchPlace_Loop4
	dc.b nRst, $0C, nC4, nRst, $48
	sJump		LunchPlace_Jump5

LunchPlace_Call10:
	dc.b nRst, $60, nRst, nRst, nRst, $48
	sPatFM		$03
	ssModZ80	$06, $01, $12, $01
	dc.b nG4, $0C
	ssModZ80	$01, $01, $01, $04
	dc.b nG4, $0C
	sRet

LunchPlace_Call11:
	sPatFM		$02
	dc.b nRst, $06, nBb3, $04, nRst, $0E, nBb3, $12
	dc.b nBb3, $06, nRst, $18, nRst, $30, nBb3, $12
	dc.b nBb3, $06, nRst, $18
	sPatFM		$03
	ssModZ80	$01, $01, $03, $05
	dc.b nG4
	ssModZ80	$01, $01, $01, $04
	sPatFM		$02
	dc.b nRst, $06, nBb3, $04, nRst, $0E, nBb3, $12
	dc.b nBb3, $06, nRst, $18, nRst, $30, nBb3, $12
	dc.b nBb3, $06, nRst, $18
	sPatFM		$03
	saVolFM		$05
	ssModZ80	$06, $01, $12, $01
	dc.b nG4, $0C
	ssModZ80	$01, $01, $01, $04
	saVolFM		$FB
	dc.b nG4, $0C
	sRet

LunchPlace_PSG1:
	sGate		$05
	sVolEnvPSG	v11
	dc.b nRst, $60, nRst, nRst
	sCall		LunchPlace_Call12

LunchPlace_Jump6:
	sCall		LunchPlace_Call12
	dc.b nF5, $06, nRst, nG5, nRst, nD5, nRst, nF5
	dc.b nF5, nRst, nF5, nG5, nRst, $1E, nRst, $60
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst

LunchPlace_Loop5:
	dc.b nRst, $60, nRst
	sLoop		$00, $04, LunchPlace_Loop5
	dc.b nRst, $60, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst
	sJump		LunchPlace_Jump6

LunchPlace_Call12:
	dc.b nF5, $06, nRst, nG5, nRst, nD5, nRst, nF5
	dc.b nF5, nRst, nF5, nG5, nRst, nD5, nRst, nF5
	dc.b nRst, nRst, $60
	sRet

LunchPlace_PSG2:
	dc.b nRst, $01
	sModEnv		m01
	sJump		LunchPlace_PSG1

LunchPlace_PSG3:
	sNoisePSG	$E7

LunchPlace_Loop6:
	sCall		LunchPlace_Call13
	sLoop		$00, $10, LunchPlace_Loop6

LunchPlace_Loop7:
	sCall		LunchPlace_Call13
	sLoop		$00, $0C, LunchPlace_Loop7
	sVolEnvPSG	v13
	dc.b nRst, $60

LunchPlace_Loop8:
	sCall		LunchPlace_Call13
	sLoop		$00, $1C, LunchPlace_Loop8
	sVolEnvPSG	v13
	dc.b nRst, $60

LunchPlace_Loop9:
	sCall		LunchPlace_Call13
	sLoop		$00, $40, LunchPlace_Loop9
	sVolEnvPSG	v02
	dc.b nBb6, $06, nBb6
	sVolEnvPSG	v13
	dc.b nRst, $54
	sJump		LunchPlace_Loop7

LunchPlace_Call13:
	sVolEnvPSG	v02
	dc.b nBb6, $06, nBb6
	sVolEnvPSG	v13
	dc.b nBb6, $06
	sVolEnvPSG	v02
	dc.b nBb6, $06
	sRet

LunchPlace_DAC:
	dc.b dLowKickShort, $12, nRst, dLowKickShort, $3C

LunchPlace_Loop10:
	dc.b dLowKickShort, $06, dHighCongo, nRst, dHighCongo, dLowCongo, nRst, dLowKickShort
	dc.b dHighCongo, nRst, dHighCongo, dLowCongo, dPowerTom, dPowerTom, $18
	sLoop		$00, $02, LunchPlace_Loop10
	dc.b dLowKickShort, $0C, dHighWood, $06, dLowKickShort, dLowWood, dLowWood, dLowKickShort
	dc.b dHighWood, nRst, dHighWood, dLowWood, dLowWood, dLowWood, dLowWood, dLowWood
	dc.b dLowWood

LunchPlace_Jump7:
	sCall		LunchPlace_Call14
	dc.b dLowKickShort, $06, dHighCongo, nRst, dLowKickShort, dSnareGo, nRst, dLowKickShort
	dc.b dHighCongo, nRst, dHighCongo, dLowCongo, dSnareGo, dSnareGo, nRst, dLowWood
	dc.b dLowWood
	sCall		LunchPlace_Call14
	dc.b dLowKickShort, $06, nRst, dHighWood, nRst, dLowWood, dLowWood, dLowWood
	dc.b dHighWood, nRst, nRst, $2A, dLowKickShort, $12, dLowKickShort, $06
	dc.b nRst, $12, dLowKickShort, $1E, dCrashHit, $24, dScratch, $24
	dc.b dPowerTom, $18, dScratch

LunchPlace_Loop11:
	dc.b dLowKickShort, $0C, dLowKickShort, nRst, $12, dLowKickShort, $06, nRst
	dc.b $2A, dLowKickShort, $06, dLowKickShort, $0C, dLowKickShort, nRst, $12
	dc.b dLowKickShort, $06, nRst, $30
	sLoop		$00, $02, LunchPlace_Loop11
	dc.b dLowKickShort, $0C, dLowKickShort, nRst, $12, dLowKickShort, $06, nRst
	dc.b $2A, dLowKickShort, $06, nRst, $36, dGlassSmash, $12, dCrashHit
	dc.b $0B, dCrashHit, $0D

LunchPlace_Loop12:
	dc.b dLowKickShort, $06, nRst, dHighCongo, dLowKickShort, dLowCongo, dLowCongo, dLowKickShort
	dc.b dHighCongo, nRst, dHighCongo, dLowCongo, dPowerTom, dPowerTom, nRst, dLowCongo
	dc.b nRst, dLowKickShort, $0C, dHighWood, $06, dLowKickShort, dLowWood, dLowWood
	dc.b dLowKickShort, dHighWood, nRst, dHighWood, dLowWood, dLowWood, dLowWood, dLowWood
	dc.b dLowWood, dLowWood
	sLoop		$00, $02, LunchPlace_Loop12
	dc.b dLowKickShort, $06, dHighCongo, nRst, dLowKickShort, dSnareGo, nRst, dLowKickShort
	dc.b dHighCongo, nRst, dHighCongo, dLowCongo, dPowerTom, dSnareGo, nRst, dLowWood
	dc.b dLowWood, dLowKickShort, nRst, dHighWood, dLowKickShort, dSnareGo, nRst, dLowKickShort
	dc.b dHighWood, nRst, dHighWood, dLowWood, dSnareGo, dSnareGo, nRst, dLowWood
	dc.b dLowWood, dLowKickShort, $06, dHighCongo, nRst, dLowKickShort, dSnareGo, nRst
	dc.b dLowKickShort, dHighCongo, nRst, dHighCongo, dLowCongo, dPowerTom, dSnareGo, nRst
	dc.b dLowWood, dLowWood, dLowKickShort, nRst, dHighWood, dLowKickShort, dSnareGo, nRst
	dc.b dLowKickShort, dHighWood, nRst, dSnareGo, nRst, dSnareGo, dSnareGo, nRst
	dc.b dSnareGo, nRst, nRst, $60, nRst, dLowKickShort, $0C, dLowKickShort
	dc.b nRst, $48, nRst, $60, dLowKickShort, $06, nRst, dGo
	dc.b nRst, dLowKickShort, nRst, dGo, dLowKickShort, nRst, nRst, dGo
	dc.b nRst, nRst, nRst, dGo, dLowKickShort, dLowKickShort, $06, nRst
	dc.b dGo, nRst, dLowKickShort, nRst, dGo, dLowKickShort, nRst, nRst
	dc.b dGo, nRst, nRst, nRst, dGo, dLowKickShort, dLowKickShort, nRst
	dc.b dGo, nRst, dSnareGo, nRst, dGo, dLowKickShort, nRst, nRst
	dc.b dGo, nRst, dSnareGo, nRst, dGo, dLowKickShort, dLowKickShort, nRst
	dc.b dGo, nRst, dSnareGo, nRst, dGo, dLowKickShort, dLowKickShort, dSnareGo
	dc.b dGo, dSnareGo, dSnareGo, nRst, dSnareGo, nRst, dLowKickShort, dLowKickShort
	dc.b dSnareGo, nRst, $4E
	sJump		LunchPlace_Jump7

LunchPlace_Call14:
	dc.b dLowKickShort, $06, dHighCongo, nRst, dHighCongo, dSnareGo, nRst, dLowKickShort
	dc.b dHighCongo, nRst, dHighCongo, dLowCongo, dPowerTom, dSnareGo, nRst, dLowWood
	dc.b dLowWood
	sRet
	dc.b $A8, $0C, $AB, $12, $A8, $06, $AC, $12	; Unused
	dc.b $AB, $06, $AB, $18, $F9, $80, $80, $AB	; Unused
	dc.b $80, $80, $80, $AB, $80, $80, $80, $AB	; Unused
	dc.b $80, $80, $80, $AB, $80, $A8, $06, $80	; Unused
	dc.b $AB, $80, $A8, $80, $AB, $A8, $80, $80	; Unused
	dc.b $AB, $80, $80, $80, $AB, $A8	; Unused

LunchPlace_Patches:

	; Patch $00
	; $03
	; $62, $40, $44, $31,	$1F, $1F, $1F, $1C
	; $0B, $0A, $02, $01,	$08, $0B, $04, $06
	; $1F, $1F, $1F, $1F,	$2A, $1A, $2B, $80
	spAlgorithm	$03
	spFeedback	$00
	spDetune	$06, $04, $04, $03
	spMultiple	$02, $04, $00, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1C
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0B, $02, $0A, $01
	spSustainLv	$01, $01, $01, $01
	spDecayRt	$08, $04, $0B, $06
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$2A, $2B, $1A, $00

	; Patch $01
	; $3D
	; $01, $02, $02, $02,	$1F, $08, $8A, $0A
	; $08, $08, $08, $08,	$00, $01, $00, $00
	; $0F, $1F, $1F, $1F,	$1F, $88, $88, $87
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $02, $02, $02
	spRateScale	$00, $02, $00, $00
	spAttackRt	$1F, $0A, $08, $0A
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$08, $08, $08, $08
	spSustainLv	$00, $01, $01, $01
	spDecayRt	$00, $00, $01, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1F, $08, $08, $07

	; Patch $02
	; $3A
	; $31, $7F, $61, $0A,	$9C, $DB, $9C, $9A
	; $04, $08, $03, $09,	$03, $01, $00, $00
	; $1F, $0F, $FF, $FF,	$23, $25, $1B, $84
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$03, $06, $07, $00
	spMultiple	$01, $01, $0F, $0A
	spRateScale	$02, $02, $03, $02
	spAttackRt	$1C, $1C, $1B, $1A
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$04, $03, $08, $09
	spSustainLv	$01, $0F, $00, $0F
	spDecayRt	$03, $00, $01, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$23, $1B, $25, $04

	; Patch $03
	; $3A
	; $01, $07, $31, $11,	$8E, $8E, $8D, $53
	; $0E, $0E, $0E, $03,	$00, $00, $00, $07
	; $1F, $FF, $1F, $0F,	$18, $28, $17, $82
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$00, $03, $00, $01
	spMultiple	$01, $01, $07, $01
	spRateScale	$02, $02, $02, $01
	spAttackRt	$0E, $0D, $0E, $13
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0E, $0E, $0E, $03
	spSustainLv	$01, $01, $0F, $00
	spDecayRt	$00, $00, $00, $07
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$18, $17, $28, $02

	; Patch $04
	; $F5
	; $24, $30, $10, $32,	$1F, $1F, $1F, $1F
	; $05, $18, $09, $02,	$06, $0F, $06, $02
	; $1F, $2F, $4F, $2F,	$0F, $0E, $0E, $80
	spAlgorithm	$05
	spFeedback	$06
	spDetune	$02, $01, $03, $03
	spMultiple	$04, $00, $00, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$05, $09, $18, $02
	spSustainLv	$01, $04, $02, $02
	spDecayRt	$06, $06, $0F, $02
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0F, $0E, $0E, $00
