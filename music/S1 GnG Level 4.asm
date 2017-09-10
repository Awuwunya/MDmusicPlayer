Level4_Header:
	sHeaderInit	
	sHeaderPatch	Level4_Patches
	sHeaderCh	$07, $00
	sHeaderTempo	$01, $06
	sHeaderDAC	Level4_DAC
	sHeaderFM	Level4_FM1, $18, $1B
	sHeaderFM	Level4_FM2, $30, $1D
	sHeaderFM	Level4_FM3, $3C, $1D
	sHeaderFM	Level4_FM4, $18, $12
	sHeaderFM	Level4_FM5, $14, $14
	sHeaderFM	Level4_FM6, $1C, $14

Level4_FM1:
	sPatFM		$00
	sPan		spCenter, $00

Level4_Loop1:
	dc.b nD2, $18, nF1, $10, nG1, $08, nRst, nD2
	dc.b nRst, nC2, nRst, $06, $08, nF1
	sLoop		$00, $16, Level4_Loop1
	saTranspose	$F4
	saVolFM		$FE

Level4_Loop2:
	sPatFM		$09
	dc.b nA0, $18, $18
	saTranspose	$1F
	sPatFM		$0A
	saVolFM		$B0
	dc.b nC0, $06, nRst, $0C, $06, $18
	saTranspose	$E1
	sPatFM		$09
	saVolFM		$50
	dc.b nA0, nA0, nRst
	saTranspose	$1F
	sPatFM		$0A
	saVolFM		$B0
	dc.b nC0, $03, $06, nRst, nRst, nRst, $03
	saTranspose	$E1
	saVolFM		$50
	sLoop		$00, $08, Level4_Loop2
	saTranspose	$0C
	saVolFM		$02
	sJump		Level4_FM1

Level4_FM2:
	sPan		spCenter, $00

Level4_Jump1:
	sPatFM		$00

Level4_Loop3:
	dc.b nG0, $18, nEb1, nD1, nEb1, nRst, $06
	sLoop		$00, $16, Level4_Loop3
	dc.b $60, $60, $60, $60
	sPatFM		$03
	dc.b nE1, $0C, nF1, nRst, nC2, nRst, $18, $0C
	dc.b nC2, nB1, nG1, nD1, $18, nRst, $30, nE1
	dc.b $0C, nF1, nRst, nC2, nRst, $18, $0C, nA1
	saTranspose	$0C
	dc.b nBb0, $18, nFs1, $48, nRst, $60, $60, $60
	dc.b $60, $60, $60, $60, $60
	saTranspose	$F4
	sJump		Level4_Jump1

Level4_FM3:
	sPan		spCenter, $00

Level4_Jump2:
	sCall		Level4_Call1
	sCall		Level4_Call2
	dc.b nRst, $60, $60, $0C
	saTranspose	$0C
	sCall		Level4_Call1
	sCall		Level4_Call2
	sPatFM		$03

Level4_Loop5:
	saTranspose	$F4
	dc.b nE1, $0C, nF1, nRst, nC2, nRst, $18, $0C
	dc.b nC2, nB1, nG1, nD1, $18, nRst, $30, nE1
	dc.b $0C, nF1, nRst, nC2, nRst, $18, $0C, nA1
	saTranspose	$0C
	dc.b nBb0, $18, nFs1, $48
	sLoop		$00, $02, Level4_Loop5
	dc.b nRst, $60, $60, $60, $60, $60, $60, $60
	dc.b $60
	saTranspose	$0C
	sJump		Level4_Jump2

Level4_Call1:
	sPatFM		$01
	dc.b nRst, $30, $18, nC1, $03, nE1, nAb1, nC2
	dc.b nC1, nEb1, nAb1, nC2, nRst, $60, $0C
	sRet		

Level4_Call2:
	saTranspose	$F4
	sPatFM		$02

Level4_Loop4:
	dc.b nA1, $06, nA0, nA1, nA0, nG1, nG0, nG1
	dc.b nA1, nA0, nA1, nA0, nG1, nG0, nG1, nA1
	dc.b nA0, nA1
	sLoop		$00, $08, Level4_Loop4
	sRet		

Level4_FM4:
	sCall		Level4_Call3

Level4_Jump3:
	saVolFM		$30
	dc.b nAb0, $30, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b $18, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FE
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b $30, sHold
	saVolFM		$FD
	dc.b $60, sHold, sHold, $06
	sPatFM		$05
	saTranspose	$0C
	saVolFM		$F9

Level4_Loop6:
	dc.b nD1, $30, nC1, nRst, $06, nD1, $30, nE1
	dc.b nRst, $06
	sLoop		$00, $02, Level4_Loop6
	sCall		Level4_Call4
	sCall		Level4_Call5
	saTranspose	$0C
	sCall		Level4_Call5
	dc.b $60, $60, $60, $30
	sPatFM		$06
	saVolFM		$07
	dc.b nFs1, nRst, $60, $60, $60, $60
	sPatFM		$05
	saTranspose	$F4
	dc.b nD1, $30, nC1, $18, nB0, nA0, nE1, $48
	dc.b nA0, $18, nC1, nA1, nE1, nF1, nG1, nG1
	dc.b $30
	saTranspose	$0C
	dc.b nA1, nG1, nBb1, nA1, nC2, nBb1, nD2, nCs2
	dc.b nD2, $60, nRst, $06
	saTranspose	$E8
	saVolFM		$F9
	sJump		Level4_Jump3

Level4_Call3:
	sPan		spCenter, $00
	sPatFM		$04
	dc.b nRst, $60, $06
	sRet		

Level4_Call6:
	dc.b nG0, $60, sHold, $60, sHold, $0C
	sRet		

Level4_Call4:
	dc.b nRst, $60, $06
	sLoop		$00, $04, Level4_Call4
	sRet		

Level4_Call5:
	dc.b nD1, $30, nC1, sHold, $18, sHold, $06, nB0
	dc.b $18, nA0, nG0, nRst, $06
	sLoop		$00, $02, Level4_Call5
	sRet		

Level4_FM5:
	sCall		Level4_Call3

Level4_Jump4:
	dc.b $18, $18, $18
	saVolFM		$2E
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FE
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b $60, sHold, sHold, $06
	saVolFM		$FB
	saTranspose	$10

Level4_Loop7:
	sCall		Level4_Call6
	sLoop		$00, $02, Level4_Loop7
	sCall		Level4_Call4

Level4_Loop8:
	dc.b nF0, $30, nE0, nRst, $06, nD0, $30, nC0
	dc.b nRst, $06
	sLoop		$00, $04, Level4_Loop8
	dc.b $60, $60, $60, $30
	sPatFM		$07
	dc.b nA1, nRst, $60, $60, $60, $60
	sPatFM		$08
	saVolFM		$08
	dc.b nG0, sHold, $30, nE0, $18, nEb0, nE0, $30
	dc.b nCs1, nBb0, $60
	saTranspose	$0C
	dc.b nF1, $30, nE1, nG1, nF1, nA1, nG1, nBb1
	dc.b nA1, nA1, $60, nRst, $06
	saTranspose	$E4
	saVolFM		$F8
	sJump		Level4_Jump4

Level4_FM6:
	sCall		Level4_Call3

Level4_Jump5:
	dc.b $18, $18, $18, $18, $18, $18, $18
	saVolFM		$2E
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b $0C, sHold
	saVolFM		$FE
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b nAb0, sHold
	saVolFM		$FD
	dc.b $18, sHold
	saVolFM		$FD
	dc.b $60, sHold, sHold, $06
	saVolFM		$FB
	saTranspose	$08

Level4_Loop9:
	dc.b nEb0, $30, nD0, nRst, $06, nEb0, $30, nF0
	dc.b nRst, $06
	sLoop		$00, $02, Level4_Loop9
	sCall		Level4_Call4
	saTranspose	$F4

Level4_Loop10:
	sCall		Level4_Call6
	sLoop		$00, $04, Level4_Loop10
	dc.b nRst, $60, $60, $60, $30
	saTranspose	$0C
	sPatFM		$07
	dc.b nD1, nRst, $60, $60, $60, $60
	saTranspose	$F4
	sPatFM		$08
	dc.b nFs1, $18, nE1, nD1, $30, nCs1, nB0, nAb0
	dc.b nG0, nFs0, nE0
	sPatFM		$05
	sCall		Level4_Call7
	sCall		Level4_Call7
	sCall		Level4_Call8
	sCall		Level4_Call8
	dc.b nE2, $60, nRst, $06
	saTranspose	$04
	sJump		Level4_Jump5

Level4_Call7:
	dc.b nD0, $0C, nRst, nA0, nRst, nE2, $18, sHold
	dc.b nE2
	sRet		

Level4_Call8:
	dc.b nD0, $0C, nRst, nA0, nRst, nEb2, $18, sHold
	dc.b nEb2
	sRet		

Level4_DAC:
	sStop		

Level4_Patches:

	; Patch $00
	; $04
	; $7A, $72, $3E, $32,	$12, $12, $12, $12
	; $8A, $8A, $8A, $8A,	$40, $00, $00, $00
	; $F6, $F6, $F6, $F6,	$12, $80, $12, $80
	spAlgorithm	$04
	spFeedback	$00
	spDetune	$07, $03, $07, $03
	spMultiple	$0A, $0E, $02, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$12, $12, $12, $12
	spAmpMod	$01, $01, $01, $01
	spDecayRt	$0A, $0A, $0A, $0A
	spSustainRt	$40, $00, $00, $00
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$06, $06, $06, $06
	spTotalLv	$12, $12, $00, $00

	; Patch $01
	; $2E
	; $03, $01, $02, $03,	$1F, $1F, $1F, $1F
	; $91, $90, $92, $92,	$40, $00, $00, $C0
	; $F8, $F8, $F8, $F8,	$10, $80, $80, $80
	spAlgorithm	$06
	spFeedback	$05
	spDetune	$00, $00, $00, $00
	spMultiple	$03, $02, $01, $03
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$01, $01, $01, $01
	spDecayRt	$11, $12, $10, $12
	spSustainRt	$40, $00, $00, $C0
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$08, $08, $08, $08
	spTotalLv	$10, $00, $00, $00

	; Patch $02
	; $07
	; $74, $31, $34, $71,	$1F, $1F, $1F, $1F
	; $8A, $8A, $8A, $8A,	$00, $00, $00, $00
	; $65, $65, $65, $65,	$80, $80, $80, $80
	spAlgorithm	$07
	spFeedback	$00
	spDetune	$07, $03, $03, $07
	spMultiple	$04, $04, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$01, $01, $01, $01
	spDecayRt	$0A, $0A, $0A, $0A
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$06, $06, $06, $06
	spReleaseRt	$05, $05, $05, $05
	spTotalLv	$00, $00, $00, $00

	; Patch $03
	; $2C
	; $31, $72, $70, $30,	$1F, $0D, $1F, $0D
	; $9F, $9F, $9F, $9F,	$00, $00, $00, $00
	; $02, $06, $02, $06,	$16, $80, $12, $80
	spAlgorithm	$04
	spFeedback	$05
	spDetune	$03, $07, $07, $03
	spMultiple	$01, $00, $02, $00
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $0D, $0D
	spAmpMod	$01, $01, $01, $01
	spDecayRt	$1F, $1F, $1F, $1F
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$00, $00, $00, $00
	spReleaseRt	$02, $02, $06, $06
	spTotalLv	$16, $12, $00, $00

	; Patch $04
	; $2A
	; $01, $01, $01, $01,	$0E, $0D, $0C, $0F
	; $87, $87, $80, $82,	$00, $01, $00, $00
	; $05, $05, $05, $08,	$1B, $39, $1B, $80
	spAlgorithm	$02
	spFeedback	$05
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$0E, $0C, $0D, $0F
	spAmpMod	$01, $01, $01, $01
	spDecayRt	$07, $00, $07, $02
	spSustainRt	$00, $00, $01, $00
	spSustainLv	$00, $00, $00, $00
	spReleaseRt	$05, $05, $05, $08
	spTotalLv	$1B, $1B, $39, $00

	; Patch $05
	; $2A
	; $01, $01, $01, $01,	$1E, $0F, $0F, $10
	; $87, $87, $80, $82,	$00, $01, $00, $00
	; $16, $16, $16, $1D,	$1B, $39, $1B, $80
	spAlgorithm	$02
	spFeedback	$05
	spDetune	$00, $00, $00, $00
	spMultiple	$01, $01, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1E, $0F, $0F, $10
	spAmpMod	$01, $01, $01, $01
	spDecayRt	$07, $00, $07, $02
	spSustainRt	$00, $00, $01, $00
	spSustainLv	$01, $01, $01, $01
	spReleaseRt	$06, $06, $06, $0D
	spTotalLv	$1B, $1B, $39, $00

	; Patch $06
	; $3E
	; $0A, $02, $02, $02,	$0A, $0C, $0C, $0C
	; $9F, $9F, $9F, $9F,	$00, $00, $00, $00
	; $05, $06, $06, $06,	$1E, $80, $80, $80
	spAlgorithm	$06
	spFeedback	$07
	spDetune	$00, $00, $00, $00
	spMultiple	$0A, $02, $02, $02
	spRateScale	$00, $00, $00, $00
	spAttackRt	$0A, $0C, $0C, $0C
	spAmpMod	$01, $01, $01, $01
	spDecayRt	$1F, $1F, $1F, $1F
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$00, $00, $00, $00
	spReleaseRt	$05, $06, $06, $06
	spTotalLv	$1E, $00, $00, $00

	; Patch $07
	; $04
	; $77, $31, $37, $71,	$1F, $0E, $1F, $0E
	; $82, $82, $82, $82,	$01, $01, $01, $01
	; $53, $36, $53, $36,	$25, $80, $25, $80
	spAlgorithm	$04
	spFeedback	$00
	spDetune	$07, $03, $03, $07
	spMultiple	$07, $07, $01, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $0E, $0E
	spAmpMod	$01, $01, $01, $01
	spDecayRt	$02, $02, $02, $02
	spSustainRt	$01, $01, $01, $01
	spSustainLv	$05, $05, $03, $03
	spReleaseRt	$03, $03, $06, $06
	spTotalLv	$25, $25, $00, $00

	; Patch $08
	; $2C
	; $31, $33, $73, $71,	$1F, $0E, $1F, $1F
	; $9F, $9F, $88, $9F,	$00, $00, $00, $00
	; $02, $07, $12, $06,	$17, $80, $15, $80
	spAlgorithm	$04
	spFeedback	$05
	spDetune	$03, $07, $03, $07
	spMultiple	$01, $03, $03, $01
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $0E, $1F
	spAmpMod	$01, $01, $01, $01
	spDecayRt	$1F, $08, $1F, $1F
	spSustainRt	$00, $00, $00, $00
	spSustainLv	$00, $01, $00, $00
	spReleaseRt	$02, $02, $07, $06
	spTotalLv	$17, $15, $00, $00

	; Patch $09
	; $01
	; $00, $0F, $00, $00,	$0A, $1F, $1F, $5F
	; $9F, $9F, $8F, $90,	$C0, $C0, $C0, $00
	; $FF, $FF, $F0, $FF,	$12, $25, $00, $80
	spAlgorithm	$01
	spFeedback	$00
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $00, $0F, $00
	spRateScale	$00, $00, $00, $01
	spAttackRt	$0A, $1F, $1F, $1F
	spAmpMod	$01, $01, $01, $01
	spDecayRt	$1F, $0F, $1F, $10
	spSustainRt	$C0, $C0, $C0, $00
	spSustainLv	$0F, $0F, $0F, $0F
	spReleaseRt	$0F, $00, $0F, $0F
	spTotalLv	$12, $00, $25, $00

	; Patch $0A
	; $2B
	; $00, $00, $00, $0F,	$1F, $1F, $1F, $1F
	; $92, $90, $85, $92,	$40, $00, $00, $00
	; $1F, $1F, $1F, $1F,	$10, $1B, $10, $80
	spAlgorithm	$03
	spFeedback	$05
	spDetune	$00, $00, $00, $00
	spMultiple	$00, $00, $00, $0F
	spRateScale	$00, $00, $00, $00
	spAttackRt	$1F, $1F, $1F, $1F
	spAmpMod	$01, $01, $01, $01
	spDecayRt	$12, $05, $10, $12
	spSustainRt	$40, $00, $00, $00
	spSustainLv	$01, $01, $01, $01
	spReleaseRt	$0F, $0F, $0F, $0F
	spTotalLv	$10, $10, $1B, $00
