crash	macro	id, frame
	move	sr,Crash_SR		; copy Status Register to RAM
	move.b	#id,CrashID		; set crash ID
	move.b	#frame,CrashStckFrm	; set stack frame size
	bra.w	CrashHandler		; run crash handler
    endm

error	macro	lable
	pea	offset(*)		; store "PC" to stack
	move	sr,-(sp)		; store sr to stack
	jmp	\lable			; go to crash handler subroutine
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
; for the next two, the actual location where stack was written wrongly to can't be
; determined. Use emulator debugger testing writes to overflow addresses
StackUnderflow:	crash 22, 6; custom error: If stack would underflow, run here
StackOverflow:	crash 24, 6; custom error: If stack would overflow, run here
; ===========================================================================
CrashHandler:; initialize the system
		movem.l	d0-a7,Crash_D0			; store registers to RAM
		moveq	#0,d0
		move.b	CrashStckFrm,d0			; get stack frame size
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
		bmi.s	.nostack; ERROR:	Stack underflow
		lsr.w	#1,d0				; halve the length

	; now we are copying the used stack to separate RAM
		lea	Crash_StackPtr,a0		; get crash stack RAM
		lea	Stack,a7			; get normal stack RAM
.copy		move.w	-(a7),-(a0)			; copy next word
		dbf	d0,.copy			; loop until done

	; write error name to screen
.nostack	moveq	#0,d6				; length of write
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
		moveq	#0,d2				; no or
		jsr	WriteNumberAddr2		; display

	; start by writing frame for CCR values
		lea	ConditionCodeStr2(pc),a0	; get CCR field string 2
		jsr	WriteString3.w			; display it

	; write CCR to screen
		move.w	Crash_SR,d3			; get status register
		moveq	#5-1,d0				; get the amount of CCR bits
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
		moveq	#0,d2				; no or
		jsr	WriteNumberAddr2		; finally write to display

	; write status register
		lea	srErrorStr(pc),a0		; get SR string
		moveq	#1,d5				; y-position
		moveq	#$16,d4				; x-position
		jsr	WriteString1.w			; display it
		move.w	(sp)+,d3			; get status register num
		jsr	WriteNumberWord2		; display value

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
		dbf	d0,.regsloop			; loop for each register

	; next write entire stack after the point it was used
		move.l	Crash_A7,a1			; get stack ptr to a0
		move.l	a1,d1				;
		sub.l	#StackStart,d1			; sub stack addr
		move.l	#$100,d0			; get stack size
		sub.l	d1,d0				; sub stack size from used size
		beq.s	.stack1done			; Special case: no stack history
		bmi.s	.stack1done			; Special case: Stack underflow
		move.w	d0,-(sp)			; store size of stack to stack
		lsr.w	#1,d0				; shift right once
		subq.w	#1,d0				; sub 1 for dbf
		sub.l	#Stack-Crash_StackPtr,a1	; sub the stack dfference from stack ptr

		moveq	#5-1,d1				; set amount of writes per line
		moveq	#0,d2				; no or for numbers
		move.w	#5,-(sp)			; store x-position to stack
		move.w	#13,-(sp)			; store y-position to stack

.nextLine	moveq	#0,d4				; x-position
		move.w	(sp),d5				; get y-position from stack
		lea	spWriteStr(pc),a0		; get the line start string.
		jsr	WriteString1.w			; display it

		move.w	4(sp),d3			; get the offset in the stack
		moveq	#2-1,d6				; 3 digits
		jsr	WriteNumberLoop.w		; write the offset number
		move.w	#$29,(a6)			; write : (colon)

.nextvalue	move.w	(a1)+,d3			; get next word
		move.w	(sp),d5				; get y-position from stack
		move.w	2(sp),d4			; get x-position from stack
		jsr	WriteNumberWord1		; display value

		add.w	#5,2(sp)			; advance x-position
		sub.w	#2,4(sp)			; sub 2 bytes from stack size left
		subq.w	#1,d0				; sub 1 from items left
		bmi.s	.stack1done			; if negative, stop
		dbf	d1,.nextvalue			; loop until line is done

		add.w	#1,(sp)				; go to next line
		move.w	#5,2(sp)			; reset x-offset
		moveq	#5-1,d1				; set amount of writes per line
		bra.s	.nextLine

.stack1done	addq.w	#6,sp				; clear out our variables from stack

	; next run special code for special interrupts
		moveq	#0,d0
		move.b	CrashID,d0			; get crash ID to d0
		move.w	CrashCodeTable(pc,d0.w),d0	; get offset value to d0
		jsr	CrashCodeTable(pc,d0.w)		; then jump to appropriate code

	; then poll for controllers until Start+A has been pressed, then reset.
.wait		jsr	VSync				; wait to poll controllers and next frame
		move.b	Ctrl1Held.w,d0			; get p1 held buttons
		or.b	Ctrl2Held.w,d0			; or p2 held buttons
		bpl.s	.wait				; if start was not pressed, wait more
		btst	#6,d0				; was A pressed?
		beq.s	.wait				; if not, branch
		jmp	ResetProgram.w			; reset the game
; ===========================================================================
CrashCodeTable:
	dc.w .addresserror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable
	dc.w .nullerror-CrashCodeTable

.nullerror	rts		; nothing here

.addresserror; write instruction register. Instruction register holds the first word of the opcode in MC68000
		move.l	Crash_A7,a1			; get crash stack ptr
		lea	irErrorStr(pc),a0		; get SR string
		moveq	#2,d5				; y-position
		moveq	#$16,d4				; x-position
		jsr	WriteString1.w			; display it
		move.w	-8(a1),d3			; get instruction register num
		jsr	WriteNumberWord2		; display value

	; next replaces USP with address error was in
		lea	addrErrorStr(pc),a0		; get SR string
		moveq	#1,d5				; y-position
		moveq	#$A,d4				; x-position
		jsr	WriteString1.w			; display it
		move.l	-12(a1),d3			; get the address
		jsr	WriteNumberAddr2		; display value

	; write bitfield info into screen
		lea	aesErrorStr(pc),a0		; get address error special bitfield string
		moveq	#$D,d4				; x-position
		moveq	#4,d5				; y-position
		jsr	WriteString1.w			; display it

	; write the bitfield bits
		moveq	#$D,d4				; x-position to write to
		moveq	#5,d5				; y-position to write to
		jsr	SetupStringWrite.w		; set position to write to

		move.w	-14(a1),d3			; get special bitfield
		moveq	#5-1,d0				; get the amount of bits
.doccr		moveq	#$49,d1				; no selection
		btst	d0,d3				; test if condition was set
		beq.s	.not				; branch if not
		moveq	#$48,d1				; has selection
.not		move.w	d1,(a6)				; write map to VDP
		dbf	d0,.doccr			; loop until all is done
		rts
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
	dc.w .stkunder-CrashNames
	dc.w .stkover-CrashNames
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
.stkunder	asc.w 0, '*||||||STACK|UNDERFLOW|||||||*'; stack underflow
.stkover	asc.w 0, '*|||||||STACK|OVERFLOW|||||||*'; stack overflow
; ===========================================================================
ConditionCodeStr:	asc2.w 0, ' BIT XNZVC  USP:$'
irErrorStr:		asc2.w 0, ' IR:$'
srErrorStr:		asc2.w 0, ' SR:$'
addrErrorStr:		asc2.w 0, 'ADDR:$'
ConditionCodeStr2:	asc2.w 0, '          CCR '
aesErrorStr:		asc2.w 0, 'RN012'	; R = Write(0)/Read(1), N = Instruction(0)/Not(1), 0-2 = Function Code(?)
pcErrorStr:		asc2.w 0, '   PC:$'
d0ErrorStr:		asc2.w 0, 'd0:$'
d1ErrorStr:		asc2.w 0, '        d1:$'
d2ErrorStr:		asc2.w 0, 'd2:$'
d3ErrorStr:		asc2.w 0, '        d3:$'
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
spWriteStr:		asc2.w 0, '-$'
; ===========================================================================
