Ballad_Header:
	sHeaderInit
	sHeaderPatch	Ballad_Patches
	sHeaderCh	$07, $03
	sHeaderTempo	$02, $0C
	sHeaderDAC	Ballad_DAC
	sHeaderFM	Ballad_FM1, $FE, $0E
	sHeaderFM	Ballad_FM2, $FE, $0E
	sHeaderFM	Ballad_FM3, $FE, $0E
	sHeaderFM	Ballad_FM4, $FE, $0E
	sHeaderFM	Ballad_FM5, $FE, $0E
	sHeaderFM	Ballad_FM6, $FE, $0D
	sHeaderPSG	Ballad_PSG1, $DA, $04, $00, v00
	sHeaderPSG	Ballad_PSG2, $DA, $02, $00, v00
	sHeaderPSG	Ballad_PSG3, $DA, $02, $00, v03

Ballad_PSG2:
	sStop

Ballad_PSG3:
	sStop

Ballad_DAC:
	sStop

Ballad_FM1:
	dc.b nRst, $18

Ballad_Jump1:
	saVolFM		$02
	sPatFM		$02
	dc.b nF5, $08
	saVolFM		$03
	dc.b nE5, nC5
	saVolFM		$FD
	dc.b nC5
	saVolFM		$03
	dc.b nD5
	saVolFM		$FE
	dc.b nD5, $30, sHold, $02
	saVolFM		$FF
	dc.b nRst, $06, nA4, $08
	saVolFM		$03
	dc.b nBb4
	saVolFM		$FE
	dc.b nC5
	saVolFM		$FF
	dc.b nC5
	saVolFM		$03
	dc.b nE5
	saVolFM		$FF
	dc.b nF5
	saVolFM		$FE
	dc.b nF5, $24, nRst, $0C, nF5, $08
	saVolFM		$03
	dc.b nE5, nC5
	saVolFM		$FD
	dc.b nC5
	saVolFM		$03
	dc.b nD5, nA5
	saVolFM		$FD
	dc.b nA5, $24, nRst, $04, nBb5, $08
	saVolFM		$03
	dc.b nA5
	saVolFM		$FE
	dc.b nF5, nG5
	saVolFM		$FF
	dc.b nG5
	saVolFM		$03
	dc.b nF5
	saVolFM		$FD
	dc.b nA5, $30, nRst, $08, nF5
	saVolFM		$03
	dc.b nE5, nC5
	saVolFM		$FD
	dc.b nC5
	saVolFM		$03
	dc.b nD5
	saVolFM		$FD
	dc.b nD5, $30, nRst, $08, nC5
	saVolFM		$03
	dc.b nE5, nF5
	saVolFM		$FD
	dc.b nG5
	saVolFM		$03
	dc.b nF5
	saVolFM		$FD
	dc.b nC6, $30, nRst, $08, nF5
	saVolFM		$03
	dc.b nG5, nA5
	saVolFM		$FD
	dc.b nA5
	saVolFM		$03
	dc.b nBb5
	saVolFM		$FF
	dc.b nD5
	saVolFM		$FE
	dc.b nF5, $0D, nRst, $03
	saVolFM		$03
	dc.b nA5, $08
	saVolFM		$FD
	dc.b nA5
	saVolFM		$03
	dc.b nBb5, nD5
	saVolFM		$FD
	dc.b nA5
	saVolFM		$03
	dc.b nG5
	saVolFM		$FF
	dc.b nF5
	saVolFM		$FE
	saVolFM		$FE
	dc.b nF5, $10, $30, nRst, $08, nF5, nE5, nC5
	dc.b nC5, nD5, nD5, $30, sHold, $08, nA4, nBb4
	dc.b nC5, nC5, nG5, nF5, nF5, $30, $08, nE5
	dc.b nC5, nC5, nD5, nA5, nF5, nRst, nC5, nD5
	dc.b nC6, nA5, nG5, nE5, nG5, nC5, nRst, nC5
	dc.b nC5, nC5, nC5, $1E, nRst, $02, nF5, $08
	dc.b nE5, nC5
	saVolFM		$05
	dc.b nC5
	saVolFM		$03
	dc.b nD5
	saVolFM		$FD
	dc.b nF5
	saVolFM		$FE
	dc.b nC5
	saVolFM		$03
	dc.b nD5
	saVolFM		$FD
	dc.b nF5
	saVolFM		$FE
	dc.b nC5
	saVolFM		$03
	dc.b nD5
	saVolFM		$FD
	dc.b nF5
	saVolFM		$FE
	dc.b nC5
	saVolFM		$03
	dc.b nD5
	saVolFM		$FD
	dc.b nF5
	saVolFM		$FF
	dc.b nC5
	saVolFM		$03
	dc.b nD5
	saVolFM		$FD
	dc.b nF5
	saVolFM		$FF
	dc.b nE5
	saVolFM		$03
	dc.b nF5
	saVolFM		$FD
	dc.b nC6
	saVolFM		$FE
	dc.b nG5
	saVolFM		$03
	dc.b nA5
	saVolFM		$FD
	dc.b nE6
	saVolFM		$FE
	dc.b nC6
	saVolFM		$03
	dc.b nG5
	saVolFM		$FD
	dc.b nA5
	saVolFM		$07
	saVolFM		$04
	dc.b nA5, nD5, nF5, nA5, nRst, $10, nA5, $08
	dc.b nD5, nF5, nA5, nG5, nF5
	saVolFM		$FD
	dc.b nF5, $18, $30
	saVolFM		$FF
	dc.b nE6, $08, nG6, nE6, nG5, nRst, $04, nG5
	dc.b $10, sHold, $02, nRst, $06, nG5, $10, nRst
	dc.b $2C, nRst, $24, nG4, $04, nA4, $05, nRst
	dc.b $03, nC5, $05, nRst, $03, nE5, $05, nRst
	dc.b $03, nG5, $05, nRst, $03, nBb5, $06, nRst
	dc.b $03, nD6, $05, nE6, nF6, nE6, $06, nF6
	dc.b nE6, $14, nRst, $0A, nD6, $06, nC6, $16
	dc.b nRst, $02, nA5, $08, nBb5, nC6, nA5, $10
	dc.b nF5, $08, nG5, $24, nRst, $0C, nA4, $08
	dc.b nBb4, nC5, nA4, nF4, nG4, nF4, $30
	ssTempo		$0D
	sPatFM		$04
	dc.b nA3, $08, nBb3, nC4, nC4, $09, nRst, $07
	dc.b nE4, $08
	ssTempo		$0E
	dc.b $09, nRst, $07, nG4, $08
	ssTempo		$0F
	dc.b $09, nRst, $07, nBb4, $08, $09, nRst, $07
	dc.b nD5, $08
	sPatFM		$02
	dc.b nRst, $18, nD5, $30, $08, nEb5, nF5, nC5
	dc.b $20, nG5, $08, nF5, nC5, $30, nBb4, sHold
	dc.b $08, nEb5, nD5, nC5, nBb4, nC5, nD5, $30
	dc.b nB4, $18, nD5, nD5, nG4, nD5, $10, nRst
	dc.b nF5, nC5, $18, nG4, $08, nA4, nC5, nC5
	dc.b $18, nG4, $08, nAb4, nC5, nBb4, nA4, nBb4
	dc.b nC5, $10, $08, nD5, nC5, nD5, nEb5, $10
	dc.b $08, nG4, $30, sHold, $08, nF4, nG5, nA5
	dc.b nBb5, nC6, nRst, $12, nD5, $06, nBb5, $30
	dc.b $08, nC6, nD6, nA5, $20, nC6, $08, nC6
	dc.b nA5, $28, $08, nG5, $30, nRst, $08, nEb6
	dc.b nD6, nC6, nBb5, nC6, nD5, $18, nG5, nD6
	dc.b nD6, $10, $08, nD5, $30, nG5, $10, nG5
	dc.b nBb5, nF5, $20, nG5, $08, nA5, nF5, $30
	saVolFM		$05
	dc.b nBb5, $08, nA5, nBb5, nC6, $10, $08, nB5
	dc.b nA5, nB5, nC6, $10, $08
	ssTempo		$12
	dc.b nC6, nD6, nEb6, nF6, nE6, nF6, nA5, nAb5
	dc.b nA5, nD6, nCs6, nD6
	ssTempo		$0F
	dc.b nG5, nFs5, nG5, nC6, nB5, nC6, nA5, nE6
	dc.b nF6
	ssTempo		$0D
	dc.b nE6, nF6, nE6, nF6, nE5, nF5
	ssTempo		$0A
	dc.b nE5, nF5, nE5
	ssTempo		$0F
	saVolFM		$FB
	dc.b nEb5, $20, $08, nG5, nAb5, $20, $08, nG5
	dc.b nAb5, $20, nF5, $08, nAb5, nRst, $18, nG5
	dc.b $04, nAb5, nBb5, nAb5, nG5, nEb5, nBb4, $10
	dc.b nC5, $12, nRst, $06, nCs4, $04, nEb4, nC4
	dc.b $18, nRst, $0C, nCs4, $06, nEb4, nF4, nG4
	dc.b nAb4, nBb4, nC5, nCs5, nEb5, nF5, nG5, $0A
	dc.b nRst, $02, nG4, $03, nAb4, nG4, nFs4, nG4
	dc.b $06, nC5, nC6, nBb5, nBb5, $08, nC6, nA5
	dc.b $0C, nRst, $04, nF4, $08, nF4, nF4, $28
	dc.b nC5, $08, nEb5, $20, nCs5, $08, nC5, nAb4
	dc.b $18, nBb4, nF4, $19, nRst, $07, nA4, $08
	dc.b nA4, nA4, $18, nC5, $08, nC5, nC5, nD5
	dc.b $18, nB4, $10, $08, nC5, $0C, nRst, $04
	dc.b nE5, $08, $10, $08, nEb5, $10, nRst, $08
	dc.b nEb4, $18, nBb4, $10, nRst, $08, nBb4, nC5
	dc.b nD4, nB4, $10, nRst, $08, nD5, $10, nF5
	dc.b $08, nEb5, nD5, nC5, nG4, nRst, nG4, nEb5
	dc.b nD5, nC5, nF4, nEb5, nF5, nG5, nF5, nEb5
	dc.b nG5, $0C, nRst, $04, nBb5, $0F, nRst, $01
	ssTempo		$0A
	dc.b nF5, $08, nEb5, nEb5, nC5, nEb5
	ssTempo		$0A
	saVolFM		$0C
	dc.b nF5, $01
	saVolFM		$F4
	dc.b nG5, $2F, sHold, $30
	ssTempo		$0C
	sJump		Ballad_Jump1
	dc.b $F2	; Unused

Ballad_FM2:
	dc.b nRst, $18

Ballad_Jump2:
	sPatFM		$02
	saVolFM		$12
	dc.b nRst, $06, nF5, $08
	saVolFM		$03
	dc.b nE5, nC5
	saVolFM		$FD
	dc.b nC5
	saVolFM		$03
	dc.b nD5
	saVolFM		$FE
	dc.b nD5, $30, sHold, $02
	saVolFM		$FF
	dc.b nRst, $06, nA4, $08
	saVolFM		$03
	dc.b nBb4
	saVolFM		$FE
	dc.b nC5
	saVolFM		$FF
	dc.b nC5
	saVolFM		$03
	dc.b nE5
	saVolFM		$FF
	dc.b nF5
	saVolFM		$FE
	dc.b nF5, $24, nRst, $0C, nF5, $08
	saVolFM		$03
	dc.b nE5, nC5
	saVolFM		$FD
	dc.b nC5
	saVolFM		$03
	dc.b nD5, nA5
	saVolFM		$FD
	dc.b nA5, $24, nRst, $04, nBb5, $08
	saVolFM		$03
	dc.b nA5
	saVolFM		$FE
	dc.b nF5, nG5
	saVolFM		$FF
	dc.b nG5
	saVolFM		$03
	dc.b nF5
	saVolFM		$FD
	dc.b nA5, $30, nRst, $08, nF5
	saVolFM		$03
	dc.b nE5, nC5
	saVolFM		$FD
	dc.b nC5
	saVolFM		$03
	dc.b nD5
	saVolFM		$FD
	dc.b nD5, $30, nRst, $08, nC5
	saVolFM		$03
	dc.b nE5, nF5
	saVolFM		$FD
	dc.b nG5
	saVolFM		$03
	dc.b nF5
	saVolFM		$FD
	dc.b nC6, $30, nRst, $08, nF5
	saVolFM		$03
	dc.b nG5, nA5
	saVolFM		$FD
	dc.b nA5
	saVolFM		$03
	dc.b nBb5
	saVolFM		$FF
	dc.b nD5
	saVolFM		$FE
	dc.b nF5, $0D, nRst, $03
	saVolFM		$03
	dc.b nA5, $08
	saVolFM		$FD
	dc.b nA5
	saVolFM		$03
	dc.b nBb5, nD5
	saVolFM		$FD
	dc.b nA5
	saVolFM		$03
	dc.b nG5
	saVolFM		$FF
	dc.b nF5
	saVolFM		$FE
	saVolFM		$EE
	dc.b nRst, $2A, nRst, $30, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, $20, nG5, $08, nD5, nRst, $10
	dc.b nG4, $08, nA4, nG4, nF4, $1E, nRst, $1A
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, $1C, nF6, $08, nF6, nC6, $04, nRst
	dc.b $06, nA5, $08, nRst, $16, nE5, $08, nRst
	dc.b $04, nC5, $30, nRst, $2C, nBb4, $05, nRst
	dc.b $03, nD5, $05, nRst, $03, nF5, $05, nRst
	dc.b $03, nA5, $05, nRst, $03, nC6, $05, nRst
	dc.b $0F
	saVolFM		$12
	dc.b nRst, $06, nE6, $06, nF6, nE6, $14, nRst
	dc.b $0A, nD6, $06, nC6, $16, nRst, $02, nA5
	dc.b $08, nBb5, nC6, nA5, $10, nF5, $08, nG5
	dc.b $24, nRst, $0C, nA4, $08, nBb4, nC5, nA4
	dc.b nF4, nG4, nF4, $30
	sPatFM		$04
	dc.b nA3, $08, nBb3, nC4
	saVolFM		$EE
	dc.b nRst, $02, nD4, $09, nRst, $0F, nF4, $09
	dc.b nRst, $0F, nA4, $09, nRst, $0F, nC5, $09
	dc.b nRst, $07
	sPatFM		$02
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b $08, nG4, nB4, nD4, nG4, nC5, nRst, $30
	dc.b nRst, $10, nEb4, $18, nD5, $08, nRst, $10
	dc.b nEb5, nRst, nRst, $08, nC4, nEb4, nRst, $20
	dc.b nC4, $08, nEb4, nRst, $18, nRst, $30, nRst
	dc.b nA4, sHold, $08, nF5, nG4, nA4, nBb4, nC5
	dc.b nRst, $12, nBb5, $06, nD6, $30, $08, nEb6
	dc.b nF6, nC6, $20, nG6, $08, nF6, nC6, $28
	dc.b $08, nBb5, $30, nRst, $08, nEb5, nD5, nC5
	dc.b nBb4, nC5, nD4, $18, nG4, nD5, nD5, $10
	dc.b $08, nG5, $30, nD6, $10, nEb6, nF6
	saVolFM		$05
	dc.b nC6, $20, $08, nC6, nC6, $30, nRst, nRst
	dc.b nRst, nRst, nRst, nRst
	saVolFM		$FB
	dc.b nRst, nRst, nRst, nRst, $18, nEb5, $08, nRst
	dc.b $10, nRst, $30, nRst, nRst, nRst, nRst, nRst
	dc.b $20, nA4, $09, nRst, $07, nC5, $28, nRst
	dc.b $30, nRst, $08, nRst, $30, nA4, $19, nRst
	dc.b $07, nC5, $08, nE5, nF5, $18, $08, nG5
	dc.b nA5, nG5, $18, nD5, $10, $08, nE5, $0C
	dc.b nRst, $04, nC6, $08, $10, nBb5, $08, nC6
	dc.b $10, nRst, $08, nC5, $18, nD5, $10, nRst
	dc.b $08, nD5, nEb5, nF5, nG5, $10, nRst, $20
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst
	sJump		Ballad_Jump2
	dc.b $F2	; Unused

Ballad_FM3:
	dc.b nRst, $30

Ballad_Jump3:
	sPatFM		$04
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, $2A, nD5, $08, nRst, $2E, nRst
	dc.b $30, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, $20, nBb4, $30, nRst, $10
	dc.b nRst, $30, nRst, nRst, nRst, nC5, sHold, $08
	dc.b nRst, $28, nRst, $12, nD6, $06, nD5, $30
	dc.b $08, nEb5, nF5, nF5, $20, nA5, $08, nA5
	dc.b nF5, $28, $08, nEb5, $30, nRst, nRst, nRst
	dc.b nD6, nD5, $10, nEb5, nF5, nC5, $20, $08
	dc.b nC5, nC5, $30, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, $20, nC4, $08, nC4, nC4
	dc.b $28, nRst, $30, nRst, $08, nRst, $30, nC5
	dc.b $19, nRst, $07, nF4, $08, nF4, nF4, $18
	dc.b nA4, $08, nA4, nA4, nB4, $18, nRst, $10
	dc.b nF5, $08, nRst, $10, nC5, $08, $10, $08
	dc.b $10, nRst, $08, nC4, $18, nD4, $10, nRst
	dc.b $08, nD4, nEb4, nF4, nG4, $10, nRst, $20
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b $18
	sJump		Ballad_Jump3
	dc.b $F2	; Unused

Ballad_FM4:
	dc.b nRst, $30

Ballad_Jump4:
	sPatFM		$04
	dc.b nBb3, $30, sHold, $30, nA3, sHold, $30, nG3
	dc.b nG4, $2D, nRst, $03, nA4, $2D, nRst, $03
	dc.b nA4, $2D, nRst, $03, nA4, $30, sHold, $30
	dc.b nE4, sHold, $30, nG3, nC4, nD4, $18, nC4
	dc.b nB3, $30, nF4, $24, nRst, $09, nF3, $06
	dc.b nRst, $15, nF3, $18, nA3, $2D, nRst, $03
	dc.b nC4, $08, nD4, nE4, nF4, nG4, nA4, nF4
	dc.b $18, nBb4, nE4, nC4, nC4, nC4, $10, nF3
	dc.b $08, nF2, nC3, nF3, nG3, nA3, nC4, nBb2
	dc.b $20, nRst, $08, nBb2, nF3, $18, nF3, nE3
	dc.b nE3, nA3, nA3, nF3, nA3, $08, nD3, nF3
	dc.b nC3, $18, nBb3, nEb3, $30, sHold, $30, nD3
	dc.b sHold, $30, nEb3, $0C, nBb4, $30, sHold, $24
	dc.b nF4, $30, sHold, $2A, nRst, $06, nF4, $18
	dc.b nG4, nRst, $30, nE4, $18, nF4, nRst, $30
	dc.b nF3, $18, nE3, nD3, nC3, nEb2, nF3, $10
	dc.b nBb3, nBb3, nBb3, nD3, $08, nRst, nA2, $10
	dc.b nD3, nA3, nD4, nE4, nC5, $08, nRst, nG2
	dc.b $10, nD3, nG3, nF3, nA3, nC4, $08, nRst
	dc.b nD3, $10, nA3, nD4, nB3, nG4, nG3, $08
	dc.b nRst, nG3, $10, nD4, nG4, nG3, nD4, nG4
	dc.b $08, nRst, nEb3, $10, nA3, nEb4, nEb3, nAb3
	dc.b nG4, $08, nRst, $18, nC4, nBb3, nBb3, nF3
	dc.b $10, $08, $10, $08, $04, nE3, nEb3, nD3
	dc.b nCs3, nC3, nB2, nBb2, nA2, nAb2, nFs2, nF2
	dc.b nEb2, $18, nD4, $08, nG4, nD5, nBb5, nD5
	dc.b nD5, nD5, nG4, nG4, nD2, $18, nC4, $08
	dc.b nF4, nC5, nA5, nC5, nC5, nC5, nF4, nF4
	dc.b nC2, $10, nEb3, $08, nC4, nG4, nC4, nF3
	dc.b $10, nA4, $08, nF5, nF5, nF4, nG2, $10
	dc.b nD4, $08, nB4, nD4, nD4, nF2, $10, nD4
	dc.b $08, nE2, $10, nD4, $08, nEb2, $18, nD4
	dc.b $08, nG4, nD5, nBb5, nD5, nD5, nD5, nG4
	dc.b nG4, nD2, $18, nC4, $08, nF4, nC5, nA5
	dc.b nC5, nC5, nC5, nF4, nF4
	saVolFM		$03
	dc.b nG3, $18, nA3, nF3, nC4, nC5, nBb4, nA4
	dc.b nA4, nG4, nG4, nF4, nF4, nF5, nF4
	saVolFM		$FD
	dc.b nAb3, nRst, nC4, nRst, nCs4, nRst, nEb4, nRst
	dc.b nAb3, nRst, nC3, nRst, nCs3, nRst, nEb4, $12
	dc.b nRst, $06, nE4, $12, nRst, $06, nF4, $18
	dc.b nRst, $08, nF3, nG3, nA2, $18, nRst, nBb2
	dc.b $20, nRst, $10, nEb3, nEb3, $08, nCs3, $10
	dc.b nBb2, $08, nF2, $18, nRst, $08, nF3, nG3
	dc.b nA2, $10, nA3, $18, nRst, $08, nB2, nG3
	dc.b nB3, $18, nRst, $08, nC3, $10, nC4, $08
	dc.b nBb2, $10, nC4, $08, nAb2, $18, nRst, $08
	dc.b nEb3, nAb3, $07, nRst, $01, nAb2, $18, nRst
	dc.b $08, nF3, nBb3, nG2, $10, nG3, $08, nB2
	dc.b $10, nB3, $08, nC3, $10, nC4, $08, nB2
	dc.b $10, nB3, $08, nBb2, $10, nBb3, $08, nA2
	dc.b $10, nA3, $08, nAb2, $10, nAb3, $08, nG2
	dc.b $10, nG3, $08, nF2, $10, nF3, $08, nBb2
	dc.b $10, nBb3, $08, nC3, $10, nC4, $08, nD4
	dc.b $10, nG4, $08, nD5, $18, nRst, $18, nRst
	dc.b $18
	sJump		Ballad_Jump4
	dc.b $F2	; Unused

Ballad_FM5:
	dc.b nRst, $30

Ballad_Jump5:
	sPatFM		$04
	dc.b nRst, $03, nF4, $30, sHold, $2D, nRst, $03
	dc.b nE4, $30, sHold, $2D, nRst, $03, nD4, $2D
	dc.b nC4, $30, nF4, nEb4, nF4, sHold, $30, nA3
	dc.b sHold, $30, nRst, $03, nD4, $2D, nRst, $03
	dc.b nG4, $2D, nA4, $30, nF4, nA4, $24, nRst
	dc.b $0C, nBb2, $18, sHold, $18, nE4, $2D, nRst
	dc.b $30, nRst, $03, nBb4, $18, nD4, nC4, nE3
	dc.b nF3, nRst, $30, nRst, $18, nF3, nF3, nA3
	dc.b nA3, nG3, nG3, nD4, nD4, nA3, nRst, nG3
	dc.b nC3, $10, nD3, $08, nRst, $03, nBb3, $30
	dc.b sHold, $2D, nRst, $03, nA3, $30, sHold, $2D
	dc.b nRst, $03, nBb3, $30, sHold, $2D, nRst, $03
	dc.b nC4, $30, sHold, $2D, nRst, $18, nBb4, nRst
	dc.b $30, nA3, $18, nBb3, nRst, $30, nA3, $18
	dc.b nG3, nF3, nE3, nRst, $08, nBb2, $10, nRst
	dc.b $08, nG3, $10, nD4, nG3, nG3, nD2, $18
	dc.b nRst, $08, nF3, $10, nC4, nF4, nF4, nC2
	dc.b $18, nRst, $08, nEb3, $10, nF2, $18, nRst
	dc.b $08, nF3, $10, nG2, $18, nRst, $08, nB3
	dc.b $10, nG4, nD4, nD4, nC3, $18, nRst, $08
	dc.b nEb4, $10, nBb2, $18, nRst, $08, nEb4, $10
	dc.b nA2, $18, nRst, $08, nC4, $10, nAb2, $18
	dc.b nRst, $08, nC4, $10, nEb4, $18, nEb3, nD3
	dc.b nC3, nF2, $30, nRst, nRst, $04, nBb2, $08
	dc.b nEb3, nBb3, nEb4, nBb4, nG5, nG5, nG5, nBb4
	dc.b nBb4, nBb4, nD4, $04, nRst, nA2, $08, nD3
	dc.b nA3, nD4, nA4, nF5, nF5, nF5, nA4, nA4
	dc.b nA4, nC4, $04, nRst, nG2, $08, nD3, nG3
	dc.b nEb4, nEb4, nG3, nC4, nG4, nC5, nC5, nC5
	dc.b nC4, $04, nRst, nD3, $08, nB3, nG4, nG4
	dc.b nG4, nB3, nD3, nB3, nG4, nBb2, nBb3, nG4
	dc.b $04, nRst, nBb2, $08, nEb3, nBb3, nEb4, nBb4
	dc.b nG5, nG5, nG5, nBb4, nBb4, nBb4, nD4, $04
	dc.b nRst, nA2, $08, nD3, nA3, nD4, nA4, nF5
	dc.b nF5, nF5, nA4, nA4, nA4, nC4, $04
	saVolFM		$03
	dc.b nRst, $18, nD4, nD4, nE3, nEb4, nD4, nCs4
	dc.b nC4, nB3, nBb3, nA3, nRst
	saVolFM		$FD
	dc.b nRst, $30, nRst, $08, nEb4, nAb4, $18, nRst
	dc.b $08, nRst, nAb4, nC5, $18, nRst, $10, nAb4
	dc.b $08, nCs5, $18, nRst, $08, nRst, nBb4, nEb5
	dc.b $18, nRst, $10, nEb4, $08, nAb4, $18, nRst
	dc.b $08, nRst, nAb3, nC4, $18, nRst, $10, nAb3
	dc.b $08, nCs4, $18, nRst, $08, nEb3, $12, nRst
	dc.b $06, nE3, $12, nRst, $06, nF3, $18, nRst
	dc.b $08, nF2, nG2, nRst, nF3, nA3, $18, nRst
	dc.b $10, nF3, $08, nBb3, $18, nRst, $08, nRst
	dc.b nEb4, nRst, $10, nCs4, $08, nRst, nF3, $18
	dc.b nRst, $08, nF2, nG2, nRst, nF3, nRst, $30
	dc.b nRst, $20, nRst, $08, nG3, nRst, $10, nG3
	dc.b $08, nRst, $10, nEb3, $08, nAb3, $10, nRst
	dc.b nRst, $08, nF3, nBb3, $10, nRst, $18, nD3
	dc.b $08, nRst, $10, nG3, $08, nRst, nRst, nG3
	dc.b nRst, $10, nG3, $08, nRst, $10, nG3, $08
	dc.b nRst, $10, nF3, $08, nRst, nRst, $08, nEb3
	dc.b nRst, $10, nEb3, $08, nRst, $10, nC3, $08
	dc.b nRst, $10, nF3, $08, nRst, nRst, nG3, nRst
	dc.b $10, nE4, $08, nRst, $0B, nE5, $15, nRst
	dc.b $09, nRst, $0F, nRst, $18
	sJump		Ballad_Jump5
	dc.b $F2	; Unused

Ballad_FM6:
	dc.b nRst, $30

Ballad_Jump6:
	sPatFM		$04
	dc.b nRst, $06, nA4, $30, sHold, $2A, nRst, $06
	dc.b nG4, $30, sHold, $2A, nRst, $06, nF4, $2A
	dc.b nBb4, nRst, $06, nRst, $30, nRst, nBb3, sHold
	dc.b $30, nG4, sHold, $30, nRst, $06, nF4, $2A
	dc.b nRst, $06, nBb4, $2A, nRst, $30, nA4, nBb3
	dc.b $24, nRst, $30, nRst, $0C, nG4, $2D, nRst
	dc.b $30, nRst, $03, nRst, $30, nRst, nRst, nRst
	dc.b nA3, $18, nA3, nBb2, $20, nRst, $08, nBb2
	dc.b nA2, $20, nRst, $08, nA2, nD3, $20, nRst
	dc.b $08, nA2, nBb2, $18, nRst, $30, nRst, $18
	dc.b nRst, $06, nD4, $30, sHold, $2A, nRst, $06
	dc.b nC4, $30, sHold, $2A, nRst, $06, nD4, $30
	dc.b sHold, $2A, nRst, $06, nA3, $30, sHold, $2A
	dc.b nBb3, $18, nC4, nRst, $30, nRst, nRst, nBb2
	dc.b $18, nA2, nG2, nF2, nRst, $10, nEb3, nRst
	dc.b $30, nRst, $10, nRst, nC3, nRst, $30, nRst
	dc.b $10, nRst, nC3, nRst, $20, nC3, $10, nRst
	dc.b nRst, nG3, nRst, $30, nRst, $10, nRst, nC4
	dc.b nRst, $20, nC4, $10, nRst, nRst, nG3, nRst
	dc.b $20, nG3, $10, nRst, nG3, $18, nRst, $30
	dc.b nRst, $18, nRst, $30, nRst, nRst, $08, nD3
	dc.b nG3, nRst, $30, nRst, $18, nRst, $08, nC3
	dc.b nF3, nRst, $30, nRst, $18, nRst, $08, nC3
	dc.b nRst, $28, nF4, $08, nRst, $20, nRst, $08
	dc.b nG3, nRst, $28, nG3, $08, nRst, $10, nG3
	dc.b $08, nRst, nRst, nD3, nG3, nRst, $30, nRst
	dc.b $18, nRst, $08, nC3, nF3, nRst, $30, nRst
	dc.b $18
	saVolFM		$03
	dc.b nBb3, nFs3, nRst, $30, nRst, nRst, nRst, nRst
	saVolFM		$FD
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, $06, nG5, $13, nRst, $08, nRst
	dc.b $0F, nRst, $18
	sJump		Ballad_Jump6
	dc.b $F2	; Unused

Ballad_PSG1:
	dc.b nRst, $30

Ballad_Jump7:
	sVolEnvPSG	v09
	dc.b nRst, $30, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b $09, nG4, $30, sHold, $27, nRst, $30, nRst
	dc.b nRst, $09, nG4, $30, sHold, $27, nRst, $09
	dc.b nD3, $30, sHold, $27, nA4, $18, nRst, $30
	dc.b nRst, $18, nRst, $30, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nD4, $18, nRst, $30, nRst
	dc.b $18, nRst, $30, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b nRst, nRst, nRst, nRst, nRst, nRst, nRst, nRst
	dc.b $09, nC6, $18, nRst, $0F, nRst, $18
	sJump		Ballad_Jump7
	dc.b $F2	; Unused

Ballad_Patches:

	; Patch $00
	; $3C
	; $78, $78, $34, $34,	$1F, $12, $1F, $1F
	; $00, $0F, $00, $0F,	$00, $01, $00, $01
	; $0F, $3F, $0F, $3F,	$1A, $89, $11, $80
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
	spTotalLv	$1A, $11, $09, $00

	; Patch $01
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

	; Patch $02
	; $2C
	; $72, $72, $32, $32,	$1F, $12, $1F, $1F
	; $00, $0F, $00, $0F,	$00, $09, $00, $09
	; $0F, $3F, $0F, $3F,	$15, $80, $14, $80
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
	spTotalLv	$15, $14, $00, $00

	; Patch $03
	; $3A
	; $71, $0C, $33, $01,	$9C, $96, $5D, $8F
	; $04, $09, $04, $07,	$00, $01, $03, $00
	; $15, $12, $16, $A5,	$25, $2F, $25, $80
	spAlgorithm	$02
	spFeedback	$07
	spDetune	$07, $03, $00, $00
	spMultiple	$01, $03, $0C, $01
	spRateScale	$02, $01, $02, $02
	spAttackRt	$1C, $1D, $16, $0F
	spAmpMod	$00, $00, $00, $00
	spSustainRt	$04, $04, $09, $07
	spSustainLv	$01, $01, $01, $0A
	spDecayRt	$00, $03, $01, $00
	spReleaseRt	$05, $06, $02, $05
	spTotalLv	$25, $25, $2F, $00

	; Patch $04
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
