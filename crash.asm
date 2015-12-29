crash	macro	id
	move	sr,Crash_SR		; copy Status Register to RAM
	move.b	#id,CrashID.w		; set crash ID
	bra.w	CrashHandler		; run crash handler
    endm
; ===========================================================================

	rsset $FFFF0000
Crash_D0	rs.l 1
Crash_D1	rs.l 1
Crash_D2	rs.l 1
Crash_D3	rs.l 1
Crash_D4	rs.l 1
Crash_D5	rs.l 1
Crash_D6	rs.l 1
Crash_D7	rs.l 1
Crash_A0	rs.l 1
Crash_A1	rs.l 1
Crash_A2	rs.l 1
Crash_A3	rs.l 1
Crash_A4	rs.l 1
Crash_A5	rs.l 1
Crash_A6	rs.l 1
Crash_A7	rs.l 1
Crash_Stack	rs.b $100
Crash_StackPtr	rs.b 0
Crash_SR	rs.w 1
CrashID		rs.b 1		; the ID of crash which is recorded for later reference.
; ===========================================================================

StackUnderflow:
		bra	*		; TODO: make code

AddressError:	crash 4+2
IllegalInstr:	crash 8+2
ZeroDivide:	crash 12+2
ChkInstr:	crash 16+2
TrapvInstr:	crash 20+2
PrivilegeViol:	crash 24+2
Trace:		crash 28+2
Line1010Emu:	crash 32+2
Line1111Emu:	crash 36+2
ErrorExcept:	crash 0+2

; ===========================================================================
CrashHandler:
		movem.l	d0-a7,Crash_A0.l		; store registers to RAM
		lea	Crash_StackPtr,a0		; get crash stack RAM
	; ensure stack is null, so we can more cleanly display stack
		moveq	#0,d1				; fill 0
		moveq	#($100/4)-1,d0			; get size of stack
.clr		move.l	d1,-(a0)			; clear long
		dbf	d0,.clr				; loop until clear
	; calculate the amount of used stack
		move.w	#Stack,d0			; get stack start address to d0
		sub.w	a7,d0				; sub stack address from d0
		bpl.s	.continue			; continue normally
		jmp	StackUnderflow(pc); ERROR:	Stack underflow

.continue	lsr.w	#1,d0				; halve the length
	; now we are copying the used stack to separate RAM
		lea	Crash_StackPtr,a0		; get crash stack RAM
		lea	Stack,a7			; get normal stack RAM
.copy		move.w	-(a7),-(a0)			; copy next word
		dbf	d0,.clr				; loop until done
	; write error name to screen
		moveq	#0,d3				; length of write
		move.b	CrashID,d3			; get crash ID
		lea	CrashNames(pc),a0		; get crash name strings
		move.w	-2(a0,d3.w),d4			; get length of the string
		adda.w	(a0,d3.w),a0			; add the offset to name
		move.l	#$40000003,d5			; location to write to in VRAM
		jsr	ShowString			; display error message



; ===========================================================================
CrashNames:
	dc.w 15, .ErrExpt-CrashNames
	dc.w 13, .Addr-CrashNames
	dc.w 19, .Illegal-CrashNames
	dc.w 11, .ZeroDiv-CrashNames
	dc.w 15, .Chk-CrashNames
	dc.w 17, .Trapv-CrashNames
	dc.w 19, .Priv-CrashNames
	dc.w  5, .Trace-CrashNames
	dc.w 15, .LineA-CrashNames
	dc.w 15, .LineF-CrashNames
	; you can here define custom error messages

.ErrExpt	asc.w 'ERROR EXECPTION'		; miscellaneous error.
.Addr		asc.w 'ADDRESS ERROR'		; address error
.illegal	asc.w 'ILLEGAL INSTRUCTION'	; illegal instruction (code runs in data likely)
,zerodiv	asc.w 'ZERO DIVIDE'		; zero divide (ex: 1/0)
.chk		asc.w 'CHK INSTRUCTION'		; CHK
.trapv		asc.w 'TRAPV INSTRUCTION'	; TRAPV
.priv		asc.w 'PRIVILEGE VIOLATION'	; Privilege violation (68k trying to use privileged instructions while supervisor mode)
.trace		asc.w 'TRACE'			; Tracing instruction. TODO: handle properly
.lineA		asc.w 'LINE A EMULATOR'		; line A emulator (running instruction that is not implemented in 68000)
.lineF		asc.w 'LINE F EMULATOR'		; line F emulator (running instruction that is not implemented in 68000)
; ===========================================================================
