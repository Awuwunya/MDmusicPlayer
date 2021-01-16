FunnyAngry_Header:
	sHeaderInit
	sHeaderPatch	FunnyAngry_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $18
	sHeaderDAC	FunnyAngry_DAC
	sHeaderFM	FunnyAngry_FM1, $00, $0E
	sHeaderFM	FunnyAngry_FM2, $00, $10
	sHeaderFM	FunnyAngry_FM3, $0C, $02
	sHeaderFM	FunnyAngry_FM4, $00, $18
	sHeaderFM	FunnyAngry_FM5, $00, $0F
	sHeaderPSG	FunnyAngry_PSG1, $DC, $02, $00, v00
	sHeaderPSG	FunnyAngry_PSG2, $DC, $01, $00, v00
	sHeaderPSG	FunnyAngry_PSG3, $00, $01, $00, v03

FunnyAngry_FM1:
	dc.b nRst, $30, nRst, nRst, nRst
	saVolFM		$F7
	ssLFO		$0E, $0F
	sPanAni		$01, $02, $01, $02, $01
	sPatFM		$16
	ssMod68k	$08, $02, $4D, $AF
	dc.b nE2, $18
	ssMod68k	$28, $03, $F7, $A6
	dc.b sHold, nE3, $48, sHold, $30, sHold, $30, sHold
	dc.b $30, sHold, $30, sHold, $30, sHold, $30, sHold
	dc.b $30, sHold, $30, sHold, $30, sHold, $30, sHold
	dc.b $30, sHold, $30, sHold, $30, sHold, $30
	saVolFM		$09
	sModOff
	sPanAni
	ssLFO		$0D, $4E
	ssMod68k	$0C, $01, $07, $03
	saVolFM		$FE
	sPatFM		$04
	dc.b nG4, $60, sHold, $60
	saVolFM		$02
	ssLFO		$00, $00
	sModOff

FunnyAngry_Jump1:
	ssMod68k	$30, $02, $70, $70
	saVolFM		$03
	sPatFM		$18
	dc.b nG4, $60, nF4, $60, nE4, $60, sHold, $60
	dc.b sHold, $30
	ssMod68k	$00, $04, $7F, $7F
	dc.b sHold, $30
	saVolFM		$04
	ssMod68k	$00, $03, $9F, $AF
	dc.b sHold, $42
	saVolFM		$FC
	saVolFM		$FD
	sModOff
	dc.b nRst, $06
	saTranspose	$F4
	ssMod68k	$10, $01, $0C, $06
	sPatFM		$11
	sCall		FunnyAngry_Call1
	saTranspose	$0C
	sModOff
	dc.b nRst, $30
	sPatFM		$14
	saVolFM		$FE
	ssMod68k	$00, $01, $0B, $04
	dc.b nG3, $30, sHold, $30, nRst, $18, nE3, nA3
	dc.b nE3, nG3, nA3, nBb3, nE3, nG3, nA3, nB3
	dc.b nD4
	saVolFM		$02
	sModOff
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, $2A
	saTranspose	$F4
	ssMod68k	$10, $01, $0C, $06
	sPatFM		$11
	sCall		FunnyAngry_Call1
	saTranspose	$0C
	sModOff
	dc.b nRst, $30
	sPatFM		$14
	saVolFM		$FF
	ssMod68k	$00, $01, $0B, $04
	dc.b nG3, $30, sHold, $30, nRst, $18, nE3, nA3
	dc.b nE3, nG3, nA3, nBb3, nE3, nG3, nA3, nB3
	dc.b nD4
	saVolFM		$01
	sModOff
	dc.b nRst, $1E, nRst, $30, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b $2A
	saTranspose	$F4
	ssMod68k	$10, $01, $0C, $06
	sPatFM		$11
	dc.b nD5, $06, nRst, nE5, $0C, nF5, $18, nE5
	dc.b $0C, nF5, nG5, nF5, nE5, $06, nRst, nF5
	dc.b $0C, nE5, $08, nF5, $04, nE5, $06, nD5
	dc.b $30, sHold, $0C, nRst, $06, nC5, $0C, nB4
	dc.b $18, nA4, $10, nB4, $14, nC5, $0C, nB4
	dc.b $06, sHold, $60, nRst, $18, nG5, $06, nF5
	dc.b nE5, nF5, $18, nF5, $06, nE5, nF5, nG5
	dc.b nD5, sHold, $30, nRst, $12, nB5, $18, nB4
	dc.b $06, nRst, $12, nD5, $18, nE5, $0C, nD5
	dc.b nE5, $06, nD5, nB4, nE4
	saVolFM		$FF
	dc.b nD5, nB4, nE4, nD4
	saVolFM		$FF
	dc.b nB4, nE4, nD4, nB3
	saVolFM		$FF
	dc.b nE4, nD4, nB3, nA3
	saVolFM		$FF
	dc.b nD4, nB3, nA3, nE3
	saVolFM		$04
	saTranspose	$0C
	sModOff
	sJump		FunnyAngry_Jump1
	dc.b $F2	; Unused

FunnyAngry_Call1:
	saVolFM		$FE
	dc.b nD4, $0C, nE4
	saVolFM		$02
	dc.b nG4, $30, sHold, $30, sHold, $30, nRst, $18
	dc.b nD4, $0C, nE4, nG4, $30, sHold, $30, sHold
	dc.b $30, nRst, $18, nF4, $0C, nG4, nBb4, $30
	dc.b sHold, $30, sHold, $30, nRst, $18, nF4, $0C
	dc.b nG4, nBb4, $30, sHold, $30, sHold, $30, sHold
	dc.b $18, nRst, $18, nE6, $06, nA5, $0C, nA4
	dc.b $30, sHold, $1E, sHold, $60, nRst, $18, nBb4
	dc.b nG4, nA4, nBb4, nG4, nA4, nD5, nCs5, $30
	dc.b sHold, $48, nRst, $18, nB4, $12, nCs5, nD5
	dc.b $0C, nG4, $18, nEb4, nFs4, $30, sHold, $48
	dc.b nRst, $18, nG5, $60, nRst, $18, nG5, nFs5
	dc.b nD5, nE5, $24, nA4, $06, nRst, nA4, $30
	dc.b sHold, $48, nRst, $18, nG5, $60, nRst, $18
	dc.b nG5, nFs5, nD5, nE5, $24, nA4, $06, nRst
	dc.b nA4, $60
	sRet

FunnyAngry_FM2:
	sPatFM		$10
	sGate		$02

FunnyAngry_Loop1:
	dc.b nE3, $06, nE3, nE3, nE3, nE3, nE3, nE3
	dc.b nE3, nE3, nE3, nE3, nE3, nE3, nE3, nE3
	dc.b nE3
	sLoop		$00, $0C, FunnyAngry_Loop1

FunnyAngry_Loop2:
	dc.b nE3, $06, nE3, nE3, nE3, nE3, nE3, nE3
	dc.b nE3, nE3, nE3, nE3, nE3, nE3, nE3, nE3
	dc.b nE3
	sLoop		$00, $07, FunnyAngry_Loop2
	sCall		FunnyAngry_Call2
	sPatFM		$15
	saVolFM		$F6
	sGate		$04
	dc.b nD4, $06, nD4, nD4, nD4, nD4, nD4, nD4
	dc.b nD4, nD4, nD4, nD4, nD4, nD4, nD4, nD4
	dc.b nD4, nD4, nD4, nRst, nD4, $0C, nD4
	saVolFM		$0A
	dc.b nRst, $30, nRst
	sCall		FunnyAngry_Call2
	sPatFM		$15
	saVolFM		$F6
	sGate		$04
	dc.b nD4, $06, nD4, nD4, nD4, nD4, nD4, nD4
	dc.b nD4, nD4, nD4, nD4, nD4, nD4, nD4, nD4
	dc.b nD4
	saVolFM		$0A
	dc.b nRst, $06, nRst, $30, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, $2A
	sGate		$00
	saVolFM		$FE
	sPatFM		$1A
	dc.b nG4, $06, nF4, nG4, $0C, nA4, $06, nG4
	dc.b nF4, nE4
	saVolFM		$FC
	dc.b nCs5, $01, sHold, nD5, $06, nRst, $11, nRst
	dc.b $18
	saVolFM		$04
	saVolFM		$02
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	sPatFM		$10
	sGate		$02
	sJump		FunnyAngry_Loop2
	dc.b $F2	; Unused

FunnyAngry_Call2:
	sGate		$00
	saVolFM		$01
	sPatFM		$1A
	dc.b nD5, $06, nE5, nRst, nE5, $04, nRst, $08
	dc.b nE5, $06, nD5, nRst, nG5
	ssMod68k	$20, $01, $DF, $FF
	dc.b nE5, $24, nRst, $06
	sModOff
	dc.b nRst, $30, nRst, nRst, $0C, nE5, $18, nD5
	dc.b $05, nRst, $07, nG4, $06, nA4, nG4, nA4
	dc.b nBb4, nA4, nG4, nE4, nG4, nE4, $0C
	ssMod68k	$20, $01, $DF, $FF
	dc.b nE5, $24
	sModOff
	dc.b nRst, $2A, nRst, $30, nC5, $06, nBb4, nA4
	dc.b nG4, nBb4, nA4, nG4, nF4, nF4, nF5, nRst
	dc.b nF5, nRst, nF5, nRst, nE5, nD5, nBb4, nRst
	dc.b $24, nD4, $06, nD4, nE4, nE4, nF4, nE4
	dc.b nF4, nG4, nA4, nA4, nBb4, nB4, nC5, nB4
	dc.b nBb4, nA4
	ssMod68k	$28, $01, $EF, $FF
	dc.b nE5, $30
	sModOff
	dc.b nRst, nRst, nRst
	sGate		$06
	dc.b nFs5, $06, nFs5, nFs5, nFs5
	sGate		$0A
	dc.b nFs5, $12, nRst, $30, nRst, $06
	sGate		$06
	dc.b nFs5, $06, nFs5, nFs5, nFs5
	sGate		$0A
	dc.b nFs5, $06
	saVolFM		$FE
	dc.b sHold, nG5, $08, nRst, $30, nRst, $0A
	saVolFM		$02
	sGate		$06
	dc.b nFs5, $06, nFs5, nFs5, nFs5
	sGate		$0A
	dc.b nFs5, $12, nRst, $30, nRst, $06
	sGate		$06
	dc.b nFs5, $06, nFs5, nFs5, nFs5
	sGate		$0A
	dc.b nFs5, $06
	saVolFM		$FE
	dc.b sHold, nG5, $08, nRst, $30, nRst, $0A
	saVolFM		$02
	sGate		$06
	dc.b nFs5, $06, nFs5, nFs5, nFs5
	sGate		$0A
	dc.b nFs5, $12, nRst, $30, nRst, $06
	sGate		$06
	dc.b nFs5, $06, nFs5, nFs5, nFs5
	sGate		$0A
	dc.b nFs5, $05, nRst, $01
	sGate		$00
	ssMod68k	$1E, $01, $DF, $FF
	dc.b nG5, $28
	sModOff
	dc.b nRst, $02, nA5, $18
	saVolFM		$FF
	sPatFM		$14
	saVolFM		$FB
	ssMod68k	$00, $01, $0B, $04
	ssLFO		$08, $0D
	dc.b nA3, $60, nRst, $18, nG3, nA3, nG3, nFs3
	dc.b $24, nE3, $06, nRst, nE3, $30, sHold, $48
	dc.b nRst, $18, nA3, $60, nRst, $18, nG3, nA3
	dc.b nG3, nFs3, $24, nE3, $06, nRst, nE3, $30
	dc.b sHold, $48, nRst, $18
	saVolFM		$05
	sModOff
	ssLFO		$00, $00
	sGate		$00
	sPatFM		$1A
	saVolFM		$FF
	dc.b nB4, $48
	saVolFM		$01
	dc.b nB4, $06, nA4, nG4, nE4, nA4, $18, $06
	dc.b nG4, nFs4, nE4, nD4, nD4, nRst, nD4, nRst
	dc.b $18, nB3, $06, nB3, nD4, nD4, nA4, nG4
	dc.b nFs4, nE4, nRst, $30, nB3, $06, nB3, nD4
	dc.b nD4, nA4, nG4, nFs4, nE4, $1E, nG5, $06
	dc.b nA5, $06, sHold, nAb5, $03, sHold, nG5, $01
	dc.b sHold, nFs5, sHold, nE5, sHold, nEb5, sHold, nD5
	dc.b nRst, $04, nE5, $06, nE5, nE5, nE5, nRst
	dc.b $0C, nE5, $06, nE5, nE5, nE5, nRst, $0C
	dc.b nE5, $06, nE5, nE5, nE5, nRst, $0C, nF5
	dc.b $10, nF5, nF5, nE5, $06, nE5, nE5, nE5
	dc.b nRst, $0C, nE5, $06, nE5, nE5, nE5, nRst
	dc.b $0C, nE5, $06, nE5, nE5, nE5, nRst, $0C
	dc.b nF5, $10, nF5, nF5, nE5, $06, nE5, nE5
	dc.b nE5, nRst, $0C, nE5, $06, nE5, nE5, nE5
	dc.b nRst, $0C, nE5, $06, nE5, nE5, nE5, nRst
	dc.b $0C, nF6, $10, nF6, nF6
	sGate		$07
	dc.b nE6, $06, nE6, nE6, nE6, nRst, $0C, nE6
	dc.b $06, nE6, nE6, nE6, nRst, $0C, nE6, $06
	dc.b nE6
	sGate		$00
	sRet

FunnyAngry_FM3:
	dc.b nRst, $30, nRst, nRst, nRst
	sPatFM		$07

FunnyAngry_Loop3:
	dc.b nE1, $0C, nRst, nE1, nRst, nE1, nRst, nE1
	dc.b nD1
	sLoop		$00, $07, FunnyAngry_Loop3
	dc.b nE1, nRst, nE1, nRst, nE1, $06, nRst, nE1
	dc.b nRst, nE1, nRst, nE1, nRst, nRst, $30, nRst
	dc.b nRst, nRst

FunnyAngry_Jump2:
	dc.b nRst, $30, nRst, nRst, nRst
	sPatFM		$07
	dc.b nE1, $0C, nRst, nE1, nRst, nE1, nRst, nE1
	dc.b nD1, nE1, nRst, nE1, nRst, nE1, nRst, nE1
	dc.b nD1, nE1, nRst, nE1, nRst, nE1, nRst, nE1
	dc.b nD1, nE1, nRst, nE1, nRst, nE1, $06, nRst
	dc.b nE1, nRst, nE1, nRst, nE1, nRst
	sCall		FunnyAngry_Call3
	dc.b nE1, $06, nE1, nE1, nE1, nRst, nB0, nE1
	dc.b nE1, nE1, nE1, nRst, nB0, nE1, nE1, nE1
	dc.b $0A, nRst, $0E, nE1, $0A, nRst, $0E, nE1
	dc.b $0A, nRst, $08, nE1, $06, nE1, nE1, nE1
	dc.b nE1, nRst, $12, nE1, $06, nRst, nE1, nRst
	sCall		FunnyAngry_Call3
	dc.b nE1, $06, nE1, nE1, nE1, nRst, nB0, nE1
	dc.b nE1, nE1, nE1, nRst, nB0, nE1, nE1, nE1
	dc.b nRst, $12, nE1, $0A, nRst, $0E, nE1, $0A
	dc.b nRst, $08, nE1, $06, nE1, nE1, nE1, nE1
	dc.b nG1, nRst, $12, nG1, $0C, nRst, nG1, nRst
	dc.b nG1, nF1, nG1, $06, nRst, $12, nG1, $0C
	dc.b nRst, nG1, nRst, nG1, nG1, nG1, $06, nRst
	dc.b $12, nG1, $0C, nRst, nG1, nRst, nG1, nF1
	dc.b nG1, $06, nRst, $12, nG1, $0C, nRst, nG1
	dc.b nG1, nG1, nG1, nB1, $06, nRst, $12, nB1
	dc.b $0C, nRst, nB1, nRst, nB1, nA1, nB1, $06
	dc.b nRst, $12, nB1, $0C, nRst, nB1, nRst, nB1
	dc.b nRst, nB1, $06, nRst, $12, nB1, $0C, nRst
	dc.b nB1, nRst, nB1, nRst, nE1, $06, nRst, nE1
	dc.b $0C, nE1, nE1, nE1, nE1, nE1, nE1
	sJump		FunnyAngry_Jump2
	dc.b $F2	; Unused

FunnyAngry_Call3:
	dc.b nE1, $0C, nRst, nE1, nRst, nE1, nRst, nE1
	dc.b nD1, nE1, nRst, nE1, nRst, nE1, nRst, nE1
	dc.b nD1, nE1, nRst, nE1, nRst, nE1, nRst, nE1
	dc.b nD1, nE1, nRst, nE1, nRst, nE1, nRst, nE1
	dc.b nD1, nG1, nRst, nG1, nRst, nG1, nRst, nG1
	dc.b nF1, nG1, nRst, nG1, nRst, nG1, nRst, nG1
	dc.b nF1, nG1, nRst, nG1, nRst, nG1, nRst, nG1
	dc.b nF1, nG1, nRst, nG1, nRst, nG1, $06, nRst
	dc.b nG1, nRst, nG1, nRst, nG1, nRst, nE1, $0C
	dc.b nRst, nE1, nRst, nE1, nRst, nE1, nD1, nE1
	dc.b nRst, nE1, nRst, nE1, nRst, nE1, nD1, nE1
	dc.b nRst, nE1, nRst, nE1, nRst, nE1, nD1, nE1
	dc.b nRst, nE1, nRst, nE1, nRst, nE1, nD1, nE1
	dc.b nRst, nE1, nRst, nE1, nRst, nE1, nD1, nE1
	dc.b nRst, nE1, nRst, nE1, nRst, nE1, nD1, nE1
	dc.b nRst, nE1, nRst, nE1, nRst, nE1, nD1, nE1
	dc.b nRst, nE1, nRst, nE1, $06, nRst, nE1, nRst
	dc.b nE1, nRst, nE1, nRst, nA1, $0C, nRst, nA1
	dc.b nRst, nA1, nRst, nA1, nG1, nA1, nRst, nA1
	dc.b nRst, nA1, nRst, nA1, nG1, nA1, nRst, nA1
	dc.b nRst, nA1, nRst, nA1, nG1, nA1, nRst, nA1
	dc.b nRst, nA1, nRst, nA1, nRst, nA1, nRst, nA1
	dc.b nRst, nA1, nRst, nA1, nG1, nA1, nRst, nA1
	dc.b nRst, nA1, nRst, nA1, nG1, nA1, nRst, nA1
	dc.b nRst, nA1, nRst, nA1, nG1, nA1, nRst, nA1
	dc.b nRst, nA1, nRst, nA1, nRst, nE1, nRst, nE1
	dc.b nRst, nE1, nRst, nE1, nD1, nE1, nRst, nE1
	dc.b nRst, nE1, nRst, nE1, nD1, nE1, nRst, nE1
	dc.b nRst, nE1, nRst, nE1, nD1, nE1, nRst, nE1
	dc.b nRst, nE1, nRst, nE1, nD1, nE1, $06, nE1
	dc.b nE1, nE1, nRst, nB0, nE1, nE1, nE1, nE1
	dc.b nRst, nB0, nE1, nE1, nE1, nE1, nRst, nB0
	dc.b nF1, $10, nF1, nF1, nE1, $06, nE1, nE1
	dc.b nE1, nRst, nB0, nE1, nE1, nE1, nE1, nRst
	dc.b nB0, nE1, nE1, nE1, nE1, nRst, nB0, nF1
	dc.b $10, nF1, nF1, nE1, $06, nE1, nE1, nE1
	dc.b nRst, nB0, nE1, nE1, nE1, nE1, nRst, nB0
	dc.b nE1, nE1, nE1, nE1, nRst, nB0, nF1, $10
	dc.b nF1, nF1
	sRet

FunnyAngry_FM4:
	dc.b nRst, $30, nRst, nRst, nRst, nRst, $0C
	saVolFM		$FB
	ssLFO		$0E, $0F
	sPanAni		$01, $02, $01, $02, $01
	sPatFM		$16
	ssMod68k	$08, $02, $4D, $AF
	dc.b nE2, $18, sHold
	ssMod68k	$28, $03, $F7, $A6
	dc.b nE3, $48, sHold, $30, sHold, $30, sHold, $30
	dc.b sHold, $30, sHold, $30, sHold, $30, sHold, $30
	dc.b sHold, $30, sHold, $30, sHold, $30, sHold, $30
	dc.b sHold, $30, sHold, $30, sHold, $30
	sModOff
	sPanAni
	ssLFO		$0D, $4E
	ssMod68k	$0C, $01, $07, $03
	sPatFM		$04
	dc.b nG4, $60, sHold, $54
	ssLFO		$00, $00
	sModOff
	saVolFM		$05

FunnyAngry_Jump3:
	saVolFM		$FC
	dc.b nRst, $0C
	ssMod68k	$30, $02, $70, $70
	sPatFM		$18
	dc.b nG4, $60, nF4, $60, nE4, $60, sHold, $60
	dc.b sHold, $30
	ssMod68k	$00, $04, $7F, $7F
	dc.b sHold, $30
	saVolFM		$04
	ssMod68k	$00, $03, $9F, $AF
	dc.b sHold, $48
	sModOff
	saVolFM		$FC
	dc.b nRst, $30, nRst, $3C
	saVolFM		$04
	sPatFM		$1A
	ssDetune	$01
	sCall		FunnyAngry_Call4
	dc.b nRst, $18, nRst, $30, nRst, nRst, nRst, nRst
	dc.b $12
	sPatFM		$1A
	sCall		FunnyAngry_Call4
	dc.b nRst, $06, nRst, $30, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, $2A
	saVolFM		$FE
	sPatFM		$1A
	dc.b nC5, $06, nB4, nC5, $0C, nD5, $06, nB4
	dc.b nA4, nG4
	saVolFM		$FD
	dc.b nE5, $01, sHold, nF5, $06, nRst, $11
	saVolFM		$03
	saVolFM		$02
	ssDetune	$00
	dc.b nRst, $18
	saTranspose	$F4
	saVolFM		$02
	ssMod68k	$10, $01, $0C, $06
	sPatFM		$11
	dc.b nRst, $06, nF5, $18, nF5, $06, nE5, nF5
	dc.b nG5, nD5, sHold, $30, nRst, $12, nB5, $18
	dc.b nB4, $06, nRst, $12, nD5, $18, nE5, $0C
	dc.b nD5, nE5, $06, nD5, nB4, nE4
	saVolFM		$FE
	dc.b nD5, nB4, nE4, nD4
	saVolFM		$FF
	dc.b nB4, nE4, nD4, nB3
	saVolFM		$FF
	dc.b nE4, nD4, nB3, nA3
	saVolFM		$FF
	dc.b nD4, nB3, nA3
	saVolFM		$03
	saTranspose	$0C
	sModOff
	sJump		FunnyAngry_Jump3
	dc.b $F2	; Unused

FunnyAngry_Call4:
	dc.b nA4, $06, nB4, nRst, nB4, $04, nRst, $08
	dc.b nB4, $06, nA4, nRst, nD5
	ssMod68k	$20, $01, $DF, $FF
	dc.b nB4, $24, nRst, $06
	sModOff
	dc.b nRst, $30, nRst, nRst, $0C, nB4, $18, nA4
	dc.b $05, nRst, $07, nD4, $06, nE4, nD4, nE4
	dc.b nF4, nE4, nD4, nB3, nD4, nB3, $0C
	ssMod68k	$20, $01, $DF, $FF
	dc.b nB4, $24
	sModOff
	dc.b nRst, $2A, nRst, $30, nG4, $06, nF4, nE4
	dc.b nD4, nF4, nE4, nD4, nC4, nC4, nC5, nRst
	dc.b nC5, nRst, nC5, nRst, nB4, nA4, nF4, nRst
	dc.b $24, nA3, $06, nA3, nB3, nB3, nC4, nB3
	dc.b nC4, nD4, nE4, nE4, nF4, nFs4, nG4, nFs4
	dc.b nF4, nE4
	ssMod68k	$28, $01, $EF, $FF
	dc.b nB5, $30
	sModOff
	dc.b nRst, nRst, nRst, nCs5, $04, nRst, $02, nCs5
	dc.b $04, nRst, $02, nCs5, $04, nRst, $02, nCs5
	dc.b $04, nRst, $02
	sGate		$0A
	dc.b nCs5, $12, nRst, $30, nRst, $06
	sGate		$00
	dc.b nCs5, $04, nRst, $02, nCs5, $04, nRst, $02
	dc.b nCs5, $04, nRst, $02, nCs5, $04, nRst, $02
	sGate		$0A
	dc.b nCs5, $06, sHold, nD5, $08, nRst, $30, nRst
	dc.b $0A
	sGate		$00
	dc.b nCs5, $04, nRst, $02, nCs5, $04, nRst, $02
	dc.b nCs5, $04, nRst, $02, nCs5, $04, nRst, $02
	sGate		$0A
	dc.b nCs5, $12, nRst, $30, nRst, $06
	sGate		$00
	dc.b nCs5, $04, nRst, $02, nCs5, $04, nRst, $02
	dc.b nCs5, $04, nRst, $02, nCs5, $04, nRst, $02
	sGate		$0A
	dc.b nCs5, $06, sHold, nD5, $08, nRst, $30, nRst
	dc.b $0A
	sGate		$00
	dc.b nCs5, $04, nRst, $02, nCs5, $04, nRst, $02
	dc.b nCs5, $04, nRst, $02, nCs5, $04, nRst, $02
	sGate		$0A
	dc.b nCs5, $12, nRst, $30, nRst, $06
	sGate		$00
	dc.b nCs5, $04, nRst, $02, nCs5, $04, nRst, $02
	dc.b nCs5, $04, nRst, $02, nCs5, $04, nRst, $02
	sGate		$0A
	dc.b nCs5, $05, nRst, $01
	ssMod68k	$1E, $01, $DF, $FF
	sGate		$00
	dc.b nD5, $28
	sModOff
	dc.b nRst, $02, nE5, $18, nRst, $30, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst
	saVolFM		$FF
	dc.b nE5, sHold, $18
	saVolFM		$01
	dc.b nE5, $06, nD5, nCs5, nB4, nD5, $18, $06
	dc.b nCs5, nB4, nA4, nG4, nG4, nRst, nG4, nRst
	dc.b $18, nE4, $06, nE4, nG4, nG4, nD5, nCs5
	dc.b nB4, nA4, nRst, $30, nE4, $06, nE4, nG4
	dc.b nG4, nD5, nCs5, nB4, nA4, $1E, nD5, $06
	dc.b nE5, $06, sHold, nEb5, $03, sHold, nD5, $01
	dc.b sHold, nCs5, sHold, nC5, sHold, nB4, sHold, nBb4
	dc.b nRst, $04, nB4, $06, nB4, nB4, nB4, nRst
	dc.b $0C, nB4, $06, nB4, nB4, nB4, nRst, $0C
	dc.b nB4, $06, nB4, nB4, nB4, nRst, $0C, nC5
	dc.b $10, nC5, nC5, nB4, $06, nB4, nB4, nB4
	dc.b nRst, $0C, nB4, $06, nB4, nB4, nB4, nRst
	dc.b $0C, nB4, $06, nB4, nB4, nB4, nRst, $0C
	dc.b nC5, $10, nC5, nC5, nB4, $06, nB4, nB4
	dc.b nB4, nRst, $0C, nB4, $06, nB4, nB4, nB4
	dc.b nRst, $0C, nB4, $06, nB4, nB4, nB4, nRst
	dc.b $0C, nC6, $10, nC6, nC6
	sGate		$07
	dc.b nB5, $06, nB5, nB5, nB5, nRst, $0C, nB5
	dc.b $06, nB5, nB5, nB5, nRst, $0C, nB5, $06
	dc.b nB5
	sGate		$00
	sRet

FunnyAngry_FM5:
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst
	ssMod68k	$04, $01, $8F, $FF
	sPatFM		$19
	saVolFM		$FF
	dc.b nG2, $06, nG2, nG2, nG2, nG2, $0C, nRst
	dc.b nRst, $30

FunnyAngry_Loop4:
	dc.b nG2, $06, nG2, nG2, nG2, nG2, $0C, nRst
	dc.b nRst, $30
	sLoop		$00, $16, FunnyAngry_Loop4
	saVolFM		$01
	saTranspose	$E8
	ssMod68k	$05, $01, $8F, $FF
	sPatFM		$13
	dc.b nA4, $06, nA4, nRst, $0C, nA4, $06, nA4
	dc.b nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4
	dc.b $06, nA4, nRst, $0C, nA4, $06, nA4, nRst
	dc.b $0C, nA4, $06, nA4, nRst, $0C, nA4, $06
	dc.b nRst, nA4, nRst, nA4, nRst, nA4, nRst, nA4
	dc.b $06, nA4, nRst, $0C, nA4, $06, nA4, nRst
	dc.b $0C, nA4, $06, nA4, nRst, $0C, nA4, $06
	dc.b nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C
	dc.b nA4, $06, nA4, nRst, $0C, nA4, $06, nRst
	dc.b nA4, nRst, nA4, nRst, nA4, nRst, nA4, $06
	dc.b nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C
	dc.b nA4, $06, nA4, nRst, $0C, nA4, $06, nA4
	dc.b nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4
	dc.b $06, nA4, nRst, $0C, nA4, $06, nRst, nA4
	dc.b nRst, nA4, nRst, nA4, nRst, nA4, $06, nA4
	dc.b nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4
	dc.b $06, nA4, nRst, $0C, nA4, $06, nA4, nRst
	dc.b $0C, nA4, $06, nA4, nRst, $0C, nA4, $06
	dc.b nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C
	dc.b nA4, $06, nA4, nRst, $0C, nRst, $30, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nE4, $06
	dc.b nE4, nE4, nE4, nRst, $0C, nE4, $06, nE4
	dc.b nE4, nE4, nRst, $0C, nE4, $06, nE4, nE4
	dc.b nE4, nRst, $0C, nF3, $10, nF3, nF3, nE4
	dc.b $06, nE4, nE4, nE4, nRst, $0C, nE4, $06
	dc.b nE4, nE4, nE4, nRst, $0C, nE4, $06, nE4
	dc.b nE4, nE4, nRst, $0C, nF3, $10, nF3, nF3
	dc.b nE4, $06, nE4, nE4, nE4, nRst, $0C, nE4
	dc.b $06, nE4, nE4, nE4, nRst, $0C, nE4, $06
	dc.b nE4, nE4, nE4, nRst, $0C, nF3, $10, nF3
	dc.b nF3, nE4, $06, nE4, nE4, nE4, nRst, $0C
	dc.b nE4, $06, nE4, nE4, nE4, nRst, $0C, nE4
	dc.b $06, nE4, nRst, $18
	saTranspose	$18
	dc.b nRst, $18, nRst, $12
	ssMod68k	$04, $01, $8F, $FF
	saVolFM		$FF
	sPatFM		$19
	dc.b nG2, $06, nG2, nG2, nG2, nG2, nRst, $2A

FunnyAngry_Loop5:
	dc.b nG2, $06, nG2, nG2, nG2, nG2, $0C, nRst
	dc.b nRst, $30
	sLoop		$00, $04, FunnyAngry_Loop5

FunnyAngry_Loop6:
	dc.b nD3, $06, nD3, nD3, nD3, nD3, $0C, nRst
	dc.b nRst, $30
	sLoop		$00, $04, FunnyAngry_Loop6

FunnyAngry_Loop7:
	dc.b nG2, $06, nG2, nG2, nG2, nG2, $0C, nRst
	dc.b nRst, $30
	sLoop		$00, $08, FunnyAngry_Loop7
	saVolFM		$01
	saTranspose	$E8
	ssMod68k	$05, $01, $8F, $FF
	sPatFM		$13
	dc.b nA4, $06, nA4, nRst, $0C, nA4, $06, nA4
	dc.b nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4
	dc.b $06, nA4, nRst, $0C, nA4, $06, nA4, nRst
	dc.b $0C, nA4, $06, nA4, nRst, $0C, nA4, $06
	dc.b nRst, nA4, nRst, nA4, nRst, nA4, nRst, nA4
	dc.b $06, nA4, nRst, $0C, nA4, $06, nA4, nRst
	dc.b $0C, nA4, $06, nA4, nRst, $0C, nA4, $06
	dc.b nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C
	dc.b nA4, $06, nA4, nRst, $0C, nA4, $06, nRst
	dc.b nA4, nRst, nA4, nRst, nA4, nRst, nA4, $06
	dc.b nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C
	dc.b nA4, $06, nA4, nRst, $0C, nA4, $06, nA4
	dc.b nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4
	dc.b $06, nA4, nRst, $0C, nA4, $06, nRst, nA4
	dc.b nRst, nA4, nRst, nA4, nRst, nA4, $06, nA4
	dc.b nRst, $0C, nA4, $06, nA4, nRst, $0C, nA4
	dc.b $06, nA4, nRst, $0C, nA4, $06, nA4, nRst
	dc.b $0C, nA4, $06, nA4, nRst, $0C, nA4, $06
	dc.b nA4, nRst, $0C, nA4, $06, nA4, nRst, $0C
	dc.b nA4, $06, nA4, nRst, $30, nRst, $2A, nRst
	dc.b $30, nRst, nRst, nRst, nRst, nRst, nRst, $12
	dc.b nE4, $06, nE4, nE4, nE4, nRst, $0C, nE4
	dc.b $06, nE4, nE4, nE4, nRst, $0C, nE4, $06
	dc.b nE4, nE4, nE4, nRst, $0C, nF3, $10, nF3
	dc.b nF3, nE4, $06, nE4, nE4, nE4, nRst, $0C
	dc.b nE4, $06, nE4, nE4, nE4, nRst, $0C, nE4
	dc.b $06, nE4, nE4, nE4, nRst, $0C, nF3, $10
	dc.b nF3, nF3, nE4, $06, nE4, nE4, nE4, nRst
	dc.b $0C, nE4, $06, nE4, nE4, nE4, nRst, $0C
	dc.b nE4, $06, nE4, nE4, nE4, nRst, $0C, nF3
	dc.b $10, nF3, nF3, nE4, $06, nE4, nE4, nE4
	dc.b nRst, $0C, nE4, $06, nE4, nE4, nE4, nRst
	dc.b $0C, nE4, $06, nE4, nRst, nRst, $30, nRst
	dc.b $2A

FunnyAngry_Loop8:
	dc.b nA2, $06, nA2, nA2, nA2, nA2, nA2, nA2
	dc.b nA2, nA2, nA2, nA2, nA2, nA2, nA2, nA2
	dc.b nA2
	sLoop		$00, $08, FunnyAngry_Loop8
	saTranspose	$18
	ssMod68k	$04, $01, $8F, $FF
	sPatFM		$19
	saVolFM		$FF
	sJump		FunnyAngry_Loop4
	dc.b $F2	; Unused

FunnyAngry_PSG1:
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst

FunnyAngry_Jump4:
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst
	sVolEnvPSG	v09
	sCall		FunnyAngry_Call5
	dc.b nRst, $18, nRst, $30, nRst, nRst, nRst, nRst
	dc.b $12
	sVolEnvPSG	v09
	sCall		FunnyAngry_Call5
	dc.b nRst, $06, nRst, $30, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, $2A
	sVolEnvPSG	v09
	dc.b nC5, $06, nB4, nC5, $0C, nD5, $06, nB4
	dc.b nA4, nG4
	saVolPSG	$FF
	dc.b nE5, $01, sHold, nF5, $06
	saVolPSG	$01
	dc.b nRst, $11, nRst, $18, nRst, $30, nRst, nRst
	dc.b nRst, nRst, nRst, nRst
	sJump		FunnyAngry_Jump4
	dc.b $F2	; Unused

FunnyAngry_Call5:
	dc.b nA4, $06, nB4, nRst, nB4, $04, nRst, $08
	dc.b nB4, $06, nA4, nRst, nD5
	ssMod68k	$1B, $02, $20, $FF
	dc.b nB4, $24, nRst, $06
	sModOff
	dc.b nRst, $30, nRst, nRst, $0C, nB4, $18, nA4
	dc.b $05, nRst, $07, nD4, $06, nE4, nD4, nE4
	dc.b nF4, nE4, nD4, nB3, nD4, nB3, $0C
	ssMod68k	$1E, $02, $20, $FF
	dc.b nB4, $24
	sModOff
	dc.b nRst, $2A, nRst, $30, nG4, $06, nF4, nE4
	dc.b nD4, nF4, nE4, nD4, nC4, nC4, nC5, nRst
	dc.b nC5, nRst, nC5, nRst, nB4, nA4, nF4, nRst
	dc.b $24, nA3, $06, nA3, nB3, nB3, nC4, nB3
	dc.b nC4, nD4, nE4, nE4, nF4, nFs4, nG4, nFs4
	dc.b nF4, nE4
	ssMod68k	$26, $02, $16, $FF
	dc.b nB5, $30
	sModOff
	dc.b nRst, nRst, nRst
	sGate		$06
	dc.b nCs5, $06, nCs5, nCs5, nCs5
	sGate		$0A
	dc.b nCs5, $12, nRst, $30, nRst, $06
	sGate		$06
	dc.b nCs5, nCs5, nCs5, nCs5, nCs5
	sGate		$0A
	dc.b nD5, $0C, nRst, $30, nRst, $06
	sGate		$06
	dc.b nCs5, nCs5, nCs5, nCs5
	sGate		$0A
	dc.b nCs5, $12, nRst, $30, nRst, $06
	sGate		$06
	dc.b nCs5, nCs5, nCs5, nCs5, nCs5
	sGate		$0A
	dc.b nD5, $0C, nRst, $30, nRst, $06
	sGate		$06
	dc.b nCs5, nCs5, nCs5, nCs5
	sGate		$0A
	dc.b nCs5, $12, nRst, $30, nRst, $06
	sGate		$06
	dc.b nCs5, nCs5, nCs5, nCs5
	sGate		$0A
	dc.b nCs5, $04, nRst, $02
	ssMod68k	$1B, $02, $20, $FF
	sGate		$00
	dc.b nD5, $28
	sModOff
	dc.b nRst, $02, nE5, $18, nRst, $30, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nE5, sHold, $18
	dc.b $06, nD5, nCs5, nB4, nD5, $18, $06, nCs5
	dc.b nB4, nA4, nG4, nG4, nRst, nG4, nRst, $18
	dc.b nE4, $06, nE4, nG4, nG4, nD5, nCs5, nB4
	dc.b nA4, nRst, $30, nE4, $06, nE4, nG4, nG4
	dc.b nD5, nCs5, nB4, nA4, $1E, nD5, $06, nE5
	dc.b $06, sHold, nEb5, $03, sHold, nD5, $01, sHold
	dc.b nCs5, sHold, nC5, sHold, nB4, sHold, nBb4, nRst
	dc.b $04, nB4, $06, nB4, nB4, nB4, nRst, $0C
	dc.b nB4, $06, nB4, nB4, nB4, nRst, $0C, nB4
	dc.b $06, nB4, nB4, nB4, nRst, $0C, nC5, $10
	dc.b nC5, nC5, nB4, $06, nB4, nB4, nB4, nRst
	dc.b $0C, nB4, $06, nB4, nB4, nB4, nRst, $0C
	dc.b nB4, $06, nB4, nB4, nB4, nRst, $0C, nC5
	dc.b $10, nC5, nC5, nB4, $06, nB4, nB4, nB4
	dc.b nRst, $0C, nB4, $06, nB4, nB4, nB4, nRst
	dc.b $0C, nB4, $06, nB4, nB4, nB4, nRst, $0C
	dc.b nC6, $10, nC6, nC6
	sGate		$06
	dc.b nB5, $06, nB5, nB5, nB5, nRst, $0C, nB5
	dc.b $06, nB5, nB5, nB5, nRst, $0C, nB5, $06
	dc.b nB5
	sGate		$00
	sRet

FunnyAngry_PSG2:
	dc.b nRst, $30, nRst, nRst, $30, nRst
	sVolEnvPSG	v05
	sGate		$02

FunnyAngry_Loop9:
	dc.b nB4, $02
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nCs5
	saVolPSG	$04
	dc.b nRst, nCs5
	saVolPSG	$FC
	dc.b nB4
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nRst, $06, nD5, $02
	saVolPSG	$04
	dc.b nRst, nD5
	saVolPSG	$FC
	dc.b nCs5
	saVolPSG	$04
	dc.b nRst, nCs5
	saVolPSG	$FC
	dc.b nB4
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nG4
	saVolPSG	$04
	dc.b nRst, nG4
	saVolPSG	$FC
	sLoop		$00, $10, FunnyAngry_Loop9
	dc.b nRst, $30, nRst, nRst, nRst

FunnyAngry_Jump5:
	dc.b nRst, $30, nRst, nRst, nRst

FunnyAngry_Loop10:
	dc.b nB4, $02
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nCs5
	saVolPSG	$04
	dc.b nRst, nCs5
	saVolPSG	$FC
	dc.b nB4
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nRst, $06, nD5, $02
	saVolPSG	$04
	dc.b nRst, nD5
	saVolPSG	$FC
	dc.b nCs5
	saVolPSG	$04
	dc.b nRst, nCs5
	saVolPSG	$FC
	dc.b nB4
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nG4
	saVolPSG	$04
	dc.b nRst, nG4
	saVolPSG	$FC
	sLoop		$00, $10, FunnyAngry_Loop10
	sVolEnvPSG	v0B
	sGate		$03
	dc.b nB3, $06, nD4, nF4, nA4, nRst, $30, nB3
	dc.b $06, nD4, nF4, nA4, nRst, $18, nB3, $06
	dc.b nD4, nF4, nA4, nRst, $30, nB3, $06, nD4
	dc.b nF4, nA4, nRst, $30, nB3, $06, nD4, nF4
	dc.b nA4, nRst, $18, nB3, $06, nD4, nF4, nA4
	dc.b nRst, $18, nB3, $06, nD4, nF4, nB3
	sVolEnvPSG	v05
	sGate		$02

FunnyAngry_Loop11:
	dc.b nB4, $02
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nCs5
	saVolPSG	$04
	dc.b nRst, nCs5
	saVolPSG	$FC
	dc.b nB4
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nRst, $06, nD5, $02
	saVolPSG	$04
	dc.b nRst, nD5
	saVolPSG	$FC
	dc.b nCs5
	saVolPSG	$04
	dc.b nRst, nCs5
	saVolPSG	$FC
	dc.b nB4
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nG4
	saVolPSG	$04
	dc.b nRst, nG4
	saVolPSG	$FC
	sLoop		$00, $10, FunnyAngry_Loop11
	sVolEnvPSG	v0B
	sGate		$03

FunnyAngry_Loop12:
	dc.b nA4, $06, nE4, nD5, nRst, nCs5, nD5, nCs5
	dc.b nA4, nA4, nE4, nE5, nRst, nCs5, nD5, nCs5
	dc.b nA4
	sLoop		$00, $08, FunnyAngry_Loop12
	sVolEnvPSG	v05
	sGate		$02

FunnyAngry_Loop13:
	dc.b nB4, $02
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nCs5
	saVolPSG	$04
	dc.b nRst, nCs5
	saVolPSG	$FC
	dc.b nB4
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nRst, $06, nD5, $02
	saVolPSG	$04
	dc.b nRst, nD5
	saVolPSG	$FC
	dc.b nCs5
	saVolPSG	$04
	dc.b nRst, nCs5
	saVolPSG	$FC
	dc.b nB4
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nG4
	saVolPSG	$04
	dc.b nRst, nG4
	saVolPSG	$FC
	sLoop		$00, $08, FunnyAngry_Loop13
	sVolEnvPSG	v0B
	sGate		$03
	saVolPSG	$01

FunnyAngry_Loop14:
	dc.b nE5, $06, nE5, nE5, nE5, nE5, nE5, nE5
	dc.b nE5, nE5, nE5, nE5, nE5, nE5, nE5, nE5
	dc.b nE5, nE5, nE5, nF5, nF5, nF5, nF5, nF5
	dc.b nF5, nF5, nF5
	sLoop		$00, $03, FunnyAngry_Loop14
	dc.b nE5, nE5, nE5, nE5, nE5, nE5, nE5, nE5
	dc.b nE5, nE5, nE5, nE5, nE5, nE5, nRst, $60
	dc.b nRst, $12, nD5, $06, nCs5, nB4, nG4
	saVolPSG	$FF
	sVolEnvPSG	v05
	sGate		$02

FunnyAngry_Loop15:
	dc.b nB4, $02
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nCs5
	saVolPSG	$04
	dc.b nRst, nCs5
	saVolPSG	$FC
	dc.b nB4
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nRst, $06, nD5, $02
	saVolPSG	$04
	dc.b nRst, nD5
	saVolPSG	$FC
	dc.b nCs5
	saVolPSG	$04
	dc.b nRst, nCs5
	saVolPSG	$FC
	dc.b nB4
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nG4
	saVolPSG	$04
	dc.b nRst, nG4
	saVolPSG	$FC
	sLoop		$00, $08, FunnyAngry_Loop15
	sVolEnvPSG	v0B
	sGate		$03
	dc.b nB3, $06, nD4, nF4, nA4, nRst, $30, nB3
	dc.b $06, nD4, nF4, nA4, nRst, $18, nB3, $06
	dc.b nD4, nF4, nA4, nRst, $30, nB3, $06, nD4
	dc.b nF4, nA4, nRst, $30, nB3, $06, nD4, nF4
	dc.b nA4, nRst, $18, nB3, $06, nD4, nF4, nA4
	dc.b nRst, $18, nB3, $06, nD4, nF4, nB3
	sVolEnvPSG	v05
	sGate		$02

FunnyAngry_Loop16:
	dc.b nB4, $02
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nCs5
	saVolPSG	$04
	dc.b nRst, nCs5
	saVolPSG	$FC
	dc.b nB4
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nRst, $06, nD5, $02
	saVolPSG	$04
	dc.b nRst, nD5
	saVolPSG	$FC
	dc.b nCs5
	saVolPSG	$04
	dc.b nRst, nCs5
	saVolPSG	$FC
	dc.b nB4
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nG4
	saVolPSG	$04
	dc.b nRst, nG4
	saVolPSG	$FC
	sLoop		$00, $10, FunnyAngry_Loop16
	sVolEnvPSG	v0B
	sGate		$03

FunnyAngry_Loop17:
	dc.b nA4, $06, nE4, nD5, nRst, nCs5, nD5, nCs5
	dc.b nA4, nA4, nE4, nE5, nRst, nCs5, nD5, nCs5
	dc.b nA4
	sLoop		$00, $08, FunnyAngry_Loop17
	sVolEnvPSG	v05
	sGate		$02

FunnyAngry_Loop18:
	dc.b nB4, $02
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nCs5
	saVolPSG	$04
	dc.b nRst, nCs5
	saVolPSG	$FC
	dc.b nB4
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nRst, $06, nD5, $02
	saVolPSG	$04
	dc.b nRst, nD5
	saVolPSG	$FC
	dc.b nCs5
	saVolPSG	$04
	dc.b nRst, nCs5
	saVolPSG	$FC
	dc.b nB4
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nG4
	saVolPSG	$04
	dc.b nRst, nG4
	saVolPSG	$FC
	sLoop		$00, $08, FunnyAngry_Loop18
	sVolEnvPSG	v0B
	sGate		$03
	saVolPSG	$01

FunnyAngry_Loop19:
	dc.b nE5, $06, nE5, nE5, nE5, nE5, nE5, nE5
	dc.b nE5, nE5, nE5, nE5, nE5, nE5, nE5, nE5
	dc.b nE5, nE5, nE5, nF5, nF5, nF5, nF5, nF5
	dc.b nF5, nF5, nF5
	sLoop		$00, $03, FunnyAngry_Loop19
	dc.b nE5, nE5, nE5, nE5, nE5, nE5, nE5, nE5
	dc.b nE5, nE5, nE5, nE5, nE5, nE5, nRst, $60
	saVolPSG	$FF
	sVolEnvPSG	v05
	sGate		$02

FunnyAngry_Loop20:
	dc.b nB4, $02
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nCs5
	saVolPSG	$04
	dc.b nRst, nCs5
	saVolPSG	$FC
	dc.b nB4
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nRst, $06, nD5, $02
	saVolPSG	$04
	dc.b nRst, nD5
	saVolPSG	$FC
	dc.b nCs5
	saVolPSG	$04
	dc.b nRst, nCs5
	saVolPSG	$FC
	dc.b nB4
	saVolPSG	$04
	dc.b nRst, nB4
	saVolPSG	$FC
	dc.b nG4
	saVolPSG	$04
	dc.b nRst, nG4
	saVolPSG	$FC
	sLoop		$00, $10, FunnyAngry_Loop20
	sJump		FunnyAngry_Jump5
	dc.b $F2	; Unused

FunnyAngry_PSG3:
	sNoisePSG	$E7
	sGate		$02

FunnyAngry_Loop21:
	dc.b nA5, $06, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5, nA5, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5
	sLoop		$00, $0C, FunnyAngry_Loop21

FunnyAngry_Loop22:
	dc.b nA5, $06, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5, nA5, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5
	sLoop		$00, $22, FunnyAngry_Loop22
	dc.b nA5, $06, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5, nA5, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5, nA5, nRst, nA5, $06, nA5, nA5, nRst
	dc.b nA5, $06, nA5, nA5, nRst, nA5, nA5, nA5
	dc.b nRst, nA5, nA5, nA5, nRst, nA5, nA5, nA5
	dc.b nRst, nA5, nA5, nA5, nRst, nA5, nA5, nA5
	dc.b nRst, nA5, nA5, nA5, nRst, nA5, nA5, nA5
	dc.b $06, nRst, nA5, nA5, nA5, nRst, nA5, nA5
	dc.b nA5, nRst, nA5, nA5, nA5, nRst, nA5, nA5
	dc.b nA5, nRst, nA5, $06, nA5, nA5, nRst, nA5
	dc.b $06, nA5, nA5, nRst, nA5, nA5, nA5, nRst
	dc.b nA5, nA5, nA5, nRst, nA5, nA5, nA5, nRst
	dc.b nA5, nA5, nRst, $60, nRst, $12, nA5, $06
	dc.b nRst, nA5, nA5

FunnyAngry_Loop23:
	dc.b nA5, $06, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5, nA5, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5
	sLoop		$00, $1C, FunnyAngry_Loop23
	dc.b nA5, $06, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5, nA5, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5, nA5, nRst, nA5, $06, nA5, nA5, nRst
	dc.b nA5, $06, nA5, nA5, nRst, nA5, nA5, nA5
	dc.b nRst, nA5, nA5, nA5, nRst, nA5, nA5, nA5
	dc.b nRst, nA5, nA5, nA5, nRst, nA5, nA5, nA5
	dc.b nRst, nA5, nA5, nA5, nRst, nA5, nA5, nA5
	dc.b $06, nRst, nA5, nA5, nA5, nRst, nA5, nA5
	dc.b nA5, nRst, nA5, nA5, nA5, nRst, nA5, nA5
	dc.b nA5, nRst, nA5, $06, nA5, nA5, nRst, nA5
	dc.b $06, nA5, nA5, nRst, nA5, nA5, nA5, nRst
	dc.b nA5, nA5, nA5, nRst, nA5, nA5, nA5, nRst
	dc.b nA5, nA5, nRst, $60

FunnyAngry_Loop24:
	dc.b nA5, $06, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5, nA5, nRst, nA5, nA5, nA5, nRst, nA5
	dc.b nA5
	sLoop		$00, $08, FunnyAngry_Loop24
	sJump		FunnyAngry_Loop22
	dc.b $F2	; Unused

FunnyAngry_DAC:
	sCall		FunnyAngry_Call6
	sLoop		$00, $04, FunnyAngry_DAC

FunnyAngry_Loop25:
	sCall		FunnyAngry_Call6
	sLoop		$00, $0E, FunnyAngry_Loop25
	dc.b d81, $0C, d89, d88, $0C, d8A, $06
	sPan		spLeft
	dc.b d90, $06
	sPan		spCenter
	dc.b d89, $0C, d88, d8A, d8A, $06
	sPan		spLeft
	dc.b d90, $06
	sPan		spCenter

FunnyAngry_Loop26:
	sCall		FunnyAngry_Call6
	sLoop		$00, $04, FunnyAngry_Loop26

FunnyAngry_Loop27:
	sCall		FunnyAngry_Call6
	sLoop		$00, $0A, FunnyAngry_Loop27
	dc.b d81, $0C, d89, d88, $0C, d8A, $06
	sPan		spLeft
	dc.b d90, $06
	sPan		spCenter
	dc.b d89, $0C, d88, d8A, d8A, $06
	sPan		spLeft
	dc.b d90, $06
	sPan		spCenter

FunnyAngry_Loop28:
	sCall		FunnyAngry_Call6
	sLoop		$00, $0E, FunnyAngry_Loop28
	dc.b d81, $0C, d89, d88, $0C, d8A, $06
	sPan		spLeft
	dc.b d90, $06
	sPan		spCenter
	dc.b d89, $0C, d88, d8A, d8A, $06
	sPan		spLeft
	dc.b d90, $06
	sPan		spCenter

FunnyAngry_Loop29:
	sCall		FunnyAngry_Call6
	sLoop		$00, $0E, FunnyAngry_Loop29
	dc.b d81, $0C, d89, d88, $0C, d8A, $06
	sPan		spLeft
	dc.b d90, $06
	sPan		spCenter
	dc.b d89, $0C, d88, d8A, d8A, $06
	sPan		spLeft
	dc.b d90, $06
	sPan		spCenter

FunnyAngry_Loop30:
	sCall		FunnyAngry_Call6
	sLoop		$00, $0F, FunnyAngry_Loop30
	dc.b d81, $0C
	sPan		spRight
	dc.b d92, $0C
	sPan		spCenter
	dc.b d88, $06, d88, d89, d8A
	sPan		spCenter

FunnyAngry_Loop31:
	sCall		FunnyAngry_Call6
	sLoop		$00, $07, FunnyAngry_Loop31
	dc.b d81, $0C
	sPan		spRight
	dc.b d92, $0C
	sPan		spCenter
	dc.b d8A, $06, d8A
	sPan		spLeft
	dc.b d90, $06, d90, $06
	sPan		spCenter
	dc.b d81, $18, d81, d81, d81, d81, d81, d81
	dc.b d81, d81, d81, d81, d81, d81, d81, $18
	dc.b d81, d81, d81, d81, d81, d81, d81, d81
	dc.b d81, d81, $18, d81, d81, $0C, d88, $06
	dc.b d89, d88, d89, nRst, $0C, d8A, $06, d8A
	dc.b d89, d88, $0C, d8A, $06
	sPan		spLeft
	dc.b d90, $06
	sPan		spCenter

FunnyAngry_Loop32:
	sCall		FunnyAngry_Call6
	sLoop		$00, $0E, FunnyAngry_Loop32
	dc.b d81, $0C, d89, d88, $0C, d8A, $06
	sPan		spLeft
	dc.b d90, $06
	sPan		spCenter
	dc.b d89, $0C, d88, d8A, d8A, $06
	sPan		spLeft
	dc.b d90, $06
	sPan		spCenter

FunnyAngry_Loop33:
	sCall		FunnyAngry_Call6
	sLoop		$00, $0E, FunnyAngry_Loop33
	dc.b d81, $0C, d89, d88, $0C, d8A, $06
	sPan		spLeft
	dc.b d90, $06
	sPan		spCenter
	dc.b d89, $0C, d88, d8A, d8A, $06
	sPan		spLeft
	dc.b d90, $06
	sPan		spCenter

FunnyAngry_Loop34:
	sCall		FunnyAngry_Call6
	sLoop		$00, $0F, FunnyAngry_Loop34
	dc.b d81, $0C
	sPan		spRight
	dc.b d92, $0C
	sPan		spCenter
	dc.b d88, $06, d88, d89, d8A

FunnyAngry_Loop35:
	sCall		FunnyAngry_Call6
	sLoop		$00, $07, FunnyAngry_Loop35
	dc.b d81, $0C
	sPan		spRight
	dc.b d92, $0C
	sPan		spCenter
	dc.b d8A, $06, d8A
	sPan		spLeft
	dc.b d90, $06, d90, $06
	sPan		spCenter
	dc.b d81, $18, d81, d81, d81, d81, d81, d81
	dc.b d81, d81, d81, d81, d81, d81, d81, $18
	dc.b d81, d81, d81, d81, d81, d81, d81, d81
	dc.b d81, d81, $18, d81, d81, $0C, d88, $06
	dc.b d89, d88, d89, nRst, $0C

FunnyAngry_Loop36:
	dc.b d81, $0C
	sPan		spLeft
	dc.b d92, $0C
	sPan		spCenter
	dc.b d86, $0C
	sPan		spRight
	dc.b d90, $06, d90, $06
	sPan		spCenter
	sLoop		$00, $10, FunnyAngry_Loop36
	sJump		FunnyAngry_Loop27
	dc.b $F2	; Unused

FunnyAngry_Call6:
	sPan		spCenter
	dc.b d81, $0C
	sPan		spLeft
	dc.b d90, $0C
	sPan		spCenter
	dc.b dB4, $0C
	sPan		spRight
	dc.b d92, $06, d92, $06
	sPan		spCenter
	sRet

FunnyAngry_Patches:

	; Patch $00
	; $3A
	; $00, $03, $00, $02,	$15, $13, $16, $12
	; $0C, $0A, $0B, $0B,	$00, $00, $00, $00
	; $07, $07, $07, $08,	$1F, $16, $2D, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $00, $03, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$15, $16, $13, $12
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0C, $0B, $0A, $0B
	spSustainLv	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$07, $07, $07, $08
	spTotalLv	$1F, $2D, $16, $00

	; Patch $01
	; $3D
	; $01, $21, $51, $01,	$12, $14, $14, $0F
	; $0A, $05, $05, $05,	$00, $00, $00, $00
	; $26, $28, $28, $18,	$19, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $05, $02, $00
	spMultiple	$01, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$12, $14, $14, $0F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0A, $05, $05, $05
	spSustainLv	$02, $02, $02, $01
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$06, $08, $08, $08
	spTotalLv	$19, $00, $00, $00

	; Patch $02
	; $3B
	; $71, $01, $31, $31,	$14, $0F, $0F, $0F
	; $14, $05, $05, $00,	$00, $00, $00, $00
	; $F6, $F6, $06, $07,	$23, $28, $32, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$07, $03, $00, $03
	spMultiple	$01, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$14, $0F, $0F, $0F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$14, $05, $05, $00
	spSustainLv	$0F, $00, $0F, $00
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$06, $06, $06, $07
	spTotalLv	$23, $32, $28, $00

	; Patch $03
	; $16
	; $7A, $74, $3C, $31,	$1F, $1F, $1F, $1F
	; $0A, $08, $0C, $0A,	$07, $0A, $07, $05
	; $25, $A7, $A7, $55,	$14, $85, $8A, $80
	spAlgorithm	$06
	spFeedback	$02
	spDetune	$07, $03, $07, $03
	spMultiple	$0A, $0C, $04, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0A, $0C, $08, $0A
	spSustainLv	$02, $0A, $0A, $05
	spDecayRt	$07, $07, $0A, $05
	spReleaseRt	$05, $07, $07, $05
	spTotalLv	$14, $0A, $05, $00

	; Patch $04
	; $3B
	; $08, $14, $02, $11,	$5F, $CF, $08, $59
	; $0C, $02, $0C, $05,	$04, $04, $04, $07
	; $16, $15, $05, $26,	$1D, $36, $0B, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$00, $00, $01, $01
	spMultiple	$08, $02, $04, $01
	spRateScale	$01, $00, $03, $01
	spAttackRt	$1F, $08, $0F, $19
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0C, $0C, $02, $05
	spSustainLv	$01, $00, $01, $02
	spDecayRt	$04, $04, $04, $07
	spReleaseRt	$06, $05, $05, $06
	spTotalLv	$1D, $0B, $36, $00

	; Patch $05
	; $3C
	; $01, $02, $0F, $04,	$8D, $52, $9F, $1F
	; $09, $00, $00, $0D,	$00, $00, $00, $00
	; $23, $08, $02, $F7,	$15, $80, $1D, $87
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $0F, $02, $04
	spRateScale	$02, $02, $01, $00
	spAttackRt	$0D, $1F, $12, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$09, $00, $00, $0D
	spSustainLv	$02, $00, $00, $0F
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$03, $02, $08, $07
	spTotalLv	$15, $1D, $00, $07

	; Patch $06
	; $3A
	; $32, $02, $02, $72,	$8F, $8F, $4F, $4D
	; $09, $09, $00, $03,	$00, $00, $00, $00
	; $15, $F5, $05, $08,	$19, $1F, $19, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$03, $00, $00, $07
	spMultiple	$02, $02, $02, $02
	spRateScale	$02, $01, $02, $01
	spAttackRt	$0F, $0F, $0F, $0D
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$09, $00, $09, $03
	spSustainLv	$01, $00, $0F, $00
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$05, $05, $05, $08
	spTotalLv	$19, $19, $1F, $00

	; Patch $07
	; $30
	; $30, $30, $30, $30,	$9E, $D8, $DC, $DC
	; $0E, $0A, $04, $05,	$08, $08, $08, $08
	; $B6, $B6, $B6, $B6,	$14, $2C, $12, $80
	spAlgorithm	$00
	spFeedback	$06
	spDetune	$03, $03, $03, $03
	spMultiple	$00, $00, $00, $00
	spRateScale	$02, $03, $03, $03
	spAttackRt	$1E, $1C, $18, $1C
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0E, $04, $0A, $05
	spSustainLv	$0B, $0B, $0B, $0B
	spDecayRt	$08, $08, $08, $08
	spReleaseRt	$06, $06, $06, $06
	spTotalLv	$14, $12, $2C, $00

	; Patch $08
	; $3A
	; $20, $23, $20, $01,	$1E, $1F, $1F, $1F
	; $0A, $0A, $0B, $0A,	$05, $07, $0A, $08
	; $A4, $85, $96, $77,	$21, $25, $28, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$02, $02, $02, $00
	spMultiple	$00, $00, $03, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1E, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0A, $0B, $0A, $0A
	spSustainLv	$0A, $09, $08, $07
	spDecayRt	$05, $0A, $07, $08
	spReleaseRt	$04, $06, $05, $07
	spTotalLv	$21, $28, $25, $00

	; Patch $09
	; $3B
	; $61, $02, $23, $02,	$59, $59, $59, $4A
	; $03, $03, $03, $05,	$00, $00, $00, $00
	; $22, $22, $22, $27,	$1E, $20, $25, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$06, $02, $00, $00
	spMultiple	$01, $03, $02, $02
	spRateScale	$01, $01, $01, $01
	spAttackRt	$19, $19, $19, $0A
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$03, $03, $03, $05
	spSustainLv	$02, $02, $02, $02
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$02, $02, $02, $07
	spTotalLv	$1E, $25, $20, $00

	; Patch $0A
	; $0C
	; $00, $00, $06, $01,	$19, $59, $D9, $59
	; $02, $06, $02, $0C,	$0A, $0A, $09, $0F
	; $14, $15, $02, $A5,	$14, $80, $1A, $80
	spAlgorithm	$04
	spFeedback	$01
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $06, $00, $01
	spRateScale	$00, $03, $01, $01
	spAttackRt	$19, $19, $19, $19
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$02, $02, $06, $0C
	spSustainLv	$01, $00, $01, $0A
	spDecayRt	$0A, $09, $0A, $0F
	spReleaseRt	$04, $02, $05, $05
	spTotalLv	$14, $1A, $00, $00

	; Patch $0B
	; $3B
	; $61, $02, $24, $05,	$5F, $5F, $5F, $4F
	; $03, $03, $03, $07,	$00, $00, $00, $04
	; $23, $22, $22, $27,	$1F, $20, $25, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$06, $02, $00, $00
	spMultiple	$01, $04, $02, $05
	spRateScale	$01, $01, $01, $01
	spAttackRt	$1F, $1F, $1F, $0F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$03, $03, $03, $07
	spSustainLv	$02, $02, $02, $02
	spDecayRt	$00, $00, $00, $04
	spReleaseRt	$03, $02, $02, $07
	spTotalLv	$1F, $25, $20, $00

	; Patch $0C
	; $3D
	; $01, $02, $02, $02,	$10, $50, $50, $50
	; $07, $08, $08, $08,	$01, $00, $00, $00
	; $24, $18, $18, $18,	$1C, $89, $89, $89
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
	spReleaseRt	$04, $08, $08, $08
	spTotalLv	$1C, $09, $09, $09

	; Patch $0D
	; $3C
	; $21, $02, $01, $62,	$CF, $0D, $CF, $0C
	; $00, $04, $00, $04,	$00, $00, $00, $00
	; $02, $37, $02, $38,	$1E, $80, $1F, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$02, $00, $00, $06
	spMultiple	$01, $01, $02, $02
	spRateScale	$03, $03, $00, $00
	spAttackRt	$0F, $0F, $0D, $0C
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $00, $04, $04
	spSustainLv	$00, $00, $03, $03
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$02, $02, $07, $08
	spTotalLv	$1E, $1F, $00, $00

	; Patch $0E
	; $3A
	; $0C, $1F, $01, $13,	$1F, $DF, $1F, $9F
	; $0C, $02, $0C, $05,	$04, $04, $04, $07
	; $1A, $F6, $06, $27,	$1D, $36, $1B, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$00, $00, $01, $01
	spMultiple	$0C, $01, $0F, $03
	spRateScale	$00, $00, $03, $02
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0C, $0C, $02, $05
	spSustainLv	$01, $00, $0F, $02
	spDecayRt	$04, $04, $04, $07
	spReleaseRt	$0A, $06, $06, $07
	spTotalLv	$1D, $1B, $36, $00

	; Patch $0F
	; $3E
	; $34, $00, $75, $02,	$5E, $DF, $5F, $9C
	; $0F, $04, $0F, $0A,	$02, $02, $05, $05
	; $A7, $A2, $FA, $F6,	$28, $80, $A3, $80
	spAlgorithm	$06
	spFeedback	$07
	spDetune	$03, $07, $00, $00
	spMultiple	$04, $05, $00, $02
	spRateScale	$01, $01, $03, $02
	spAttackRt	$1E, $1F, $1F, $1C
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0F, $0F, $04, $0A
	spSustainLv	$0A, $0F, $0A, $0F
	spDecayRt	$02, $05, $02, $05
	spReleaseRt	$07, $0A, $02, $06
	spTotalLv	$28, $23, $00, $00

	; Patch $10
	; $3B
	; $3F, $31, $10, $34,	$0D, $1F, $0E, $1F
	; $0A, $0A, $A0, $04,	$00, $00, $00, $05
	; $53, $A0, $15, $A9,	$26, $1D, $11, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$03, $01, $03, $03
	spMultiple	$0F, $00, $01, $04
	spRateScale	$00, $00, $00, $00
	spAttackRt	$0D, $0E, $1F, $1F
	spAmpMod	$00, $01, $00, $00
	spSustainRt	$0A, $00, $0A, $04
	spSustainLv	$05, $01, $0A, $0A
	spDecayRt	$00, $00, $00, $05
	spReleaseRt	$03, $05, $00, $09
	spTotalLv	$26, $11, $1D, $00

	; Patch $11
	; $3C
	; $62, $24, $13, $46,	$C9, $AE, $C9, $4E
	; $03, $05, $03, $05,	$01, $00, $01, $00
	; $22, $26, $22, $27,	$11, $83, $10, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$06, $01, $02, $04
	spMultiple	$02, $03, $04, $06
	spRateScale	$03, $03, $02, $01
	spAttackRt	$09, $09, $0E, $0E
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$03, $03, $05, $05
	spSustainLv	$02, $02, $02, $02
	spDecayRt	$01, $01, $00, $00
	spReleaseRt	$02, $02, $06, $07
	spTotalLv	$11, $10, $03, $00

	; Patch $12
	; $3C
	; $24, $18, $23, $26,	$59, $4A, $59, $4A
	; $03, $05, $03, $05,	$00, $00, $00, $00
	; $22, $27, $22, $27,	$1C, $85, $19, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$02, $02, $01, $02
	spMultiple	$04, $03, $08, $06
	spRateScale	$01, $01, $01, $01
	spAttackRt	$19, $19, $0A, $0A
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$03, $03, $05, $05
	spSustainLv	$02, $02, $02, $02
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$02, $02, $07, $07
	spTotalLv	$1C, $19, $05, $00

	; Patch $13
	; $3C
	; $0B, $04, $0A, $01,	$1F, $1E, $1F, $1F
	; $0F, $0E, $11, $10,	$13, $0F, $11, $0E
	; $24, $07, $17, $08,	$10, $80, $0B, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$0B, $0A, $04, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1E, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0F, $11, $0E, $10
	spSustainLv	$02, $01, $00, $00
	spDecayRt	$13, $11, $0F, $0E
	spReleaseRt	$04, $07, $07, $08
	spTotalLv	$10, $0B, $00, $00

	; Patch $14
	; $06
	; $02, $34, $73, $32,	$0A, $8C, $4C, $52
	; $00, $00, $00, $00,	$01, $00, $01, $00
	; $03, $05, $26, $06,	$3D, $85, $80, $90
	spAlgorithm	$06
	spFeedback	$00
	spDetune	$00, $07, $03, $03
	spMultiple	$02, $03, $04, $02
	spRateScale	$00, $01, $02, $01
	spAttackRt	$0A, $0C, $0C, $12
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$00, $02, $00, $00
	spDecayRt	$01, $01, $00, $00
	spReleaseRt	$03, $06, $05, $06
	spTotalLv	$3D, $00, $05, $10

	; Patch $15
	; $3A
	; $38, $4A, $40, $31,	$1F, $DF, $5F, $9F
	; $0C, $0A, $0C, $0F,	$04, $04, $04, $0B
	; $1F, $FF, $0F, $3F,	$1E, $31, $0C, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$03, $04, $04, $03
	spMultiple	$08, $00, $0A, $01
	spRateScale	$00, $01, $03, $02
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0C, $0C, $0A, $0F
	spSustainLv	$01, $00, $0F, $03
	spDecayRt	$04, $04, $04, $0B
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1E, $0C, $31, $00

	; Patch $16
	; $40
	; $01, $03, $00, $01,	$15, $13, $16, $12
	; $0C, $0A, $0B, $0B,	$00, $00, $00, $00
	; $07, $07, $07, $08,	$1F, $16, $2D, $80
	spAlgorithm	$00
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $00, $03, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$15, $16, $13, $12
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0C, $0B, $0A, $0B
	spSustainLv	$00, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$07, $07, $07, $08
	spTotalLv	$1F, $2D, $16, $00

	; Patch $17
	; $3B
	; $52, $31, $31, $51,	$0C, $14, $12, $14
	; $0C, $00, $0E, $02,	$0E, $09, $09, $01
	; $46, $03, $54, $3A,	$1C, $18, $1D, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$05, $03, $03, $05
	spMultiple	$02, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$0C, $12, $14, $14
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0C, $0E, $00, $02
	spSustainLv	$04, $05, $00, $03
	spDecayRt	$0E, $09, $09, $01
	spReleaseRt	$06, $04, $03, $0A
	spTotalLv	$1C, $1D, $18, $00

	; Patch $18
	; $0B
	; $02, $01, $0F, $02,	$07, $1F, $09, $1F
	; $05, $02, $0C, $1F,	$00, $04, $00, $00
	; $3F, $0F, $3F, $0F,	$0B, $10, $3A, $80
	spAlgorithm	$03
	spFeedback	$01
	spDetune	$00, $00, $00, $00
	spMultiple	$02, $0F, $01, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$07, $09, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$05, $0C, $02, $1F
	spSustainLv	$03, $03, $00, $00
	spDecayRt	$00, $00, $04, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0B, $3A, $10, $00

	; Patch $19
	; $3E
	; $0F, $02, $32, $72,	$1F, $1F, $1F, $1F
	; $00, $18, $00, $00,	$00, $0F, $0F, $0F
	; $20, $9A, $0C, $04,	$00, $80, $80, $80
	spAlgorithm	$06
	spFeedback	$07
	spDetune	$00, $03, $00, $07
	spMultiple	$0F, $02, $02, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $00, $18, $00
	spSustainLv	$02, $00, $09, $00
	spDecayRt	$00, $0F, $0F, $0F
	spReleaseRt	$00, $0C, $0A, $04
	spTotalLv	$00, $00, $00, $00

	; Patch $1A
	; $3D
	; $01, $21, $51, $01,	$12, $14, $1A, $0F
	; $0A, $07, $07, $07,	$00, $00, $00, $00
	; $2B, $2B, $2B, $18,	$19, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $05, $02, $00
	spMultiple	$01, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$12, $1A, $14, $0F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0A, $07, $07, $07
	spSustainLv	$02, $02, $02, $01
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$0B, $0B, $0B, $08
	spTotalLv	$19, $00, $00, $00
