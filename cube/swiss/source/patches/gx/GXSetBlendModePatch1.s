#include "../asm.h"
#define _LANGUAGE_ASSEMBLY
#include "../../../../reservedarea.h"

.globl GXSetBlendModePatch1
GXSetBlendModePatch1:
	lwz		%r10, 0 (0)
	lwz		%r9, 464 (%r10)
	cmpwi	%cr0, %r3, 1
	cmpwi	%cr1, %r3, 2
	cmpwi	%cr5, %r3, 3
	cror	4*%cr0+so, 4*%cr0+eq, 4*%cr5+eq
	insrwi	%r9, %r4, 3, 21
	cmpwi	%cr6, %r4, 0
	insrwi	%r9, %r5, 3, 24
	cmpwi	%cr7, %r5, 0
	crand	4*%cr7+gt, 4*%cr7+gt, 4*%cr6+gt
	cror	4*%cr7+gt, 4*%cr7+gt, 4*%cr0+gt
	insrwi	%r9, %r6, 4, 16
	mfcr	%r0
	rlwimi	%r9, %r0, 4, 31, 31
	rlwimi	%r9, %r0, 8, 30, 30
	rlwimi	%r9, %r0, 2, 20, 20
	stw		%r9, 464 (%r10)
	rlwinm	%r0, %r0, 0, 29, 29
	andc	%r9, %r9, %r0
	lis		%r8, 0xCC01
	li		%r7, 0x61
	stb		%r7, -0x8000 (%r8)
	stw		%r9, -0x8000 (%r8)
	sth		%r8, 2 (%r10)
	blr

.globl GXSetBlendModePatch1_length
GXSetBlendModePatch1_length:
.long (GXSetBlendModePatch1_length - GXSetBlendModePatch1)