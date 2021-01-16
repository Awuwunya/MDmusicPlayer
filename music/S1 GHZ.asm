GreenHill_Header:
	sHeaderInit
	sHeaderPatch	GreenHill_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $03
	sHeaderDAC	GreenHill_DAC
	sHeaderFM	GreenHill_FM1, $F4, $12
	sHeaderFM	GreenHill_FM2, $00, $0B
	sHeaderFM	GreenHill_FM3, $F4, $14
	sHeaderFM	GreenHill_FM4, $F4, $08
	sHeaderFM	GreenHill_FM5, $F4, $20
	sHeaderPSG	GreenHill_PSG1, $D0, $01, $00, v03
	sHeaderPSG	GreenHill_PSG2, $D0, $03, $00, v06
	sHeaderPSG	GreenHill_PSG3, $00, $03, $00, v04

GreenHill_FM1:
	sPatFM		$02
	sPan		spRight
	sCall		GreenHill_Call1
	sPan		spCenter

GreenHill_Loop1:
	sPan		spLeft
	dc.b nE7, $04
	sPan		spRight
	dc.b nC7
	saVolFM		$01
	sLoop		$00, $0D, GreenHill_Loop1
	dc.b nE7, $04, nRst, $14
	saVolFM		$EB
	sPan		spCenter
	dc.b nRst, $40, nRst, nRst, nRst, nRst, nRst

GreenHill_Jump1:
	sPatFM		$06
	ssMod68k	$0D, $01, $07, $04
	saTranspose	$F4
	dc.b nRst, $20
	sCall		GreenHill_Call2
	dc.b nC6, $38
	sCall		GreenHill_Call2
	dc.b nC6, $08, $08, nE6
	saTranspose	$0C
	sPatFM		$06
	saTranspose	$F4
	dc.b nD6, $34, sHold, $34, nC6, $08, nD6, nE6
	dc.b $38, sHold, $38, nC6, $08, nC6, nE6, nEb6
	dc.b $34, sHold, $34, nC6, $08, nEb6, nD6, $1C
	dc.b sHold, $1C
	sPatFM		$05
	saTranspose	$F4
	saVolFM		$0A
	dc.b nRst, $08, nE7, $0C, nRst, $04
	sGate		$0B
	dc.b nE7, $08, nF7, nE7, nG7
	sGate		$14
	dc.b nE7, $10
	sGate		$0B
	dc.b nC7, $08
	sGate		$00
	saVolFM		$F6
	saTranspose	$18
	sJump		GreenHill_Jump1

GreenHill_Call1:
	dc.b nA6, $04, nF6, nA6, nF6, nB6, nG6, nB6
	dc.b nG6, nC7, nA6, nC7, nA6, nD7, nB6, nD7
	dc.b nB6
	sRet

GreenHill_Call2:
	dc.b nC7, $08, nA6, $10, nC7, $08, nB6, $10
	dc.b nC7, $08, nB6, $10, nG6, $30, nA6, $08
	dc.b nE7, nD7, $10, nC7, $08, nB6, $10, nC7
	dc.b $08, nB6, $10, nG6, $38, nC7, $08, nA6
	dc.b $10, nC7, $08, nB6, $10, nC7, $08, nB6
	dc.b $10, nG6, $30, nA6, $08, $08, nF6, $10
	dc.b nA6, $08, nG6, $10, nA6, $08, nG6, $10
	sRet

GreenHill_FM2:
	sPatFM		$00
	sComm		$01
	dc.b nRst, $08, nA2, nA3, nA2, nBb2, nBb3, nB2
	dc.b nB3
	sGate		$04
	sPatFM		$01

GreenHill_Loop2:
	dc.b nC3, $08
	sLoop		$00, $18, GreenHill_Loop2
	sGate		$00
	dc.b nC3, $04, nRst, nC3, $08, nA2, $04, nRst
	dc.b nA2, $08, nBb2, $04, nRst, nBb2, $08, nB2
	dc.b $04, nRst, nB2, $08
	sGate		$04

GreenHill_Loop3:
	dc.b nC3, $08
	sLoop		$00, $1D, GreenHill_Loop3
	sGate		$00
	dc.b nC3, nD3, nE3

GreenHill_Jump2:
	sPatFM		$01
	sCall		GreenHill_Call3
	sCall		GreenHill_Call4
	sGate		$00
	dc.b nC3, nD3, nE3
	sCall		GreenHill_Call3
	sCall		GreenHill_Call4
	dc.b nC3, nC3, nC3
	sGate		$00
	sPatFM		$00
	dc.b nBb2, $18, nA2, nG2, nF2, nE2, $08, nRst
	dc.b nD2, nRst, nA2, $18, nB2, nC3, nD3, nE3
	dc.b $08, nRst, nA3, nRst, nAb3, $18, nG3, nF3
	dc.b nEb3, nD3, $08, nRst, nC3, nRst, nG2, $18
	dc.b nD3, nG2, nG3, $08, nE2, nE3, nF2, nF3
	dc.b nG2, nG3
	sGate		$04
	sComm		$01
	sJump		GreenHill_Jump2

GreenHill_Call3:
	sGate		$04
	dc.b nF3, $08, nF3, nF3, nF3, nF3, nF3, nF3
	sGate		$00
	dc.b nF3
	sGate		$04
	dc.b nE3, nE3, nE3, nE3, nE3
	sGate		$00
	dc.b nC3, nD3, nE3
	sGate		$04
	dc.b nF3, nF3, nF3, nF3, nF3, nF3, nF3
	sGate		$00
	dc.b nF3
	sGate		$04
	dc.b nE3, nE3, nE3, nE3, nE3
	sGate		$00
	dc.b nC3, nD3, nE3
	sRet

GreenHill_Call4:
	sGate		$04
	dc.b nF3, nF3, nF3, nF3, nF3, nF3, nF3
	sGate		$00
	dc.b nF3
	sGate		$04
	dc.b nE3, nE3, nE3, nE3, nE3, nE3, nE3
	sGate		$00
	dc.b nE3
	sGate		$04
	dc.b nD3, nD3, nD3, nD3, nD3, nD3, nD3
	sGate		$00
	dc.b nD3
	sGate		$04
	dc.b nC3, nC3, nC3, nC3, nC3
	sRet

GreenHill_FM3:
	sPatFM		$02
	sPan		spLeft
	sCall		GreenHill_Call1
	sPatFM		$08
	sPan		spCenter
	saTranspose	$E8
	saVolFM		$FE
	dc.b nRst, $01

GreenHill_Loop4:
	dc.b nC6, $01, sHold, nB5, $0F, nRst, $08, nBb5
	dc.b $01, sHold, nA5, $0F, nRst, $08
	sLoop		$00, $02, GreenHill_Loop4
	dc.b nC6, $01, sHold, nB5, $07, nRst, $08, nBb5
	dc.b $01, sHold, nA5, $07, nRst, $08, nCs6, $01
	dc.b sHold, nC6, $0F, nRst, $08, nC6, $01, sHold
	dc.b nB5, $0F, nRst, $08, nBb5, $01, sHold, nA5
	dc.b $10, sHold, $3B, nRst, $04

GreenHill_Loop5:
	dc.b nBb5, $01, sHold, nA5, $0F, nRst, $08, nC6
	dc.b $01, sHold, nB5, $0F, nRst, $08, nCs6, $01
	dc.b sHold, nC6, $07, nRst, $08
	sLoop		$00, $02, GreenHill_Loop5
	dc.b nCs6, $01, sHold, nC6, $0F, nRst, $08, nC6
	dc.b $01, sHold, nB5, $28, sHold, $3E
	saVolFM		$02
	saTranspose	$18

GreenHill_Jump3:
	sPatFM		$05
	saTranspose	$E8
	sCall		GreenHill_Call5
	dc.b nA6
	sCall		GreenHill_Call5
	dc.b nE7
	sCall		GreenHill_Call5
	dc.b nA6, nRst, $24, nRst, nC7, $04, nRst, $0C
	dc.b nA6, $10, nG6, $04, nRst, nA6, nRst, nC7
	dc.b nRst
	sModOff
	sPatFM		$05
	sCall		GreenHill_Call6
	dc.b nG6, $04, nA6, nC7, $08, nA6
	sCall		GreenHill_Call6
	dc.b nG6, $04, nA6, nC7, $08, nE7
	sCall		GreenHill_Call6
	dc.b nG6, $04, nA6, nC7, $08, nA6
	saVolFM		$06
	dc.b nC5, nA4, $04, nRst, $16, nRst
	saVolFM		$FA
	dc.b nE7, $08, nRst, nC7, nRst, nA6, nA6, nA6
	dc.b $04, nRst, nC7, nRst, nE7, nRst
	saTranspose	$18
	sPatFM		$07
	sPan		spCenter
	sGate		$1E
	saVolFM		$06
	dc.b nF5, $18, $18, $18, $18, $08, nRst, nF5
	dc.b nRst, nE5, $18, $18, $18, $18, $08, nRst
	dc.b nE5, nRst, nEb5, $18, $18, $18, $18, $08
	dc.b nRst, nEb5, nRst, nA5, $18, $18, $18, $18
	dc.b $08, nRst, nA5, nRst
	saVolFM		$FA
	sGate		$00
	sJump		GreenHill_Jump3

GreenHill_Call5:
	dc.b nRst, $34, nRst, nG6, $04, nA6, nC7, $08
	sRet

GreenHill_Call6:
	saVolFM		$06
	dc.b nE5, $08, nC5, $04, nRst, $12, nRst, nE5
	dc.b $08, nC5, $04, nRst, nD5, $08, nB4, $04
	dc.b nRst, $0E, nRst
	saVolFM		$FA
	sRet

GreenHill_FM4:
	sPatFM		$08
	dc.b nRst, $20, nRst
	sPan		spLeft
	saTranspose	$E8
	saVolFM		$0A

GreenHill_Loop6:
	dc.b nAb5, $01, sHold, nG5, $0F, nRst, $08, nFs5
	dc.b $01, sHold, nF5, $0F, nRst, $08
	sLoop		$00, $02, GreenHill_Loop6
	dc.b nAb5, $01, sHold, nG5, $07, nRst, $08, nFs5
	dc.b $01, sHold, nF5, $07, nRst, $08, nBb5, $01
	dc.b sHold, nA5, $0F, nRst, $08, nAb5, $01, sHold
	dc.b nG5, $0F, nRst, $08, nFs5, $01, sHold, nF5
	dc.b $10, sHold, $3C, nRst, $04

GreenHill_Loop7:
	dc.b nFs5, $01, sHold, nF5, $0F, nRst, $08, nAb5
	dc.b $01, sHold, nG5, $0F, nRst, $08, nBb5, $01
	dc.b sHold, nA5, $07, nRst, $08
	sLoop		$00, $02, GreenHill_Loop7
	dc.b nBb5, $01, sHold, nA5, $0F, nRst, $08, nAb5
	dc.b $01, sHold, nG5, $28, sHold, $3F
	saVolFM		$F6
	saTranspose	$18
	sModOff

GreenHill_Jump4:
	sPatFM		$05
	saTranspose	$E8
	saVolFM		$18
	sPan		spLeft
	saVolFM		$FD
	sCall		GreenHill_Call7
	dc.b nD5, nD5, nE5, nE5, nC5, nC5, nA4, nA4
	dc.b nF4, nF4, nD5, nD5, nB4, nB4, nG4, nG4
	dc.b nD5, nD5
	sCall		GreenHill_Call7
	dc.b nE4, nE4, nC5, nC5, nA4, nA4, nF4, nF4
	dc.b nD4, nD4, nB4, nB4
	saVolFM		$03
	saTranspose	$18
	saTranspose	$F4
	sPatFM		$04
	dc.b nG6, $10, nA6, nB6
	saVolFM		$F9
	dc.b nC7, $28, sHold, $28, nD7, $10, nB6, nG6
	dc.b nC7, $28, sHold, $28, nB6, $10, nG6, nB6
	dc.b nC7, $28, sHold, $28, nD7, $10, nB6, nG6
	dc.b nC7, $40, sHold, $40
	saTranspose	$0C
	saVolFM		$07
	saVolFM		$E8
	sPatFM		$07
	sGate		$1E
	sPan		spCenter
	saVolFM		$12
	dc.b nD5, $18, $18, $18, $18, $08, nRst, nD5
	dc.b nRst, nC5, $18, $18, $18, $18, $08, nRst
	dc.b nC5, nRst, nC5, $18, $18, $18, $18, $08
	dc.b nRst, nC5, nRst, nF5, $18, $18, $18, $18
	dc.b $08, nRst, nF5, nRst
	saVolFM		$EE
	sGate		$00
	sJump		GreenHill_Jump4

GreenHill_Call7:
	dc.b nE5, $08, nE5, nC5, nC5, nA4, nA4, nF4
	dc.b nF4, nD5, nD5, nB4, nB4, nG4, nG4
	sRet

GreenHill_FM5:
	sPatFM		$03
	dc.b nRst, $20, nRst
	sPatFM		$08
	sPan		spRight
	saTranspose	$E8
	saVolFM		$F2

GreenHill_Loop8:
	dc.b nF5, $01, sHold, nE5, $0F, nRst, $08, nEb5
	dc.b $01, sHold, nD5, $0F, nRst, $08
	sLoop		$00, $02, GreenHill_Loop8
	dc.b nF5, $01, sHold, nE5, $07, nRst, $08, nEb5
	dc.b $01, sHold, nD5, $07, nRst, $08, nFs5, $01
	dc.b sHold, nF5, $0F, nRst, $08, nF5, $01, sHold
	dc.b nE5, $0F, nRst, $08, nEb5, $01, sHold, nD5
	dc.b $10, sHold, $3C, nRst, $04

GreenHill_Loop9:
	dc.b nEb5, $01, sHold, nD5, $0F, nRst, $08, nF5
	dc.b $01, sHold, nE5, $0F, nRst, $08, nFs5, $01
	dc.b sHold, nF5, $07, nRst, $08
	sLoop		$00, $02, GreenHill_Loop9
	dc.b nFs5, $01, sHold, nF5, $0F, nRst, $08, nF5
	dc.b $01, sHold, nE5, $28, sHold, $3F
	saTranspose	$18
	saVolFM		$0E

GreenHill_Jump5:
	sPatFM		$05
	saTranspose	$E8
	sPan		spRight
	saVolFM		$FD
	sCall		GreenHill_Call8
	dc.b nD5, nD5, nE5, nE5, nC5, nC5, nA4, nA4
	dc.b nF4, nF4, nD5, nD5, nB4, nB4, nG4, nG4
	dc.b nD5, nD5
	sCall		GreenHill_Call8
	dc.b nE4, nE4, nC5, nC5, nA4, nA4, nF4, nF4
	dc.b nD4, nD4, nB4, nB4
	saTranspose	$18
	saVolFM		$03
	saTranspose	$F4
	sPatFM		$04
	ssDetune	$02
	dc.b nG6, $10, nA6, nB6
	saVolFM		$F9
	dc.b nC7, $28, sHold, $28, nD7, $10, nB6, nG6
	dc.b nC7, $28, sHold, $28, nB6, $10, nG6, nB6
	dc.b nC7, $28, sHold, $28, nD7, $10, nB6, nG6
	dc.b nC7, $40, sHold, $40
	saTranspose	$0C
	ssDetune	$00
	sPatFM		$04
	saTranspose	$F4
	saVolFM		$FA

GreenHill_Loop10:
	dc.b nBb6, $08, nF6, nD7, nF6, nBb6, nF6, nD7
	dc.b nF6
	sLoop		$00, $02, GreenHill_Loop10

GreenHill_Loop11:
	dc.b nA6, nE6, nC7, nE6, nA6, nE6, nC7, nE6
	sLoop		$00, $02, GreenHill_Loop11

GreenHill_Loop12:
	dc.b nAb6, nEb6, nC7, nEb6, nAb6, nEb6, nC7, nEb6
	sLoop		$00, $02, GreenHill_Loop12

GreenHill_Loop13:
	dc.b nC7, nA6, nE7, nA6, nC7, nA6, nE7, nA6
	sLoop		$00, $02, GreenHill_Loop13
	saVolFM		$0D
	saTranspose	$0C
	sJump		GreenHill_Jump5

GreenHill_Call8:
	dc.b nE5, $08, nE5, nC5, nC5, nA4, nA4, nF4
	dc.b nF4, nD5, nD5, nB4, nB4, nG4, nG4
	sRet

GreenHill_PSG1:
	sVolEnvPSG	v05
	ssMod68k	$0E, $01, $01, $03
	dc.b nRst, $40
	sGate		$10
	dc.b nE5, $18, nD5, nE5, nD5, nE5, $08, nRst
	dc.b nD5, nRst, nF5, $18, nE5
	sGate		$00
	dc.b nD5, $28, sHold, $28
	sGate		$10
	dc.b nD5, $18, nE5, nF5, $10, nD5, $18, nE5
	dc.b nF5, $10, $18
	sGate		$00
	dc.b nE5, $34, sHold, $34
	sModOff

GreenHill_Loop15:
	sVolEnvPSG	v01

GreenHill_Loop14:
	dc.b nRst, $10, nC6, $04, nRst, $14, nC6, $08
	dc.b nRst, $20, nB5, $04, nRst, $14, nB5, $08
	dc.b nRst, $10
	sLoop		$01, $03, GreenHill_Loop14
	dc.b nRst, $10, nA5, $04, nRst, $14, nA5, $08
	dc.b nRst, $20, nG5, $04, nRst, $14, nG5, $08
	dc.b nRst, $10
	sLoop		$00, $02, GreenHill_Loop15
	sVolEnvPSG	v05
	dc.b nBb6, $18, nA6, nG6, nF6, nE6, $08, nRst
	dc.b nD6, nRst, nA5, $18, nB5, nC6, nD6, nE6
	dc.b $08, nRst, nA6, nRst, nAb6, $18, nG6, nF6
	dc.b nEb6, nD6, $10, nC6, $08, nRst, nRst, $08
	dc.b nG6, nA6, nG6, $10, $08, nA6, nRst, $10
	saVolPSG	$01
	dc.b nA5, $18, $08, nRst, nA5, nRst
	saVolPSG	$FF
	sVolEnvPSG	v03
	sJump		GreenHill_Loop15

GreenHill_PSG2:
	dc.b nRst, $40
	saVolPSG	$FE

GreenHill_Loop16:
	sGate		$06
	dc.b nC7, $08, nB6, nA6, nG6, nC7, nB6, nA6
	dc.b nG6
	sLoop		$00, $08, GreenHill_Loop16
	sGate		$00

GreenHill_Loop18:
	sVolEnvPSG	v01

GreenHill_Loop17:
	dc.b nRst, $10, nE6, $04, nRst, $14, nE6, $08
	dc.b nRst, $20, nD6, $04, nRst, $14, nD6, $08
	dc.b nRst, $10
	sLoop		$01, $03, GreenHill_Loop17
	dc.b nRst, $10, nC6, $04, nRst, $14, nC6, $08
	dc.b nRst, $20, nB5, $04, nRst, $14, nB5, $08
	dc.b nRst, $10
	sLoop		$00, $02, GreenHill_Loop18
	dc.b nD6, $34, sHold, $34, nC6, $08, nD6, nE6
	dc.b $38, sHold, $38, nC6, $08, nC6, nE6, nEb6
	dc.b $34, sHold, $34, nC6, $08, nEb6, nD6
	sVolEnvPSG	v05
	dc.b nC5, $18, $18, $18, $18, $08, nRst, nC5
	dc.b nRst
	sVolEnvPSG	v03
	sJump		GreenHill_Loop18

GreenHill_PSG3:
	sNoisePSG	$E7
	sGate		$06
	dc.b nA5, $10, $10, $10

GreenHill_Jump6:
	dc.b $08
	sJump		GreenHill_Jump6

GreenHill_DAC:
	dc.b nRst, $08, dKick, dSnare, dKick, dKick, dSnare, dSnare
	dc.b dSnare

GreenHill_Loop19:
	dc.b dKick, $10, dSnare, $08, dKick, $10, $08, dSnare
	dc.b $10
	sLoop		$00, $07, GreenHill_Loop19
	dc.b dKick, $10, dSnare, $08, dKick, $10, dSnare, $08
	dc.b $08, $08

GreenHill_Loop20:
	dc.b dKick, $10, dSnare, $08, dKick, $10, $08, dSnare
	dc.b $10
	sLoop		$00, $07, GreenHill_Loop20
	dc.b dKick, $10, dSnare, $08, dKick, $10, dSnare, $08
	dc.b $08, $08
	sLoop		$01, $02, GreenHill_Loop20
	sJump		GreenHill_Loop20

GreenHill_Patches:

	; Patch $00
	; $08
	; $0A, $70, $30, $00,	$1F, $1F, $5F, $5F
	; $12, $0E, $0A, $0A,	$00, $04, $04, $03
	; $2F, $2F, $2F, $2F,	$24, $2D, $13, $80
	spAlgorithm	$00
	spFeedback	$01
	spDetune	$00, $03, $07, $00
	spMultiple	$0A, $00, $00, $00
	spRateScale	$00, $01, $00, $01
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$12, $0A, $0E, $0A
	spSustainLv	$02, $02, $02, $02
	spDecayRt	$00, $04, $04, $03
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$24, $13, $2D, $00

	; Patch $01
	; $20
	; $36, $35, $30, $31,	$DF, $DF, $9F, $9F
	; $07, $06, $09, $06,	$07, $06, $06, $08
	; $20, $10, $10, $F8,	$19, $37, $13, $80
	spAlgorithm	$00
	spFeedback	$04
	spDetune	$03, $03, $03, $03
	spMultiple	$06, $00, $05, $01
	spRateScale	$03, $02, $03, $02
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$07, $09, $06, $06
	spSustainLv	$02, $01, $01, $0F
	spDecayRt	$07, $06, $06, $08
	spReleaseRt	$00, $00, $00, $08
	spTotalLv	$19, $13, $37, $00

	; Patch $02
	; $36
	; $0F, $01, $01, $01,	$1F, $1F, $1F, $1F
	; $12, $11, $0E, $00,	$00, $0A, $07, $09
	; $FF, $0F, $1F, $0F,	$18, $80, $80, $80
	spAlgorithm	$06
	spFeedback	$06
	spDetune	$00, $00, $00, $00
	spMultiple	$0F, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$12, $0E, $11, $00
	spSustainLv	$0F, $01, $00, $00
	spDecayRt	$00, $07, $0A, $09
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$18, $00, $00, $00

	; Patch $03
	; $3D
	; $01, $02, $02, $02,	$14, $0E, $8C, $0E
	; $08, $05, $02, $05,	$00, $0D, $0D, $0D
	; $1F, $1F, $1F, $1F,	$1A, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $02, $02, $02
	spRateScale	$00, $02, $00, $00
	spAttackRt	$14, $0C, $0E, $0E
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$08, $02, $05, $05
	spSustainLv	$01, $01, $01, $01
	spDecayRt	$00, $0D, $0D, $0D
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1A, $00, $00, $00

	; Patch $04
	; $2C
	; $72, $78, $34, $34,	$1F, $12, $1F, $12
	; $00, $0A, $00, $0A,	$00, $00, $00, $00
	; $0F, $1F, $0F, $1F,	$16, $80, $17, $80
	spAlgorithm	$04
	spFeedback	$05
	spDetune	$07, $03, $07, $03
	spMultiple	$02, $04, $08, $04
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $12, $12
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $00, $0A, $0A
	spSustainLv	$00, $00, $01, $01
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$16, $17, $00, $00

	; Patch $05
	; $2C
	; $74, $74, $34, $34,	$1F, $12, $1F, $1F
	; $00, $00, $00, $00,	$00, $01, $00, $01
	; $0F, $3F, $0F, $3F,	$16, $80, $17, $80
	spAlgorithm	$04
	spFeedback	$05
	spDetune	$07, $03, $07, $03
	spMultiple	$04, $04, $04, $04
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $12, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$00, $00, $03, $03
	spDecayRt	$00, $00, $01, $01
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$16, $17, $00, $00

	; Patch $06
	; $04
	; $72, $42, $32, $32,	$12, $12, $12, $12
	; $00, $08, $00, $08,	$00, $08, $00, $08
	; $0F, $1F, $0F, $1F,	$23, $80, $23, $80
	spAlgorithm	$04
	spFeedback	$00
	spDetune	$07, $03, $04, $03
	spMultiple	$02, $02, $02, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$12, $12, $12, $12
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $00, $08, $08
	spSustainLv	$00, $00, $01, $01
	spDecayRt	$00, $00, $08, $08
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$23, $23, $00, $00

	; Patch $07
	; $3D
	; $01, $02, $02, $02,	$10, $50, $50, $50
	; $07, $08, $08, $08,	$01, $00, $00, $00
	; $20, $17, $17, $17,	$1C, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $02, $02, $02
	spRateScale	$00, $01, $01, $01
	spAttackRt	$10, $10, $10, $10
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$07, $08, $08, $08
	spSustainLv	$02, $01, $01, $01
	spDecayRt	$01, $00, $00, $00
	spReleaseRt	$00, $07, $07, $07
	spTotalLv	$1C, $00, $00, $00

	; Patch $08
	; $2C
	; $74, $74, $34, $34,	$1F, $12, $1F, $1F
	; $00, $07, $00, $07,	$00, $07, $00, $07
	; $00, $38, $00, $38,	$16, $80, $17, $80
	spAlgorithm	$04
	spFeedback	$05
	spDetune	$07, $03, $07, $03
	spMultiple	$04, $04, $04, $04
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $12, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $00, $07, $07
	spSustainLv	$00, $00, $03, $03
	spDecayRt	$00, $00, $07, $07
	spReleaseRt	$00, $00, $08, $08
	spTotalLv	$16, $17, $00, $00
