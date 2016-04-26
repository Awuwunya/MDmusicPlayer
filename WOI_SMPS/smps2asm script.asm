?dat {
	=endian "little"
	@offset 0 "Please specify offset of this song in Z80 bank"
}

?header {
	~£_Voices
	! > smpsHeaderVoice: /aw;
	=FMnum /db
	=PSGnum /nb
	! > smpsHeaderChan: /lb, /db;
	! > smpsHeaderTempo: /db, /db;
	~£_DAC
	! > smpsHeaderDAC: /aw;
	$ /sw;
	~£_FM#
	* \FMnum\ - 1 {
		! > smpsHeaderFM: /aw, /db, /db;
	}

	~£_PSG#
	* \PSGnum\ {
		! > smpsHeaderPSG: /aw, /db, /db, /db, /db {
			#4 {
				=sTone_01 1
				=sTone_02 2
				=sTone_03 3
				=sTone_04 4
				=sTone_05 5
				=sTone_06 6
				=sTone_07 7
				=sTone_08 8
				=sTone_09 9
				=sTone_0A 0x0A
				=sTone_0B 0x0B
				=sTone_0C 0x0C
				=sTone_0D 0x0D
				=sTone_0E 0x0E
				=sTone_0F 0x0F
				=sTone_10 0x10
				=sTone_11 0x11
				=sTone_12 0x12
				=sTone_13 0x13
				=sTone_14 0x14
				=sTone_15 0x15
				=sTone_16 0x16
				=sTone_17 0x17
			}
		}
	}
}

?Voices {
	=num 0
	=b1 0
	=b2 0
	=b3 0
	=b4 0
	%; Voice {$2!\num\}\r\n\t; {$2!/db}\r\n\t; {$2!/db}, {$2!/db}, {$2!/db}, {$2!/db},\t{$2!/db}, {$2!/db}, {$2!/db}, {$2!/db}\r\n\t; {$2!/db}, {$2!/db}, {$2!/db}, {$2!/db},\t{$2!/db}, {$2!/db}, {$2!/db}, {$2!/db}\r\n\t; {$2!/db}, {$2!/db}, {$2!/db}, {$2!/db},\t{$2!/db}, {$2!/db}, {$2!/db}, {$2!/db}
	>b 17
	! > smpsVcAlgorithm: /nb&0x7;
	! > smpsVcFeedback: (/db&0x38)>>3;
	=b1 /db
	=b2 /db
	=b3 /db
	=b4 /db
	! > smpsVcDetune: (\b4\&0xF0)>>4, (\b3\&0xF0)>>4, (\b2\&0xF0)>>4, (\b1\&0xF0)>>4;
	! > smpsVcCoarseFreq: \b4\&0xF, \b3\&0xF, \b2\&0xF, \b1\&0xF;
	=b1 /db
	=b2 /db
	=b3 /db
	=b4 /db
	! > smpsVcRateScale: (\b4\&0xC0)>>6, (\b3\&0xC0)>>6, (\b2\&0xC0)>>6, (\b1\&0xC0)>>6;
	! > smpsVcAttackRate: \b4\&0x1F, \b3\&0x1F, \b2\&0x1F, \b1\&0x1F;
	=b1 /db
	=b2 /db
	=b3 /db
	=b4 /db
	! > smpsVcAmpMod: (\b4\&0x80)>>7, (\b3\&0x80)>>7, (\b2\&0x80)>>7, (\b1\&0x80)>>7;
	! > smpsVcDecayRate1: \b4\&0x1F, \b3\&0x1F, \b2\&0x1F, \b1\&0x1F;
	=b1 /db
	=b2 /db
	=b3 /db
	=b4 /db
	! > smpsVcDecayRate2: \b4\, \b3\, \b2\, \b1\;
	=b1 /db
	=b2 /db
	=b3 /db
	=b4 /db
	! > smpsVcDecayLevel: (\b4\&0xF0)>>4, (\b3\&0xF0)>>4, (\b2\&0xF0)>>4, (\b1\&0xF0)>>4;
	! > smpsVcReleaseRate: \b4\&0xF, \b3\&0xF, \b2\&0xF, \b1\&0xF;
	=b1 /db
	=b2 /db
	=b3 /db
	! > smpsVcTotalLevel: /db&0x7F, \b3\&0x7F, \b2\&0x7F, \b1\&0x7F;
	=num \num\+1
}

?DAC {
	=nRst 0x80
	=dSnareS3 0x81
}

?note {
	=nRst 0x80
	=nC0 0x81
	=nCs0 0x82
	=nD0 0x83
	=nEb0 0x84
	=nE0 0x85
	=nF0 0x86
	=nFs0 0x87
	=nG0 0x88
	=nAb0 0x89
	=nA0 0x8A
	=nBb0 0x8B
	=nB0 0x8C
	=nC1 0x8D
	=nCs1 0x8E
	=nD1 0x8F
	=nEb1 0x90
	=nE1 0x91
	=nF1 0x92
	=nFs1 0x93
	=nG1 0x94
	=nAb1 0x95
	=nA1 0x96
	=nBb1 0x97
	=nB1 0x98
	=nC2 0x99
	=nCs2 0x9A
	=nD2 0x9B
	=nEb2 0x9C
	=nE2 0x9D
	=nF2 0x9E
	=nFs2 0x9F
	=nG2 0xA0
	=nAb2 0xA1
	=nA2 0xA2
	=nBb2 0xA3
	=nB2 0xA4
	=nC3 0xA5
	=nCs3 0xA6
	=nD3 0xA7
	=nEb3 0xA8
	=nE3 0xA9
	=nF3 0xAA
	=nFs3 0xAB
	=nG3 0xAC
	=nAb3 0xAD
	=nA3 0xAE
	=nBb3 0xAF
	=nB3 0xB0
	=nC4 0xB1
	=nCs4 0xB2
	=nD4 0xB3
	=nEb4 0xB4
	=nE4 0xB5
	=nF4 0xB6
	=nFs4 0xB7
	=nG4 0xB8
	=nAb4 0xB9
	=nA4 0xBA
	=nBb4 0xBB
	=nB4 0xBC
	=nC5 0xBD
	=nCs5 0xBE
	=nD5 0xBF
	=nEb5 0xC0
	=nE5 0xC1
	=nF5 0xC2
	=nFs5 0xC3
	=nG5 0xC4
	=nAb5 0xC5
	=nA5 0xC6
	=nBb5 0xC7
	=nB5 0xC8
	=nC6 0xC9
	=nCs6 0xCA
	=nD6 0xCB
	=nEb6 0xCC
	=nE6 0xCD
	=nF6 0xCE
	=nFs6 0xCF
}

?coordination {
	¤ /nb >= 0xD0 && /nb < 0xE0 {
		! > smpsVolQuick: /db&0xF;
	}
	!0xE0 > smpsPan: /db & 0xC0, /lb & 0x3F {
		#0 {
			=panNone 0x00
			=panRight 0x40
			=panLeft 0x80
			=panCentre 0xC0
		}
	}
	!0xE1 > smpsAlterNote: /db;
	!0xE2 > smpsSetComm: /db;
	!0xE3 > smpsStopFM:;
	!0xE4 > smpsCondJump: /aw{
		;
	}
	!0xE5 > smpsBaseVolSet: /db;
	!0xE6 > smpsFMAlterVol: /db;
	=smpsNoAttack 0xE7
	!0xE8 > smpsNoteFill: /db;
	!0xE9 > smpsLF0: /db, /db;
	!0xEA > smpsPlayDACSample: /db | 0x80;
	!0xEB > smpsConditionalJump: /db, /aw;
	!0xEC > smpsPSGAlterVol: /db;
	!0xED > smpsSetTempoMod: /db;
	!0xEE > smpsSetTempoDiv: /db;
	!0xEF > smpsSetvoice: /db;
	!0xF0 > smpsModSet: /db, /db, /db, /db;
	!0xF1 > smpsAlterPitch2: /db;
	!0xF2 > smpsStop:{
		;
	}
	!0xF3 > smpsPSGform: /db;
	!0xF4, 0x80 > smpsModOn:;
	!0xF4 > smpsModChange: /db;
	!0xF5 > smpsPSGvoice: /db {
		#0 {
			=sTone_01 1
			=sTone_02 2
			=sTone_03 3
			=sTone_04 4
			=sTone_05 5
			=sTone_06 6
			=sTone_07 7
			=sTone_08 8
			=sTone_09 9
			=sTone_0A 0x0A
			=sTone_0B 0x0B
			=sTone_0C 0x0C
			=sTone_0D 0x0D
			=sTone_0E 0x0E
			=sTone_0F 0x0F
			=sTone_10 0x10
			=sTone_11 0x11
			=sTone_12 0x12
			=sTone_13 0x13
			=sTone_14 0x14
			=sTone_15 0x15
			=sTone_16 0x16
			=sTone_17 0x17
		}
	}
	~£_Jump#
	!0xF6 > smpsJump: /aw{
		;
	}
	~£_Loop#
	!0xF7 > smpsLoop: /db, /db, /aw;
	~£_Call#
	!0xF8 > smpsCall: /aw;
	!0xF9 > smpsReturn:{
		;
	}
	!0xFA > smpsChanTempoDiv: /db;
	!0xFB > smpsAlterPitch: /db;
	!0xFC > smpsPitchSlide: /db;
	!0xFD > smpsAlternateSMPS: /db;
	!0xFE > smpsFM3SpecialMode: /db, /db, /db, /db;
	!0xFF > smpsVolQuick: /db&0xF;
}
