crash	macro	id, frame
	move	sr,Crash_SR		; copy Status Register to RAM
	move.b	#id,CrashID		; set crash ID
	move.b	#frame,CrashStckFrm	; set stack frame size
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
CrashStckFrm	rs.b 1		; the size of the stack frame for the interrupt
; ===========================================================================

StackUnderflow:
		bra	offset(*)		; TODO: make code

AddressError:	crash  0,14
ErrorExcept:	crash  2, 6
IllegalInstr:	crash  4, 6
ZeroDivide:	crash  6, 6
ChkInstr:	crash  8, 6
TrapvInstr:	crash 10, 6
PrivilegeViol:	crash 12, 6
Trace:		crash 14, 6
Line1010Emu:	crash 16, 6
Line1111Emu:	crash 18, 6
ErrorTrap:	crash 20, 6

; ===========================================================================
CrashHandler:; initialize the system
		movem.l	d0-a7,Crash_D0			; store registers to RAM
		moveq	#0,d0
		move.b	CrashStckFrm,d0
		add.l	d0,Crash_A7			; sub stack frame size from A7
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
		dbf	d0,.copy			; loop until done

	; write error name to screen
		moveq	#0,d6				; length of write
		move.b	CrashID,d6			; get crash ID
		lea	CrashNames(pc),a0		; get crash name strings
		adda.w	(a0,d6.w),a0			; add the offset to name
		moveq	#1,d4				; x-position to write to
		moveq	#0,d5				; y-position to write to
		moveq	#30-1,d6			; length of the string
		jsr	WriteString2.w			; display error message

	; wirte some information and USP
		lea	ConditionCodeStr(pc),a0		; get CCR field string
		jsr	WriteString3.w			; display it
		move.l	usp,a0				; get usp
		move.l	a0,d3				; put to a3
		jsr	WriteNumberAddr2		; display

	; start by writing frame for CCR values
		lea	ConditionCodeStr2(pc),a0	; get CCR field string 2
		jsr	WriteString3.w			; display it

	; write CCR to screen
		move.w	Crash_SR,d3			; get status register
		moveq	#4,d0				; get the amount of CCR bits
.doccr		moveq	#$49,d1				; no selection
		btst	d0,d3				; test if condition was set
		beq.s	.not				; branch if not
		moveq	#$48,d1				; has selection
.not		move.w	d1,(a6)				; write map to VDP
		dbf	d0,.doccr			; loop until all is done

	; next write Status Register value. Clears out CCR
		andi.b	#$E0,d3				; clear ccr
		move.w	d3,-(sp)

	; next write PC register info
		lea	pcErrorStr(pc),a0		; get PC string
		jsr	WriteString3.w			; display

		move.l	Crash_A7,d0			; get old stack ptr
		sub.l	#Stack-Crash_StackPtr,d0	; sub the stack dfference from stack ptr
		movea.l	d0,a0				; get the final stack address to a0
		move.l	-4(a0),d3			; get the PC addredd to d3
		jsr	WriteNumberAddr2		; finally write to display

	; write d0-a7
		moveq	#0,d4				; x-position to write to
		moveq	#4,d5				; y-position to write to
		jsr	SetupStringWrite.w		; set position to write to

		lea	d0ErrorStr(pc),a0		; get the strings
		lea	Crash_D0,a1			; get values
		moveq	#8+8-1,d0			; this is the amount of registers

.regsloop	jsr	WriteString3.w			; display regsiter string
		move.l	(a1)+,d3			; get register value
		jsr	WriteNumberLong2		; display value

		cmp.b	#6+8-1,d0			; is this after d2 string?
		bne.s	.nextreg			; if not, branch
		jsr	WriteString3.w			; display status regsiter string 2
		move.w	(sp)+,d3			; get status register num
		jsr	WriteNumberWord2		; display value
.nextreg	dbf	d0,.regsloop			; loop for each register

		bra	offset(*)		; for not loop indefinately. TODO: run reset polling code

; ===========================================================================
CrashNames:
	dc.w .Addr-CrashNames
	dc.w .ErrExpt-CrashNames
	dc.w .Illegal-CrashNames
	dc.w .zerodiv-CrashNames
	dc.w .Chk-CrashNames
	dc.w .Trapv-CrashNames
	dc.w .Priv-CrashNames
	dc.w .Trace-CrashNames
	dc.w .LineA-CrashNames
	dc.w .LineF-CrashNames
	dc.w .trapped-CrashNames
	; you can here define custom error messages

.ErrExpt	asc.w 0, '*||||||ERROR|EXECPTION|||||||*'; miscellaneous error.
.Addr		asc.w 0, '*|||||||ADDRESS|ERROR||||||||*'; address error
.illegal	asc.w 0, '*||||ILLEGAL|INSTRUCTION|||||*'; illegal instruction (code runs in data likely)
.zerodiv	asc.w 0, '*|||||||ZERO|DIVISION||||||||*'; zero divide (ex: 1/0)
.chk		asc.w 0, '*|||||||CHK|INSTRUCTION||||||*'; CHK
.trapv		asc.w 0, '*||||||TRAPV|INSTRUCTION|||||*'; TRAPV
.priv		asc.w 0, '*|||||PRIVILEGE|VIOLATION||||*'; Privilege violation (68k trying to use privileged instructions while supervisor mode)
.trace		asc.w 0, '*||||||||||||TRACE|||||||||||*'; Tracing instruction. TODO: handle properly
.lineA		asc.w 0, '*|||||||LINE|A|EMULATOR||||||*'; line A emulator (running instruction that is not implemented in 68000)
.lineF		asc.w 0, '*|||||||LINE|F|EMULATOR||||||*'; line F emulator (running instruction that is not implemented in 68000)
.trapped	asc.w 0, '*||||||||||ERRORTRAP|||||||||*'; ran into ErrorTrap.

; ===========================================================================
ConditionCodeStr:	asc2.w 0, ' BIT * = SET XNZVC USP:$'
ConditionCodeStr2:	asc2.w 0, '   CCR - = CLR '
pcErrorStr:		asc2.w 0, '  PC:$'
d0ErrorStr:		asc2.w 0, 'd0:$'
d1ErrorStr:		asc2.w 0, '  SR:   d1:$'
d2ErrorStr:		asc2.w 0, 'd2:$'
srErrorStr:		asc2.w 0, ' $'
d3ErrorStr:		asc2.w 0, '  d3:$'
d4ErrorStr:		asc2.w 0, 'd4:$'
d5ErrorStr:		asc2.w 0, '        d5:$'
d6ErrorStr:		asc2.w 0, 'd6:$'
d7ErrorStr:		asc2.w 0, '        d7:$'
a0ErrorStr:		asc2.w 0, 'a0:$'
a1ErrorStr:		asc2.w 0, '        a1:$'
a2ErrorStr:		asc2.w 0, 'a2:$'
a3ErrorStr:		asc2.w 0, '        a3:$'
a4ErrorStr:		asc2.w 0, 'a4:$'
a5ErrorStr:		asc2.w 0, '        a5:$'
a6ErrorStr:		asc2.w 0, 'a6:$'
spErrorStr:		asc2.w 0, '        sp:$'
; ===========================================================================
