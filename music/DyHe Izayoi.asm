Izayoi_Header:
	sHeaderInit
	sHeaderPatch	Izayoi_Patches
	sHeaderCh	$06, $03
	sHeaderTempo	$01, $08
	sHeaderDAC	Izayoi_DAC
	sHeaderFM	Izayoi_FM1, $00, $08
	sHeaderFM	Izayoi_FM2, $00, $08
	sHeaderFM	Izayoi_FM3, $00, $0E
	sHeaderFM	Izayoi_FM4, $00, $10
	sHeaderFM	Izayoi_FM5, $00, $15
	sHeaderPSG	Izayoi_PSG1, $DC, $06, $00, v08
	sHeaderPSG	Izayoi_PSG2, $DC, $09, $00, v08
	sHeaderPSG	Izayoi_PSG3, $00, $01, $00, v02

Izayoi_FM1:
	dc.b nRst, $30, nRst, $0F
	sPatFM		$3F
	saVolFM		$02
	ssMod68k	$05, $03, $BE, $A4
	sPanAni		$02, $01, $00, $03, $02
	dc.b nE4, $15
	sModOff
	saVolFM		$FE
	sPatFM		$13
	dc.b nC3, $0C
	sPanAni

Izayoi_Jump1:
	sCall		Izayoi_Call1
	sCall		Izayoi_Call1
	dc.b nRst, $30
	sCall		Izayoi_Call2
	dc.b sHold, $30
	ssMod68k	$00, $01, $0A, $04
	saVolFM		$0A
	dc.b sHold, $0C
	saVolFM		$0A
	dc.b sHold, $0C
	saVolFM		$0A
	dc.b sHold, $0C
	saVolFM		$0A
	dc.b sHold, $0C, nRst, $18
	saVolFM		$D8
	ssMod68k	$1C, $01, $0A, $04
	saVolFM		$07
	saTranspose	$F4
	sCall		Izayoi_Call1
	dc.b nRst, $30
	sCall		Izayoi_Call2
	dc.b sHold, $18
	saVolFM		$07
	saTranspose	$F4
	sPan		spCenter
	sPatFM		$41
	dc.b nA2, $04, nG2, nA2, nB2, nA2, nB2, nC3
	dc.b nB2, nC3, nD3, nC3, nD3
	saVolFM		$FF
	dc.b nE3, nD3, nE3, nFs3, nE3, nFs3, nG3, nFs3
	dc.b nG3, nA3, nG3, nA3, sHold, nAb3, $03, sHold
	dc.b nG3, sHold, nFs3, sHold, nF3, sHold, nE3, sHold
	dc.b nEb3, sHold, nD3, sHold, nCs3, sHold, nC3, sHold
	dc.b nB2, sHold, nBb2, sHold, nA2, sHold, nAb2, sHold
	dc.b nG2
	sPan		spRight
	saVolFM		$01
	sCall		Izayoi_Call3
	sCall		Izayoi_Call4
	sJump		Izayoi_Jump1

Izayoi_Call1:
	sPatFM		$41
	sPan		spRight
	ssMod68k	$0F, $01, $04, $05
	saVolFM		$FA
	sGate		$02
	sPatFM		$44
	dc.b nA2, $06, nA2, nA2, nA2
	sGate		$08
	sPatFM		$41
	dc.b nE3, nD3, nC3
	sGate		$00
	dc.b nD3, sHold, nD3, nC3, nB2, nA2, $0C, nB2
	dc.b $06, nG2, $0C
	sGate		$02
	sPatFM		$44
	dc.b nA2, $06, nA2, nA2, nA2
	sPatFM		$41
	sGate		$08
	dc.b nE3, nD3, nC3
	sGate		$00
	dc.b nD3, sHold, nD3, $30
	sGate		$02
	sPatFM		$44
	dc.b nA2, $06, nA2, nA2, nA2
	sPatFM		$41
	sGate		$08
	dc.b nE3, nD3, nC3
	sGate		$00
	dc.b nD3, sHold, nD3, nC3, nB2, nA2, $0C, nB2
	dc.b $06, nG2, $0C
	sGate		$02
	sPatFM		$44
	dc.b nA2, $06, nA2, nA2, nA2
	sPatFM		$41
	sGate		$08
	dc.b nE3, nD3, nC3
	sGate		$00
	dc.b nD3, sHold, nD3, $30, sHold, nD3, $30
	saVolFM		$06
	sRet

Izayoi_Call2:
	saVolFM		$04
	sPatFM		$06
	sPan		spCenter
	dc.b nA4, $06, nC5, nE5, nG5, $06, sHold, $18
	dc.b sHold, $30, nA4, $06, nC5, nE5, nG5, $0C
	dc.b nFs5, $06, nD5, nFs5, $0C, nE5, $06, nC5
	dc.b nE5, $0C, nD5, $06, nAb4, $0C, nA4, $06
	dc.b nC5, nE5, nG5, $06, sHold, $18, sHold, $30
	dc.b nC5, $06, nE5, nA5, nB5, $0C, nA5, $06
	dc.b nB5, nC6, $0C, nB5, $06, nC6, nD6, $0C
	dc.b nC6, $06, nAb5, $0C
	saVolFM		$FC
	sPatFM		$41
	sPan		spRight
	saTranspose	$0C
	ssMod68k	$1C, $01, $0A, $04
	saVolFM		$F9
	dc.b nD3, $06, nA3, nE4, nD4, sHold, $18, nRst
	dc.b $06, nD4, nC4, nG3, nC4, nB3, nG3, nA3
	dc.b sHold, $06, nFs3, nD3, nG3, $0C, nE3, $06
	dc.b nC3, nFs3, sHold, $06, nD3, nA2, nE3, $0C
	dc.b nC3, $06, nG2, $0C, nF3, $06, nC4, nG4
	dc.b nF4, sHold, $18, nRst, $06, nF4, nEb4, nBb3
	dc.b nEb4, nD4, nBb3, nC4, sHold, $06, nA3, nF3
	dc.b nD4, $0C, nB3, $06, nG3, nE4, sHold, $06
	dc.b nCs4, nA3, nFs4, sHold, $18
	sRet

Izayoi_Call3:
	sPatFM		$41
	saVolFM		$FD

Izayoi_Loop1:
	ssMod68k	$01, $03, $3F, $AF
	dc.b nD4, $06
	ssMod68k	$1C, $01, $0A, $04
	dc.b sHold, nE4, $12, sHold, $18
	ssMod68k	$01, $03, $3F, $AF
	dc.b nF4, $06
	ssMod68k	$1C, $01, $0A, $04
	dc.b sHold, nG4, $12, sHold, $18
	ssMod68k	$01, $03, $3F, $AF
	dc.b nE4, $06
	ssMod68k	$1C, $01, $0A, $04
	dc.b sHold, nFs4, $12, sHold, $18
	ssMod68k	$01, $03, $3F, $AF
	dc.b nEb4, $06
	ssMod68k	$1C, $01, $0A, $04
	dc.b sHold, nF4, $12, sHold, $18
	sLoop		$00, $02, Izayoi_Loop1
	ssMod68k	$01, $03, $3F, $AF
	dc.b nF4, $06
	ssMod68k	$1C, $01, $0A, $04
	dc.b sHold, nG4, $12, sHold, $18
	ssMod68k	$01, $03, $3F, $AF
	dc.b nAb4, $06
	ssMod68k	$1C, $01, $0A, $04
	dc.b sHold, nBb4, $12, sHold, $18
	ssMod68k	$01, $03, $3F, $AF
	dc.b nG4, $06
	ssMod68k	$1C, $01, $0A, $04
	dc.b sHold, nA4, $12, sHold, $18
	ssMod68k	$01, $03, $3F, $AF
	dc.b nFs4, $06
	ssMod68k	$1C, $01, $0A, $04
	dc.b sHold, nAb4, $12, sHold, $18
	ssMod68k	$01, $03, $3F, $AF
	dc.b nF4, $06
	ssMod68k	$1C, $01, $0A, $04
	dc.b sHold, nG4, $12, sHold, $18
	ssMod68k	$01, $03, $3F, $AF
	dc.b nAb4, $06
	ssMod68k	$1C, $01, $0A, $04
	dc.b sHold, nBb4, $12, sHold, $18
	ssMod68k	$01, $03, $3F, $AF
	dc.b nG4, $06
	ssMod68k	$1C, $01, $0A, $04
	dc.b sHold, nA4, $12, sHold, $18
	ssMod68k	$01, $03, $3F, $AF
	dc.b nFs4, $06
	ssMod68k	$1C, $01, $0A, $04
	dc.b sHold, nAb4, $24, sHold, $0C
	saVolFM		$03
	sRet

Izayoi_Call4:
	sPatFM		$42
	sPan		spRight
	saTranspose	$0C
	ssMod68k	$1C, $01, $0A, $04
	saVolFM		$FD
	sPan		spCenter
	dc.b nBb2, $06, nE4, $0C, nBb2, $06, nFs4, $18
	dc.b sHold, $30, nG4, $06, nFs4, nE4, nD4, nE3
	dc.b nC4, nRst, nD4
	sPatFM		$41
	saVolFM		$FB
	sPan		spLeft
	dc.b nB3, $03, nC4, nB3, nC4, nB3, $0C
	sPan		spRight
	dc.b nC4, $03, nB3, nA3, nG3, nFs3, nE3, nEb3
	dc.b nD3
	saVolFM		$05
	sPatFM		$42
	sPan		spCenter
	dc.b nBb2, $06, nE4, $0C, nBb2, $06, nFs4, $18
	dc.b sHold, $30, nG4, $06, nFs4, nE4, nD4, nE3
	dc.b nC4, nRst, nD4
	saVolFM		$FE
	dc.b nG5, $03, nC5, nEb5, nC5, nFs5, $03, nB4
	dc.b nD5, nB4, nF5, $03, nBb4, nCs5, nBb4, nE5
	dc.b $03, nA4, nC5, nA4
	saVolFM		$02
	sPan		spCenter
	dc.b nBb2, $06, nE4, $0C, nBb2, $06, nFs4, $18
	dc.b sHold, $30, nG4, $06, nFs4, nE4, nD4, nE3
	dc.b nC4, nRst, nD4
	sPatFM		$41
	saVolFM		$FB
	sPan		spRight
	dc.b nB3, $03, nC4, nB3, nC4, nB3, $0C
	sPan		spLeft
	dc.b nC4, $03, nB3, nA3, nG3, nFs3, nE3, nEb3
	dc.b nD3
	saVolFM		$05
	sPatFM		$42
	sPan		spCenter
	dc.b nBb2, $06, nE4, $0C, nBb2, $06, nFs4, $0C
	dc.b nC3, $06, nG4, $0C, nC3, $06, nA4, $0C
	dc.b nEb3, $06, nBb4, $0C, nEb3, $06, nC5, $30
	dc.b sHold, $30, nCs5, $06, nC5, nBb4, nAb4, nBb4
	dc.b nFs4, nRst
	saVolFM		$FD
	dc.b nAb4
	saVolFM		$01
	ssMod68k	$14, $02, $DF, $AF
	dc.b sHold, $60
	saVolFM		$02
	saTranspose	$F4
	ssMod68k	$1C, $01, $0A, $04
	saVolFM		$03
	sRet
	dc.b $E0, $C0, $80, $30, $80, $80, $18, $EF	; Unused
	dc.b $30, $E0, $C0, $FB, $0C, $F0, $04, $03	; Unused
	dc.b $43, $03, $BD, $0C, $F0, $04, $01, $0A	; Unused
	dc.b $05, $E7, $BF, $30, $E6, $02, $E7, $BE	; Unused
	dc.b $02, $E7, $BD, $E6, $03, $E7, $BC, $E7	; Unused
	dc.b $BB, $E6, $04, $E7, $BA, $E7, $B9, $FB	; Unused
	dc.b $F4, $E6, $F7, $80, $30, $80, $FB, $0C	; Unused
	dc.b $EF, $3C, $E6, $08, $B1, $04, $A5, $A7	; Unused
	dc.b $B3, $04, $A5, $A7, $B5, $04, $A5, $A7	; Unused
	dc.b $B6, $04, $A5, $A7, $B8, $04, $A5, $A7	; Unused
	dc.b $BA, $04, $A5, $A7, $BD, $04, $A5, $A7	; Unused
	dc.b $BF, $04, $A5, $A7, $FB, $F4, $E6, $F8	; Unused
	dc.b $80, $30, $80, $EF, $30, $F0, $0F, $01	; Unused
	dc.b $04, $05, $E6, $00, $C2, $04, $BF, $C4	; Unused
	dc.b $BF, $BC, $BF, $F7, $00, $03, $FF, $F5	; Unused
	dc.b $BD, $BA, $BC, $BA, $B6, $BA, $E6, $00	; Unused
	dc.b $80, $30, $80, $EF, $42, $FB, $0C, $E6	; Unused
	dc.b $FD, $F0, $0F, $01, $04, $05, $BD, $06	; Unused
	dc.b $F0, $05, $02, $32, $32, $B8, $0C, $F7	; Unused
	dc.b $00, $05, $FF, $EE, $F0, $0F, $01, $04	; Unused
	dc.b $05, $BD, $06, $FB, $F4, $E6, $03, $F9	; Unused
	dc.b $E0, $40, $F0, $0F, $01, $04, $05, $EF	; Unused
	dc.b $41, $E6, $FB, $A2, $12, $A7, $06, $80	; Unused
	dc.b $0C, $E6, $05, $E0, $C0, $EF, $1E, $E6	; Unused
	dc.b $FB, $AA, $06, $AB, $E6, $05, $E0, $40	; Unused
	dc.b $EF, $41, $E6, $FB, $A0, $12, $A7, $06	; Unused
	dc.b $80, $0C, $E6, $05, $E0, $C0, $EF, $1E	; Unused
	dc.b $E6, $FB, $A8, $06, $A9, $80, $E6, $05	; Unused
	dc.b $E0, $40, $EF, $41, $E6, $FB, $9F, $12	; Unused
	dc.b $A0, $05, $80, $13, $E6, $05, $E0, $C0	; Unused
	dc.b $EF, $30, $E6, $02, $AE, $06, $BA, $03	; Unused
	dc.b $B5, $01, $B6, $E7, $B7, $E7, $B8, $05	; Unused
	dc.b $80, $07, $BA, $04, $80, $02, $E6, $FE	; Unused
	dc.b $E0, $40, $EF, $41, $E6, $FB, $A2, $06	; Unused
	dc.b $80, $0C, $E6, $05, $F7, $00, $03, $FF	; Unused
	dc.b $90, $E6, $FB, $A2, $12, $A7, $06, $80	; Unused
	dc.b $0C, $E6, $05, $E0, $C0, $EF, $1E, $E6	; Unused
	dc.b $FB, $AA, $06, $AB, $E6, $05, $E0, $40	; Unused
	dc.b $EF, $41, $E6, $FB, $A0, $12, $A7, $06	; Unused
	dc.b $80, $0C, $E6, $05, $E0, $C0, $EF, $1E	; Unused
	dc.b $E6, $FB, $A8, $06, $A9, $80, $E6, $05	; Unused
	dc.b $E0, $40, $EF, $41, $E6, $FB, $9F, $12	; Unused
	dc.b $A0, $0C, $A4, $F0, $01, $03, $E5, $A0	; Unused
	dc.b $E4, $02, $03, $01, $03, $02, $E7, $30	; Unused
	dc.b $E6, $05, $FD, $E4, $00, $F9, $EF, $41	; Unused
	dc.b $E0, $40, $F0, $0F, $01, $04, $05, $E6	; Unused
	dc.b $FB, $80, $0C, $A5, $12, $A7, $A5, $A7	; Unused
	dc.b $1E, $80, $0C, $A5, $10, $80, $02, $A7	; Unused
	dc.b $12, $AC, $06, $AB, $A7, $A5, $1E, $F7	; Unused
	dc.b $00, $04, $FC, $C9, $E6, $05, $F9, $E0	; Unused
	dc.b $40, $F0, $0F, $01, $04, $05, $EF, $41	; Unused
	dc.b $E6, $FB, $A9, $08, $A9, $04, $AB, $06	; Unused
	dc.b $80, $AC, $80, $AB, $80, $AC, $80, $AB	; Unused
	dc.b $08, $AE, $04, $80, $0C, $08, $A9, $04	; Unused
	dc.b $E7, $A9, $08, $A9, $04, $AB, $06, $80	; Unused
	dc.b $AC, $80, $AB, $80, $AC, $80, $AB, $08	; Unused
	dc.b $A9, $04, $80, $0C, $08, $A9, $04, $E7	; Unused
	dc.b $A9, $08, $A9, $04, $AB, $06, $80, $AC	; Unused
	dc.b $80, $AB, $80, $AC, $80, $AB, $08, $AE	; Unused
	dc.b $04, $80, $0C, $08, $A9, $04, $E7, $A9	; Unused
	dc.b $08, $A9, $04, $AB, $06, $80, $AC, $80	; Unused
	dc.b $AB, $80, $AC, $80, $AB, $08, $A9, $04	; Unused
	dc.b $F7, $00, $02, $FF, $CE, $80, $0C, $08	; Unused
	dc.b $80, $04, $A9, $08, $A9, $04, $AB, $06	; Unused
	dc.b $80, $AC, $80, $AB, $80, $AC, $80, $AB	; Unused
	dc.b $08, $AE, $04, $80, $0C, $08, $A9, $04	; Unused
	dc.b $E7, $A9, $08, $A9, $04, $AB, $06, $80	; Unused
	dc.b $AC, $80, $EF, $41, $A7, $0C, $F0, $01	; Unused
	dc.b $03, $E5, $A0, $E4, $02, $02, $00, $03	; Unused
	dc.b $02, $E7, $30, $FD, $E4, $00, $E6, $05	; Unused
	dc.b $F9	; Unused

Izayoi_FM2:
	dc.b nRst, $30, nRst

Izayoi_Jump2:
	saVolFM		$FE
	sPatFM		$08
	sGate		$00
	dc.b nA2, $06, nA2, nRst, $24, nRst, $30
	saVolFM		$02
	ssMod68k	$01, $01, $60, $03
	ssLFO		$0C, $5A
	sPatFM		$1F
	sGate		$01
	saVolFM		$04
	dc.b nA2, $06, nA3, nA2, nA3
	ssLFO		$00, $00
	sGate		$00
	sModOff
	saVolFM		$FC
	dc.b nRst, $18, nRst, $30
	saVolFM		$FE
	sPatFM		$08
	dc.b nA2, $06, nA2, nRst, $24, nRst, $30
	saVolFM		$02
	ssMod68k	$01, $01, $60, $03
	ssLFO		$0C, $5A
	sPatFM		$1F
	sGate		$01
	saVolFM		$04
	dc.b nA2, $06, nA3, nA2, nA3
	ssLFO		$00, $00
	sGate		$00
	sModOff
	saVolFM		$FC
	dc.b nRst, $12
	saVolFM		$FC
	sPatFM		$41
	dc.b nA3, $06
	ssMod68k	$01, $05, $E5, $A0
	sPanAni		$01, $01, $01, $03, $01
	dc.b sHold, $30, sHold, $30
	sModOff
	sPanAni
	saVolFM		$04
	saVolFM		$01
	sPatFM		$43

Izayoi_Loop2:
	dc.b nA2, $06
	sLoop		$00, $17, Izayoi_Loop2
	dc.b nD3, $06
	ssMod68k	$14, $01, $DF, $AF
	dc.b sHold, $18
	sModOff
	dc.b nD3, $06, nD3, nD2, nD3

Izayoi_Loop3:
	dc.b nA2, $06
	sLoop		$00, $17, Izayoi_Loop3
	dc.b nD3, $06, sHold, $30, sHold, $30, nRst, $30

Izayoi_Loop4:
	dc.b nA2, $06, nA2, nA2, nA2, nA2, $06, nA2
	dc.b nA2, nA2, nA2, nC3, sHold, $0C, nG2, $18
	dc.b nA2, $06, nA2, nA2, nA2, nA2, $06, nA2
	dc.b nA2, nA2, nA2, nE3, sHold, $0C, nEb3, $06
	dc.b nEb2, nE3, nE2
	sLoop		$00, $02, Izayoi_Loop4
	dc.b nD3, $06, nD3, nD2, nD3, $0C, nD3, $06
	dc.b nD2, nD3, sHold, $06, nD3, nD2, nD3, $0C
	dc.b nD3, $06, nD2, nD3, nD3, $06, nD3, nD2
	dc.b nD3, $0C, nD3, $06, nD2, nD3, sHold, $06
	dc.b nD3, nD2, nD3, $0C, nD3, $06, nD2, nD3
	dc.b nF3, $06, nF3, nF2, nF3, $0C, nF3, $06
	dc.b nF2, nF3, sHold, $06, nF3, nF2, nF3, $0C
	dc.b nF3, $06, nF2, nC3, sHold, $06, nC2, nC2
	dc.b nD3, $0C, nD2, $06, nD2, nE3, sHold, $06
	dc.b nE2, nE2, nFs3, sHold, $18, sHold, $18, nFs3
	dc.b $02, sHold, nF3, sHold, nE3, sHold, nEb3, sHold
	dc.b nD3, sHold, nCs3, sHold, nC3, sHold, nB2, sHold
	dc.b nBb2, sHold, nA2, sHold, nAb2, sHold, nG2, sHold
	dc.b nFs2, sHold, nF2, sHold, nE2, sHold, nEb2, sHold
	dc.b nD2, sHold, nCs2, nRst, $24, nRst, $18

Izayoi_Loop5:
	dc.b nA2, $06
	sLoop		$00, $17, Izayoi_Loop5
	dc.b nD3, $06
	ssMod68k	$14, $01, $DF, $AF
	dc.b sHold, $18
	sModOff
	dc.b nD3, $06, nD3, nD2, nD3

Izayoi_Loop6:
	dc.b nA2, $06
	sLoop		$00, $17, Izayoi_Loop6
	dc.b nD3, $06, sHold, $30, sHold, $30, nRst, $30

Izayoi_Loop7:
	dc.b nA2, $06, nA2, nA2, nA2, nA2, $06, nA2
	dc.b nA2, nA2, nA2, nC3, sHold, $0C, nG2, $18
	dc.b nA2, $06, nA2, nA2, nA2, nA2, $06, nA2
	dc.b nA2, nA2, nA2, nE3, sHold, $0C, nEb3, $06
	dc.b nEb2, nE3, nE2
	sLoop		$00, $02, Izayoi_Loop7
	dc.b nD3, $06, nD3, nD2, nD3, $0C, nD3, $06
	dc.b nD2, nD3, sHold, $06, nD3, nD2, nD3, $0C
	dc.b nD3, $06, nD2, nD3, nD3, $06, nD3, nD2
	dc.b nD3, $0C, nD3, $06, nD2, nD3, sHold, $06
	dc.b nD3, nD2, nD3, $0C, nD3, $06, nD2, nD3
	dc.b nF3, $06, nF3, nF2, nF3, $0C, nF3, $06
	dc.b nF2, nF3, sHold, $06, nF3, nF2, nF3, $0C
	dc.b nF3, $06, nF2, nC3, sHold, $06, nC2, nC2
	dc.b nD3, $0C, nD2, $06, nD2, nE3, sHold, $06
	dc.b nE2, nE2, nFs3, sHold, $18, sHold, $18, nFs3
	dc.b $02, sHold, nF3, sHold, nE3, sHold, nEb3, sHold
	dc.b nD3, sHold, nCs3, sHold, nC3, sHold, nB2, sHold
	dc.b nBb2, sHold, nA2, sHold, nAb2, sHold, nG2, sHold
	dc.b nFs2, sHold, nF2, sHold, nE2, sHold, nEb2, sHold
	dc.b nD2, sHold, nCs2, nRst, $24, nRst, $30, nRst
	dc.b $12

Izayoi_Loop8:
	saVolFM		$FE
	dc.b nA2, $0C
	saVolFM		$02
	dc.b nA2, $06, nA2, nA2
	saVolFM		$FE
	dc.b nA2, nA1, nRst, nA2, $0C
	saVolFM		$02
	dc.b nA2, $06, nA2, nA2, nA2
	saVolFM		$FE
	dc.b nA3, nA2
	saVolFM		$02
	sLoop		$00, $04, Izayoi_Loop8

Izayoi_Loop9:
	saVolFM		$FE
	dc.b nC3, $0C
	saVolFM		$02
	dc.b nC3, $06, nC3, nC3
	saVolFM		$FE
	dc.b nC3, nC2, nRst, nC3, $0C
	saVolFM		$02
	dc.b nC3, $06, nC3, nC3, nC3
	saVolFM		$FE
	dc.b nC4, nC3
	saVolFM		$02
	sLoop		$00, $03, Izayoi_Loop9
	saVolFM		$FE
	dc.b nC3, $0C
	saVolFM		$02
	dc.b nC3, $06, nC3, nC3
	saVolFM		$FE
	dc.b nC3, nC2, nRst, nC3, $0C
	saVolFM		$02
	dc.b nC3, $06, nC3, nC3, nC3
	saVolFM		$FE
	dc.b nC4, nC3, $0C
	saVolFM		$02

Izayoi_Loop10:
	dc.b nA2, $12, nA2, $06, nA2, $18, nA2, $06
	dc.b nA2, nA2, nA2, nA2, $06, nA2, nA2, nA2
	dc.b nA2, $06, nA2, nA2, nA2, nA2, $06, nA2
	dc.b nA2, nA2, nA2, $06, nA2, nA2, nA2, nA2
	dc.b $06, nA2, nA2, nA2
	sLoop		$00, $03, Izayoi_Loop10
	dc.b nA2, $12, nA2, $06, nA2, $0C, nC3, $12
	dc.b nC3, $06, nC3, $0C, nEb3, $12, nEb3, $06
	dc.b nEb3, $06, nEb2, nEb3, nEb2, nEb3, $06, nEb2
	dc.b nEb3, nEb2, nEb3, nEb3, nEb3, $03, nD3, nCs3
	dc.b nC3, nBb2, nA2, nAb2, nG2, nF2, nE2, nEb2
	dc.b nD2, nEb3, $06, nEb3, nRst, $18, nRst, $06
	ssMod68k	$14, $01, $DF, $AF
	dc.b nE3, $06, sHold, $60
	sModOff
	saVolFM		$FF
	sJump		Izayoi_Jump2
	dc.b $F2, $F8, $00, $A2, $E6, $FD, $EF, $43	; Unused
	dc.b $A2, $12, $A7, $06, $80, $18, $A0, $12	; Unused
	dc.b $A7, $06, $80, $18, $80, $06, $9F, $12	; Unused
	dc.b $A0, $05, $80, $13, $80, $18, $06, $A2	; Unused
	dc.b $80, $0C, $F7, $00, $03, $A2, $12, $A7	; Unused
	dc.b $06, $80, $18, $A0, $12, $A7, $06, $80	; Unused
	dc.b $18, $80, $06, $9F, $12, $A0, $0C, $9D	; Unused
	dc.b $E7, $30, $F8, $00, $96, $F8, $00, $93	; Unused
	dc.b $EF, $08, $E8, $00, $A7, $06, $B3, $B1	; Unused
	dc.b $A7, $B0, $AE, $A7, $0C, $AE, $06, $AC	; Unused
	dc.b $A7, $0C, $B0, $06, $A7, $B1, $B3, $F7	; Unused
	dc.b $00, $04, $FD, $9B, $E6, $04, $EF, $43	; Unused
	dc.b $F8, $00, $43, $F8, $00, $40, $E6, $FC	; Unused
	dc.b $F8, $00, $8D, $EF, $43, $A2, $16, $A7	; Unused
	dc.b $06, $80, $18, $A0, $12, $A7, $06, $80	; Unused
	dc.b $18, $80, $06, $9F, $12, $A0, $05, $80	; Unused
	dc.b $13, $80, $18, $06, $A2, $80, $0C, $A2	; Unused
	dc.b $12, $A7, $06, $80, $18, $A0, $12, $A7	; Unused
	dc.b $06, $80, $18, $80, $06, $9F, $12, $A0	; Unused
	dc.b $0C, $9D, $E7, $30, $F8, $00, $34, $F8	; Unused
	dc.b $00, $31, $F6, $FC, $8F, $AA, $06, $9E	; Unused
	dc.b $AA, $9E, $AA, $9E, $AA, $9E, $A9, $9D	; Unused
	dc.b $A9, $9D, $A7, $9B, $F7, $00, $0A, $FF	; Unused
	dc.b $FA, $AA, $06, $9E, $AA, $9E, $AA, $9E	; Unused
	dc.b $AA, $9E, $A9, $9D, $A9, $9D, $A8, $9C	; Unused
	dc.b $A8, $9C, $A7, $9B, $F7, $00, $08, $FF	; Unused
	dc.b $FA, $F9, $EF, $08, $E8, $00, $A2, $06	; Unused
	dc.b $A2, $A2, $A2, $F7, $00, $07, $FF, $F3	; Unused
	dc.b $A2, $9F, $A0, $A1, $A2, $06, $A2, $A2	; Unused
	dc.b $A2, $F7, $00, $06, $FF, $F7, $A2, $AE	; Unused
	dc.b $AD, $AC, $AB, $A7, $A8, $A9, $F9, $E0	; Unused
	dc.b $80, $F0, $0F, $01, $04, $05, $EF, $41	; Unused
	dc.b $E6, $FE, $A2, $08, $A2, $04, $A2, $06	; Unused
	dc.b $80, $A2, $80, $A2, $80, $A2, $80, $A2	; Unused
	dc.b $08, $A2, $04, $80, $0C, $08, $A2, $04	; Unused
	dc.b $E7, $A2, $08, $A2, $04, $A2, $06, $80	; Unused
	dc.b $A2, $80, $A2, $80, $A2, $80, $A2, $08	; Unused
	dc.b $A2, $04, $80, $0C, $08, $A2, $04, $E7	; Unused
	dc.b $A2, $08, $A2, $04, $A2, $06, $80, $A2	; Unused
	dc.b $80, $A2, $80, $A2, $80, $A2, $08, $A2	; Unused
	dc.b $04, $80, $0C, $08, $A2, $04, $E7, $A2	; Unused
	dc.b $08, $A2, $04, $A2, $06, $80, $A2, $80	; Unused
	dc.b $A2, $80, $A2, $80, $A2, $08, $A2, $04	; Unused
	dc.b $80, $14, $E6, $02, $E0, $C0, $F9	; Unused

Izayoi_FM3:
	dc.b nRst, $30, nRst

Izayoi_Jump3:
	sCall		Izayoi_Call5
	sCall		Izayoi_Call6
	dc.b nRst, $30
	sCall		Izayoi_Call7
	sCall		Izayoi_Call8
	dc.b sHold, $12, nRst, $06, nRst, $30, nRst, $18
	saVolFM		$03
	saTranspose	$F4
	sCall		Izayoi_Call6
	dc.b nRst, $30
	sCall		Izayoi_Call7
	sCall		Izayoi_Call8
	saVolFM		$03
	saTranspose	$F4
	sPan		spCenter
	saVolFM		$FF
	sPatFM		$41
	dc.b nC3, $04, nB2, nC3, nD3, nC3, nD3, nE3
	dc.b nD3, nE3, nFs3, nE3, nFs3, nG3, nFs3, nG3
	dc.b nA3, nG3, nA3
	saVolFM		$FF
	dc.b nB3, nA3, nB3, nC4, nB3, nC4, sHold, nB3
	dc.b $03, sHold, nBb3, sHold, nA3, sHold, nAb3, sHold
	dc.b nG3, sHold, nFs3, sHold, nF3, sHold, nE3, sHold
	dc.b nEb3, sHold, nD3, sHold, nCs3, sHold, nC3, sHold
	dc.b nB2, sHold, nBb2
	saVolFM		$02
	sCall		Izayoi_Call9
	sJump		Izayoi_Jump3
	dc.b $F8, $00, $7C, $F8, $00, $E4, $F8, $00	; Unused
	dc.b $0B, $F8, $01, $3E, $F8, $00, $DB, $F6	; Unused
	dc.b $FF, $80, $F2	; Unused

Izayoi_Call5:
	sPatFM		$42
	sPan		spLeft
	ssMod68k	$0C, $01, $05, $03
	saVolFM		$FA
	saTranspose	$0C
	sGate		$02
	dc.b nA1, $06, nA1, nA1, nA1
	sGate		$08
	dc.b nB3, nA3, nG3
	sGate		$00
	dc.b nA3, sHold, nA3, nG3, nFs3, nE3, $0C, nFs3
	dc.b $06, nD3, $0C
	sGate		$02
	dc.b nA1, $06, nA1, nA1, nA1
	sGate		$08
	dc.b nB3, nA3, nG3
	sGate		$00
	dc.b nA3, sHold, nA3, $30
	sGate		$02
	dc.b nA1, $06, nA1, nA1, nA1
	sGate		$08
	dc.b nB3, nA3, nG3
	sGate		$00
	dc.b nA3, sHold, nA3, nG3, nFs3, nE3, $0C, nFs3
	dc.b $06, nD3, $0C
	sGate		$02
	dc.b nA1, $06, nA1, nA1, nA1
	sGate		$08
	dc.b nB3, nA3, nG3
	sGate		$00
	dc.b nA3, sHold, nA3, $30, sHold, nA3, $30
	saVolFM		$06
	saTranspose	$F4
	sRet

Izayoi_Call6:
	sPatFM		$42
	sPan		spLeft
	ssMod68k	$0C, $01, $05, $03
	saVolFM		$FA
	saTranspose	$0C
	sGate		$05
	dc.b nE2, $06, nE2, nE2, nE2
	sGate		$08
	dc.b nB3, nA3, nG3
	sGate		$00
	dc.b nA3, sHold, nA3, nG3, nFs3, nE3, $0C, nFs3
	dc.b $06, nD3, $0C
	sGate		$05
	dc.b nE2, $06, nE2, nE2, nE2
	sGate		$08
	dc.b nB3, nA3, nG3
	sGate		$00
	dc.b nA3, sHold, nA3, $30
	sGate		$05
	dc.b nE2, $06, nE2, nE2, nE2
	sGate		$08
	dc.b nB3, nA3, nG3
	sGate		$00
	dc.b nA3, sHold, nA3, nG3, nFs3, nE3, $0C, nFs3
	dc.b $06, nD3, $0C
	sGate		$05
	dc.b nE2, $06, nE2, nE2, nE2
	sGate		$08
	dc.b nB3, nA3, nG3
	sGate		$00
	dc.b nA3, sHold, nA3, $30, sHold, nA3, $30
	saVolFM		$06
	saTranspose	$F4
	sRet

Izayoi_Call7:
	sPatFM		$41
	sPan		spRight
	ssMod68k	$0F, $01, $04, $05
	saVolFM		$FB

Izayoi_Loop11:
	sGate		$05
	saVolFM		$FE
	dc.b nA2, $06
	saVolFM		$02
	dc.b nA2, nA2
	saVolFM		$FE
	dc.b nA2
	saVolFM		$02
	dc.b nA2, nA2
	saVolFM		$FE
	dc.b nA2
	saVolFM		$02
	dc.b nA2
	sGate		$08
	dc.b nA2
	saVolFM		$FE
	dc.b nC3, sHold, $0C
	sGate		$00
	saVolFM		$02
	dc.b nG2, $18
	sGate		$05
	saVolFM		$FE
	dc.b nA2, $06
	saVolFM		$02
	dc.b nA2, nA2
	saVolFM		$FE
	dc.b nA2
	saVolFM		$02
	dc.b nA2, nA2
	saVolFM		$FE
	dc.b nA2
	saVolFM		$02
	dc.b nA2
	sGate		$08
	dc.b nA2
	saVolFM		$FE
	dc.b nE3, sHold, $0C
	sGate		$00
	dc.b nEb3, $06, nRst, nE3, nRst
	saVolFM		$02
	sLoop		$00, $02, Izayoi_Loop11
	saVolFM		$05
	sRet

Izayoi_Call8:
	sPatFM		$42
	sPan		spLeft
	saTranspose	$0C
	ssMod68k	$1C, $01, $0A, $04
	saVolFM		$FC
	dc.b nA2, $30
	sPatFM		$1F
	sGate		$01
	dc.b nA2, $06
	sPatFM		$42
	sGate		$00
	dc.b nA2
	sPatFM		$1F
	sGate		$01
	dc.b nA2, nD4
	sPatFM		$42
	sGate		$00
	dc.b nA2, $0C
	sPatFM		$1F
	sGate		$01
	dc.b nA2, $06
	sPatFM		$42
	sGate		$00
	dc.b nA2, sHold, $18
	sPatFM		$1F
	sGate		$01
	dc.b nA2, $06
	sPatFM		$42
	sGate		$00
	dc.b nA2
	sPatFM		$1F
	sGate		$01
	dc.b nA2
	sPatFM		$42
	sGate		$00
	dc.b nA2, sHold, $0C
	sPatFM		$1F
	sGate		$01
	dc.b nA2, $06
	sPatFM		$42
	sGate		$00
	dc.b nA2, $06, sHold, $18, nC3, $30
	sPatFM		$1F
	sGate		$01
	dc.b nC3, $06
	sPatFM		$42
	sGate		$00
	dc.b nC3
	sPatFM		$1F
	sGate		$01
	dc.b nC3, nC4
	sPatFM		$42
	sGate		$00
	dc.b nC3, $0C
	sPatFM		$1F
	sGate		$01
	dc.b nC3, $06
	sPatFM		$42
	sGate		$00
	dc.b nF2, sHold, $0C
	sPatFM		$1F
	sGate		$01
	dc.b nF2, $06
	saVolFM		$FF
	sPatFM		$42
	sGate		$00
	dc.b nG2, $12
	saVolFM		$01
	sPatFM		$1F
	sGate		$01
	dc.b nG2, $06
	saVolFM		$FE
	sPatFM		$42
	sGate		$00
	dc.b nA2, $12
	saVolFM		$02
	sPatFM		$1F
	sGate		$01
	dc.b nA2, $06
	saVolFM		$FD
	sPatFM		$42
	sGate		$00
	dc.b nB2, $06, sHold, $18, sHold, $18
	saVolFM		$04
	sRet

Izayoi_Call9:
	sPatFM		$41
	sPan		spLeft
	ssMod68k	$1C, $01, $0A, $04
	saVolFM		$F8

Izayoi_Loop12:
	dc.b nA4, $06, sHold, $24, sHold, $06, nC5, $06
	dc.b sHold, $24, sHold, $06, nB4, $06, sHold, $24
	dc.b sHold, $06, nBb4, $06, sHold, $24, sHold, $06
	sLoop		$00, $02, Izayoi_Loop12
	dc.b nC5, $06, sHold, $24, sHold, $06, nEb5, $06
	dc.b sHold, $24, sHold, $06, nD5, $06, sHold, $24
	dc.b sHold, $06, nCs5, $06, sHold, $24, sHold, $06
	dc.b nC5, $06, sHold, $24, sHold, $06, nEb5, $06
	dc.b sHold, $24, sHold, $06, nD5, $06, sHold, $24
	dc.b sHold, $06, nCs5, $06, sHold, $30
	saVolFM		$08
	sPan		spCenter
	dc.b nRst, $06, nC4, $0C, nRst, $06, nD4, $18
	dc.b sHold, $30, nEb4, $06, nD4, nC4, nA3, nC4
	dc.b nG3, nRst, nA3
	saVolFM		$FA
	sPatFM		$42
	sPan		spLeft
	dc.b nFs4, $03, nG4, nFs4, nG4, nFs4, $0C
	saVolFM		$06
	dc.b nRst, $18
	sPatFM		$41
	sPan		spCenter
	dc.b nRst, $06, nC4, $0C, nRst, $06, nD4, $18
	dc.b sHold, $30, nEb4, $06, nD4, nC4, nA3, nC4
	dc.b nG3, nRst, nA3, nRst, $30, nRst, $06, nC4
	dc.b $0C, nRst, $06, nD4, $18, sHold, $30, nEb4
	dc.b $06, nD4, nC4, nA3, nC4, nG3, nRst, nA3
	saVolFM		$FA
	sPatFM		$42
	sPan		spRight
	dc.b nFs4, $03, nG4, nFs4, nG4, nFs4, $0C
	saVolFM		$06
	dc.b nRst, $18
	sPatFM		$41
	sPan		spCenter
	dc.b nRst, $06, nC4, $0C, nRst, $06, nD4, $0C
	dc.b nRst, $06, nEb4, $0C, nRst, $06, nF4, $0C
	dc.b nRst, $06, nFs4, $0C, nRst, $06, nAb4, $30
	dc.b sHold, $30
	ssMod68k	$1C, $01, $0A, $04
	dc.b nA4, $06, nAb4, nFs4, nEb4, nFs4, nCs4, nRst
	saVolFM		$FD
	dc.b nEb4, $06
	saVolFM		$01
	ssMod68k	$14, $02, $DF, $AF
	dc.b sHold, $60
	saVolFM		$02
	ssMod68k	$1C, $01, $0A, $04
	sRet
	dc.b $B1, $30, $B0, $18, $AE, $12, $AA, $36	; Unused
	dc.b $E7, $18, $80, $06, $A7, $AA, $AE, $B1	; Unused
	dc.b $30, $B0, $18, $AF, $12, $AE, $36, $E7	; Unused
	dc.b $18, $80, $06, $A7, $AA, $AE, $B1, $30	; Unused
	dc.b $B0, $18, $AE, $12, $AA, $36, $E7, $18	; Unused
	dc.b $80, $06, $A7, $AA, $AE, $B1, $30, $B0	; Unused
	dc.b $18, $AF, $12, $AE, $36, $E7, $30, $E6	; Unused
	dc.b $09, $FB, $F4, $F9, $E0, $80, $F0, $0C	; Unused
	dc.b $01, $05, $03, $EF, $41, $E6, $FA, $A9	; Unused
	dc.b $12, $AE, $06, $80, $0C, $E6, $06, $E0	; Unused
	dc.b $C0, $EF, $1E, $E6, $FB, $B2, $06, $B3	; Unused
	dc.b $E6, $05, $E0, $80, $EF, $41, $E6, $FA	; Unused
	dc.b $A7, $12, $AE, $06, $80, $0C, $E6, $06	; Unused
	dc.b $E0, $C0, $EF, $1E, $E6, $FB, $B0, $06	; Unused
	dc.b $B1, $80, $E6, $05, $E0, $80, $EF, $41	; Unused
	dc.b $E6, $FA, $A6, $12, $A7, $05, $80, $13	; Unused
	dc.b $E6, $06, $F0, $01, $01, $60, $03, $E9	; Unused
	dc.b $0C, $5A, $E6, $FA, $EF, $1F, $E8, $01	; Unused
	dc.b $A0, $06, $B3, $A0, $A0, $B3, $E6, $06	; Unused
	dc.b $E9, $00, $00, $E8, $00, $F0, $0C, $01	; Unused
	dc.b $05, $03, $EF, $41, $E6, $FA, $A9, $06	; Unused
	dc.b $80, $0C, $E6, $06, $F7, $00, $03, $FC	; Unused
	dc.b $E4, $E6, $FA, $A9, $12, $AE, $06, $80	; Unused
	dc.b $0C, $E6, $06, $E0, $C0, $EF, $1E, $E6	; Unused
	dc.b $FB, $B2, $06, $B3, $E6, $05, $E0, $80	; Unused
	dc.b $EF, $41, $E6, $FA, $A7, $12, $AE, $06	; Unused
	dc.b $80, $0C, $E6, $06, $E0, $C0, $EF, $1E	; Unused
	dc.b $E6, $FB, $B0, $06, $B1, $80, $E6, $05	; Unused
	dc.b $E0, $80, $EF, $41, $E6, $FA, $A6, $12	; Unused
	dc.b $A7, $0C, $A7, $F0, $01, $03, $E5, $A0	; Unused
	dc.b $E4, $02, $02, $00, $03, $02, $E7, $30	; Unused
	dc.b $E6, $06, $FD, $E4, $00, $F9, $EF, $42	; Unused
	dc.b $E0, $80, $F0, $0C, $01, $05, $03, $E6	; Unused
	dc.b $FA, $A2, $18, $0C, $80, $06, $A2, $80	; Unused
	dc.b $0C, $A2, $80, $18, $A2, $0C, $80, $A2	; Unused
	dc.b $80, $A7, $06, $A7, $A2, $A0, $1E, $F7	; Unused
	dc.b $00, $04, $FC, $DA, $E6, $06, $F9, $E0	; Unused
	dc.b $80, $F0, $0F, $01, $04, $05, $EF, $41	; Unused
	dc.b $E6, $FA, $A2, $08, $A2, $04, $A2, $06	; Unused
	dc.b $80, $A2, $80, $A2, $80, $A2, $80, $A2	; Unused
	dc.b $08, $A2, $04, $80, $0C, $08, $A2, $04	; Unused
	dc.b $E7, $A2, $08, $A2, $04, $A2, $06, $80	; Unused
	dc.b $A2, $80, $A2, $80, $A2, $80, $A2, $08	; Unused
	dc.b $A2, $04, $80, $0C, $08, $A2, $04, $E7	; Unused
	dc.b $A2, $08, $A2, $04, $A2, $06, $80, $A2	; Unused
	dc.b $80, $A2, $80, $A2, $80, $A2, $08, $A2	; Unused
	dc.b $04, $80, $0C, $08, $A2, $04, $E7, $A2	; Unused
	dc.b $08, $A2, $04, $A2, $06, $80, $A2, $80	; Unused
	dc.b $A2, $80, $A2, $80, $A2, $08, $A2, $04	; Unused
	dc.b $80, $0C, $08, $80, $04, $A2, $08, $A2	; Unused
	dc.b $04, $A2, $06, $80, $A2, $80, $A2, $80	; Unused
	dc.b $A2, $80, $A2, $08, $A2, $04, $80, $0C	; Unused
	dc.b $08, $A2, $04, $E7, $A2, $08, $A2, $04	; Unused
	dc.b $A2, $06, $80, $A2, $80, $EF, $41, $A4	; Unused
	dc.b $0C, $F0, $01, $03, $E5, $A0, $E4, $02	; Unused
	dc.b $03, $01, $03, $02, $E7, $30, $FD, $E4	; Unused
	dc.b $00, $E6, $06, $F9	; Unused

Izayoi_FM4:
	dc.b nRst, $30, nRst

Izayoi_Jump4:
	dc.b nRst, $30, nRst, nRst, $30, nRst, nRst, $30
	dc.b nRst, nRst, $24, nRst, $06
	saVolFM		$FC
	sPatFM		$1F
	dc.b nA3, $06
	ssMod68k	$01, $05, $E5, $A0
	sPanAni		$01, $03, $01, $01, $01
	dc.b sHold, $30, sHold, $30
	sModOff
	sPanAni
	saVolFM		$04
	sCall		Izayoi_Call10
	sCall		Izayoi_Call11
	sCall		Izayoi_Call12
	dc.b sHold, $12, nRst, $06, nRst, $30, nRst, $18
	saTranspose	$F4
	sCall		Izayoi_Call10
	sCall		Izayoi_Call11
	sCall		Izayoi_Call12
	dc.b nRst, $18, nRst, $30, nRst, $18
	saTranspose	$F4
	dc.b nRst, $30
	sCall		Izayoi_Call13
	sCall		Izayoi_Call14
	sJump		Izayoi_Jump4
	dc.b $F2, $EF, $41, $E0, $80, $F0, $1C, $01	; Unused
	dc.b $0A, $04, $E6, $FD, $E6, $03	; Unused

Izayoi_Call10:
	dc.b nRst, $30, nRst, nRst, $30, nRst, nRst, $30
	dc.b nRst, nRst, $30, nRst, nRst, $30, nRst
	sRet

Izayoi_Call11:
	sPatFM		$41
	sPan		spLeft
	ssMod68k	$0F, $01, $04, $05
	saVolFM		$F9

Izayoi_Loop13:
	sGate		$05
	saVolFM		$FE
	dc.b nE3, $06
	saVolFM		$02
	dc.b nE3, nE3
	saVolFM		$FE
	dc.b nE3
	saVolFM		$02
	dc.b nE3, nE3
	saVolFM		$FE
	dc.b nE3
	saVolFM		$02
	dc.b nE3
	sGate		$08
	dc.b nE3
	saVolFM		$FE
	dc.b nG3, sHold, $0C
	sGate		$00
	saVolFM		$02
	dc.b nC3, $18
	sGate		$05
	saVolFM		$FE
	dc.b nE3, $06
	saVolFM		$02
	dc.b nE3, nE3
	saVolFM		$FE
	dc.b nE3
	saVolFM		$02
	dc.b nE3, nE3
	saVolFM		$FE
	dc.b nE3
	saVolFM		$02
	dc.b nE3
	sGate		$08
	dc.b nE3
	saVolFM		$FE
	dc.b nB3, sHold, $0C
	sGate		$00
	dc.b nBb3, $06, nRst, nB3, nRst
	saVolFM		$02
	sLoop		$00, $02, Izayoi_Loop13
	saVolFM		$07
	sRet

Izayoi_Call12:
	sPatFM		$42
	sPan		spCenter
	saTranspose	$0C
	ssMod68k	$1C, $01, $0A, $04
	dc.b nD3, $30
	sPatFM		$1F
	sGate		$01
	dc.b nD3, $06
	sPatFM		$42
	sGate		$00
	dc.b nD3
	sPatFM		$1F
	sGate		$01
	dc.b nD3, nD4
	sPatFM		$42
	sGate		$00
	dc.b nD3, $0C
	sPatFM		$1F
	sGate		$01
	dc.b nD3, $06
	sPatFM		$42
	sGate		$00
	dc.b nD3, sHold, $18
	sPatFM		$1F
	sGate		$01
	dc.b nD3, $06
	sPatFM		$42
	sGate		$00
	dc.b nD3
	sPatFM		$1F
	sGate		$01
	dc.b nD3
	sPatFM		$42
	sGate		$00
	dc.b nD3, sHold, $0C
	sPatFM		$1F
	sGate		$01
	dc.b nD3, $06
	sPatFM		$42
	sGate		$00
	dc.b nD3, $06, sHold, $18, nF3, $30
	sPatFM		$1F
	sGate		$01
	dc.b nF3, $06
	sPatFM		$42
	sGate		$00
	dc.b nF3
	sPatFM		$1F
	sGate		$01
	dc.b nF3, nF4
	sPatFM		$42
	sGate		$00
	dc.b nF3, $0C
	sPatFM		$1F
	sGate		$01
	dc.b nF3, $06
	sPatFM		$42
	sGate		$00
	dc.b nA2, sHold, $0C
	sPatFM		$1F
	sGate		$01
	dc.b nA2, $06
	saVolFM		$FF
	sPatFM		$42
	sGate		$00
	dc.b nB2, $12
	saVolFM		$01
	sPatFM		$1F
	sGate		$01
	dc.b nB2, $06
	saVolFM		$FE
	sPatFM		$42
	sGate		$00
	dc.b nCs3, $12
	saVolFM		$02
	sPatFM		$1F
	sGate		$01
	dc.b nCs3, $06
	saVolFM		$FD
	sPatFM		$42
	sGate		$00
	dc.b nEb3, $06, sHold, $18, sHold, $18
	saVolFM		$03
	sRet

Izayoi_Call13:
	dc.b nRst, $30, nRst, nRst, $30, nRst, nRst, $30
	dc.b nRst, nRst, $30, nRst, nRst, $30, nRst, nRst
	dc.b $30, nRst, nRst, $30, nRst, nRst, $30, nRst
	sRet

Izayoi_Call14:
	dc.b nRst, $30, nRst, nRst, $30, nRst, nRst, $30
	dc.b nRst, nRst, $30, nRst, nRst, $30, nRst, nRst
	dc.b $30, nRst, nRst, $30, nRst, nRst, $30, nRst
	dc.b nRst, $30, nRst, nRst, $30
	sRet

Izayoi_FM5:
	dc.b nRst, $12
	sPan		spCenter
	sJump		Izayoi_FM1
	dc.b $F2	; Unused

Izayoi_PSG1:
	dc.b nRst, $30, nRst

Izayoi_Jump5:
	sCall		Izayoi_Call15
	sCall		Izayoi_Call16
	sCall		Izayoi_Call17
	sCall		Izayoi_Call18
	dc.b sHold, $12, nRst, $06, nRst, $30, nRst, $18
	sCall		Izayoi_Call16
	sCall		Izayoi_Call17
	sCall		Izayoi_Call18
	dc.b nRst, $18, nRst, $30, nRst, $18, nRst, $2A
	sCall		Izayoi_Call19
	sCall		Izayoi_Call20
	sJump		Izayoi_Jump5
	dc.b $F2	; Unused

Izayoi_Call15:
	saTranspose	$0C
	ssMod68k	$0C, $02, $02, $03
	sVolEnvPSG	v08
	dc.b nRst, $30, nRst, nRst, $30, nRst, nRst, $30
	dc.b nRst, nRst, $30, nRst, nRst
	saTranspose	$F4
	sRet

Izayoi_Call16:
	saTranspose	$0C
	ssMod68k	$0C, $02, $02, $03
	sVolEnvPSG	v08
	dc.b nRst, $30, nRst, nRst, $30, nRst, nRst, $30
	dc.b nRst, nRst, $30, nRst, nRst, $30, nRst
	saTranspose	$F4
	sRet

Izayoi_Call17:
	saTranspose	$0C
	ssMod68k	$0C, $02, $02, $03

Izayoi_Loop14:
	sVolEnvPSG	v08
	sGate		$05
	saVolPSG	$FE
	dc.b nE3, $06
	saVolPSG	$02
	dc.b nE3, nE3
	saVolPSG	$FE
	dc.b nE3
	saVolPSG	$02
	dc.b nE3, nE3
	saVolPSG	$FE
	dc.b nE3
	saVolPSG	$02
	dc.b nE3
	sGate		$08
	dc.b nE3
	saVolPSG	$FE
	dc.b nG3, sHold, $0C
	sGate		$00
	saVolPSG	$02
	dc.b nC3, $18
	sGate		$05
	saVolPSG	$FE
	dc.b nE3, $06
	saVolPSG	$02
	dc.b nE3, nE3
	saVolPSG	$FE
	dc.b nE3
	saVolPSG	$02
	dc.b nE3, nE3
	saVolPSG	$FE
	dc.b nE3
	saVolPSG	$02
	dc.b nE3
	sGate		$08
	dc.b nE3
	saVolPSG	$FE
	dc.b nB3, sHold, $0C
	sGate		$00
	dc.b nBb3, $06, nRst, nB3, nRst
	saVolPSG	$02
	sLoop		$00, $02, Izayoi_Loop14
	saTranspose	$F4
	sRet

Izayoi_Call18:
	saTranspose	$0C
	ssMod68k	$0C, $02, $02, $03
	sVolEnvPSG	v08
	dc.b nD3, $30
	sGate		$01
	dc.b nD3, $06
	sGate		$00
	dc.b nD3
	sGate		$01
	dc.b nD3, nD4
	sGate		$00
	dc.b nD3, $0C
	sGate		$01
	dc.b nD3, $06
	sGate		$00
	dc.b nD3, sHold, $18
	sGate		$01
	dc.b nD3, $06
	sGate		$00
	dc.b nD3
	sGate		$01
	dc.b nD3
	sGate		$00
	dc.b nD3, sHold, $0C
	sGate		$01
	dc.b nD3, $06
	sGate		$00
	dc.b nD3, $06, sHold, $18, nF3, $30
	sGate		$01
	dc.b nF3, $06
	sGate		$00
	dc.b nF3
	sGate		$01
	dc.b nF3, nF4
	sGate		$00
	dc.b nF3, $0C
	sGate		$01
	dc.b nF3, $06
	sGate		$00
	dc.b nA2, sHold, $0C
	sGate		$01
	dc.b nA2, $06
	saVolPSG	$FF
	sGate		$00
	dc.b nB2, $12
	saVolPSG	$01
	sGate		$01
	dc.b nB2, $06
	saVolPSG	$FE
	sGate		$00
	dc.b nCs3, $12
	saVolPSG	$02
	sGate		$01
	dc.b nCs3, $06
	saVolPSG	$FD
	sGate		$00
	dc.b nEb3, $06, sHold, $18, sHold, $18
	saVolPSG	$03
	saTranspose	$F4
	sRet

Izayoi_Call19:
	ssMod68k	$1C, $02, $03, $02
	saTranspose	$0C
	saVolPSG	$FD
	sVolEnvPSG	v00

Izayoi_Loop15:
	dc.b nE4, $06, sHold, $24, sHold, $06, nG4, $06
	dc.b sHold, $24, sHold, $06, nFs4, $06, sHold, $24
	dc.b sHold, $06, nF4, $06, sHold, $24, sHold, $06
	sLoop		$00, $02, Izayoi_Loop15
	dc.b nG4, $06, sHold, $24, sHold, $06, nBb4, $06
	dc.b sHold, $24, sHold, $06, nA4, $06, sHold, $24
	dc.b sHold, $06, nAb4, $06, sHold, $24, sHold, $06
	dc.b nG4, $06, sHold, $24, sHold, $06, nBb4, $06
	dc.b sHold, $24, sHold, $06, nA4, $06, sHold, $24
	dc.b sHold, $06, nAb4, $06, sHold, $30
	saVolPSG	$03
	saTranspose	$F4
	sRet

Izayoi_Call20:
	dc.b nRst, $30, nRst, nRst, $30, nRst, nRst, $30
	dc.b nRst, nRst, $30, nRst, nRst, $30, nRst, nRst
	dc.b $30, nRst, nRst, $30, nRst, nRst, $30, nRst
	dc.b nRst, $30, nRst, nRst, $30
	sRet

Izayoi_PSG2:
	dc.b nRst, $09
	sJump		Izayoi_PSG1
	dc.b $F2	; Unused

Izayoi_PSG3:
	sNoisePSG	$E7
	dc.b nRst, $30, nRst

Izayoi_Jump6:
	dc.b nRst, $30, nRst, nRst, nRst, nRst, $30, nRst
	dc.b nRst, nRst, nRst, $30, nRst, nRst, nRst, nRst
	dc.b nRst, $30, nRst, nRst, nRst, nRst, $30, nRst
	dc.b nRst, $30, nRst, nRst, nRst

Izayoi_Loop16:
	sVolEnvPSG	v01
	sGate		$02
	dc.b nA5, $06, nA5, nA5, nA5
	sLoop		$00, $1D, Izayoi_Loop16

Izayoi_Loop17:
	sVolEnvPSG	v01
	sGate		$14
	dc.b nA5, $0C, nA5, nA5, nA5
	sLoop		$00, $09, Izayoi_Loop17
	dc.b nRst, $30

Izayoi_Loop18:
	sVolEnvPSG	v01
	sGate		$02
	dc.b nA5, $06, nA5, nA5, nA5
	sLoop		$00, $10, Izayoi_Loop18

Izayoi_Loop19:
	sVolEnvPSG	v01
	sGate		$14
	dc.b nA5, $0C, nA5, nA5, nA5
	sLoop		$00, $0B, Izayoi_Loop19
	dc.b nRst, $18

Izayoi_Loop20:
	sVolEnvPSG	v01
	sGate		$0F
	dc.b nA5, $18
	sLoop		$00, $18, Izayoi_Loop20

Izayoi_Loop21:
	sGate		$02
	dc.b nA5, $06, nA5, nA5, nA5
	sLoop		$00, $08, Izayoi_Loop21

Izayoi_Loop22:
	sVolEnvPSG	v01
	sGate		$14
	dc.b nA5, $0C, nA5, nA5, nA5
	sLoop		$00, $10, Izayoi_Loop22
	dc.b nA5, $06, nA5, nA5, nA5, nA5, nA5, nRst
	sGate		$1E
	dc.b nA5, $06, sHold, $18, nRst, nRst, $30
	sJump		Izayoi_Jump6
	dc.b $F2	; Unused

Izayoi_DAC:
	dc.b dC1, $08, dC2, dC3, dA5, $04, dA6, dA7
	dc.b dC1, dC1, dC2, d81, $03, d81, d81, d81
	dc.b dC3, $0C, nRst, $0C, dC1, $0C

Izayoi_Jump7:
	dc.b dC0, $06, dC0, nRst, $24, nRst, $30, nRst
	dc.b nRst, $18, d89, $06, dC1, dC2, dC3, d81
	dc.b $06, d81, dC0, $0C, nRst, $18, nRst, $30
	dc.b nRst, nRst, nRst, $24, dC0, $02, dC2, $0A

Izayoi_Loop23:
	dc.b d81, $0C, dC0, d81, $06, d81, dC0, $0C
	sLoop		$00, $06, Izayoi_Loop23
	dc.b d81, $0C, dC0, d81, $06, dC1, dC2, d8C
	dc.b nRst, $30, d81, $06, dC0, $03, dC0, dC3
	dc.b $0C, d81, $06, dC0, $03, dC0, dC0, dC0
	dc.b dC0, dC0, dC0, $06, d82, dC0, d82, dC0
	dc.b dA5, d86, $03, d86, dC2, $06, d81, $0C
	dc.b dC0, d81, $06, d81, dC0, $0C, d81, $06
	dc.b d8C, $0C, dC0, $06, d81, d81, dC0, $0C
	dc.b d81, $0C, dC0, d81, $06, d81, dC0, $0C
	dc.b d81, $06, d8C, $0C, dC0, $06, d81, $0C
	dc.b dC0, d81, $0C, dC0, d81, $06, d81, dC0
	dc.b $0C, d81, $06, d8C, $0C, dC0, $06, d81
	dc.b d81, dC0, $0C, d81, $0C, dC0, d81, $06
	dc.b d81, dC0, $0C, d81, $06, d8C, $0C, dC0
	dc.b $06, d81, dC0, dC0, dC0, d81, $0C, dC0
	dc.b d81, dC0, d81, $0C, dC0, d81, $06, d81
	dc.b dC0, $06, d81, nRst, d81, dC0, d81, nRst
	dc.b d81, dC0, d81, nRst, d81, dC0, d81, nRst
	dc.b d81, dC0, $0C, d81, $0C, dC0, d81, dC0
	dc.b d81, $0C, dC0, d81, $06, d81, dC0, $06
	dc.b d81, nRst, d81, dC0, d81, nRst, d81, dC0
	dc.b d81, nRst, d81, dC0, d8C, nRst, $18, nRst
	dc.b $18, d82, $03, d82, dC0, $06, dC0, dC0
	dc.b dC0, $06, dC0, dC0, dC0, dC0, dC0, d89
	dc.b d89, dC1, dC1, dC2, dC3

Izayoi_Loop24:
	dc.b d81, $0C, dC0, d81, $06, d81, dC0, $0C
	sLoop		$00, $06, Izayoi_Loop24
	dc.b d81, $0C, dC0, d81, $06, dC1, dC2, d8C
	dc.b nRst, $30, d81, $06, dC0, $03, dC0, dC3
	dc.b $0C, d81, $06, dC0, $03, dC0, dC0, dC0
	dc.b dC0, dC0, dC0, $06, d82, dC0, d82, dC0
	dc.b d82, d86, $03, d86, dC2, $06, d81, $0C
	dc.b dC0, d81, $06, d81, dC0, $0C, d81, $06
	dc.b d8C, $0C, dC0, $06, d81, d81, dC0, $0C
	dc.b d81, $0C, dC0, d81, $06, d81, dC0, $0C
	dc.b d81, $06, d8C, $0C, dC0, $06, d81, $0C
	dc.b dC0, d81, $0C, dC0, d81, $06, d81, dC0
	dc.b $0C, d81, $06, d8C, $0C, dC0, $06, d81
	dc.b d81, dC0, $0C, d81, $0C, dC0, d81, $06
	dc.b d81, dC0, $0C, d81, $06, d8C, $0C, dC0
	dc.b $06, d81, dC0, dC0, dC0, d81, $0C, dC0
	dc.b d81, dC0, d81, $0C, dC0, d81, $06, d81
	dc.b dC0, $06, d81, nRst, d81, dC0, d81, nRst
	dc.b d81, dC0, d81, nRst, d81, dC0, d81, nRst
	dc.b d81, dC0, $0C, d81, $0C, dC0, d81, dC0
	dc.b d81, $0C, dC0, d81, $06, d81, dC0, $06
	dc.b d81, nRst, d81, dC0, d81, nRst, d81, dC0
	dc.b d81, nRst, d81, dC0, d8C, nRst, $18, nRst
	dc.b $18, d8C, $0C, nRst, nRst, $30, nRst, $0C
	dc.b dC0, $04, dC0, d8C, nRst, $18, d8C, $06
	dc.b dC0, $03, dC0, dC1, $06, d8C, $06, nRst
	dc.b d81, dC0, $0C, d81, dC0, $06, d8C, $06
	dc.b nRst, d81, dC0, $0C, d81, dC0, $06, d8C
	dc.b $06, nRst, d81, dC0, $0C, d81, dC0, $06
	dc.b d8C, $06, nRst, d81, dC0, $0C, d81, dC0
	dc.b $06, d8C, $06, nRst, d81, dC0, $0C, d81
	dc.b dC0, $06, d8C, $06, nRst, d81, dC0, $0C
	dc.b d81, dC0, $06, d8C, $06, nRst, d81, dC0
	dc.b $0C, d81, dC0, $06, d8C, $06, nRst, d81
	dc.b dC0, d81, dC0, dC0, dC0, d8C, $06, nRst
	dc.b d81, dC0, $0C, d81, dC0, $06, d8C, $06
	dc.b nRst, d81, dC0, $0C, d81, dC0, $06, d8C
	dc.b $06, nRst, d81, dC0, $0C, d81, dC0, $06
	dc.b d8C, $06, nRst, d81, dC0, $0C, d81, dC0
	dc.b $06, d8C, $06, nRst, d81, dC0, $0C, d81
	dc.b dC0, $06, d8C, $06, nRst, d81, dC0, $0C
	dc.b d81, dC0, $06, d8C, $06, nRst, d81, dC0
	dc.b $0C, d81, dC0, $06, d8C, $06, nRst, dC0
	dc.b dC0, dC0, dC0, dC0, dC0, dC0

Izayoi_Loop25:
	dc.b d81, $0C, dC0, d81, dC0, d81, dC0, d81
	dc.b $06, d81, dC0, $0C, d81, $0C, dC0, d81
	dc.b $06, d81, dC0, d8C, nRst, d81, dC0, $0C
	dc.b d81, $06, d81, dC0, $0C
	sLoop		$00, $03, Izayoi_Loop25
	dc.b d81, $06, d8C, $0C, d81, $06, dC0, dC0
	dc.b d81, $06, d8C, $0C, d81, $06, dC0, dC0
	dc.b d81, $06, d8C, $0C, d81, $06, d8C, $0C
	dc.b dC0, d81, $06, d81, dC0, $0C, d81, $06
	dc.b d81, dC0, $0C, d81, $06, d81, dC0, $0C
	dc.b dC0, $06, dC0, dC0, dC0, dC0, dC0, nRst
	dc.b d8C, nRst, $06, d81, dC0, $0C, d81, dC1
	dc.b d82, $04, d82, d82, d82, d82, d82, dC0
	dc.b dC0, dC0, dC0, dC0, dC0
	sJump		Izayoi_Jump7
	dc.b $F2, $81, $06, $82, $82, $0C, $F8, $01	; Unused
	dc.b $2A, $F8, $01, $27, $F8, $01, $24, $81	; Unused
	dc.b $06, $84, $82, $84, $81, $84, $82, $84	; Unused
	dc.b $81, $84, $82, $84, $81, $84, $82, $84	; Unused
	dc.b $82, $06, $84, $81, $82, $84, $81, $82	; Unused
	dc.b $84, $81, $82, $84, $81, $89, $8A, $82	; Unused
	dc.b $0C, $81, $0C, $82, $81, $82, $81, $82	; Unused
	dc.b $81, $82, $81, $82, $81, $82, $81, $82	; Unused
	dc.b $81, $82, $01, $8A, $0B, $F7, $00, $03	; Unused
	dc.b $FD, $F2, $81, $0C, $82, $81, $82, $81	; Unused
	dc.b $82, $81, $82, $81, $82, $81, $82, $81	; Unused
	dc.b $06, $87, $82, $87, $82, $04, $82, $82	; Unused
	dc.b $82, $82, $82, $81, $0C, $82, $F7, $00	; Unused
	dc.b $1E, $FF, $F9, $87, $02, $88, $04, $87	; Unused
	dc.b $02, $88, $04, $87, $02, $89, $04, $87	; Unused
	dc.b $02, $89, $04, $87, $02, $8A, $04, $87	; Unused
	dc.b $02, $8A, $04, $86, $02, $82, $04, $86	; Unused
	dc.b $02, $82, $04, $81, $06, $84, $82, $84	; Unused
	dc.b $F7, $00, $0F, $FF, $F7, $81, $06, $82	; Unused
	dc.b $82, $0C, $F8, $00, $96, $F8, $00, $93	; Unused
	dc.b $F8, $00, $90, $81, $06, $84, $82, $84	; Unused
	dc.b $81, $84, $82, $84, $81, $84, $82, $84	; Unused
	dc.b $81, $84, $82, $84, $82, $06, $84, $81	; Unused
	dc.b $82, $84, $81, $82, $84, $81, $82, $84	; Unused
	dc.b $81, $89, $8A, $82, $0C, $81, $0C, $84	; Unused
	dc.b $82, $84, $81, $84, $82, $84, $08, $81	; Unused
	dc.b $0C, $81, $04, $84, $0C, $82, $84, $F7	; Unused
	dc.b $00, $03, $FF, $EF, $81, $0C, $87, $04	; Unused
	dc.b $87, $87, $82, $0C, $84, $08, $81, $0C	; Unused
	dc.b $81, $04, $82, $0C, $81, $0C, $82, $F7	; Unused
	dc.b $00, $0D, $FF, $F9, $81, $06, $87, $82	; Unused
	dc.b $87, $82, $04, $82, $82, $82, $82, $82	; Unused
	dc.b $81, $0C, $82, $F7, $00, $1D, $FF, $F9	; Unused
	dc.b $81, $0C, $82, $04, $82, $82, $82, $02	; Unused
	dc.b $89, $04, $82, $02, $88, $04, $82, $02	; Unused
	dc.b $89, $04, $82, $02, $89, $04, $87, $02	; Unused
	dc.b $8A, $04, $87, $02, $8A, $04, $86, $02	; Unused
	dc.b $82, $04, $86, $02, $82, $04, $F6, $FC	; Unused
	dc.b $21, $F2, $81, $06, $84, $82, $84, $F7	; Unused
	dc.b $00, $07, $FF, $F7, $81, $06, $82, $8A	; Unused
	dc.b $0C, $F9	; Unused

Izayoi_Patches:

	; Patch $00
	; $06
	; $01, $33, $72, $31,	$0A, $8C, $4C, $52
	; $00, $00, $00, $00,	$01, $00, $01, $00
	; $03, $05, $26, $06,	$4D, $87, $80, $91
	spAlgorithm	$06
	spFeedback	$00
	spDetune	$00, $07, $03, $03
	spMultiple	$01, $02, $03, $01
	spRateScale	$00, $01, $02, $01
	spAttackRt	$0A, $0C, $0C, $12
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$00, $02, $00, $00
	spDecayRt	$01, $01, $00, $00
	spReleaseRt	$03, $06, $05, $06
	spTotalLv	$4D, $00, $07, $11

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
	; $15
	; $71, $72, $31, $31,	$0F, $12, $0F, $0F
	; $00, $0F, $09, $0A,	$01, $02, $01, $01
	; $06, $A7, $06, $07,	$32, $80, $A8, $80
	spAlgorithm	$05
	spFeedback	$02
	spDetune	$07, $03, $07, $03
	spMultiple	$01, $01, $02, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$0F, $0F, $12, $0F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $09, $0F, $0A
	spSustainLv	$00, $00, $0A, $00
	spDecayRt	$01, $01, $02, $01
	spReleaseRt	$06, $06, $07, $07
	spTotalLv	$32, $28, $00, $00

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

	; Patch $05
	; $3E
	; $0F, $02, $32, $72,	$1F, $1F, $1F, $1F
	; $00, $18, $00, $00,	$00, $0F, $0F, $0F
	; $20, $97, $08, $08,	$00, $80, $80, $80
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
	spReleaseRt	$00, $08, $07, $08
	spTotalLv	$00, $00, $00, $00

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
	; $30, $3A, $30, $30,	$9E, $D8, $DC, $DC
	; $0E, $0A, $04, $05,	$08, $08, $08, $08
	; $B6, $B6, $B6, $B6,	$14, $2F, $14, $80
	spAlgorithm	$00
	spFeedback	$06
	spDetune	$03, $03, $03, $03
	spMultiple	$00, $00, $0A, $00
	spRateScale	$02, $03, $03, $03
	spAttackRt	$1E, $1C, $18, $1C
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0E, $04, $0A, $05
	spSustainLv	$0B, $0B, $0B, $0B
	spDecayRt	$08, $08, $08, $08
	spReleaseRt	$06, $06, $06, $06
	spTotalLv	$14, $14, $2F, $00

	; Patch $08
	; $3A
	; $60, $66, $60, $61,	$1F, $94, $1F, $1F
	; $0F, $10, $05, $0D,	$07, $06, $06, $07
	; $2F, $4F, $1F, $5F,	$21, $14, $22, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$06, $06, $06, $06
	spMultiple	$00, $00, $06, $01
	spRateScale	$00, $00, $02, $00
	spAttackRt	$1F, $1F, $14, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0F, $05, $10, $0D
	spSustainLv	$02, $01, $04, $05
	spDecayRt	$07, $06, $06, $07
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$21, $22, $14, $00

	; Patch $09
	; $3C
	; $52, $36, $63, $52,	$DF, $59, $CF, $8A
	; $0A, $0A, $01, $05,	$14, $14, $0A, $14
	; $AF, $5F, $AF, $5F,	$1E, $85, $28, $82
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$05, $06, $03, $05
	spMultiple	$02, $03, $06, $02
	spRateScale	$03, $03, $01, $02
	spAttackRt	$1F, $0F, $19, $0A
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0A, $01, $0A, $05
	spSustainLv	$0A, $0A, $05, $05
	spDecayRt	$14, $0A, $14, $14
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1E, $28, $05, $02

	; Patch $0A
	; $0C
	; $00, $00, $06, $01,	$1B, $59, $DA, $59
	; $02, $06, $02, $0C,	$0A, $0A, $09, $0F
	; $14, $15, $02, $A5,	$14, $80, $1A, $80
	spAlgorithm	$04
	spFeedback	$01
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $06, $00, $01
	spRateScale	$00, $03, $01, $01
	spAttackRt	$1B, $1A, $19, $19
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
	; $34
	; $33, $41, $7E, $74,	$5B, $9F, $5F, $1F
	; $04, $07, $07, $08,	$00, $00, $00, $00
	; $FF, $FF, $EF, $FF,	$23, $90, $29, $97
	spAlgorithm	$04
	spFeedback	$06
	spDetune	$03, $07, $04, $07
	spMultiple	$03, $0E, $01, $04
	spRateScale	$01, $01, $02, $00
	spAttackRt	$1B, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$04, $07, $07, $08
	spSustainLv	$0F, $0E, $0F, $0F
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$23, $29, $10, $17

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
	; $3A
	; $01, $02, $01, $01,	$14, $14, $17, $14
	; $0A, $0C, $03, $07,	$02, $08, $08, $03
	; $07, $F9, $A8, $18,	$1C, $2B, $28, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $01, $02, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$14, $17, $14, $14
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0A, $03, $0C, $07
	spSustainLv	$00, $0A, $0F, $01
	spDecayRt	$02, $08, $08, $03
	spReleaseRt	$07, $08, $09, $08
	spTotalLv	$1C, $28, $2B, $00

	; Patch $11
	; $3A
	; $01, $07, $01, $01,	$0F, $0F, $0F, $14
	; $0A, $0A, $0A, $05,	$02, $02, $02, $02
	; $56, $A6, $56, $18,	$19, $28, $28, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $01, $07, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$0F, $0F, $0F, $14
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0A, $0A, $0A, $05
	spSustainLv	$05, $05, $0A, $01
	spDecayRt	$02, $02, $02, $02
	spReleaseRt	$06, $06, $06, $08
	spTotalLv	$19, $28, $28, $00

	; Patch $12
	; $38
	; $0F, $0F, $0F, $0F,	$1F, $1F, $1F, $11
	; $00, $00, $00, $0E,	$00, $00, $00, $19
	; $03, $03, $03, $1A,	$07, $07, $07, $80
	spAlgorithm	$00
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$0F, $0F, $0F, $0F
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $11
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $00, $00, $0E
	spSustainLv	$00, $00, $00, $01
	spDecayRt	$00, $00, $00, $19
	spReleaseRt	$03, $03, $03, $0A
	spTotalLv	$07, $07, $07, $00

	; Patch $13
	; $3C
	; $03, $01, $01, $01,	$1F, $1F, $1F, $1F
	; $12, $0F, $14, $0F,	$01, $0F, $0C, $0F
	; $17, $F9, $F7, $F9,	$00, $81, $05, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$03, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$12, $14, $0F, $0F
	spSustainLv	$01, $0F, $0F, $0F
	spDecayRt	$01, $0C, $0F, $0F
	spReleaseRt	$07, $07, $09, $09
	spTotalLv	$00, $05, $01, $00

	; Patch $14
	; $00
	; $00, $03, $02, $00,	$DF, $DF, $1F, $1F
	; $12, $11, $14, $0E,	$0A, $00, $0A, $0D
	; $F3, $F6, $F3, $F8,	$22, $07, $27, $80
	spAlgorithm	$00
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $02, $03, $00
	spRateScale	$03, $00, $03, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$12, $14, $11, $0E
	spSustainLv	$0F, $0F, $0F, $0F
	spDecayRt	$0A, $0A, $00, $0D
	spReleaseRt	$03, $03, $06, $08
	spTotalLv	$22, $27, $07, $00

	; Patch $15
	; $3B
	; $08, $04, $0F, $0C,	$1F, $1F, $1F, $1F
	; $1F, $1F, $1C, $1F,	$00, $04, $00, $06
	; $10, $10, $00, $07,	$0D, $21, $4D, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$08, $0F, $04, $0C
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$1F, $1C, $1F, $1F
	spSustainLv	$01, $00, $01, $00
	spDecayRt	$00, $00, $04, $06
	spReleaseRt	$00, $00, $00, $07
	spTotalLv	$0D, $4D, $21, $00

	; Patch $16
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

	; Patch $17
	; $38
	; $6A, $0A, $11, $02,	$19, $18, $0F, $0F
	; $05, $08, $02, $08,	$00, $00, $00, $00
	; $A6, $16, $16, $17,	$1C, $2D, $28, $80
	spAlgorithm	$00
	spFeedback	$07
	spDetune	$06, $01, $00, $00
	spMultiple	$0A, $01, $0A, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$19, $0F, $18, $0F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$05, $02, $08, $08
	spSustainLv	$0A, $01, $01, $01
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$06, $06, $06, $07
	spTotalLv	$1C, $28, $2D, $00

	; Patch $18
	; $32
	; $71, $0D, $33, $01,	$5F, $99, $5F, $94
	; $05, $05, $05, $07,	$02, $02, $02, $02
	; $11, $11, $11, $72,	$23, $2D, $26, $80
	spAlgorithm	$02
	spFeedback	$06
	spDetune	$07, $03, $00, $00
	spMultiple	$01, $03, $0D, $01
	spRateScale	$01, $01, $02, $02
	spAttackRt	$1F, $1F, $19, $14
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$05, $05, $05, $07
	spSustainLv	$01, $01, $01, $07
	spDecayRt	$02, $02, $02, $02
	spReleaseRt	$01, $01, $01, $02
	spTotalLv	$23, $26, $2D, $00

	; Patch $19
	; $2C
	; $71, $71, $31, $31,	$5F, $54, $5F, $5F
	; $05, $0A, $03, $0C,	$00, $03, $00, $03
	; $00, $87, $00, $A7,	$17, $80, $19, $82
	spAlgorithm	$04
	spFeedback	$05
	spDetune	$07, $03, $07, $03
	spMultiple	$01, $01, $01, $01
	spRateScale	$01, $01, $01, $01
	spAttackRt	$1F, $1F, $14, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$05, $03, $0A, $0C
	spSustainLv	$00, $00, $08, $0A
	spDecayRt	$00, $00, $03, $03
	spReleaseRt	$00, $00, $07, $07
	spTotalLv	$17, $19, $00, $02

	; Patch $1A
	; $3A
	; $01, $03, $02, $03,	$D6, $D6, $16, $11
	; $08, $08, $0A, $09,	$00, $0C, $01, $01
	; $33, $33, $13, $07,	$18, $18, $2F, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $02, $03, $03
	spRateScale	$03, $00, $03, $00
	spAttackRt	$16, $16, $16, $11
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$08, $0A, $08, $09
	spSustainLv	$03, $01, $03, $00
	spDecayRt	$00, $01, $0C, $01
	spReleaseRt	$03, $03, $03, $07
	spTotalLv	$18, $2F, $18, $00

	; Patch $1B
	; $3A
	; $32, $56, $32, $42,	$8D, $4F, $15, $52
	; $06, $08, $07, $04,	$02, $00, $00, $00
	; $1F, $1F, $2F, $2F,	$19, $20, $2A, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$03, $03, $05, $04
	spMultiple	$02, $02, $06, $02
	spRateScale	$02, $00, $01, $01
	spAttackRt	$0D, $15, $0F, $12
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$06, $07, $08, $04
	spSustainLv	$01, $02, $01, $02
	spDecayRt	$02, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$19, $2A, $20, $00

	; Patch $1C
	; $3A
	; $31, $37, $31, $31,	$8D, $8D, $8E, $53
	; $0E, $0E, $0E, $03,	$00, $00, $00, $00
	; $1F, $FF, $1F, $0F,	$17, $25, $23, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$03, $03, $03, $03
	spMultiple	$01, $01, $07, $01
	spRateScale	$02, $02, $02, $01
	spAttackRt	$0D, $0E, $0D, $13
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0E, $0E, $0E, $03
	spSustainLv	$01, $01, $0F, $00
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$17, $23, $25, $00

	; Patch $1D
	; $3A
	; $41, $45, $32, $41,	$59, $59, $5C, $4E
	; $0A, $0B, $0D, $04,	$00, $00, $00, $00
	; $1F, $5F, $2F, $0F,	$1D, $0F, $20, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$04, $03, $04, $04
	spMultiple	$01, $02, $05, $01
	spRateScale	$01, $01, $01, $01
	spAttackRt	$19, $1C, $19, $0E
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0A, $0D, $0B, $04
	spSustainLv	$01, $02, $05, $00
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1D, $20, $0F, $00

	; Patch $1E
	; $2A
	; $21, $39, $31, $74,	$1E, $1F, $1F, $1F
	; $17, $1B, $02, $03,	$00, $08, $03, $0B
	; $3F, $3F, $0F, $6F,	$11, $0C, $1C, $8A
	spAlgorithm	$02
	spFeedback	$05
	spDetune	$02, $03, $03, $07
	spMultiple	$01, $01, $09, $04
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1E, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$17, $02, $1B, $03
	spSustainLv	$03, $00, $03, $06
	spDecayRt	$00, $03, $08, $0B
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$11, $1C, $0C, $0A

	; Patch $1F
	; $3D
	; $0A, $65, $14, $31,	$8E, $52, $14, $4C
	; $08, $08, $0E, $03,	$00, $00, $00, $00
	; $1F, $1B, $1F, $16,	$10, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $01, $06, $03
	spMultiple	$0A, $04, $05, $01
	spRateScale	$02, $00, $01, $01
	spAttackRt	$0E, $14, $12, $0C
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$08, $0E, $08, $03
	spSustainLv	$01, $01, $01, $01
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0B, $06
	spTotalLv	$10, $00, $00, $00

	; Patch $20
	; $02
	; $00, $00, $00, $00,	$5C, $54, $1C, $D0
	; $0C, $08, $0A, $05,	$00, $00, $00, $00
	; $FF, $FF, $FF, $FF,	$24, $1B, $22, $80
	spAlgorithm	$02
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $00, $00, $00
	spRateScale	$01, $00, $01, $03
	spAttackRt	$1C, $1C, $14, $10
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0C, $0A, $08, $05
	spSustainLv	$0F, $0F, $0F, $0F
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$24, $22, $1B, $00

	; Patch $21
	; $39
	; $01, $51, $00, $00,	$1F, $5F, $5F, $5F
	; $10, $11, $09, $09,	$07, $00, $00, $00
	; $CF, $FF, $FF, $FF,	$1C, $1D, $1F, $80
	spAlgorithm	$01
	spFeedback	$07
	spDetune	$00, $00, $05, $00
	spMultiple	$01, $00, $01, $00
	spRateScale	$00, $01, $01, $01
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$10, $09, $11, $09
	spSustainLv	$0C, $0F, $0F, $0F
	spDecayRt	$07, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1C, $1F, $1D, $00

	; Patch $22
	; $2C
	; $61, $03, $01, $33,	$5F, $94, $5F, $94
	; $05, $05, $05, $07,	$02, $02, $02, $02
	; $1F, $6F, $1F, $AF,	$1E, $80, $1E, $80
	spAlgorithm	$04
	spFeedback	$05
	spDetune	$06, $00, $00, $03
	spMultiple	$01, $01, $03, $03
	spRateScale	$01, $01, $02, $02
	spAttackRt	$1F, $1F, $14, $14
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$05, $05, $05, $07
	spSustainLv	$01, $01, $06, $0A
	spDecayRt	$02, $02, $02, $02
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1E, $1E, $00, $00

	; Patch $23
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

	; Patch $24
	; $3B
	; $03, $01, $30, $01,	$1C, $DC, $DC, $5E
	; $14, $13, $0F, $0C,	$0C, $05, $0A, $07
	; $AF, $AF, $5F, $6F,	$16, $11, $11, $80
	spAlgorithm	$03
	spFeedback	$07
	spDetune	$00, $03, $00, $00
	spMultiple	$03, $00, $01, $01
	spRateScale	$00, $03, $03, $01
	spAttackRt	$1C, $1C, $1C, $1E
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$14, $0F, $13, $0C
	spSustainLv	$0A, $05, $0A, $06
	spDecayRt	$0C, $0A, $05, $07
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$16, $11, $11, $00

	; Patch $25
	; $3D
	; $08, $01, $01, $01,	$1F, $1F, $1F, $1F
	; $19, $19, $19, $11,	$05, $11, $00, $0F
	; $0F, $7F, $FF, $FF,	$00, $80, $80, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$08, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$19, $19, $19, $11
	spSustainLv	$00, $0F, $07, $0F
	spDecayRt	$05, $00, $11, $0F
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$00, $00, $00, $00

	; Patch $26
	; $3A
	; $60, $66, $60, $61,	$1F, $94, $1F, $1F
	; $0F, $10, $05, $0D,	$07, $06, $06, $07
	; $2F, $4F, $1F, $5F,	$21, $14, $28, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$06, $06, $06, $06
	spMultiple	$00, $00, $06, $01
	spRateScale	$00, $00, $02, $00
	spAttackRt	$1F, $1F, $14, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0F, $05, $10, $0D
	spSustainLv	$02, $01, $04, $05
	spDecayRt	$07, $06, $06, $07
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$21, $28, $14, $00

	; Patch $27
	; $00
	; $60, $32, $32, $30,	$06, $06, $08, $0E
	; $06, $00, $00, $04,	$02, $00, $00, $04
	; $3F, $2F, $2F, $4F,	$10, $19, $1A, $80
	spAlgorithm	$00
	spFeedback	$00
	spDetune	$06, $03, $03, $03
	spMultiple	$00, $02, $02, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$06, $08, $06, $0E
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$06, $00, $00, $04
	spSustainLv	$03, $02, $02, $04
	spDecayRt	$02, $00, $00, $04
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$10, $1A, $19, $00

	; Patch $28
	; $3C
	; $78, $78, $34, $34,	$1F, $12, $1F, $1F
	; $00, $0F, $00, $0F,	$00, $01, $00, $01
	; $0F, $3F, $0F, $3F,	$21, $90, $18, $87
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$07, $03, $07, $03
	spMultiple	$08, $04, $08, $04
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $12, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $00, $0F, $0F
	spSustainLv	$00, $00, $03, $03
	spDecayRt	$00, $00, $01, $01
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$21, $18, $10, $07

	; Patch $29
	; $3C
	; $78, $78, $34, $34,	$1F, $12, $1F, $1F
	; $00, $0F, $00, $0F,	$00, $09, $00, $09
	; $0F, $3F, $0F, $3F,	$21, $90, $18, $87
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$07, $03, $07, $03
	spMultiple	$08, $04, $08, $04
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $12, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $00, $0F, $0F
	spSustainLv	$00, $00, $03, $03
	spDecayRt	$00, $00, $09, $09
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$21, $18, $10, $07

	; Patch $2A
	; $2C
	; $72, $72, $32, $32,	$1F, $12, $1F, $1F
	; $00, $0F, $00, $0F,	$00, $09, $00, $09
	; $0F, $3F, $0F, $3F,	$0E, $88, $0E, $88
	spAlgorithm	$04
	spFeedback	$05
	spDetune	$07, $03, $07, $03
	spMultiple	$02, $02, $02, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $12, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $00, $0F, $0F
	spSustainLv	$00, $00, $03, $03
	spDecayRt	$00, $00, $09, $09
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$0E, $0E, $08, $08

	; Patch $2B
	; $3C
	; $52, $36, $63, $52,	$DF, $59, $CF, $8A
	; $0A, $0A, $01, $05,	$14, $14, $0A, $14
	; $AF, $5F, $AF, $5F,	$1E, $85, $28, $82
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$05, $06, $03, $05
	spMultiple	$02, $03, $06, $02
	spRateScale	$03, $03, $01, $02
	spAttackRt	$1F, $0F, $19, $0A
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0A, $01, $0A, $05
	spSustainLv	$0A, $0A, $05, $05
	spDecayRt	$14, $0A, $14, $14
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1E, $28, $05, $02

	; Patch $2C
	; $38
	; $20, $62, $70, $30,	$14, $12, $0A, $0A
	; $0E, $0E, $09, $1F,	$00, $00, $00, $00
	; $5F, $5F, $AF, $0F,	$1C, $28, $14, $85
	spAlgorithm	$00
	spFeedback	$07
	spDetune	$02, $07, $06, $03
	spMultiple	$00, $00, $02, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$14, $0A, $12, $0A
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0E, $09, $0E, $1F
	spSustainLv	$05, $0A, $05, $00
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1C, $14, $28, $05

	; Patch $2D
	; $3A
	; $3C, $4F, $31, $23,	$1F, $DF, $1F, $9F
	; $0C, $02, $0C, $05,	$04, $04, $04, $07
	; $1F, $FF, $0F, $2F,	$20, $39, $1E, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$03, $03, $04, $02
	spMultiple	$0C, $01, $0F, $03
	spRateScale	$00, $00, $03, $02
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0C, $0C, $02, $05
	spSustainLv	$01, $00, $0F, $02
	spDecayRt	$04, $04, $04, $07
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$20, $1E, $39, $00

	; Patch $2E
	; $1C
	; $6B, $33, $37, $92,	$DF, $DF, $5F, $DF
	; $0E, $07, $10, $0F,	$00, $0B, $05, $04
	; $FF, $17, $AF, $1F,	$14, $80, $27, $85
	spAlgorithm	$04
	spFeedback	$03
	spDetune	$06, $03, $03, $09
	spMultiple	$0B, $07, $03, $02
	spRateScale	$03, $01, $03, $03
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0E, $10, $07, $0F
	spSustainLv	$0F, $0A, $01, $01
	spDecayRt	$00, $05, $0B, $04
	spReleaseRt	$0F, $0F, $07, $0F
	spTotalLv	$14, $27, $00, $05

	; Patch $2F
	; $2A
	; $21, $39, $31, $74,	$1E, $1F, $1F, $1F
	; $17, $1B, $02, $03,	$00, $08, $03, $0B
	; $3F, $3F, $0F, $6F,	$1A, $0D, $27, $87
	spAlgorithm	$02
	spFeedback	$05
	spDetune	$02, $03, $03, $07
	spMultiple	$01, $01, $09, $04
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1E, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$17, $02, $1B, $03
	spSustainLv	$03, $00, $03, $06
	spDecayRt	$00, $03, $08, $0B
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1A, $27, $0D, $07

	; Patch $30
	; $38
	; $63, $31, $31, $31,	$10, $13, $1A, $1B
	; $0E, $00, $00, $00,	$00, $00, $00, $00
	; $3F, $0F, $0F, $0F,	$1A, $19, $1A, $80
	spAlgorithm	$00
	spFeedback	$07
	spDetune	$06, $03, $03, $03
	spMultiple	$03, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$10, $1A, $13, $1B
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0E, $00, $00, $00
	spSustainLv	$03, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1A, $1A, $19, $00

	; Patch $31
	; $3D
	; $65, $28, $02, $61,	$DF, $1F, $1F, $1F
	; $12, $04, $0F, $0F,	$00, $00, $00, $00
	; $2F, $0F, $0F, $0F,	$27, $91, $9B, $80
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$06, $00, $02, $06
	spMultiple	$05, $02, $08, $01
	spRateScale	$03, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$12, $0F, $04, $0F
	spSustainLv	$02, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$27, $1B, $11, $00

	; Patch $32
	; $1F
	; $16, $61, $03, $52,	$1C, $9F, $1F, $1F
	; $12, $0F, $0F, $0F,	$00, $00, $00, $00
	; $FF, $0F, $0F, $0F,	$91, $8A, $8A, $80
	spAlgorithm	$07
	spFeedback	$03
	spDetune	$01, $00, $06, $05
	spMultiple	$06, $03, $01, $02
	spRateScale	$00, $00, $02, $00
	spAttackRt	$1C, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$12, $0F, $0F, $0F
	spSustainLv	$0F, $00, $00, $00
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$11, $0A, $0A, $00

	; Patch $33
	; $30
	; $75, $75, $71, $31,	$D8, $58, $96, $94
	; $01, $0B, $03, $08,	$01, $04, $01, $01
	; $F3, $23, $34, $35,	$34, $29, $10, $80
	spAlgorithm	$00
	spFeedback	$06
	spDetune	$07, $07, $07, $03
	spMultiple	$05, $01, $05, $01
	spRateScale	$03, $02, $01, $02
	spAttackRt	$18, $16, $18, $14
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$01, $03, $0B, $08
	spSustainLv	$0F, $03, $02, $03
	spDecayRt	$01, $01, $04, $01
	spReleaseRt	$03, $04, $03, $05
	spTotalLv	$34, $10, $29, $00

	; Patch $34
	; $1C
	; $76, $74, $36, $34,	$94, $99, $94, $99
	; $08, $0A, $08, $0A,	$00, $05, $00, $05
	; $35, $47, $35, $47,	$1E, $80, $19, $80
	spAlgorithm	$04
	spFeedback	$03
	spDetune	$07, $03, $07, $03
	spMultiple	$06, $06, $04, $04
	spRateScale	$02, $02, $02, $02
	spAttackRt	$14, $14, $19, $19
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$08, $08, $0A, $0A
	spSustainLv	$03, $03, $04, $04
	spDecayRt	$00, $00, $05, $05
	spReleaseRt	$05, $05, $07, $07
	spTotalLv	$1E, $19, $00, $00

	; Patch $35
	; $3A
	; $42, $4A, $32, $42,	$5C, $53, $5C, $4D
	; $07, $09, $07, $04,	$00, $00, $00, $00
	; $1F, $3F, $1F, $0F,	$1B, $18, $33, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$04, $03, $04, $04
	spMultiple	$02, $02, $0A, $02
	spRateScale	$01, $01, $01, $01
	spAttackRt	$1C, $1C, $13, $0D
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$07, $07, $09, $04
	spSustainLv	$01, $01, $03, $00
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1B, $33, $18, $00

	; Patch $36
	; $16
	; $7A, $74, $3C, $31,	$1F, $1F, $1F, $1F
	; $0A, $07, $0C, $06,	$07, $0A, $07, $05
	; $25, $A7, $A7, $55,	$14, $85, $8A, $80
	spAlgorithm	$06
	spFeedback	$02
	spDetune	$07, $03, $07, $03
	spMultiple	$0A, $0C, $04, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0A, $0C, $07, $06
	spSustainLv	$02, $0A, $0A, $05
	spDecayRt	$07, $07, $0A, $05
	spReleaseRt	$05, $07, $07, $05
	spTotalLv	$14, $0A, $05, $00

	; Patch $37
	; $30
	; $31, $3A, $30, $31,	$9E, $D8, $DC, $DC
	; $0E, $0A, $01, $05,	$08, $08, $08, $08
	; $BF, $B6, $B6, $BA,	$14, $2F, $14, $80
	spAlgorithm	$00
	spFeedback	$06
	spDetune	$03, $03, $03, $03
	spMultiple	$01, $00, $0A, $01
	spRateScale	$02, $03, $03, $03
	spAttackRt	$1E, $1C, $18, $1C
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0E, $01, $0A, $05
	spSustainLv	$0B, $0B, $0B, $0B
	spDecayRt	$08, $08, $08, $08
	spReleaseRt	$0F, $06, $06, $0A
	spTotalLv	$14, $14, $2F, $00

	; Patch $38
	; $3A
	; $41, $45, $32, $41,	$59, $4F, $5C, $4E
	; $0A, $0B, $0D, $04,	$00, $01, $00, $00
	; $1F, $5F, $2F, $08,	$1D, $0F, $20, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$04, $03, $04, $04
	spMultiple	$01, $02, $05, $01
	spRateScale	$01, $01, $01, $01
	spAttackRt	$19, $1C, $0F, $0E
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0A, $0D, $0B, $04
	spSustainLv	$01, $02, $05, $00
	spDecayRt	$00, $00, $01, $00
	spReleaseRt	$0F, $0F, $0F, $08
	spTotalLv	$1D, $20, $0F, $00

	; Patch $39
	; $30
	; $30, $3A, $30, $31,	$9E, $D8, $DC, $DC
	; $0E, $0A, $01, $05,	$08, $08, $08, $08
	; $B6, $B6, $B6, $B6,	$14, $2F, $14, $80
	spAlgorithm	$00
	spFeedback	$06
	spDetune	$03, $03, $03, $03
	spMultiple	$00, $00, $0A, $01
	spRateScale	$02, $03, $03, $03
	spAttackRt	$1E, $1C, $18, $1C
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0E, $01, $0A, $05
	spSustainLv	$0B, $0B, $0B, $0B
	spDecayRt	$08, $08, $08, $08
	spReleaseRt	$06, $06, $06, $06
	spTotalLv	$14, $14, $2F, $00

	; Patch $3A
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

	; Patch $3B
	; $3A
	; $20, $29, $20, $01,	$1E, $1F, $1F, $1F
	; $0A, $0A, $0B, $0A,	$05, $07, $0A, $08
	; $A4, $85, $96, $77,	$21, $25, $28, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$02, $02, $02, $00
	spMultiple	$00, $00, $09, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1E, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0A, $0B, $0A, $0A
	spSustainLv	$0A, $09, $08, $07
	spDecayRt	$05, $0A, $07, $08
	spReleaseRt	$04, $06, $05, $07
	spTotalLv	$21, $28, $25, $00

	; Patch $3C
	; $3F
	; $14, $04, $12, $01,	$1F, $1F, $1F, $1F
	; $00, $00, $00, $00,	$00, $00, $00, $00
	; $AA, $AA, $AA, $9A,	$AF, $88, $80, $80
	spAlgorithm	$07
	spFeedback	$07
	spDetune	$01, $01, $00, $00
	spMultiple	$04, $02, $04, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$0A, $0A, $0A, $09
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$0A, $0A, $0A, $0A
	spTotalLv	$2F, $00, $08, $00

	; Patch $3D
	; $3D
	; $01, $22, $42, $02,	$19, $52, $52, $53
	; $07, $08, $08, $0A,	$01, $00, $00, $04
	; $24, $1A, $1A, $16,	$1C, $87, $87, $87
	spAlgorithm	$05
	spFeedback	$07
	spDetune	$00, $04, $02, $00
	spMultiple	$01, $02, $02, $02
	spRateScale	$00, $01, $01, $01
	spAttackRt	$19, $12, $12, $13
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$07, $08, $08, $0A
	spSustainLv	$02, $01, $01, $01
	spDecayRt	$01, $00, $00, $04
	spReleaseRt	$04, $0A, $0A, $06
	spTotalLv	$1C, $07, $07, $07

	; Patch $3E
	; $08
	; $0A, $30, $30, $00,	$1F, $1F, $5F, $5F
	; $12, $0E, $0A, $0A,	$00, $04, $04, $03
	; $26, $26, $26, $26,	$24, $2D, $13, $80
	spAlgorithm	$00
	spFeedback	$01
	spDetune	$00, $03, $03, $00
	spMultiple	$0A, $00, $00, $00
	spRateScale	$00, $01, $00, $01
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$12, $0A, $0E, $0A
	spSustainLv	$02, $02, $02, $02
	spDecayRt	$00, $04, $04, $03
	spReleaseRt	$06, $06, $06, $06
	spTotalLv	$24, $13, $2D, $00

	; Patch $3F
	; $14
	; $70, $70, $30, $30,	$5F, $5F, $5F, $5F
	; $17, $0A, $19, $0A,	$00, $00, $00, $00
	; $FF, $F7, $FF, $F7,	$00, $80, $00, $80
	spAlgorithm	$04
	spFeedback	$02
	spDetune	$07, $03, $07, $03
	spMultiple	$00, $00, $00, $00
	spRateScale	$01, $01, $01, $01
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$17, $19, $0A, $0A
	spSustainLv	$0F, $0F, $0F, $0F
	spDecayRt	$00, $00, $00, $00
	spReleaseRt	$0F, $0F, $07, $07
	spTotalLv	$00, $00, $00, $00

	; Patch $40
	; $3C
	; $0B, $02, $0A, $02,	$1F, $1E, $1F, $1F
	; $0F, $0E, $11, $10,	$13, $0F, $11, $0E
	; $24, $07, $17, $08,	$20, $80, $1B, $80
	spAlgorithm	$04
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$0B, $0A, $02, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1E, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0F, $11, $0E, $10
	spSustainLv	$02, $01, $00, $00
	spDecayRt	$13, $11, $0F, $0E
	spReleaseRt	$04, $07, $07, $08
	spTotalLv	$20, $1B, $00, $00

	; Patch $41
	; $28
	; $03, $0F, $17, $71,	$1F, $12, $1F, $1F
	; $04, $01, $04, $0C,	$01, $01, $01, $00
	; $10, $19, $10, $17,	$17, $26, $1B, $80
	spAlgorithm	$00
	spFeedback	$05
	spDetune	$00, $01, $00, $07
	spMultiple	$03, $07, $0F, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $12, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$04, $04, $01, $0C
	spSustainLv	$01, $01, $01, $01
	spDecayRt	$01, $01, $01, $00
	spReleaseRt	$00, $00, $09, $07
	spTotalLv	$17, $1B, $26, $00

	; Patch $42
	; $3A
	; $01, $40, $01, $31,	$1F, $1F, $1F, $1F
	; $0B, $04, $04, $04,	$02, $04, $03, $02
	; $53, $1C, $53, $26,	$18, $05, $11, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$00, $00, $04, $03
	spMultiple	$01, $01, $00, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$0B, $04, $04, $04
	spSustainLv	$05, $05, $01, $02
	spDecayRt	$02, $03, $04, $02
	spReleaseRt	$03, $03, $0C, $06
	spTotalLv	$18, $11, $05, $00

	; Patch $43
	; $20
	; $66, $65, $60, $61,	$DF, $DF, $9F, $9F
	; $07, $06, $09, $06,	$07, $06, $06, $08
	; $2F, $1F, $1F, $FF,	$1C, $2E, $16, $81
	spAlgorithm	$00
	spFeedback	$04
	spDetune	$06, $06, $06, $06
	spMultiple	$06, $00, $05, $01
	spRateScale	$03, $02, $03, $02
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$07, $09, $06, $06
	spSustainLv	$02, $01, $01, $0F
	spDecayRt	$07, $06, $06, $08
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$1C, $16, $2E, $01

	; Patch $44
	; $28
	; $03, $0F, $17, $71,	$1F, $12, $1F, $1F
	; $04, $01, $04, $0C,	$01, $01, $01, $00
	; $10, $19, $10, $17,	$17, $1F, $1B, $80
	spAlgorithm	$00
	spFeedback	$05
	spDetune	$00, $01, $00, $07
	spMultiple	$03, $07, $0F, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $12, $1F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$04, $04, $01, $0C
	spSustainLv	$01, $01, $01, $01
	spDecayRt	$01, $01, $01, $00
	spReleaseRt	$00, $00, $09, $07
	spTotalLv	$17, $1B, $1F, $00
