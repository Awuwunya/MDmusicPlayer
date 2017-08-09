?dat {
	=endian "little"
	@offset 0 "Please specify offset of this song in Z80 bank"
}

?header {
	~£_Header
	^ .of
	! > sHeaderInit:;
	~£_Patches
	! > sHeaderPatch: .hw;
	=FMnum .db
	=PSGnum .nb
	! > sHeaderCh: .lb, .db;
	! > sHeaderTempo: .db, .db;
	~£_DAC
	! > sHeaderDAC: .aw;
	$ .sw;
	~£_FM#
	* \FMnum\ - 1 {
		! > sHeaderFM: .aw, .db, .db;
	}

	~£_PSG#
	* \PSGnum\ {
		! > sHeaderPSG: .aw, .db, .db, .db, .db {
			#4 {
				?volenv;
			}
		}
	}
}

?voices {
	=num 0
	=b1 0
	=b2 0
	=b3 0
	=b4 0
	* (.an-.pc)/25 {
		%; Patch {$2!\num\}\r\n\t; {$2!.db}\r\n\t; {$2!.db}, {$2!.db}, {$2!.db}, {$2!.db},\t{$2!.db}, {$2!.db}, {$2!.db}, {$2!.db}\r\n\t; {$2!.db}, {$2!.db}, {$2!.db}, {$2!.db},\t{$2!.db}, {$2!.db}, {$2!.db}, {$2!.db}\r\n\t; {$2!.db}, {$2!.db}, {$2!.db}, {$2!.db},\t{$2!.db}, {$2!.db}, {$2!.db}, {$2!.db}
		>b 25
		! > spAlgorithm: .nb&0x7;
		! > spFeedback: (.db&0x38)>>3;
		=b1 .db
		=b2 .db
		=b3 .db
		=b4 .db
		! > spDetune: (\b1\&0xF0)>>4, (\b2\&0xF0)>>4, (\b3\&0xF0)>>4, (\b4\&0xF0)>>4;
		! > spMultiple: \b1\&0xF, \b2\&0xF, \b3\&0xF, \b4\&0xF;
		=b1 .db
		=b2 .db
		=b3 .db
		=b4 .db
		! > spRateScale: (\b1\&0xC0)>>6, (\b2\&0xC0)>>6, (\b3\&0xC0)>>6, (\b4\&0xC0)>>6;
		! > spAttackRt: \b1\&0x1F, \b2\&0x1F, \b3\&0x1F, \b4\&0x1F;
		=b1 .db
		=b2 .db
		=b3 .db
		=b4 .db
		! > spAmpMod: (\b1\&0x80)>>7, (\b2\&0x80)>>7, (\b3\&0x80)>>7, (\b4\&0x80)>>7;
		! > spDecayRt: \b1\&0x1F, \b2\&0x1F, \b3\&0x1F, \b4\&0x1F;
		=b1 .db
		=b2 .db
		=b3 .db
		=b4 .db
		! > spSustainRt: \b1\, \b2\, \b3\, \b4\;
		=b1 .db
		=b2 .db
		=b3 .db
		=b4 .db
		! > spSustainLv: (\b1\&0xF0)>>4, (\b2\&0xF0)>>4, (\b3\&0xF0)>>4, (\b4\&0xF0)>>4;
		! > spReleaseRt: \b1\&0xF, \b2\&0xF, \b3\&0xF, \b4\&0xF;
		! > spTotalLv: .db&0x7F, .db&0x7F, .db&0x7F, .db&0x7F;
		=num \num\+1
	}
}

?DAC {
	=nRst 0x80
	=dKick 0x81
	=dSnare 0x83
	=dClap 0x84
	=dScratch 0x85
	=dTimpani 0x86
	=dHiTom 0x87
	=dVLowClap 0x88
	=dHiTimpani 0x89
	=dMidTimpani 0x8A
	=dLowTimpani 0x8B
	=dFloorTimpani 0x8C
	=dMidTom 0x8D
	=dLowTom 0x8E
	=dFloorTom 0x8F
	=dHiClap 0x90
	=dMidClapdLowClap 0x91
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
	=nC 0xA6
	=nD3 0xA7
	=nEb3 0xA8
	=nE3 0xA9
	=nF3 0xAA
	=nF 0xAB
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
	=nG6 0xD0
	=nAb6 0xD1
	=nA6 0xD2
	=nBb6 0xD3
	=nB6 0xD4
	=nC7 0xD5
	=nCs7 0xD6
	=nD7 0xD7
	=nEb7 0xD8
	=nE7 0xD9
	=nF7 0xDA
	=nFs7 0xDB
	=nG7 0xDC
	=nAb7 0xDD
	=nA7 0xDE
	=nBb7 0xDF
}

?volenv {
	=VolEnv_00 0
	=VolEnv_01 1
	=VolEnv_02 2
	=VolEnv_03 3
	=VolEnv_04 4
	=VolEnv_05 5
	=VolEnv_06 6
	=VolEnv_07 7
	=VolEnv_08 8
	=VolEnv_09 9
	=VolEnv_0A 8
	=VolEnv_0B 9
	=VolEnv_0C 8
}

?coordination {
	!0xE0 > sPan\t: .db & 0xC0, .lb & 0x3F {
		#0 {
			=spNone 0x00
			=spRight 0x40
			=spLeft 0x80
			=spCenter 0xC0
		}
	}
	!0xE1 > saDetune: .db;
	!0xE2 > sComm\t: .db;
	!0xE3 > sRet:{
		;
	}
	!0xE4 > sFade: {
		;
	}
	!0xE5 > ssTickMulCh: .db;
	!0xE6 > saVolFM\t: .db;
	=sHold 0xE7
	!0xE8 > sNoteTimeOut: .db;
	!0xE9 > saTranspose: .db;
	!0xEA > ssTempo\t: .db;
	!0xEB > ssTickMul: .db;
	!0xEC > saVolPSG: .db;
	!0xED > sNop:;
	!0xEE > sNop: .db;
	!0xEF > sPatFM\t: .db;
	!0xF0 > ssMod68k: .db, .db, .db, .db;
	!0xF1 > sModOn:;
	!0xF2 > sStop:{
		;
	}
	!0xF3 > sNoisePSG: .db;
	!0xF4 > sModOff:;
	!0xF5 > sVolEnvPSG: .db {
		#0 {
			?volenv;
		}
	}
	~£_Jump#
	!0xF6 > sJump\t: .ow {
		;
	}
	~£_Loop#
	!0xF7 > sLoop\t: .db, .db, .ow;
	~£_Call#
	!0xF8 > sCall\t: .ow;
	!0xF9 > sMuteFM1:;
}
