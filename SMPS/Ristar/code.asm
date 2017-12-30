; ===========================================================================
; ---------------------------------------------------------------------------
; Some fucking structures here to help us. Yeah its quite long >_>
; ---------------------------------------------------------------------------

	rsset 0
panstruct.anim:		rs.b 1
panstruct.index:		rs.b 1
panstruct.anilen:		rs.b 1
panstruct.master:		rs.b 1
panstruct.timeout:	rs.b 1
panstruct.sz		rs.b 0

	rsset 0
panvoc.voiceptr:	rs.l 1
panvoc.panctrl:		rs.b panstruct.sz
panvoc.Sz		rs.b 0

	rsset 0
Track.playback_control:	rs.b 1
Track.voice_control:	rs.b 1
Track.dividing_timing:	rs.b 1
Track.noise_sensitivity rs.b 1
Track.track_ptr:	rs.l 1
Track.key_delta:	rs.b 1
Track.volume:		rs.b 1
Track.mod_control:	rs.b 1
Track.voice:		rs.b 1
Track.flutter:		rs.b 1
Track.return_stack:	rs.b 1
Track.note_timeout:	rs.b 1
Track.last_note_duration:	rs.b 1
Track.note_frequency:	rs.w 1
Track.notefill_timeout:	rs.b 1
Track.notefill_master:	rs.b 1
Track.modulation_data_ptr:	rs.l 1
Track.mod_wait:		rs.b 1
Track.mod_speed:	rs.b 1
Track.mod_delta:	rs.b 1
Track.mod_steps:	rs.b 1
Track.mod_frequency:	rs.w 1
Track.frequency_adjust:	rs.b 1
Track.pan_control:	rs.b 1
Track.PanVoc:		rs.b panvoc.Sz
Track.feedbackalgorithm_noise:	rs.b 1
Track.noise_index:	rs.b 1
Track.amsfmspan:	rs.b 1
Track.loopindex:	rs.b 4
Track.note_cutoff:	rs.b 1
Track.SpecialNoteFill:	rs.b 1
Track.stop_notefill:	rs.b 1
Track.field_2F:	rs.b 1
Track.field_30:	rs.b 1
Track.field_31:	rs.b 1
Track.field_32:	rs.b 1
Track.field_33:	rs.b 1
Track.Sz	rs.b 0

	rsset 0
DACTrack.playback_control:	rs.b 1
DACTrack.voice_control:	rs.b 1
DACTrack.dividing_timing:	rs.b 1
DACTrack.field_3:	rs.b 1
DACTrack.track_ptr:	rs.l 1
DACTrack.key_delta:	rs.b 1
DACTrack.volume:		rs.b 1
DACTrack.field_A:	rs.b 1
DACTrack.field_B:	rs.b 1
DACTrack.field_C:	rs.b 1
DACTrack.field_D:	rs.b 1
DACTrack.note_timeout:	rs.b 1
DACTrack.last_note_duration:	rs.b 1
DACTrack.sample_id:	rs.b 1
DACTrack.field_11:	rs.b 1
DACTrack.notefill_timeout:	rs.b 1
DACTrack.notefill_master:	rs.b 1
DACTrack.field_14:	rs.b 1
DACTrack.field_15:	rs.b 1
DACTrack.dac_bank:	rs.b 1
DACTrack.dac_offset:	rs.w 1
DACTrack.dac_length:	rs.w 1
DACTrack.dac_length_high_byte:	rs.b 1
DACTrack.dac_length_low_word:	rs.w 1
DACTrack.field_1E:	rs.b 1
DACTrack.field_1F:	rs.b 1
DACTrack.field_20:	rs.b 1
DACTrack.field_21:	rs.b 1
DACTrack.field_22:	rs.b 1
DACTrack.field_23:	rs.b 1
DACTrack.field_24:	rs.b 1
DACTrack.field_25:	rs.b 1
DACTrack.field_26:	rs.b 1
DACTrack.field_27:	rs.b 1
DACTrack.loopindex:	rs.b 4
DACTrack.field_2C:	rs.b 1
DACTrack.field_2D:	rs.b 1
DACTrack.field_2E:	rs.b 1
DACTrack.field_2F:	rs.b 1
DACTrack.field_30:	rs.b 1
DACTrack.field_31:	rs.b 1
DACTrack.field_32:	rs.b 1
DACTrack.field_33:	rs.b 1
DACTrack.Sz	rs.b 0
; ===========================================================================
; ---------------------------------------------------------------------------
; Play a song
; ---------------------------------------------------------------------------

Ristar_play:
		move.l	d7,Driver68K+4		; set music pointer
	;	move.b	#$FF,Drv68Kmem+$A.w	; load driver
		move.b	#1,Drv68Kmem+$B.w	; play music id $81
; ===========================================================================
; ---------------------------------------------------------------------------
; Enable DMA
; ---------------------------------------------------------------------------

Ristar_dmaon:
; ===========================================================================
; ---------------------------------------------------------------------------
; Disable DMA
; ---------------------------------------------------------------------------

Ristar_dmaoff:
		rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Update driver data
; ---------------------------------------------------------------------------

Ristar_update:
		lea	sPSG3.w,a1		; get PSG3
		lea	.chns(pc),a2		; get table to a2
		moveq	#11-1,d0		; 11 channels
		moveq	#0,d1

.loop		move.w	(a2)+,a0		; get next channel
		tst.b	(a0)
		bpl.s	.inactive		; branch if channel is inactive
		bset	d0,d1			; set active bit

		move.b	Track.dividing_timing(a0),(a1); get tick multiplier
		move.b	Track.voice(a0),1(a1)	; get instrument
		move.b	Track.volume(a0),2(a1)	; get volume
		move.b	Track.note_timeout(a0),3(a1); get time counter

		move.w	Track.note_frequency(a0),d6; get freq to d6
		move.w	d6,4(a1)		; save it
		add.w	Track.mod_frequency(a0),d6; add mod freq

		move.b	Track.frequency_adjust(a0),d5; get detune
		ext.w	d5			; extend to word
		add.w	d5,d6			; add to mod freq
		move.w	d6,6(a1)		; save it

.inactive	addq.w	#8,a1			; advance offset
		dbf	d0,.loop		; loop until done

		move.w	d1,ActiveChn.w		; now set the active channels and be happy
		move.b	Drv68Kmem+$02.w,sTempo.w; get tempo
		st.b	sTickMul.w		; get tick multiplier
		rts

.chns		dc.w Drv68Kmem+$21E, Drv68Kmem+$1EA, Drv68Kmem+$1B6 			; PSG 1-3
		dc.w Drv68Kmem+$C00, Drv68Kmem+$182, Drv68Kmem+$14E 			; FM 4-5 (6 is not used)
		dc.w Drv68Kmem+$11A, Drv68Kmem+$E6,  Drv68Kmem+$B2			; FM 1-3
		dc.w Drv68Kmem+$7E,  Drv68Kmem+$4A					; DAC 1-2
; ===========================================================================
; ---------------------------------------------------------------------------
; Load SMPS sound driver
; ---------------------------------------------------------------------------

Ristar_load:
		move.b	#TYPE_SMPS,DriverType.w
		move.l	#sDualDriverPropertyData,DisplayList.w
		movem.l	PtrTable(pc),d0-d4	; load ptrs
		movem.l	d0-d4,Driver68K+8	; save to RAM

		; dirty init code
	startZ80
		moveq	#$10,d0
		dbf	d0,offset(*)
		jsr	Driver68K+$1C
		moveq	#$10,d0
		dbf	d0,offset(*)
	stopZ80
		rts

PtrTable:	dc.l PCMSimpleDriver, PCMDualDriver, PCMSamples, DACTable1
		dc.w DACTable2-DACTable1, 0
; ===========================================================================
; ---------------------------------------------------------------------------
; DAC driver stuff
; ---------------------------------------------------------------------------

PCMSimpleDriver:incbin "SMPS/Ristar/drivers/simple.unc"
PCMDualDriver:	incbin "SMPS/Ristar/drivers/dual.unc"
PCMSamples:	incbin "SMPS/Ristar/data/PCMSamples.unc"
		even
; ===========================================================================
; ---------------------------------------------------------------------------
; Entry for a DAC
; ---------------------------------------------------------------------------

DACTableEntry	macro id
	dc.l DAC\id\, DAC\id\_End-DAC\id\, 0, 0
    endm
; ===========================================================================
; ---------------------------------------------------------------------------
; Include sample
; ---------------------------------------------------------------------------

saminc		macro id
	rept narg
DAC\id		incbin "SMPS/Ristar/dac/dac_\id\.bin"
DAC\id\_End
	shift
	endr
    endm
; ===========================================================================
; ---------------------------------------------------------------------------
; Z80 word macro
; ---------------------------------------------------------------------------

dw	macro val
	rept narg
		dc.b ((\val)&$FF), ((\val)>>8&$FF)
		shift
	endr
    endm
; ===========================================================================
; ---------------------------------------------------------------------------
; DAC pointer table
; ---------------------------------------------------------------------------

DACTable1:	DACTableEntry 01
		DACTableEntry 02
		DACTableEntry 03
		DACTableEntry 04
		DACTableEntry 05
		DACTableEntry 06
		DACTableEntry 07
		DACTableEntry 08
DACTable2:	DACTableEntry 09
		DACTableEntry 0A
		DACTableEntry 0B
		DACTableEntry 0C
		DACTableEntry 0D
		DACTableEntry 0E
		DACTableEntry 0F
		DACTableEntry 10
		DACTableEntry 11
		DACTableEntry 12
		DACTableEntry 13
		DACTableEntry 14
		DACTableEntry 15
		DACTableEntry 16
		DACTableEntry 17
		DACTableEntry 18
		DACTableEntry 19
		DACTableEntry 1A
		DACTableEntry 1B
		DACTableEntry 1C
		DACTableEntry 1D
		DACTableEntry 1E
		DACTableEntry 1F
		DACTableEntry 20
		DACTableEntry 21
		DACTableEntry 22
		DACTableEntry 23
		DACTableEntry 24
		DACTableEntry 25
		DACTableEntry 26
		DACTableEntry 27
		DACTableEntry 28
		DACTableEntry 29
		DACTableEntry 2A
		DACTableEntry 2B
		DACTableEntry 2C
		DACTableEntry 2D
		DACTableEntry 2E
		DACTableEntry 2F
		DACTableEntry 30
		DACTableEntry 31
		DACTableEntry 32
		DACTableEntry 33
		DACTableEntry 34
		DACTableEntry 35
		DACTableEntry 36
		DACTableEntry 37
		DACTableEntry 38
		DACTableEntry 39
		DACTableEntry 3A
		DACTableEntry 3B
; ===========================================================================
; ---------------------------------------------------------------------------
; Sample includes
; ---------------------------------------------------------------------------

	saminc 01, 02, 03, 04, 05, 06, 07, 08
	saminc 09, 0A, 0B, 0C, 0D, 0E, 0F, 10
	saminc 11, 12, 13, 14, 15, 16, 17, 18
	saminc 19, 1A, 1B, 1C, 1D, 1E, 1F, 20
	saminc 21, 22, 23, 24, 25, 26, 27, 28
	saminc 29, 2A, 2B, 2C, 2D, 2E, 2F, 30
	saminc 31, 32, 33, 34, 35, 36, 37, 38
	saminc 39, 3A, 3B
	even
; ===========================================================================
