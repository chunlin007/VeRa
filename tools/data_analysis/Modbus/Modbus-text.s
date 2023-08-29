
DICE-Evaluation/ARM/Fuzzing/Firmware/Binaries/Modbus.elf:     file format elf32-littlearm


Disassembly of section .text:

080001a0 <__do_global_dtors_aux>:
 80001a0:	b510      	push	{r4, lr}
 80001a2:	4c05      	ldr	r4, [pc, #20]	; (80001b8 <__do_global_dtors_aux+0x18>)
 80001a4:	7823      	ldrb	r3, [r4, #0]
 80001a6:	b933      	cbnz	r3, 80001b6 <__do_global_dtors_aux+0x16>
 80001a8:	4b04      	ldr	r3, [pc, #16]	; (80001bc <__do_global_dtors_aux+0x1c>)
 80001aa:	b113      	cbz	r3, 80001b2 <__do_global_dtors_aux+0x12>
 80001ac:	4804      	ldr	r0, [pc, #16]	; (80001c0 <__do_global_dtors_aux+0x20>)
 80001ae:	f3af 8000 	nop.w
 80001b2:	2301      	movs	r3, #1
 80001b4:	7023      	strb	r3, [r4, #0]
 80001b6:	bd10      	pop	{r4, pc}
 80001b8:	2000043c 	.word	0x2000043c
 80001bc:	00000000 	.word	0x00000000
 80001c0:	08002cdc 	.word	0x08002cdc

080001c4 <frame_dummy>:
 80001c4:	b508      	push	{r3, lr}
 80001c6:	4b03      	ldr	r3, [pc, #12]	; (80001d4 <frame_dummy+0x10>)
 80001c8:	b11b      	cbz	r3, 80001d2 <frame_dummy+0xe>
 80001ca:	4903      	ldr	r1, [pc, #12]	; (80001d8 <frame_dummy+0x14>)
 80001cc:	4803      	ldr	r0, [pc, #12]	; (80001dc <frame_dummy+0x18>)
 80001ce:	f3af 8000 	nop.w
 80001d2:	bd08      	pop	{r3, pc}
 80001d4:	00000000 	.word	0x00000000
 80001d8:	20000440 	.word	0x20000440
 80001dc:	08002cdc 	.word	0x08002cdc

080001e0 <memcpy>:
 80001e0:	4684      	mov	ip, r0
 80001e2:	ea41 0300 	orr.w	r3, r1, r0
 80001e6:	f013 0303 	ands.w	r3, r3, #3
 80001ea:	d16d      	bne.n	80002c8 <memcpy+0xe8>
 80001ec:	3a40      	subs	r2, #64	; 0x40
 80001ee:	d341      	bcc.n	8000274 <memcpy+0x94>
 80001f0:	f851 3b04 	ldr.w	r3, [r1], #4
 80001f4:	f840 3b04 	str.w	r3, [r0], #4
 80001f8:	f851 3b04 	ldr.w	r3, [r1], #4
 80001fc:	f840 3b04 	str.w	r3, [r0], #4
 8000200:	f851 3b04 	ldr.w	r3, [r1], #4
 8000204:	f840 3b04 	str.w	r3, [r0], #4
 8000208:	f851 3b04 	ldr.w	r3, [r1], #4
 800020c:	f840 3b04 	str.w	r3, [r0], #4
 8000210:	f851 3b04 	ldr.w	r3, [r1], #4
 8000214:	f840 3b04 	str.w	r3, [r0], #4
 8000218:	f851 3b04 	ldr.w	r3, [r1], #4
 800021c:	f840 3b04 	str.w	r3, [r0], #4
 8000220:	f851 3b04 	ldr.w	r3, [r1], #4
 8000224:	f840 3b04 	str.w	r3, [r0], #4
 8000228:	f851 3b04 	ldr.w	r3, [r1], #4
 800022c:	f840 3b04 	str.w	r3, [r0], #4
 8000230:	f851 3b04 	ldr.w	r3, [r1], #4
 8000234:	f840 3b04 	str.w	r3, [r0], #4
 8000238:	f851 3b04 	ldr.w	r3, [r1], #4
 800023c:	f840 3b04 	str.w	r3, [r0], #4
 8000240:	f851 3b04 	ldr.w	r3, [r1], #4
 8000244:	f840 3b04 	str.w	r3, [r0], #4
 8000248:	f851 3b04 	ldr.w	r3, [r1], #4
 800024c:	f840 3b04 	str.w	r3, [r0], #4
 8000250:	f851 3b04 	ldr.w	r3, [r1], #4
 8000254:	f840 3b04 	str.w	r3, [r0], #4
 8000258:	f851 3b04 	ldr.w	r3, [r1], #4
 800025c:	f840 3b04 	str.w	r3, [r0], #4
 8000260:	f851 3b04 	ldr.w	r3, [r1], #4
 8000264:	f840 3b04 	str.w	r3, [r0], #4
 8000268:	f851 3b04 	ldr.w	r3, [r1], #4
 800026c:	f840 3b04 	str.w	r3, [r0], #4
 8000270:	3a40      	subs	r2, #64	; 0x40
 8000272:	d2bd      	bcs.n	80001f0 <memcpy+0x10>
 8000274:	3230      	adds	r2, #48	; 0x30
 8000276:	d311      	bcc.n	800029c <memcpy+0xbc>
 8000278:	f851 3b04 	ldr.w	r3, [r1], #4
 800027c:	f840 3b04 	str.w	r3, [r0], #4
 8000280:	f851 3b04 	ldr.w	r3, [r1], #4
 8000284:	f840 3b04 	str.w	r3, [r0], #4
 8000288:	f851 3b04 	ldr.w	r3, [r1], #4
 800028c:	f840 3b04 	str.w	r3, [r0], #4
 8000290:	f851 3b04 	ldr.w	r3, [r1], #4
 8000294:	f840 3b04 	str.w	r3, [r0], #4
 8000298:	3a10      	subs	r2, #16
 800029a:	d2ed      	bcs.n	8000278 <memcpy+0x98>
 800029c:	320c      	adds	r2, #12
 800029e:	d305      	bcc.n	80002ac <memcpy+0xcc>
 80002a0:	f851 3b04 	ldr.w	r3, [r1], #4
 80002a4:	f840 3b04 	str.w	r3, [r0], #4
 80002a8:	3a04      	subs	r2, #4
 80002aa:	d2f9      	bcs.n	80002a0 <memcpy+0xc0>
 80002ac:	3204      	adds	r2, #4
 80002ae:	d008      	beq.n	80002c2 <memcpy+0xe2>
 80002b0:	07d2      	lsls	r2, r2, #31
 80002b2:	bf1c      	itt	ne
 80002b4:	f811 3b01 	ldrbne.w	r3, [r1], #1
 80002b8:	f800 3b01 	strbne.w	r3, [r0], #1
 80002bc:	d301      	bcc.n	80002c2 <memcpy+0xe2>
 80002be:	880b      	ldrh	r3, [r1, #0]
 80002c0:	8003      	strh	r3, [r0, #0]
 80002c2:	4660      	mov	r0, ip
 80002c4:	4770      	bx	lr
 80002c6:	bf00      	nop
 80002c8:	2a08      	cmp	r2, #8
 80002ca:	d313      	bcc.n	80002f4 <memcpy+0x114>
 80002cc:	078b      	lsls	r3, r1, #30
 80002ce:	d08d      	beq.n	80001ec <memcpy+0xc>
 80002d0:	f010 0303 	ands.w	r3, r0, #3
 80002d4:	d08a      	beq.n	80001ec <memcpy+0xc>
 80002d6:	f1c3 0304 	rsb	r3, r3, #4
 80002da:	1ad2      	subs	r2, r2, r3
 80002dc:	07db      	lsls	r3, r3, #31
 80002de:	bf1c      	itt	ne
 80002e0:	f811 3b01 	ldrbne.w	r3, [r1], #1
 80002e4:	f800 3b01 	strbne.w	r3, [r0], #1
 80002e8:	d380      	bcc.n	80001ec <memcpy+0xc>
 80002ea:	f831 3b02 	ldrh.w	r3, [r1], #2
 80002ee:	f820 3b02 	strh.w	r3, [r0], #2
 80002f2:	e77b      	b.n	80001ec <memcpy+0xc>
 80002f4:	3a04      	subs	r2, #4
 80002f6:	d3d9      	bcc.n	80002ac <memcpy+0xcc>
 80002f8:	3a01      	subs	r2, #1
 80002fa:	f811 3b01 	ldrb.w	r3, [r1], #1
 80002fe:	f800 3b01 	strb.w	r3, [r0], #1
 8000302:	d2f9      	bcs.n	80002f8 <memcpy+0x118>
 8000304:	780b      	ldrb	r3, [r1, #0]
 8000306:	7003      	strb	r3, [r0, #0]
 8000308:	784b      	ldrb	r3, [r1, #1]
 800030a:	7043      	strb	r3, [r0, #1]
 800030c:	788b      	ldrb	r3, [r1, #2]
 800030e:	7083      	strb	r3, [r0, #2]
 8000310:	4660      	mov	r0, ip
 8000312:	4770      	bx	lr

08000314 <HAL_IncTick>:
 8000314:	b480      	push	{r7}
 8000316:	af00      	add	r7, sp, #0
 8000318:	4b05      	ldr	r3, [pc, #20]	; (8000330 <HAL_IncTick+0x1c>)
 800031a:	781b      	ldrb	r3, [r3, #0]
 800031c:	461a      	mov	r2, r3
 800031e:	4b05      	ldr	r3, [pc, #20]	; (8000334 <HAL_IncTick+0x20>)
 8000320:	681b      	ldr	r3, [r3, #0]
 8000322:	4413      	add	r3, r2
 8000324:	4a03      	ldr	r2, [pc, #12]	; (8000334 <HAL_IncTick+0x20>)
 8000326:	6013      	str	r3, [r2, #0]
 8000328:	bf00      	nop
 800032a:	46bd      	mov	sp, r7
 800032c:	bc80      	pop	{r7}
 800032e:	4770      	bx	lr
 8000330:	20000004 	.word	0x20000004
 8000334:	200042b8 	.word	0x200042b8

08000338 <HAL_SYSTICK_IRQHandler>:
 8000338:	b580      	push	{r7, lr}
 800033a:	af00      	add	r7, sp, #0
 800033c:	f000 f802 	bl	8000344 <HAL_SYSTICK_Callback>
 8000340:	bf00      	nop
 8000342:	bd80      	pop	{r7, pc}

08000344 <HAL_SYSTICK_Callback>:
 8000344:	b480      	push	{r7}
 8000346:	af00      	add	r7, sp, #0
 8000348:	bf00      	nop
 800034a:	46bd      	mov	sp, r7
 800034c:	bc80      	pop	{r7}
 800034e:	4770      	bx	lr

08000350 <LL_RCC_HSI_IsReady>:
 8000350:	b480      	push	{r7}
 8000352:	af00      	add	r7, sp, #0
 8000354:	4b06      	ldr	r3, [pc, #24]	; (8000370 <LL_RCC_HSI_IsReady+0x20>)
 8000356:	681b      	ldr	r3, [r3, #0]
 8000358:	f003 0302 	and.w	r3, r3, #2
 800035c:	2b02      	cmp	r3, #2
 800035e:	bf0c      	ite	eq
 8000360:	2301      	moveq	r3, #1
 8000362:	2300      	movne	r3, #0
 8000364:	b2db      	uxtb	r3, r3
 8000366:	4618      	mov	r0, r3
 8000368:	46bd      	mov	sp, r7
 800036a:	bc80      	pop	{r7}
 800036c:	4770      	bx	lr
 800036e:	bf00      	nop
 8000370:	40021000 	.word	0x40021000

08000374 <LL_RCC_LSE_IsReady>:
 8000374:	b480      	push	{r7}
 8000376:	af00      	add	r7, sp, #0
 8000378:	4b06      	ldr	r3, [pc, #24]	; (8000394 <LL_RCC_LSE_IsReady+0x20>)
 800037a:	6a1b      	ldr	r3, [r3, #32]
 800037c:	f003 0302 	and.w	r3, r3, #2
 8000380:	2b02      	cmp	r3, #2
 8000382:	bf0c      	ite	eq
 8000384:	2301      	moveq	r3, #1
 8000386:	2300      	movne	r3, #0
 8000388:	b2db      	uxtb	r3, r3
 800038a:	4618      	mov	r0, r3
 800038c:	46bd      	mov	sp, r7
 800038e:	bc80      	pop	{r7}
 8000390:	4770      	bx	lr
 8000392:	bf00      	nop
 8000394:	40021000 	.word	0x40021000

08000398 <LL_RCC_GetSysClkSource>:
 8000398:	b480      	push	{r7}
 800039a:	af00      	add	r7, sp, #0
 800039c:	4b03      	ldr	r3, [pc, #12]	; (80003ac <LL_RCC_GetSysClkSource+0x14>)
 800039e:	685b      	ldr	r3, [r3, #4]
 80003a0:	f003 030c 	and.w	r3, r3, #12
 80003a4:	4618      	mov	r0, r3
 80003a6:	46bd      	mov	sp, r7
 80003a8:	bc80      	pop	{r7}
 80003aa:	4770      	bx	lr
 80003ac:	40021000 	.word	0x40021000

080003b0 <LL_RCC_GetAHBPrescaler>:
 80003b0:	b480      	push	{r7}
 80003b2:	af00      	add	r7, sp, #0
 80003b4:	4b03      	ldr	r3, [pc, #12]	; (80003c4 <LL_RCC_GetAHBPrescaler+0x14>)
 80003b6:	685b      	ldr	r3, [r3, #4]
 80003b8:	f003 03f0 	and.w	r3, r3, #240	; 0xf0
 80003bc:	4618      	mov	r0, r3
 80003be:	46bd      	mov	sp, r7
 80003c0:	bc80      	pop	{r7}
 80003c2:	4770      	bx	lr
 80003c4:	40021000 	.word	0x40021000

080003c8 <LL_RCC_GetAPB1Prescaler>:
 80003c8:	b480      	push	{r7}
 80003ca:	af00      	add	r7, sp, #0
 80003cc:	4b03      	ldr	r3, [pc, #12]	; (80003dc <LL_RCC_GetAPB1Prescaler+0x14>)
 80003ce:	685b      	ldr	r3, [r3, #4]
 80003d0:	f403 63e0 	and.w	r3, r3, #1792	; 0x700
 80003d4:	4618      	mov	r0, r3
 80003d6:	46bd      	mov	sp, r7
 80003d8:	bc80      	pop	{r7}
 80003da:	4770      	bx	lr
 80003dc:	40021000 	.word	0x40021000

080003e0 <LL_RCC_GetAPB2Prescaler>:
 80003e0:	b480      	push	{r7}
 80003e2:	af00      	add	r7, sp, #0
 80003e4:	4b03      	ldr	r3, [pc, #12]	; (80003f4 <LL_RCC_GetAPB2Prescaler+0x14>)
 80003e6:	685b      	ldr	r3, [r3, #4]
 80003e8:	f403 5360 	and.w	r3, r3, #14336	; 0x3800
 80003ec:	4618      	mov	r0, r3
 80003ee:	46bd      	mov	sp, r7
 80003f0:	bc80      	pop	{r7}
 80003f2:	4770      	bx	lr
 80003f4:	40021000 	.word	0x40021000

080003f8 <LL_RCC_GetUSARTClockSource>:
 80003f8:	b480      	push	{r7}
 80003fa:	b083      	sub	sp, #12
 80003fc:	af00      	add	r7, sp, #0
 80003fe:	6078      	str	r0, [r7, #4]
 8000400:	4b07      	ldr	r3, [pc, #28]	; (8000420 <LL_RCC_GetUSARTClockSource+0x28>)
 8000402:	6b1a      	ldr	r2, [r3, #48]	; 0x30
 8000404:	2103      	movs	r1, #3
 8000406:	687b      	ldr	r3, [r7, #4]
 8000408:	fa01 f303 	lsl.w	r3, r1, r3
 800040c:	401a      	ands	r2, r3
 800040e:	687b      	ldr	r3, [r7, #4]
 8000410:	061b      	lsls	r3, r3, #24
 8000412:	4313      	orrs	r3, r2
 8000414:	4618      	mov	r0, r3
 8000416:	370c      	adds	r7, #12
 8000418:	46bd      	mov	sp, r7
 800041a:	bc80      	pop	{r7}
 800041c:	4770      	bx	lr
 800041e:	bf00      	nop
 8000420:	40021000 	.word	0x40021000

08000424 <LL_RCC_PLL_GetMainSource>:
 8000424:	b480      	push	{r7}
 8000426:	af00      	add	r7, sp, #0
 8000428:	4b03      	ldr	r3, [pc, #12]	; (8000438 <LL_RCC_PLL_GetMainSource+0x14>)
 800042a:	685b      	ldr	r3, [r3, #4]
 800042c:	f403 33c0 	and.w	r3, r3, #98304	; 0x18000
 8000430:	4618      	mov	r0, r3
 8000432:	46bd      	mov	sp, r7
 8000434:	bc80      	pop	{r7}
 8000436:	4770      	bx	lr
 8000438:	40021000 	.word	0x40021000

0800043c <LL_RCC_PLL_GetMultiplicator>:
 800043c:	b480      	push	{r7}
 800043e:	af00      	add	r7, sp, #0
 8000440:	4b03      	ldr	r3, [pc, #12]	; (8000450 <LL_RCC_PLL_GetMultiplicator+0x14>)
 8000442:	685b      	ldr	r3, [r3, #4]
 8000444:	f403 1370 	and.w	r3, r3, #3932160	; 0x3c0000
 8000448:	4618      	mov	r0, r3
 800044a:	46bd      	mov	sp, r7
 800044c:	bc80      	pop	{r7}
 800044e:	4770      	bx	lr
 8000450:	40021000 	.word	0x40021000

08000454 <LL_RCC_PLL_GetPrediv>:
 8000454:	b480      	push	{r7}
 8000456:	af00      	add	r7, sp, #0
 8000458:	4b03      	ldr	r3, [pc, #12]	; (8000468 <LL_RCC_PLL_GetPrediv+0x14>)
 800045a:	6adb      	ldr	r3, [r3, #44]	; 0x2c
 800045c:	f003 030f 	and.w	r3, r3, #15
 8000460:	4618      	mov	r0, r3
 8000462:	46bd      	mov	sp, r7
 8000464:	bc80      	pop	{r7}
 8000466:	4770      	bx	lr
 8000468:	40021000 	.word	0x40021000

0800046c <LL_RCC_GetUSARTClockFreq>:
 800046c:	b580      	push	{r7, lr}
 800046e:	b084      	sub	sp, #16
 8000470:	af00      	add	r7, sp, #0
 8000472:	6078      	str	r0, [r7, #4]
 8000474:	2300      	movs	r3, #0
 8000476:	60fb      	str	r3, [r7, #12]
 8000478:	687b      	ldr	r3, [r7, #4]
 800047a:	2b00      	cmp	r3, #0
 800047c:	d12a      	bne.n	80004d4 <LL_RCC_GetUSARTClockFreq+0x68>
 800047e:	6878      	ldr	r0, [r7, #4]
 8000480:	f7ff ffba 	bl	80003f8 <LL_RCC_GetUSARTClockSource>
 8000484:	4603      	mov	r3, r0
 8000486:	2b02      	cmp	r3, #2
 8000488:	d00f      	beq.n	80004aa <LL_RCC_GetUSARTClockFreq+0x3e>
 800048a:	2b03      	cmp	r3, #3
 800048c:	d005      	beq.n	800049a <LL_RCC_GetUSARTClockFreq+0x2e>
 800048e:	2b01      	cmp	r3, #1
 8000490:	d114      	bne.n	80004bc <LL_RCC_GetUSARTClockFreq+0x50>
 8000492:	f000 f8a3 	bl	80005dc <RCC_GetSystemClockFreq>
 8000496:	60f8      	str	r0, [r7, #12]
 8000498:	e021      	b.n	80004de <LL_RCC_GetUSARTClockFreq+0x72>
 800049a:	f7ff ff59 	bl	8000350 <LL_RCC_HSI_IsReady>
 800049e:	4603      	mov	r3, r0
 80004a0:	2b00      	cmp	r3, #0
 80004a2:	d019      	beq.n	80004d8 <LL_RCC_GetUSARTClockFreq+0x6c>
 80004a4:	4b46      	ldr	r3, [pc, #280]	; (80005c0 <LL_RCC_GetUSARTClockFreq+0x154>)
 80004a6:	60fb      	str	r3, [r7, #12]
 80004a8:	e016      	b.n	80004d8 <LL_RCC_GetUSARTClockFreq+0x6c>
 80004aa:	f7ff ff63 	bl	8000374 <LL_RCC_LSE_IsReady>
 80004ae:	4603      	mov	r3, r0
 80004b0:	2b00      	cmp	r3, #0
 80004b2:	d013      	beq.n	80004dc <LL_RCC_GetUSARTClockFreq+0x70>
 80004b4:	f44f 4300 	mov.w	r3, #32768	; 0x8000
 80004b8:	60fb      	str	r3, [r7, #12]
 80004ba:	e00f      	b.n	80004dc <LL_RCC_GetUSARTClockFreq+0x70>
 80004bc:	f000 f88e 	bl	80005dc <RCC_GetSystemClockFreq>
 80004c0:	4603      	mov	r3, r0
 80004c2:	4618      	mov	r0, r3
 80004c4:	f000 f8ac 	bl	8000620 <RCC_GetHCLKClockFreq>
 80004c8:	4603      	mov	r3, r0
 80004ca:	4618      	mov	r0, r3
 80004cc:	f000 f8d2 	bl	8000674 <RCC_GetPCLK2ClockFreq>
 80004d0:	60f8      	str	r0, [r7, #12]
 80004d2:	e004      	b.n	80004de <LL_RCC_GetUSARTClockFreq+0x72>
 80004d4:	bf00      	nop
 80004d6:	e002      	b.n	80004de <LL_RCC_GetUSARTClockFreq+0x72>
 80004d8:	bf00      	nop
 80004da:	e000      	b.n	80004de <LL_RCC_GetUSARTClockFreq+0x72>
 80004dc:	bf00      	nop
 80004de:	687b      	ldr	r3, [r7, #4]
 80004e0:	2b10      	cmp	r3, #16
 80004e2:	d12d      	bne.n	8000540 <LL_RCC_GetUSARTClockFreq+0xd4>
 80004e4:	6878      	ldr	r0, [r7, #4]
 80004e6:	f7ff ff87 	bl	80003f8 <LL_RCC_GetUSARTClockSource>
 80004ea:	4603      	mov	r3, r0
 80004ec:	4a35      	ldr	r2, [pc, #212]	; (80005c4 <LL_RCC_GetUSARTClockFreq+0x158>)
 80004ee:	4293      	cmp	r3, r2
 80004f0:	d011      	beq.n	8000516 <LL_RCC_GetUSARTClockFreq+0xaa>
 80004f2:	4a35      	ldr	r2, [pc, #212]	; (80005c8 <LL_RCC_GetUSARTClockFreq+0x15c>)
 80004f4:	4293      	cmp	r3, r2
 80004f6:	d006      	beq.n	8000506 <LL_RCC_GetUSARTClockFreq+0x9a>
 80004f8:	4a34      	ldr	r2, [pc, #208]	; (80005cc <LL_RCC_GetUSARTClockFreq+0x160>)
 80004fa:	4293      	cmp	r3, r2
 80004fc:	d114      	bne.n	8000528 <LL_RCC_GetUSARTClockFreq+0xbc>
 80004fe:	f000 f86d 	bl	80005dc <RCC_GetSystemClockFreq>
 8000502:	60f8      	str	r0, [r7, #12]
 8000504:	e021      	b.n	800054a <LL_RCC_GetUSARTClockFreq+0xde>
 8000506:	f7ff ff23 	bl	8000350 <LL_RCC_HSI_IsReady>
 800050a:	4603      	mov	r3, r0
 800050c:	2b00      	cmp	r3, #0
 800050e:	d019      	beq.n	8000544 <LL_RCC_GetUSARTClockFreq+0xd8>
 8000510:	4b2b      	ldr	r3, [pc, #172]	; (80005c0 <LL_RCC_GetUSARTClockFreq+0x154>)
 8000512:	60fb      	str	r3, [r7, #12]
 8000514:	e016      	b.n	8000544 <LL_RCC_GetUSARTClockFreq+0xd8>
 8000516:	f7ff ff2d 	bl	8000374 <LL_RCC_LSE_IsReady>
 800051a:	4603      	mov	r3, r0
 800051c:	2b00      	cmp	r3, #0
 800051e:	d013      	beq.n	8000548 <LL_RCC_GetUSARTClockFreq+0xdc>
 8000520:	f44f 4300 	mov.w	r3, #32768	; 0x8000
 8000524:	60fb      	str	r3, [r7, #12]
 8000526:	e00f      	b.n	8000548 <LL_RCC_GetUSARTClockFreq+0xdc>
 8000528:	f000 f858 	bl	80005dc <RCC_GetSystemClockFreq>
 800052c:	4603      	mov	r3, r0
 800052e:	4618      	mov	r0, r3
 8000530:	f000 f876 	bl	8000620 <RCC_GetHCLKClockFreq>
 8000534:	4603      	mov	r3, r0
 8000536:	4618      	mov	r0, r3
 8000538:	f000 f888 	bl	800064c <RCC_GetPCLK1ClockFreq>
 800053c:	60f8      	str	r0, [r7, #12]
 800053e:	e004      	b.n	800054a <LL_RCC_GetUSARTClockFreq+0xde>
 8000540:	bf00      	nop
 8000542:	e002      	b.n	800054a <LL_RCC_GetUSARTClockFreq+0xde>
 8000544:	bf00      	nop
 8000546:	e000      	b.n	800054a <LL_RCC_GetUSARTClockFreq+0xde>
 8000548:	bf00      	nop
 800054a:	687b      	ldr	r3, [r7, #4]
 800054c:	2b12      	cmp	r3, #18
 800054e:	d12d      	bne.n	80005ac <LL_RCC_GetUSARTClockFreq+0x140>
 8000550:	6878      	ldr	r0, [r7, #4]
 8000552:	f7ff ff51 	bl	80003f8 <LL_RCC_GetUSARTClockSource>
 8000556:	4603      	mov	r3, r0
 8000558:	4a1d      	ldr	r2, [pc, #116]	; (80005d0 <LL_RCC_GetUSARTClockFreq+0x164>)
 800055a:	4293      	cmp	r3, r2
 800055c:	d011      	beq.n	8000582 <LL_RCC_GetUSARTClockFreq+0x116>
 800055e:	4a1d      	ldr	r2, [pc, #116]	; (80005d4 <LL_RCC_GetUSARTClockFreq+0x168>)
 8000560:	4293      	cmp	r3, r2
 8000562:	d006      	beq.n	8000572 <LL_RCC_GetUSARTClockFreq+0x106>
 8000564:	4a1c      	ldr	r2, [pc, #112]	; (80005d8 <LL_RCC_GetUSARTClockFreq+0x16c>)
 8000566:	4293      	cmp	r3, r2
 8000568:	d114      	bne.n	8000594 <LL_RCC_GetUSARTClockFreq+0x128>
 800056a:	f000 f837 	bl	80005dc <RCC_GetSystemClockFreq>
 800056e:	60f8      	str	r0, [r7, #12]
 8000570:	e021      	b.n	80005b6 <LL_RCC_GetUSARTClockFreq+0x14a>
 8000572:	f7ff feed 	bl	8000350 <LL_RCC_HSI_IsReady>
 8000576:	4603      	mov	r3, r0
 8000578:	2b00      	cmp	r3, #0
 800057a:	d019      	beq.n	80005b0 <LL_RCC_GetUSARTClockFreq+0x144>
 800057c:	4b10      	ldr	r3, [pc, #64]	; (80005c0 <LL_RCC_GetUSARTClockFreq+0x154>)
 800057e:	60fb      	str	r3, [r7, #12]
 8000580:	e016      	b.n	80005b0 <LL_RCC_GetUSARTClockFreq+0x144>
 8000582:	f7ff fef7 	bl	8000374 <LL_RCC_LSE_IsReady>
 8000586:	4603      	mov	r3, r0
 8000588:	2b00      	cmp	r3, #0
 800058a:	d013      	beq.n	80005b4 <LL_RCC_GetUSARTClockFreq+0x148>
 800058c:	f44f 4300 	mov.w	r3, #32768	; 0x8000
 8000590:	60fb      	str	r3, [r7, #12]
 8000592:	e00f      	b.n	80005b4 <LL_RCC_GetUSARTClockFreq+0x148>
 8000594:	f000 f822 	bl	80005dc <RCC_GetSystemClockFreq>
 8000598:	4603      	mov	r3, r0
 800059a:	4618      	mov	r0, r3
 800059c:	f000 f840 	bl	8000620 <RCC_GetHCLKClockFreq>
 80005a0:	4603      	mov	r3, r0
 80005a2:	4618      	mov	r0, r3
 80005a4:	f000 f852 	bl	800064c <RCC_GetPCLK1ClockFreq>
 80005a8:	60f8      	str	r0, [r7, #12]
 80005aa:	e004      	b.n	80005b6 <LL_RCC_GetUSARTClockFreq+0x14a>
 80005ac:	bf00      	nop
 80005ae:	e002      	b.n	80005b6 <LL_RCC_GetUSARTClockFreq+0x14a>
 80005b0:	bf00      	nop
 80005b2:	e000      	b.n	80005b6 <LL_RCC_GetUSARTClockFreq+0x14a>
 80005b4:	bf00      	nop
 80005b6:	68fb      	ldr	r3, [r7, #12]
 80005b8:	4618      	mov	r0, r3
 80005ba:	3710      	adds	r7, #16
 80005bc:	46bd      	mov	sp, r7
 80005be:	bd80      	pop	{r7, pc}
 80005c0:	007a1200 	.word	0x007a1200
 80005c4:	10020000 	.word	0x10020000
 80005c8:	10030000 	.word	0x10030000
 80005cc:	10010000 	.word	0x10010000
 80005d0:	12080000 	.word	0x12080000
 80005d4:	120c0000 	.word	0x120c0000
 80005d8:	12040000 	.word	0x12040000

080005dc <RCC_GetSystemClockFreq>:
 80005dc:	b580      	push	{r7, lr}
 80005de:	b082      	sub	sp, #8
 80005e0:	af00      	add	r7, sp, #0
 80005e2:	2300      	movs	r3, #0
 80005e4:	607b      	str	r3, [r7, #4]
 80005e6:	f7ff fed7 	bl	8000398 <LL_RCC_GetSysClkSource>
 80005ea:	4603      	mov	r3, r0
 80005ec:	2b04      	cmp	r3, #4
 80005ee:	d006      	beq.n	80005fe <RCC_GetSystemClockFreq+0x22>
 80005f0:	2b08      	cmp	r3, #8
 80005f2:	d007      	beq.n	8000604 <RCC_GetSystemClockFreq+0x28>
 80005f4:	2b00      	cmp	r3, #0
 80005f6:	d109      	bne.n	800060c <RCC_GetSystemClockFreq+0x30>
 80005f8:	4b08      	ldr	r3, [pc, #32]	; (800061c <RCC_GetSystemClockFreq+0x40>)
 80005fa:	607b      	str	r3, [r7, #4]
 80005fc:	e009      	b.n	8000612 <RCC_GetSystemClockFreq+0x36>
 80005fe:	4b07      	ldr	r3, [pc, #28]	; (800061c <RCC_GetSystemClockFreq+0x40>)
 8000600:	607b      	str	r3, [r7, #4]
 8000602:	e006      	b.n	8000612 <RCC_GetSystemClockFreq+0x36>
 8000604:	f000 f84a 	bl	800069c <RCC_PLL_GetFreqDomain_SYS>
 8000608:	6078      	str	r0, [r7, #4]
 800060a:	e002      	b.n	8000612 <RCC_GetSystemClockFreq+0x36>
 800060c:	4b03      	ldr	r3, [pc, #12]	; (800061c <RCC_GetSystemClockFreq+0x40>)
 800060e:	607b      	str	r3, [r7, #4]
 8000610:	bf00      	nop
 8000612:	687b      	ldr	r3, [r7, #4]
 8000614:	4618      	mov	r0, r3
 8000616:	3708      	adds	r7, #8
 8000618:	46bd      	mov	sp, r7
 800061a:	bd80      	pop	{r7, pc}
 800061c:	007a1200 	.word	0x007a1200

08000620 <RCC_GetHCLKClockFreq>:
 8000620:	b580      	push	{r7, lr}
 8000622:	b082      	sub	sp, #8
 8000624:	af00      	add	r7, sp, #0
 8000626:	6078      	str	r0, [r7, #4]
 8000628:	f7ff fec2 	bl	80003b0 <LL_RCC_GetAHBPrescaler>
 800062c:	4603      	mov	r3, r0
 800062e:	091b      	lsrs	r3, r3, #4
 8000630:	f003 030f 	and.w	r3, r3, #15
 8000634:	4a04      	ldr	r2, [pc, #16]	; (8000648 <RCC_GetHCLKClockFreq+0x28>)
 8000636:	5cd3      	ldrb	r3, [r2, r3]
 8000638:	461a      	mov	r2, r3
 800063a:	687b      	ldr	r3, [r7, #4]
 800063c:	40d3      	lsrs	r3, r2
 800063e:	4618      	mov	r0, r3
 8000640:	3708      	adds	r7, #8
 8000642:	46bd      	mov	sp, r7
 8000644:	bd80      	pop	{r7, pc}
 8000646:	bf00      	nop
 8000648:	08002d08 	.word	0x08002d08

0800064c <RCC_GetPCLK1ClockFreq>:
 800064c:	b580      	push	{r7, lr}
 800064e:	b082      	sub	sp, #8
 8000650:	af00      	add	r7, sp, #0
 8000652:	6078      	str	r0, [r7, #4]
 8000654:	f7ff feb8 	bl	80003c8 <LL_RCC_GetAPB1Prescaler>
 8000658:	4603      	mov	r3, r0
 800065a:	0a1b      	lsrs	r3, r3, #8
 800065c:	4a04      	ldr	r2, [pc, #16]	; (8000670 <RCC_GetPCLK1ClockFreq+0x24>)
 800065e:	5cd3      	ldrb	r3, [r2, r3]
 8000660:	461a      	mov	r2, r3
 8000662:	687b      	ldr	r3, [r7, #4]
 8000664:	40d3      	lsrs	r3, r2
 8000666:	4618      	mov	r0, r3
 8000668:	3708      	adds	r7, #8
 800066a:	46bd      	mov	sp, r7
 800066c:	bd80      	pop	{r7, pc}
 800066e:	bf00      	nop
 8000670:	08002d18 	.word	0x08002d18

08000674 <RCC_GetPCLK2ClockFreq>:
 8000674:	b580      	push	{r7, lr}
 8000676:	b082      	sub	sp, #8
 8000678:	af00      	add	r7, sp, #0
 800067a:	6078      	str	r0, [r7, #4]
 800067c:	f7ff feb0 	bl	80003e0 <LL_RCC_GetAPB2Prescaler>
 8000680:	4603      	mov	r3, r0
 8000682:	0adb      	lsrs	r3, r3, #11
 8000684:	4a04      	ldr	r2, [pc, #16]	; (8000698 <RCC_GetPCLK2ClockFreq+0x24>)
 8000686:	5cd3      	ldrb	r3, [r2, r3]
 8000688:	461a      	mov	r2, r3
 800068a:	687b      	ldr	r3, [r7, #4]
 800068c:	40d3      	lsrs	r3, r2
 800068e:	4618      	mov	r0, r3
 8000690:	3708      	adds	r7, #8
 8000692:	46bd      	mov	sp, r7
 8000694:	bd80      	pop	{r7, pc}
 8000696:	bf00      	nop
 8000698:	08002d18 	.word	0x08002d18

0800069c <RCC_PLL_GetFreqDomain_SYS>:
 800069c:	b590      	push	{r4, r7, lr}
 800069e:	b085      	sub	sp, #20
 80006a0:	af00      	add	r7, sp, #0
 80006a2:	2300      	movs	r3, #0
 80006a4:	60fb      	str	r3, [r7, #12]
 80006a6:	2300      	movs	r3, #0
 80006a8:	60bb      	str	r3, [r7, #8]
 80006aa:	f7ff febb 	bl	8000424 <LL_RCC_PLL_GetMainSource>
 80006ae:	60b8      	str	r0, [r7, #8]
 80006b0:	68bb      	ldr	r3, [r7, #8]
 80006b2:	f5b3 4f00 	cmp.w	r3, #32768	; 0x8000
 80006b6:	d003      	beq.n	80006c0 <RCC_PLL_GetFreqDomain_SYS+0x24>
 80006b8:	f5b3 3f80 	cmp.w	r3, #65536	; 0x10000
 80006bc:	d003      	beq.n	80006c6 <RCC_PLL_GetFreqDomain_SYS+0x2a>
 80006be:	e005      	b.n	80006cc <RCC_PLL_GetFreqDomain_SYS+0x30>
 80006c0:	4b14      	ldr	r3, [pc, #80]	; (8000714 <RCC_PLL_GetFreqDomain_SYS+0x78>)
 80006c2:	60fb      	str	r3, [r7, #12]
 80006c4:	e005      	b.n	80006d2 <RCC_PLL_GetFreqDomain_SYS+0x36>
 80006c6:	4b13      	ldr	r3, [pc, #76]	; (8000714 <RCC_PLL_GetFreqDomain_SYS+0x78>)
 80006c8:	60fb      	str	r3, [r7, #12]
 80006ca:	e002      	b.n	80006d2 <RCC_PLL_GetFreqDomain_SYS+0x36>
 80006cc:	4b11      	ldr	r3, [pc, #68]	; (8000714 <RCC_PLL_GetFreqDomain_SYS+0x78>)
 80006ce:	60fb      	str	r3, [r7, #12]
 80006d0:	bf00      	nop
 80006d2:	f7ff febf 	bl	8000454 <LL_RCC_PLL_GetPrediv>
 80006d6:	4603      	mov	r3, r0
 80006d8:	f003 030f 	and.w	r3, r3, #15
 80006dc:	3301      	adds	r3, #1
 80006de:	68fa      	ldr	r2, [r7, #12]
 80006e0:	fbb2 f4f3 	udiv	r4, r2, r3
 80006e4:	f7ff feaa 	bl	800043c <LL_RCC_PLL_GetMultiplicator>
 80006e8:	4603      	mov	r3, r0
 80006ea:	f403 1370 	and.w	r3, r3, #3932160	; 0x3c0000
 80006ee:	f44f 1270 	mov.w	r2, #3932160	; 0x3c0000
 80006f2:	607a      	str	r2, [r7, #4]
 80006f4:	687a      	ldr	r2, [r7, #4]
 80006f6:	fa92 f2a2 	rbit	r2, r2
 80006fa:	603a      	str	r2, [r7, #0]
 80006fc:	683a      	ldr	r2, [r7, #0]
 80006fe:	fab2 f282 	clz	r2, r2
 8000702:	40d3      	lsrs	r3, r2
 8000704:	3302      	adds	r3, #2
 8000706:	fb03 f304 	mul.w	r3, r3, r4
 800070a:	4618      	mov	r0, r3
 800070c:	3714      	adds	r7, #20
 800070e:	46bd      	mov	sp, r7
 8000710:	bd90      	pop	{r4, r7, pc}
 8000712:	bf00      	nop
 8000714:	007a1200 	.word	0x007a1200

08000718 <osSystickHandler>:
 8000718:	b580      	push	{r7, lr}
 800071a:	af00      	add	r7, sp, #0
 800071c:	f001 f8ba 	bl	8001894 <xTaskGetSchedulerState>
 8000720:	4603      	mov	r3, r0
 8000722:	2b01      	cmp	r3, #1
 8000724:	d001      	beq.n	800072a <osSystickHandler+0x12>
 8000726:	f001 fb0f 	bl	8001d48 <xPortSysTickHandler>
 800072a:	bf00      	nop
 800072c:	bd80      	pop	{r7, pc}

0800072e <vListInitialise>:
 800072e:	b480      	push	{r7}
 8000730:	b083      	sub	sp, #12
 8000732:	af00      	add	r7, sp, #0
 8000734:	6078      	str	r0, [r7, #4]
 8000736:	687b      	ldr	r3, [r7, #4]
 8000738:	f103 0208 	add.w	r2, r3, #8
 800073c:	687b      	ldr	r3, [r7, #4]
 800073e:	605a      	str	r2, [r3, #4]
 8000740:	687b      	ldr	r3, [r7, #4]
 8000742:	f04f 32ff 	mov.w	r2, #4294967295	; 0xffffffff
 8000746:	609a      	str	r2, [r3, #8]
 8000748:	687b      	ldr	r3, [r7, #4]
 800074a:	f103 0208 	add.w	r2, r3, #8
 800074e:	687b      	ldr	r3, [r7, #4]
 8000750:	60da      	str	r2, [r3, #12]
 8000752:	687b      	ldr	r3, [r7, #4]
 8000754:	f103 0208 	add.w	r2, r3, #8
 8000758:	687b      	ldr	r3, [r7, #4]
 800075a:	611a      	str	r2, [r3, #16]
 800075c:	687b      	ldr	r3, [r7, #4]
 800075e:	2200      	movs	r2, #0
 8000760:	601a      	str	r2, [r3, #0]
 8000762:	bf00      	nop
 8000764:	370c      	adds	r7, #12
 8000766:	46bd      	mov	sp, r7
 8000768:	bc80      	pop	{r7}
 800076a:	4770      	bx	lr

0800076c <vListInitialiseItem>:
 800076c:	b480      	push	{r7}
 800076e:	b083      	sub	sp, #12
 8000770:	af00      	add	r7, sp, #0
 8000772:	6078      	str	r0, [r7, #4]
 8000774:	687b      	ldr	r3, [r7, #4]
 8000776:	2200      	movs	r2, #0
 8000778:	611a      	str	r2, [r3, #16]
 800077a:	bf00      	nop
 800077c:	370c      	adds	r7, #12
 800077e:	46bd      	mov	sp, r7
 8000780:	bc80      	pop	{r7}
 8000782:	4770      	bx	lr

08000784 <vListInsertEnd>:
 8000784:	b480      	push	{r7}
 8000786:	b085      	sub	sp, #20
 8000788:	af00      	add	r7, sp, #0
 800078a:	6078      	str	r0, [r7, #4]
 800078c:	6039      	str	r1, [r7, #0]
 800078e:	687b      	ldr	r3, [r7, #4]
 8000790:	685b      	ldr	r3, [r3, #4]
 8000792:	60fb      	str	r3, [r7, #12]
 8000794:	683b      	ldr	r3, [r7, #0]
 8000796:	68fa      	ldr	r2, [r7, #12]
 8000798:	605a      	str	r2, [r3, #4]
 800079a:	68fb      	ldr	r3, [r7, #12]
 800079c:	689a      	ldr	r2, [r3, #8]
 800079e:	683b      	ldr	r3, [r7, #0]
 80007a0:	609a      	str	r2, [r3, #8]
 80007a2:	68fb      	ldr	r3, [r7, #12]
 80007a4:	689b      	ldr	r3, [r3, #8]
 80007a6:	683a      	ldr	r2, [r7, #0]
 80007a8:	605a      	str	r2, [r3, #4]
 80007aa:	68fb      	ldr	r3, [r7, #12]
 80007ac:	683a      	ldr	r2, [r7, #0]
 80007ae:	609a      	str	r2, [r3, #8]
 80007b0:	683b      	ldr	r3, [r7, #0]
 80007b2:	687a      	ldr	r2, [r7, #4]
 80007b4:	611a      	str	r2, [r3, #16]
 80007b6:	687b      	ldr	r3, [r7, #4]
 80007b8:	681b      	ldr	r3, [r3, #0]
 80007ba:	1c5a      	adds	r2, r3, #1
 80007bc:	687b      	ldr	r3, [r7, #4]
 80007be:	601a      	str	r2, [r3, #0]
 80007c0:	bf00      	nop
 80007c2:	3714      	adds	r7, #20
 80007c4:	46bd      	mov	sp, r7
 80007c6:	bc80      	pop	{r7}
 80007c8:	4770      	bx	lr

080007ca <vListInsert>:
 80007ca:	b480      	push	{r7}
 80007cc:	b085      	sub	sp, #20
 80007ce:	af00      	add	r7, sp, #0
 80007d0:	6078      	str	r0, [r7, #4]
 80007d2:	6039      	str	r1, [r7, #0]
 80007d4:	683b      	ldr	r3, [r7, #0]
 80007d6:	681b      	ldr	r3, [r3, #0]
 80007d8:	60bb      	str	r3, [r7, #8]
 80007da:	68bb      	ldr	r3, [r7, #8]
 80007dc:	f1b3 3fff 	cmp.w	r3, #4294967295	; 0xffffffff
 80007e0:	d103      	bne.n	80007ea <vListInsert+0x20>
 80007e2:	687b      	ldr	r3, [r7, #4]
 80007e4:	691b      	ldr	r3, [r3, #16]
 80007e6:	60fb      	str	r3, [r7, #12]
 80007e8:	e00c      	b.n	8000804 <vListInsert+0x3a>
 80007ea:	687b      	ldr	r3, [r7, #4]
 80007ec:	3308      	adds	r3, #8
 80007ee:	60fb      	str	r3, [r7, #12]
 80007f0:	e002      	b.n	80007f8 <vListInsert+0x2e>
 80007f2:	68fb      	ldr	r3, [r7, #12]
 80007f4:	685b      	ldr	r3, [r3, #4]
 80007f6:	60fb      	str	r3, [r7, #12]
 80007f8:	68fb      	ldr	r3, [r7, #12]
 80007fa:	685b      	ldr	r3, [r3, #4]
 80007fc:	681b      	ldr	r3, [r3, #0]
 80007fe:	68ba      	ldr	r2, [r7, #8]
 8000800:	429a      	cmp	r2, r3
 8000802:	d2f6      	bcs.n	80007f2 <vListInsert+0x28>
 8000804:	68fb      	ldr	r3, [r7, #12]
 8000806:	685a      	ldr	r2, [r3, #4]
 8000808:	683b      	ldr	r3, [r7, #0]
 800080a:	605a      	str	r2, [r3, #4]
 800080c:	683b      	ldr	r3, [r7, #0]
 800080e:	685b      	ldr	r3, [r3, #4]
 8000810:	683a      	ldr	r2, [r7, #0]
 8000812:	609a      	str	r2, [r3, #8]
 8000814:	683b      	ldr	r3, [r7, #0]
 8000816:	68fa      	ldr	r2, [r7, #12]
 8000818:	609a      	str	r2, [r3, #8]
 800081a:	68fb      	ldr	r3, [r7, #12]
 800081c:	683a      	ldr	r2, [r7, #0]
 800081e:	605a      	str	r2, [r3, #4]
 8000820:	683b      	ldr	r3, [r7, #0]
 8000822:	687a      	ldr	r2, [r7, #4]
 8000824:	611a      	str	r2, [r3, #16]
 8000826:	687b      	ldr	r3, [r7, #4]
 8000828:	681b      	ldr	r3, [r3, #0]
 800082a:	1c5a      	adds	r2, r3, #1
 800082c:	687b      	ldr	r3, [r7, #4]
 800082e:	601a      	str	r2, [r3, #0]
 8000830:	bf00      	nop
 8000832:	3714      	adds	r7, #20
 8000834:	46bd      	mov	sp, r7
 8000836:	bc80      	pop	{r7}
 8000838:	4770      	bx	lr

0800083a <uxListRemove>:
 800083a:	b480      	push	{r7}
 800083c:	b085      	sub	sp, #20
 800083e:	af00      	add	r7, sp, #0
 8000840:	6078      	str	r0, [r7, #4]
 8000842:	687b      	ldr	r3, [r7, #4]
 8000844:	691b      	ldr	r3, [r3, #16]
 8000846:	60fb      	str	r3, [r7, #12]
 8000848:	687b      	ldr	r3, [r7, #4]
 800084a:	685b      	ldr	r3, [r3, #4]
 800084c:	687a      	ldr	r2, [r7, #4]
 800084e:	6892      	ldr	r2, [r2, #8]
 8000850:	609a      	str	r2, [r3, #8]
 8000852:	687b      	ldr	r3, [r7, #4]
 8000854:	689b      	ldr	r3, [r3, #8]
 8000856:	687a      	ldr	r2, [r7, #4]
 8000858:	6852      	ldr	r2, [r2, #4]
 800085a:	605a      	str	r2, [r3, #4]
 800085c:	68fb      	ldr	r3, [r7, #12]
 800085e:	685b      	ldr	r3, [r3, #4]
 8000860:	687a      	ldr	r2, [r7, #4]
 8000862:	429a      	cmp	r2, r3
 8000864:	d103      	bne.n	800086e <uxListRemove+0x34>
 8000866:	687b      	ldr	r3, [r7, #4]
 8000868:	689a      	ldr	r2, [r3, #8]
 800086a:	68fb      	ldr	r3, [r7, #12]
 800086c:	605a      	str	r2, [r3, #4]
 800086e:	687b      	ldr	r3, [r7, #4]
 8000870:	2200      	movs	r2, #0
 8000872:	611a      	str	r2, [r3, #16]
 8000874:	68fb      	ldr	r3, [r7, #12]
 8000876:	681b      	ldr	r3, [r3, #0]
 8000878:	1e5a      	subs	r2, r3, #1
 800087a:	68fb      	ldr	r3, [r7, #12]
 800087c:	601a      	str	r2, [r3, #0]
 800087e:	68fb      	ldr	r3, [r7, #12]
 8000880:	681b      	ldr	r3, [r3, #0]
 8000882:	4618      	mov	r0, r3
 8000884:	3714      	adds	r7, #20
 8000886:	46bd      	mov	sp, r7
 8000888:	bc80      	pop	{r7}
 800088a:	4770      	bx	lr

0800088c <xQueueGenericReset>:
 800088c:	b580      	push	{r7, lr}
 800088e:	b084      	sub	sp, #16
 8000890:	af00      	add	r7, sp, #0
 8000892:	6078      	str	r0, [r7, #4]
 8000894:	6039      	str	r1, [r7, #0]
 8000896:	687b      	ldr	r3, [r7, #4]
 8000898:	60fb      	str	r3, [r7, #12]
 800089a:	68fb      	ldr	r3, [r7, #12]
 800089c:	2b00      	cmp	r3, #0
 800089e:	d109      	bne.n	80008b4 <xQueueGenericReset+0x28>
 80008a0:	f04f 0350 	mov.w	r3, #80	; 0x50
 80008a4:	f383 8811 	msr	BASEPRI, r3
 80008a8:	f3bf 8f6f 	isb	sy
 80008ac:	f3bf 8f4f 	dsb	sy
 80008b0:	60bb      	str	r3, [r7, #8]
 80008b2:	e7fe      	b.n	80008b2 <xQueueGenericReset+0x26>
 80008b4:	f001 f9ce 	bl	8001c54 <vPortEnterCritical>
 80008b8:	68fb      	ldr	r3, [r7, #12]
 80008ba:	681a      	ldr	r2, [r3, #0]
 80008bc:	68fb      	ldr	r3, [r7, #12]
 80008be:	6bdb      	ldr	r3, [r3, #60]	; 0x3c
 80008c0:	68f9      	ldr	r1, [r7, #12]
 80008c2:	6c09      	ldr	r1, [r1, #64]	; 0x40
 80008c4:	fb01 f303 	mul.w	r3, r1, r3
 80008c8:	441a      	add	r2, r3
 80008ca:	68fb      	ldr	r3, [r7, #12]
 80008cc:	605a      	str	r2, [r3, #4]
 80008ce:	68fb      	ldr	r3, [r7, #12]
 80008d0:	2200      	movs	r2, #0
 80008d2:	639a      	str	r2, [r3, #56]	; 0x38
 80008d4:	68fb      	ldr	r3, [r7, #12]
 80008d6:	681a      	ldr	r2, [r3, #0]
 80008d8:	68fb      	ldr	r3, [r7, #12]
 80008da:	609a      	str	r2, [r3, #8]
 80008dc:	68fb      	ldr	r3, [r7, #12]
 80008de:	681a      	ldr	r2, [r3, #0]
 80008e0:	68fb      	ldr	r3, [r7, #12]
 80008e2:	6bdb      	ldr	r3, [r3, #60]	; 0x3c
 80008e4:	3b01      	subs	r3, #1
 80008e6:	68f9      	ldr	r1, [r7, #12]
 80008e8:	6c09      	ldr	r1, [r1, #64]	; 0x40
 80008ea:	fb01 f303 	mul.w	r3, r1, r3
 80008ee:	441a      	add	r2, r3
 80008f0:	68fb      	ldr	r3, [r7, #12]
 80008f2:	60da      	str	r2, [r3, #12]
 80008f4:	68fb      	ldr	r3, [r7, #12]
 80008f6:	22ff      	movs	r2, #255	; 0xff
 80008f8:	f883 2044 	strb.w	r2, [r3, #68]	; 0x44
 80008fc:	68fb      	ldr	r3, [r7, #12]
 80008fe:	22ff      	movs	r2, #255	; 0xff
 8000900:	f883 2045 	strb.w	r2, [r3, #69]	; 0x45
 8000904:	683b      	ldr	r3, [r7, #0]
 8000906:	2b00      	cmp	r3, #0
 8000908:	d114      	bne.n	8000934 <xQueueGenericReset+0xa8>
 800090a:	68fb      	ldr	r3, [r7, #12]
 800090c:	691b      	ldr	r3, [r3, #16]
 800090e:	2b00      	cmp	r3, #0
 8000910:	d01a      	beq.n	8000948 <xQueueGenericReset+0xbc>
 8000912:	68fb      	ldr	r3, [r7, #12]
 8000914:	3310      	adds	r3, #16
 8000916:	4618      	mov	r0, r3
 8000918:	f000 fe06 	bl	8001528 <xTaskRemoveFromEventList>
 800091c:	4603      	mov	r3, r0
 800091e:	2b00      	cmp	r3, #0
 8000920:	d012      	beq.n	8000948 <xQueueGenericReset+0xbc>
 8000922:	4b0d      	ldr	r3, [pc, #52]	; (8000958 <xQueueGenericReset+0xcc>)
 8000924:	f04f 5280 	mov.w	r2, #268435456	; 0x10000000
 8000928:	601a      	str	r2, [r3, #0]
 800092a:	f3bf 8f4f 	dsb	sy
 800092e:	f3bf 8f6f 	isb	sy
 8000932:	e009      	b.n	8000948 <xQueueGenericReset+0xbc>
 8000934:	68fb      	ldr	r3, [r7, #12]
 8000936:	3310      	adds	r3, #16
 8000938:	4618      	mov	r0, r3
 800093a:	f7ff fef8 	bl	800072e <vListInitialise>
 800093e:	68fb      	ldr	r3, [r7, #12]
 8000940:	3324      	adds	r3, #36	; 0x24
 8000942:	4618      	mov	r0, r3
 8000944:	f7ff fef3 	bl	800072e <vListInitialise>
 8000948:	f001 f9b2 	bl	8001cb0 <vPortExitCritical>
 800094c:	2301      	movs	r3, #1
 800094e:	4618      	mov	r0, r3
 8000950:	3710      	adds	r7, #16
 8000952:	46bd      	mov	sp, r7
 8000954:	bd80      	pop	{r7, pc}
 8000956:	bf00      	nop
 8000958:	e000ed04 	.word	0xe000ed04

0800095c <xQueueGenericCreate>:
 800095c:	b580      	push	{r7, lr}
 800095e:	b08a      	sub	sp, #40	; 0x28
 8000960:	af02      	add	r7, sp, #8
 8000962:	60f8      	str	r0, [r7, #12]
 8000964:	60b9      	str	r1, [r7, #8]
 8000966:	4613      	mov	r3, r2
 8000968:	71fb      	strb	r3, [r7, #7]
 800096a:	68fb      	ldr	r3, [r7, #12]
 800096c:	2b00      	cmp	r3, #0
 800096e:	d109      	bne.n	8000984 <xQueueGenericCreate+0x28>
 8000970:	f04f 0350 	mov.w	r3, #80	; 0x50
 8000974:	f383 8811 	msr	BASEPRI, r3
 8000978:	f3bf 8f6f 	isb	sy
 800097c:	f3bf 8f4f 	dsb	sy
 8000980:	613b      	str	r3, [r7, #16]
 8000982:	e7fe      	b.n	8000982 <xQueueGenericCreate+0x26>
 8000984:	68bb      	ldr	r3, [r7, #8]
 8000986:	2b00      	cmp	r3, #0
 8000988:	d102      	bne.n	8000990 <xQueueGenericCreate+0x34>
 800098a:	2300      	movs	r3, #0
 800098c:	61fb      	str	r3, [r7, #28]
 800098e:	e004      	b.n	800099a <xQueueGenericCreate+0x3e>
 8000990:	68fb      	ldr	r3, [r7, #12]
 8000992:	68ba      	ldr	r2, [r7, #8]
 8000994:	fb02 f303 	mul.w	r3, r2, r3
 8000998:	61fb      	str	r3, [r7, #28]
 800099a:	69fb      	ldr	r3, [r7, #28]
 800099c:	3350      	adds	r3, #80	; 0x50
 800099e:	4618      	mov	r0, r3
 80009a0:	f001 fa48 	bl	8001e34 <pvPortMalloc>
 80009a4:	61b8      	str	r0, [r7, #24]
 80009a6:	69bb      	ldr	r3, [r7, #24]
 80009a8:	2b00      	cmp	r3, #0
 80009aa:	d00b      	beq.n	80009c4 <xQueueGenericCreate+0x68>
 80009ac:	69bb      	ldr	r3, [r7, #24]
 80009ae:	3350      	adds	r3, #80	; 0x50
 80009b0:	617b      	str	r3, [r7, #20]
 80009b2:	79fa      	ldrb	r2, [r7, #7]
 80009b4:	69bb      	ldr	r3, [r7, #24]
 80009b6:	9300      	str	r3, [sp, #0]
 80009b8:	4613      	mov	r3, r2
 80009ba:	697a      	ldr	r2, [r7, #20]
 80009bc:	68b9      	ldr	r1, [r7, #8]
 80009be:	68f8      	ldr	r0, [r7, #12]
 80009c0:	f000 f805 	bl	80009ce <prvInitialiseNewQueue>
 80009c4:	69bb      	ldr	r3, [r7, #24]
 80009c6:	4618      	mov	r0, r3
 80009c8:	3720      	adds	r7, #32
 80009ca:	46bd      	mov	sp, r7
 80009cc:	bd80      	pop	{r7, pc}

080009ce <prvInitialiseNewQueue>:
 80009ce:	b580      	push	{r7, lr}
 80009d0:	b084      	sub	sp, #16
 80009d2:	af00      	add	r7, sp, #0
 80009d4:	60f8      	str	r0, [r7, #12]
 80009d6:	60b9      	str	r1, [r7, #8]
 80009d8:	607a      	str	r2, [r7, #4]
 80009da:	70fb      	strb	r3, [r7, #3]
 80009dc:	68bb      	ldr	r3, [r7, #8]
 80009de:	2b00      	cmp	r3, #0
 80009e0:	d103      	bne.n	80009ea <prvInitialiseNewQueue+0x1c>
 80009e2:	69bb      	ldr	r3, [r7, #24]
 80009e4:	69ba      	ldr	r2, [r7, #24]
 80009e6:	601a      	str	r2, [r3, #0]
 80009e8:	e002      	b.n	80009f0 <prvInitialiseNewQueue+0x22>
 80009ea:	69bb      	ldr	r3, [r7, #24]
 80009ec:	687a      	ldr	r2, [r7, #4]
 80009ee:	601a      	str	r2, [r3, #0]
 80009f0:	69bb      	ldr	r3, [r7, #24]
 80009f2:	68fa      	ldr	r2, [r7, #12]
 80009f4:	63da      	str	r2, [r3, #60]	; 0x3c
 80009f6:	69bb      	ldr	r3, [r7, #24]
 80009f8:	68ba      	ldr	r2, [r7, #8]
 80009fa:	641a      	str	r2, [r3, #64]	; 0x40
 80009fc:	2101      	movs	r1, #1
 80009fe:	69b8      	ldr	r0, [r7, #24]
 8000a00:	f7ff ff44 	bl	800088c <xQueueGenericReset>
 8000a04:	69bb      	ldr	r3, [r7, #24]
 8000a06:	78fa      	ldrb	r2, [r7, #3]
 8000a08:	f883 204c 	strb.w	r2, [r3, #76]	; 0x4c
 8000a0c:	bf00      	nop
 8000a0e:	3710      	adds	r7, #16
 8000a10:	46bd      	mov	sp, r7
 8000a12:	bd80      	pop	{r7, pc}

08000a14 <xQueueGiveFromISR>:
 8000a14:	b580      	push	{r7, lr}
 8000a16:	b08e      	sub	sp, #56	; 0x38
 8000a18:	af00      	add	r7, sp, #0
 8000a1a:	6078      	str	r0, [r7, #4]
 8000a1c:	6039      	str	r1, [r7, #0]
 8000a1e:	687b      	ldr	r3, [r7, #4]
 8000a20:	633b      	str	r3, [r7, #48]	; 0x30
 8000a22:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000a24:	2b00      	cmp	r3, #0
 8000a26:	d109      	bne.n	8000a3c <xQueueGiveFromISR+0x28>
 8000a28:	f04f 0350 	mov.w	r3, #80	; 0x50
 8000a2c:	f383 8811 	msr	BASEPRI, r3
 8000a30:	f3bf 8f6f 	isb	sy
 8000a34:	f3bf 8f4f 	dsb	sy
 8000a38:	623b      	str	r3, [r7, #32]
 8000a3a:	e7fe      	b.n	8000a3a <xQueueGiveFromISR+0x26>
 8000a3c:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000a3e:	6c1b      	ldr	r3, [r3, #64]	; 0x40
 8000a40:	2b00      	cmp	r3, #0
 8000a42:	d009      	beq.n	8000a58 <xQueueGiveFromISR+0x44>
 8000a44:	f04f 0350 	mov.w	r3, #80	; 0x50
 8000a48:	f383 8811 	msr	BASEPRI, r3
 8000a4c:	f3bf 8f6f 	isb	sy
 8000a50:	f3bf 8f4f 	dsb	sy
 8000a54:	61fb      	str	r3, [r7, #28]
 8000a56:	e7fe      	b.n	8000a56 <xQueueGiveFromISR+0x42>
 8000a58:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000a5a:	681b      	ldr	r3, [r3, #0]
 8000a5c:	2b00      	cmp	r3, #0
 8000a5e:	d103      	bne.n	8000a68 <xQueueGiveFromISR+0x54>
 8000a60:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000a62:	685b      	ldr	r3, [r3, #4]
 8000a64:	2b00      	cmp	r3, #0
 8000a66:	d101      	bne.n	8000a6c <xQueueGiveFromISR+0x58>
 8000a68:	2301      	movs	r3, #1
 8000a6a:	e000      	b.n	8000a6e <xQueueGiveFromISR+0x5a>
 8000a6c:	2300      	movs	r3, #0
 8000a6e:	2b00      	cmp	r3, #0
 8000a70:	d109      	bne.n	8000a86 <xQueueGiveFromISR+0x72>
 8000a72:	f04f 0350 	mov.w	r3, #80	; 0x50
 8000a76:	f383 8811 	msr	BASEPRI, r3
 8000a7a:	f3bf 8f6f 	isb	sy
 8000a7e:	f3bf 8f4f 	dsb	sy
 8000a82:	61bb      	str	r3, [r7, #24]
 8000a84:	e7fe      	b.n	8000a84 <xQueueGiveFromISR+0x70>
 8000a86:	f001 f999 	bl	8001dbc <vPortValidateInterruptPriority>
 8000a8a:	f3ef 8211 	mrs	r2, BASEPRI
 8000a8e:	f04f 0350 	mov.w	r3, #80	; 0x50
 8000a92:	f383 8811 	msr	BASEPRI, r3
 8000a96:	f3bf 8f6f 	isb	sy
 8000a9a:	f3bf 8f4f 	dsb	sy
 8000a9e:	617a      	str	r2, [r7, #20]
 8000aa0:	613b      	str	r3, [r7, #16]
 8000aa2:	697b      	ldr	r3, [r7, #20]
 8000aa4:	62fb      	str	r3, [r7, #44]	; 0x2c
 8000aa6:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000aa8:	6b9b      	ldr	r3, [r3, #56]	; 0x38
 8000aaa:	62bb      	str	r3, [r7, #40]	; 0x28
 8000aac:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000aae:	6bdb      	ldr	r3, [r3, #60]	; 0x3c
 8000ab0:	6aba      	ldr	r2, [r7, #40]	; 0x28
 8000ab2:	429a      	cmp	r2, r3
 8000ab4:	d22b      	bcs.n	8000b0e <xQueueGiveFromISR+0xfa>
 8000ab6:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000ab8:	f893 3045 	ldrb.w	r3, [r3, #69]	; 0x45
 8000abc:	f887 3027 	strb.w	r3, [r7, #39]	; 0x27
 8000ac0:	6abb      	ldr	r3, [r7, #40]	; 0x28
 8000ac2:	1c5a      	adds	r2, r3, #1
 8000ac4:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000ac6:	639a      	str	r2, [r3, #56]	; 0x38
 8000ac8:	f997 3027 	ldrsb.w	r3, [r7, #39]	; 0x27
 8000acc:	f1b3 3fff 	cmp.w	r3, #4294967295	; 0xffffffff
 8000ad0:	d112      	bne.n	8000af8 <xQueueGiveFromISR+0xe4>
 8000ad2:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000ad4:	6a5b      	ldr	r3, [r3, #36]	; 0x24
 8000ad6:	2b00      	cmp	r3, #0
 8000ad8:	d016      	beq.n	8000b08 <xQueueGiveFromISR+0xf4>
 8000ada:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000adc:	3324      	adds	r3, #36	; 0x24
 8000ade:	4618      	mov	r0, r3
 8000ae0:	f000 fd22 	bl	8001528 <xTaskRemoveFromEventList>
 8000ae4:	4603      	mov	r3, r0
 8000ae6:	2b00      	cmp	r3, #0
 8000ae8:	d00e      	beq.n	8000b08 <xQueueGiveFromISR+0xf4>
 8000aea:	683b      	ldr	r3, [r7, #0]
 8000aec:	2b00      	cmp	r3, #0
 8000aee:	d00b      	beq.n	8000b08 <xQueueGiveFromISR+0xf4>
 8000af0:	683b      	ldr	r3, [r7, #0]
 8000af2:	2201      	movs	r2, #1
 8000af4:	601a      	str	r2, [r3, #0]
 8000af6:	e007      	b.n	8000b08 <xQueueGiveFromISR+0xf4>
 8000af8:	f897 3027 	ldrb.w	r3, [r7, #39]	; 0x27
 8000afc:	3301      	adds	r3, #1
 8000afe:	b2db      	uxtb	r3, r3
 8000b00:	b25a      	sxtb	r2, r3
 8000b02:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000b04:	f883 2045 	strb.w	r2, [r3, #69]	; 0x45
 8000b08:	2301      	movs	r3, #1
 8000b0a:	637b      	str	r3, [r7, #52]	; 0x34
 8000b0c:	e001      	b.n	8000b12 <xQueueGiveFromISR+0xfe>
 8000b0e:	2300      	movs	r3, #0
 8000b10:	637b      	str	r3, [r7, #52]	; 0x34
 8000b12:	6afb      	ldr	r3, [r7, #44]	; 0x2c
 8000b14:	60fb      	str	r3, [r7, #12]
 8000b16:	68fb      	ldr	r3, [r7, #12]
 8000b18:	f383 8811 	msr	BASEPRI, r3
 8000b1c:	6b7b      	ldr	r3, [r7, #52]	; 0x34
 8000b1e:	4618      	mov	r0, r3
 8000b20:	3738      	adds	r7, #56	; 0x38
 8000b22:	46bd      	mov	sp, r7
 8000b24:	bd80      	pop	{r7, pc}
	...

08000b28 <xQueueGenericReceive>:
 8000b28:	b580      	push	{r7, lr}
 8000b2a:	b08e      	sub	sp, #56	; 0x38
 8000b2c:	af00      	add	r7, sp, #0
 8000b2e:	60f8      	str	r0, [r7, #12]
 8000b30:	60b9      	str	r1, [r7, #8]
 8000b32:	607a      	str	r2, [r7, #4]
 8000b34:	603b      	str	r3, [r7, #0]
 8000b36:	2300      	movs	r3, #0
 8000b38:	637b      	str	r3, [r7, #52]	; 0x34
 8000b3a:	68fb      	ldr	r3, [r7, #12]
 8000b3c:	633b      	str	r3, [r7, #48]	; 0x30
 8000b3e:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000b40:	2b00      	cmp	r3, #0
 8000b42:	d109      	bne.n	8000b58 <xQueueGenericReceive+0x30>
 8000b44:	f04f 0350 	mov.w	r3, #80	; 0x50
 8000b48:	f383 8811 	msr	BASEPRI, r3
 8000b4c:	f3bf 8f6f 	isb	sy
 8000b50:	f3bf 8f4f 	dsb	sy
 8000b54:	627b      	str	r3, [r7, #36]	; 0x24
 8000b56:	e7fe      	b.n	8000b56 <xQueueGenericReceive+0x2e>
 8000b58:	68bb      	ldr	r3, [r7, #8]
 8000b5a:	2b00      	cmp	r3, #0
 8000b5c:	d103      	bne.n	8000b66 <xQueueGenericReceive+0x3e>
 8000b5e:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000b60:	6c1b      	ldr	r3, [r3, #64]	; 0x40
 8000b62:	2b00      	cmp	r3, #0
 8000b64:	d101      	bne.n	8000b6a <xQueueGenericReceive+0x42>
 8000b66:	2301      	movs	r3, #1
 8000b68:	e000      	b.n	8000b6c <xQueueGenericReceive+0x44>
 8000b6a:	2300      	movs	r3, #0
 8000b6c:	2b00      	cmp	r3, #0
 8000b6e:	d109      	bne.n	8000b84 <xQueueGenericReceive+0x5c>
 8000b70:	f04f 0350 	mov.w	r3, #80	; 0x50
 8000b74:	f383 8811 	msr	BASEPRI, r3
 8000b78:	f3bf 8f6f 	isb	sy
 8000b7c:	f3bf 8f4f 	dsb	sy
 8000b80:	623b      	str	r3, [r7, #32]
 8000b82:	e7fe      	b.n	8000b82 <xQueueGenericReceive+0x5a>
 8000b84:	f000 fe86 	bl	8001894 <xTaskGetSchedulerState>
 8000b88:	4603      	mov	r3, r0
 8000b8a:	2b00      	cmp	r3, #0
 8000b8c:	d102      	bne.n	8000b94 <xQueueGenericReceive+0x6c>
 8000b8e:	687b      	ldr	r3, [r7, #4]
 8000b90:	2b00      	cmp	r3, #0
 8000b92:	d101      	bne.n	8000b98 <xQueueGenericReceive+0x70>
 8000b94:	2301      	movs	r3, #1
 8000b96:	e000      	b.n	8000b9a <xQueueGenericReceive+0x72>
 8000b98:	2300      	movs	r3, #0
 8000b9a:	2b00      	cmp	r3, #0
 8000b9c:	d109      	bne.n	8000bb2 <xQueueGenericReceive+0x8a>
 8000b9e:	f04f 0350 	mov.w	r3, #80	; 0x50
 8000ba2:	f383 8811 	msr	BASEPRI, r3
 8000ba6:	f3bf 8f6f 	isb	sy
 8000baa:	f3bf 8f4f 	dsb	sy
 8000bae:	61fb      	str	r3, [r7, #28]
 8000bb0:	e7fe      	b.n	8000bb0 <xQueueGenericReceive+0x88>
 8000bb2:	f001 f84f 	bl	8001c54 <vPortEnterCritical>
 8000bb6:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000bb8:	6b9b      	ldr	r3, [r3, #56]	; 0x38
 8000bba:	62fb      	str	r3, [r7, #44]	; 0x2c
 8000bbc:	6afb      	ldr	r3, [r7, #44]	; 0x2c
 8000bbe:	2b00      	cmp	r3, #0
 8000bc0:	d046      	beq.n	8000c50 <xQueueGenericReceive+0x128>
 8000bc2:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000bc4:	68db      	ldr	r3, [r3, #12]
 8000bc6:	62bb      	str	r3, [r7, #40]	; 0x28
 8000bc8:	68b9      	ldr	r1, [r7, #8]
 8000bca:	6b38      	ldr	r0, [r7, #48]	; 0x30
 8000bcc:	f000 f8be 	bl	8000d4c <prvCopyDataFromQueue>
 8000bd0:	683b      	ldr	r3, [r7, #0]
 8000bd2:	2b00      	cmp	r3, #0
 8000bd4:	d121      	bne.n	8000c1a <xQueueGenericReceive+0xf2>
 8000bd6:	6afb      	ldr	r3, [r7, #44]	; 0x2c
 8000bd8:	1e5a      	subs	r2, r3, #1
 8000bda:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000bdc:	639a      	str	r2, [r3, #56]	; 0x38
 8000bde:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000be0:	681b      	ldr	r3, [r3, #0]
 8000be2:	2b00      	cmp	r3, #0
 8000be4:	d104      	bne.n	8000bf0 <xQueueGenericReceive+0xc8>
 8000be6:	f000 fee9 	bl	80019bc <pvTaskIncrementMutexHeldCount>
 8000bea:	4602      	mov	r2, r0
 8000bec:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000bee:	605a      	str	r2, [r3, #4]
 8000bf0:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000bf2:	691b      	ldr	r3, [r3, #16]
 8000bf4:	2b00      	cmp	r3, #0
 8000bf6:	d027      	beq.n	8000c48 <xQueueGenericReceive+0x120>
 8000bf8:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000bfa:	3310      	adds	r3, #16
 8000bfc:	4618      	mov	r0, r3
 8000bfe:	f000 fc93 	bl	8001528 <xTaskRemoveFromEventList>
 8000c02:	4603      	mov	r3, r0
 8000c04:	2b00      	cmp	r3, #0
 8000c06:	d01f      	beq.n	8000c48 <xQueueGenericReceive+0x120>
 8000c08:	4b4f      	ldr	r3, [pc, #316]	; (8000d48 <xQueueGenericReceive+0x220>)
 8000c0a:	f04f 5280 	mov.w	r2, #268435456	; 0x10000000
 8000c0e:	601a      	str	r2, [r3, #0]
 8000c10:	f3bf 8f4f 	dsb	sy
 8000c14:	f3bf 8f6f 	isb	sy
 8000c18:	e016      	b.n	8000c48 <xQueueGenericReceive+0x120>
 8000c1a:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000c1c:	6aba      	ldr	r2, [r7, #40]	; 0x28
 8000c1e:	60da      	str	r2, [r3, #12]
 8000c20:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000c22:	6a5b      	ldr	r3, [r3, #36]	; 0x24
 8000c24:	2b00      	cmp	r3, #0
 8000c26:	d00f      	beq.n	8000c48 <xQueueGenericReceive+0x120>
 8000c28:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000c2a:	3324      	adds	r3, #36	; 0x24
 8000c2c:	4618      	mov	r0, r3
 8000c2e:	f000 fc7b 	bl	8001528 <xTaskRemoveFromEventList>
 8000c32:	4603      	mov	r3, r0
 8000c34:	2b00      	cmp	r3, #0
 8000c36:	d007      	beq.n	8000c48 <xQueueGenericReceive+0x120>
 8000c38:	4b43      	ldr	r3, [pc, #268]	; (8000d48 <xQueueGenericReceive+0x220>)
 8000c3a:	f04f 5280 	mov.w	r2, #268435456	; 0x10000000
 8000c3e:	601a      	str	r2, [r3, #0]
 8000c40:	f3bf 8f4f 	dsb	sy
 8000c44:	f3bf 8f6f 	isb	sy
 8000c48:	f001 f832 	bl	8001cb0 <vPortExitCritical>
 8000c4c:	2301      	movs	r3, #1
 8000c4e:	e077      	b.n	8000d40 <xQueueGenericReceive+0x218>
 8000c50:	687b      	ldr	r3, [r7, #4]
 8000c52:	2b00      	cmp	r3, #0
 8000c54:	d103      	bne.n	8000c5e <xQueueGenericReceive+0x136>
 8000c56:	f001 f82b 	bl	8001cb0 <vPortExitCritical>
 8000c5a:	2300      	movs	r3, #0
 8000c5c:	e070      	b.n	8000d40 <xQueueGenericReceive+0x218>
 8000c5e:	6b7b      	ldr	r3, [r7, #52]	; 0x34
 8000c60:	2b00      	cmp	r3, #0
 8000c62:	d106      	bne.n	8000c72 <xQueueGenericReceive+0x14a>
 8000c64:	f107 0314 	add.w	r3, r7, #20
 8000c68:	4618      	mov	r0, r3
 8000c6a:	f000 fcbf 	bl	80015ec <vTaskSetTimeOutState>
 8000c6e:	2301      	movs	r3, #1
 8000c70:	637b      	str	r3, [r7, #52]	; 0x34
 8000c72:	f001 f81d 	bl	8001cb0 <vPortExitCritical>
 8000c76:	f000 fa73 	bl	8001160 <vTaskSuspendAll>
 8000c7a:	f000 ffeb 	bl	8001c54 <vPortEnterCritical>
 8000c7e:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000c80:	f893 3044 	ldrb.w	r3, [r3, #68]	; 0x44
 8000c84:	b25b      	sxtb	r3, r3
 8000c86:	f1b3 3fff 	cmp.w	r3, #4294967295	; 0xffffffff
 8000c8a:	d103      	bne.n	8000c94 <xQueueGenericReceive+0x16c>
 8000c8c:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000c8e:	2200      	movs	r2, #0
 8000c90:	f883 2044 	strb.w	r2, [r3, #68]	; 0x44
 8000c94:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000c96:	f893 3045 	ldrb.w	r3, [r3, #69]	; 0x45
 8000c9a:	b25b      	sxtb	r3, r3
 8000c9c:	f1b3 3fff 	cmp.w	r3, #4294967295	; 0xffffffff
 8000ca0:	d103      	bne.n	8000caa <xQueueGenericReceive+0x182>
 8000ca2:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000ca4:	2200      	movs	r2, #0
 8000ca6:	f883 2045 	strb.w	r2, [r3, #69]	; 0x45
 8000caa:	f001 f801 	bl	8001cb0 <vPortExitCritical>
 8000cae:	1d3a      	adds	r2, r7, #4
 8000cb0:	f107 0314 	add.w	r3, r7, #20
 8000cb4:	4611      	mov	r1, r2
 8000cb6:	4618      	mov	r0, r3
 8000cb8:	f000 fcba 	bl	8001630 <xTaskCheckForTimeOut>
 8000cbc:	4603      	mov	r3, r0
 8000cbe:	2b00      	cmp	r3, #0
 8000cc0:	d131      	bne.n	8000d26 <xQueueGenericReceive+0x1fe>
 8000cc2:	6b38      	ldr	r0, [r7, #48]	; 0x30
 8000cc4:	f000 f8ba 	bl	8000e3c <prvIsQueueEmpty>
 8000cc8:	4603      	mov	r3, r0
 8000cca:	2b00      	cmp	r3, #0
 8000ccc:	d025      	beq.n	8000d1a <xQueueGenericReceive+0x1f2>
 8000cce:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000cd0:	681b      	ldr	r3, [r3, #0]
 8000cd2:	2b00      	cmp	r3, #0
 8000cd4:	d108      	bne.n	8000ce8 <xQueueGenericReceive+0x1c0>
 8000cd6:	f000 ffbd 	bl	8001c54 <vPortEnterCritical>
 8000cda:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000cdc:	685b      	ldr	r3, [r3, #4]
 8000cde:	4618      	mov	r0, r3
 8000ce0:	f000 fdf6 	bl	80018d0 <vTaskPriorityInherit>
 8000ce4:	f000 ffe4 	bl	8001cb0 <vPortExitCritical>
 8000ce8:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000cea:	3324      	adds	r3, #36	; 0x24
 8000cec:	687a      	ldr	r2, [r7, #4]
 8000cee:	4611      	mov	r1, r2
 8000cf0:	4618      	mov	r0, r3
 8000cf2:	f000 fbf5 	bl	80014e0 <vTaskPlaceOnEventList>
 8000cf6:	6b38      	ldr	r0, [r7, #48]	; 0x30
 8000cf8:	f000 f84e 	bl	8000d98 <prvUnlockQueue>
 8000cfc:	f000 fa3e 	bl	800117c <xTaskResumeAll>
 8000d00:	4603      	mov	r3, r0
 8000d02:	2b00      	cmp	r3, #0
 8000d04:	f47f af55 	bne.w	8000bb2 <xQueueGenericReceive+0x8a>
 8000d08:	4b0f      	ldr	r3, [pc, #60]	; (8000d48 <xQueueGenericReceive+0x220>)
 8000d0a:	f04f 5280 	mov.w	r2, #268435456	; 0x10000000
 8000d0e:	601a      	str	r2, [r3, #0]
 8000d10:	f3bf 8f4f 	dsb	sy
 8000d14:	f3bf 8f6f 	isb	sy
 8000d18:	e74b      	b.n	8000bb2 <xQueueGenericReceive+0x8a>
 8000d1a:	6b38      	ldr	r0, [r7, #48]	; 0x30
 8000d1c:	f000 f83c 	bl	8000d98 <prvUnlockQueue>
 8000d20:	f000 fa2c 	bl	800117c <xTaskResumeAll>
 8000d24:	e745      	b.n	8000bb2 <xQueueGenericReceive+0x8a>
 8000d26:	6b38      	ldr	r0, [r7, #48]	; 0x30
 8000d28:	f000 f836 	bl	8000d98 <prvUnlockQueue>
 8000d2c:	f000 fa26 	bl	800117c <xTaskResumeAll>
 8000d30:	6b38      	ldr	r0, [r7, #48]	; 0x30
 8000d32:	f000 f883 	bl	8000e3c <prvIsQueueEmpty>
 8000d36:	4603      	mov	r3, r0
 8000d38:	2b00      	cmp	r3, #0
 8000d3a:	f43f af3a 	beq.w	8000bb2 <xQueueGenericReceive+0x8a>
 8000d3e:	2300      	movs	r3, #0
 8000d40:	4618      	mov	r0, r3
 8000d42:	3738      	adds	r7, #56	; 0x38
 8000d44:	46bd      	mov	sp, r7
 8000d46:	bd80      	pop	{r7, pc}
 8000d48:	e000ed04 	.word	0xe000ed04

08000d4c <prvCopyDataFromQueue>:
 8000d4c:	b580      	push	{r7, lr}
 8000d4e:	b082      	sub	sp, #8
 8000d50:	af00      	add	r7, sp, #0
 8000d52:	6078      	str	r0, [r7, #4]
 8000d54:	6039      	str	r1, [r7, #0]
 8000d56:	687b      	ldr	r3, [r7, #4]
 8000d58:	6c1b      	ldr	r3, [r3, #64]	; 0x40
 8000d5a:	2b00      	cmp	r3, #0
 8000d5c:	d018      	beq.n	8000d90 <prvCopyDataFromQueue+0x44>
 8000d5e:	687b      	ldr	r3, [r7, #4]
 8000d60:	68da      	ldr	r2, [r3, #12]
 8000d62:	687b      	ldr	r3, [r7, #4]
 8000d64:	6c1b      	ldr	r3, [r3, #64]	; 0x40
 8000d66:	441a      	add	r2, r3
 8000d68:	687b      	ldr	r3, [r7, #4]
 8000d6a:	60da      	str	r2, [r3, #12]
 8000d6c:	687b      	ldr	r3, [r7, #4]
 8000d6e:	68da      	ldr	r2, [r3, #12]
 8000d70:	687b      	ldr	r3, [r7, #4]
 8000d72:	685b      	ldr	r3, [r3, #4]
 8000d74:	429a      	cmp	r2, r3
 8000d76:	d303      	bcc.n	8000d80 <prvCopyDataFromQueue+0x34>
 8000d78:	687b      	ldr	r3, [r7, #4]
 8000d7a:	681a      	ldr	r2, [r3, #0]
 8000d7c:	687b      	ldr	r3, [r7, #4]
 8000d7e:	60da      	str	r2, [r3, #12]
 8000d80:	687b      	ldr	r3, [r7, #4]
 8000d82:	68d9      	ldr	r1, [r3, #12]
 8000d84:	687b      	ldr	r3, [r7, #4]
 8000d86:	6c1b      	ldr	r3, [r3, #64]	; 0x40
 8000d88:	461a      	mov	r2, r3
 8000d8a:	6838      	ldr	r0, [r7, #0]
 8000d8c:	f7ff fa28 	bl	80001e0 <memcpy>
 8000d90:	bf00      	nop
 8000d92:	3708      	adds	r7, #8
 8000d94:	46bd      	mov	sp, r7
 8000d96:	bd80      	pop	{r7, pc}

08000d98 <prvUnlockQueue>:
 8000d98:	b580      	push	{r7, lr}
 8000d9a:	b084      	sub	sp, #16
 8000d9c:	af00      	add	r7, sp, #0
 8000d9e:	6078      	str	r0, [r7, #4]
 8000da0:	f000 ff58 	bl	8001c54 <vPortEnterCritical>
 8000da4:	687b      	ldr	r3, [r7, #4]
 8000da6:	f893 3045 	ldrb.w	r3, [r3, #69]	; 0x45
 8000daa:	73fb      	strb	r3, [r7, #15]
 8000dac:	e011      	b.n	8000dd2 <prvUnlockQueue+0x3a>
 8000dae:	687b      	ldr	r3, [r7, #4]
 8000db0:	6a5b      	ldr	r3, [r3, #36]	; 0x24
 8000db2:	2b00      	cmp	r3, #0
 8000db4:	d012      	beq.n	8000ddc <prvUnlockQueue+0x44>
 8000db6:	687b      	ldr	r3, [r7, #4]
 8000db8:	3324      	adds	r3, #36	; 0x24
 8000dba:	4618      	mov	r0, r3
 8000dbc:	f000 fbb4 	bl	8001528 <xTaskRemoveFromEventList>
 8000dc0:	4603      	mov	r3, r0
 8000dc2:	2b00      	cmp	r3, #0
 8000dc4:	d001      	beq.n	8000dca <prvUnlockQueue+0x32>
 8000dc6:	f000 fc91 	bl	80016ec <vTaskMissedYield>
 8000dca:	7bfb      	ldrb	r3, [r7, #15]
 8000dcc:	3b01      	subs	r3, #1
 8000dce:	b2db      	uxtb	r3, r3
 8000dd0:	73fb      	strb	r3, [r7, #15]
 8000dd2:	f997 300f 	ldrsb.w	r3, [r7, #15]
 8000dd6:	2b00      	cmp	r3, #0
 8000dd8:	dce9      	bgt.n	8000dae <prvUnlockQueue+0x16>
 8000dda:	e000      	b.n	8000dde <prvUnlockQueue+0x46>
 8000ddc:	bf00      	nop
 8000dde:	687b      	ldr	r3, [r7, #4]
 8000de0:	22ff      	movs	r2, #255	; 0xff
 8000de2:	f883 2045 	strb.w	r2, [r3, #69]	; 0x45
 8000de6:	f000 ff63 	bl	8001cb0 <vPortExitCritical>
 8000dea:	f000 ff33 	bl	8001c54 <vPortEnterCritical>
 8000dee:	687b      	ldr	r3, [r7, #4]
 8000df0:	f893 3044 	ldrb.w	r3, [r3, #68]	; 0x44
 8000df4:	73bb      	strb	r3, [r7, #14]
 8000df6:	e011      	b.n	8000e1c <prvUnlockQueue+0x84>
 8000df8:	687b      	ldr	r3, [r7, #4]
 8000dfa:	691b      	ldr	r3, [r3, #16]
 8000dfc:	2b00      	cmp	r3, #0
 8000dfe:	d012      	beq.n	8000e26 <prvUnlockQueue+0x8e>
 8000e00:	687b      	ldr	r3, [r7, #4]
 8000e02:	3310      	adds	r3, #16
 8000e04:	4618      	mov	r0, r3
 8000e06:	f000 fb8f 	bl	8001528 <xTaskRemoveFromEventList>
 8000e0a:	4603      	mov	r3, r0
 8000e0c:	2b00      	cmp	r3, #0
 8000e0e:	d001      	beq.n	8000e14 <prvUnlockQueue+0x7c>
 8000e10:	f000 fc6c 	bl	80016ec <vTaskMissedYield>
 8000e14:	7bbb      	ldrb	r3, [r7, #14]
 8000e16:	3b01      	subs	r3, #1
 8000e18:	b2db      	uxtb	r3, r3
 8000e1a:	73bb      	strb	r3, [r7, #14]
 8000e1c:	f997 300e 	ldrsb.w	r3, [r7, #14]
 8000e20:	2b00      	cmp	r3, #0
 8000e22:	dce9      	bgt.n	8000df8 <prvUnlockQueue+0x60>
 8000e24:	e000      	b.n	8000e28 <prvUnlockQueue+0x90>
 8000e26:	bf00      	nop
 8000e28:	687b      	ldr	r3, [r7, #4]
 8000e2a:	22ff      	movs	r2, #255	; 0xff
 8000e2c:	f883 2044 	strb.w	r2, [r3, #68]	; 0x44
 8000e30:	f000 ff3e 	bl	8001cb0 <vPortExitCritical>
 8000e34:	bf00      	nop
 8000e36:	3710      	adds	r7, #16
 8000e38:	46bd      	mov	sp, r7
 8000e3a:	bd80      	pop	{r7, pc}

08000e3c <prvIsQueueEmpty>:
 8000e3c:	b580      	push	{r7, lr}
 8000e3e:	b084      	sub	sp, #16
 8000e40:	af00      	add	r7, sp, #0
 8000e42:	6078      	str	r0, [r7, #4]
 8000e44:	f000 ff06 	bl	8001c54 <vPortEnterCritical>
 8000e48:	687b      	ldr	r3, [r7, #4]
 8000e4a:	6b9b      	ldr	r3, [r3, #56]	; 0x38
 8000e4c:	2b00      	cmp	r3, #0
 8000e4e:	d102      	bne.n	8000e56 <prvIsQueueEmpty+0x1a>
 8000e50:	2301      	movs	r3, #1
 8000e52:	60fb      	str	r3, [r7, #12]
 8000e54:	e001      	b.n	8000e5a <prvIsQueueEmpty+0x1e>
 8000e56:	2300      	movs	r3, #0
 8000e58:	60fb      	str	r3, [r7, #12]
 8000e5a:	f000 ff29 	bl	8001cb0 <vPortExitCritical>
 8000e5e:	68fb      	ldr	r3, [r7, #12]
 8000e60:	4618      	mov	r0, r3
 8000e62:	3710      	adds	r7, #16
 8000e64:	46bd      	mov	sp, r7
 8000e66:	bd80      	pop	{r7, pc}

08000e68 <xTaskCreate>:
 8000e68:	b580      	push	{r7, lr}
 8000e6a:	b08c      	sub	sp, #48	; 0x30
 8000e6c:	af04      	add	r7, sp, #16
 8000e6e:	60f8      	str	r0, [r7, #12]
 8000e70:	60b9      	str	r1, [r7, #8]
 8000e72:	603b      	str	r3, [r7, #0]
 8000e74:	4613      	mov	r3, r2
 8000e76:	80fb      	strh	r3, [r7, #6]
 8000e78:	88fb      	ldrh	r3, [r7, #6]
 8000e7a:	009b      	lsls	r3, r3, #2
 8000e7c:	4618      	mov	r0, r3
 8000e7e:	f000 ffd9 	bl	8001e34 <pvPortMalloc>
 8000e82:	6178      	str	r0, [r7, #20]
 8000e84:	697b      	ldr	r3, [r7, #20]
 8000e86:	2b00      	cmp	r3, #0
 8000e88:	d00e      	beq.n	8000ea8 <xTaskCreate+0x40>
 8000e8a:	205c      	movs	r0, #92	; 0x5c
 8000e8c:	f000 ffd2 	bl	8001e34 <pvPortMalloc>
 8000e90:	61f8      	str	r0, [r7, #28]
 8000e92:	69fb      	ldr	r3, [r7, #28]
 8000e94:	2b00      	cmp	r3, #0
 8000e96:	d003      	beq.n	8000ea0 <xTaskCreate+0x38>
 8000e98:	69fb      	ldr	r3, [r7, #28]
 8000e9a:	697a      	ldr	r2, [r7, #20]
 8000e9c:	631a      	str	r2, [r3, #48]	; 0x30
 8000e9e:	e005      	b.n	8000eac <xTaskCreate+0x44>
 8000ea0:	6978      	ldr	r0, [r7, #20]
 8000ea2:	f001 f889 	bl	8001fb8 <vPortFree>
 8000ea6:	e001      	b.n	8000eac <xTaskCreate+0x44>
 8000ea8:	2300      	movs	r3, #0
 8000eaa:	61fb      	str	r3, [r7, #28]
 8000eac:	69fb      	ldr	r3, [r7, #28]
 8000eae:	2b00      	cmp	r3, #0
 8000eb0:	d013      	beq.n	8000eda <xTaskCreate+0x72>
 8000eb2:	88fa      	ldrh	r2, [r7, #6]
 8000eb4:	2300      	movs	r3, #0
 8000eb6:	9303      	str	r3, [sp, #12]
 8000eb8:	69fb      	ldr	r3, [r7, #28]
 8000eba:	9302      	str	r3, [sp, #8]
 8000ebc:	6afb      	ldr	r3, [r7, #44]	; 0x2c
 8000ebe:	9301      	str	r3, [sp, #4]
 8000ec0:	6abb      	ldr	r3, [r7, #40]	; 0x28
 8000ec2:	9300      	str	r3, [sp, #0]
 8000ec4:	683b      	ldr	r3, [r7, #0]
 8000ec6:	68b9      	ldr	r1, [r7, #8]
 8000ec8:	68f8      	ldr	r0, [r7, #12]
 8000eca:	f000 f80e 	bl	8000eea <prvInitialiseNewTask>
 8000ece:	69f8      	ldr	r0, [r7, #28]
 8000ed0:	f000 f892 	bl	8000ff8 <prvAddNewTaskToReadyList>
 8000ed4:	2301      	movs	r3, #1
 8000ed6:	61bb      	str	r3, [r7, #24]
 8000ed8:	e002      	b.n	8000ee0 <xTaskCreate+0x78>
 8000eda:	f04f 33ff 	mov.w	r3, #4294967295	; 0xffffffff
 8000ede:	61bb      	str	r3, [r7, #24]
 8000ee0:	69bb      	ldr	r3, [r7, #24]
 8000ee2:	4618      	mov	r0, r3
 8000ee4:	3720      	adds	r7, #32
 8000ee6:	46bd      	mov	sp, r7
 8000ee8:	bd80      	pop	{r7, pc}

08000eea <prvInitialiseNewTask>:
 8000eea:	b580      	push	{r7, lr}
 8000eec:	b088      	sub	sp, #32
 8000eee:	af00      	add	r7, sp, #0
 8000ef0:	60f8      	str	r0, [r7, #12]
 8000ef2:	60b9      	str	r1, [r7, #8]
 8000ef4:	607a      	str	r2, [r7, #4]
 8000ef6:	603b      	str	r3, [r7, #0]
 8000ef8:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000efa:	6b18      	ldr	r0, [r3, #48]	; 0x30
 8000efc:	687b      	ldr	r3, [r7, #4]
 8000efe:	009b      	lsls	r3, r3, #2
 8000f00:	461a      	mov	r2, r3
 8000f02:	21a5      	movs	r1, #165	; 0xa5
 8000f04:	f001 fe12 	bl	8002b2c <memset>
 8000f08:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000f0a:	6b1a      	ldr	r2, [r3, #48]	; 0x30
 8000f0c:	687b      	ldr	r3, [r7, #4]
 8000f0e:	f103 4380 	add.w	r3, r3, #1073741824	; 0x40000000
 8000f12:	3b01      	subs	r3, #1
 8000f14:	009b      	lsls	r3, r3, #2
 8000f16:	4413      	add	r3, r2
 8000f18:	61bb      	str	r3, [r7, #24]
 8000f1a:	69bb      	ldr	r3, [r7, #24]
 8000f1c:	f023 0307 	bic.w	r3, r3, #7
 8000f20:	61bb      	str	r3, [r7, #24]
 8000f22:	69bb      	ldr	r3, [r7, #24]
 8000f24:	f003 0307 	and.w	r3, r3, #7
 8000f28:	2b00      	cmp	r3, #0
 8000f2a:	d009      	beq.n	8000f40 <prvInitialiseNewTask+0x56>
 8000f2c:	f04f 0350 	mov.w	r3, #80	; 0x50
 8000f30:	f383 8811 	msr	BASEPRI, r3
 8000f34:	f3bf 8f6f 	isb	sy
 8000f38:	f3bf 8f4f 	dsb	sy
 8000f3c:	617b      	str	r3, [r7, #20]
 8000f3e:	e7fe      	b.n	8000f3e <prvInitialiseNewTask+0x54>
 8000f40:	2300      	movs	r3, #0
 8000f42:	61fb      	str	r3, [r7, #28]
 8000f44:	e012      	b.n	8000f6c <prvInitialiseNewTask+0x82>
 8000f46:	68ba      	ldr	r2, [r7, #8]
 8000f48:	69fb      	ldr	r3, [r7, #28]
 8000f4a:	4413      	add	r3, r2
 8000f4c:	7819      	ldrb	r1, [r3, #0]
 8000f4e:	6b3a      	ldr	r2, [r7, #48]	; 0x30
 8000f50:	69fb      	ldr	r3, [r7, #28]
 8000f52:	4413      	add	r3, r2
 8000f54:	3334      	adds	r3, #52	; 0x34
 8000f56:	460a      	mov	r2, r1
 8000f58:	701a      	strb	r2, [r3, #0]
 8000f5a:	68ba      	ldr	r2, [r7, #8]
 8000f5c:	69fb      	ldr	r3, [r7, #28]
 8000f5e:	4413      	add	r3, r2
 8000f60:	781b      	ldrb	r3, [r3, #0]
 8000f62:	2b00      	cmp	r3, #0
 8000f64:	d006      	beq.n	8000f74 <prvInitialiseNewTask+0x8a>
 8000f66:	69fb      	ldr	r3, [r7, #28]
 8000f68:	3301      	adds	r3, #1
 8000f6a:	61fb      	str	r3, [r7, #28]
 8000f6c:	69fb      	ldr	r3, [r7, #28]
 8000f6e:	2b0f      	cmp	r3, #15
 8000f70:	d9e9      	bls.n	8000f46 <prvInitialiseNewTask+0x5c>
 8000f72:	e000      	b.n	8000f76 <prvInitialiseNewTask+0x8c>
 8000f74:	bf00      	nop
 8000f76:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000f78:	2200      	movs	r2, #0
 8000f7a:	f883 2043 	strb.w	r2, [r3, #67]	; 0x43
 8000f7e:	6abb      	ldr	r3, [r7, #40]	; 0x28
 8000f80:	2b06      	cmp	r3, #6
 8000f82:	d901      	bls.n	8000f88 <prvInitialiseNewTask+0x9e>
 8000f84:	2306      	movs	r3, #6
 8000f86:	62bb      	str	r3, [r7, #40]	; 0x28
 8000f88:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000f8a:	6aba      	ldr	r2, [r7, #40]	; 0x28
 8000f8c:	62da      	str	r2, [r3, #44]	; 0x2c
 8000f8e:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000f90:	6aba      	ldr	r2, [r7, #40]	; 0x28
 8000f92:	64da      	str	r2, [r3, #76]	; 0x4c
 8000f94:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000f96:	2200      	movs	r2, #0
 8000f98:	651a      	str	r2, [r3, #80]	; 0x50
 8000f9a:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000f9c:	3304      	adds	r3, #4
 8000f9e:	4618      	mov	r0, r3
 8000fa0:	f7ff fbe4 	bl	800076c <vListInitialiseItem>
 8000fa4:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000fa6:	3318      	adds	r3, #24
 8000fa8:	4618      	mov	r0, r3
 8000faa:	f7ff fbdf 	bl	800076c <vListInitialiseItem>
 8000fae:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000fb0:	6b3a      	ldr	r2, [r7, #48]	; 0x30
 8000fb2:	611a      	str	r2, [r3, #16]
 8000fb4:	6abb      	ldr	r3, [r7, #40]	; 0x28
 8000fb6:	f1c3 0207 	rsb	r2, r3, #7
 8000fba:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000fbc:	619a      	str	r2, [r3, #24]
 8000fbe:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000fc0:	6b3a      	ldr	r2, [r7, #48]	; 0x30
 8000fc2:	625a      	str	r2, [r3, #36]	; 0x24
 8000fc4:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000fc6:	2200      	movs	r2, #0
 8000fc8:	655a      	str	r2, [r3, #84]	; 0x54
 8000fca:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000fcc:	2200      	movs	r2, #0
 8000fce:	f883 2058 	strb.w	r2, [r3, #88]	; 0x58
 8000fd2:	683a      	ldr	r2, [r7, #0]
 8000fd4:	68f9      	ldr	r1, [r7, #12]
 8000fd6:	69b8      	ldr	r0, [r7, #24]
 8000fd8:	f000 fd6a 	bl	8001ab0 <pxPortInitialiseStack>
 8000fdc:	4602      	mov	r2, r0
 8000fde:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000fe0:	601a      	str	r2, [r3, #0]
 8000fe2:	6afb      	ldr	r3, [r7, #44]	; 0x2c
 8000fe4:	2b00      	cmp	r3, #0
 8000fe6:	d002      	beq.n	8000fee <prvInitialiseNewTask+0x104>
 8000fe8:	6afb      	ldr	r3, [r7, #44]	; 0x2c
 8000fea:	6b3a      	ldr	r2, [r7, #48]	; 0x30
 8000fec:	601a      	str	r2, [r3, #0]
 8000fee:	bf00      	nop
 8000ff0:	3720      	adds	r7, #32
 8000ff2:	46bd      	mov	sp, r7
 8000ff4:	bd80      	pop	{r7, pc}
	...

08000ff8 <prvAddNewTaskToReadyList>:
 8000ff8:	b580      	push	{r7, lr}
 8000ffa:	b082      	sub	sp, #8
 8000ffc:	af00      	add	r7, sp, #0
 8000ffe:	6078      	str	r0, [r7, #4]
 8001000:	f000 fe28 	bl	8001c54 <vPortEnterCritical>
 8001004:	4b2c      	ldr	r3, [pc, #176]	; (80010b8 <prvAddNewTaskToReadyList+0xc0>)
 8001006:	681b      	ldr	r3, [r3, #0]
 8001008:	3301      	adds	r3, #1
 800100a:	4a2b      	ldr	r2, [pc, #172]	; (80010b8 <prvAddNewTaskToReadyList+0xc0>)
 800100c:	6013      	str	r3, [r2, #0]
 800100e:	4b2b      	ldr	r3, [pc, #172]	; (80010bc <prvAddNewTaskToReadyList+0xc4>)
 8001010:	681b      	ldr	r3, [r3, #0]
 8001012:	2b00      	cmp	r3, #0
 8001014:	d109      	bne.n	800102a <prvAddNewTaskToReadyList+0x32>
 8001016:	4a29      	ldr	r2, [pc, #164]	; (80010bc <prvAddNewTaskToReadyList+0xc4>)
 8001018:	687b      	ldr	r3, [r7, #4]
 800101a:	6013      	str	r3, [r2, #0]
 800101c:	4b26      	ldr	r3, [pc, #152]	; (80010b8 <prvAddNewTaskToReadyList+0xc0>)
 800101e:	681b      	ldr	r3, [r3, #0]
 8001020:	2b01      	cmp	r3, #1
 8001022:	d110      	bne.n	8001046 <prvAddNewTaskToReadyList+0x4e>
 8001024:	f000 fb86 	bl	8001734 <prvInitialiseTaskLists>
 8001028:	e00d      	b.n	8001046 <prvAddNewTaskToReadyList+0x4e>
 800102a:	4b25      	ldr	r3, [pc, #148]	; (80010c0 <prvAddNewTaskToReadyList+0xc8>)
 800102c:	681b      	ldr	r3, [r3, #0]
 800102e:	2b00      	cmp	r3, #0
 8001030:	d109      	bne.n	8001046 <prvAddNewTaskToReadyList+0x4e>
 8001032:	4b22      	ldr	r3, [pc, #136]	; (80010bc <prvAddNewTaskToReadyList+0xc4>)
 8001034:	681b      	ldr	r3, [r3, #0]
 8001036:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 8001038:	687b      	ldr	r3, [r7, #4]
 800103a:	6adb      	ldr	r3, [r3, #44]	; 0x2c
 800103c:	429a      	cmp	r2, r3
 800103e:	d802      	bhi.n	8001046 <prvAddNewTaskToReadyList+0x4e>
 8001040:	4a1e      	ldr	r2, [pc, #120]	; (80010bc <prvAddNewTaskToReadyList+0xc4>)
 8001042:	687b      	ldr	r3, [r7, #4]
 8001044:	6013      	str	r3, [r2, #0]
 8001046:	4b1f      	ldr	r3, [pc, #124]	; (80010c4 <prvAddNewTaskToReadyList+0xcc>)
 8001048:	681b      	ldr	r3, [r3, #0]
 800104a:	3301      	adds	r3, #1
 800104c:	4a1d      	ldr	r2, [pc, #116]	; (80010c4 <prvAddNewTaskToReadyList+0xcc>)
 800104e:	6013      	str	r3, [r2, #0]
 8001050:	4b1c      	ldr	r3, [pc, #112]	; (80010c4 <prvAddNewTaskToReadyList+0xcc>)
 8001052:	681a      	ldr	r2, [r3, #0]
 8001054:	687b      	ldr	r3, [r7, #4]
 8001056:	645a      	str	r2, [r3, #68]	; 0x44
 8001058:	687b      	ldr	r3, [r7, #4]
 800105a:	6adb      	ldr	r3, [r3, #44]	; 0x2c
 800105c:	2201      	movs	r2, #1
 800105e:	409a      	lsls	r2, r3
 8001060:	4b19      	ldr	r3, [pc, #100]	; (80010c8 <prvAddNewTaskToReadyList+0xd0>)
 8001062:	681b      	ldr	r3, [r3, #0]
 8001064:	4313      	orrs	r3, r2
 8001066:	4a18      	ldr	r2, [pc, #96]	; (80010c8 <prvAddNewTaskToReadyList+0xd0>)
 8001068:	6013      	str	r3, [r2, #0]
 800106a:	687b      	ldr	r3, [r7, #4]
 800106c:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 800106e:	4613      	mov	r3, r2
 8001070:	009b      	lsls	r3, r3, #2
 8001072:	4413      	add	r3, r2
 8001074:	009b      	lsls	r3, r3, #2
 8001076:	4a15      	ldr	r2, [pc, #84]	; (80010cc <prvAddNewTaskToReadyList+0xd4>)
 8001078:	441a      	add	r2, r3
 800107a:	687b      	ldr	r3, [r7, #4]
 800107c:	3304      	adds	r3, #4
 800107e:	4619      	mov	r1, r3
 8001080:	4610      	mov	r0, r2
 8001082:	f7ff fb7f 	bl	8000784 <vListInsertEnd>
 8001086:	f000 fe13 	bl	8001cb0 <vPortExitCritical>
 800108a:	4b0d      	ldr	r3, [pc, #52]	; (80010c0 <prvAddNewTaskToReadyList+0xc8>)
 800108c:	681b      	ldr	r3, [r3, #0]
 800108e:	2b00      	cmp	r3, #0
 8001090:	d00e      	beq.n	80010b0 <prvAddNewTaskToReadyList+0xb8>
 8001092:	4b0a      	ldr	r3, [pc, #40]	; (80010bc <prvAddNewTaskToReadyList+0xc4>)
 8001094:	681b      	ldr	r3, [r3, #0]
 8001096:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 8001098:	687b      	ldr	r3, [r7, #4]
 800109a:	6adb      	ldr	r3, [r3, #44]	; 0x2c
 800109c:	429a      	cmp	r2, r3
 800109e:	d207      	bcs.n	80010b0 <prvAddNewTaskToReadyList+0xb8>
 80010a0:	4b0b      	ldr	r3, [pc, #44]	; (80010d0 <prvAddNewTaskToReadyList+0xd8>)
 80010a2:	f04f 5280 	mov.w	r2, #268435456	; 0x10000000
 80010a6:	601a      	str	r2, [r3, #0]
 80010a8:	f3bf 8f4f 	dsb	sy
 80010ac:	f3bf 8f6f 	isb	sy
 80010b0:	bf00      	nop
 80010b2:	3708      	adds	r7, #8
 80010b4:	46bd      	mov	sp, r7
 80010b6:	bd80      	pop	{r7, pc}
 80010b8:	20000558 	.word	0x20000558
 80010bc:	20000458 	.word	0x20000458
 80010c0:	20000564 	.word	0x20000564
 80010c4:	20000574 	.word	0x20000574
 80010c8:	20000560 	.word	0x20000560
 80010cc:	2000045c 	.word	0x2000045c
 80010d0:	e000ed04 	.word	0xe000ed04

080010d4 <vTaskStartScheduler>:
 80010d4:	b580      	push	{r7, lr}
 80010d6:	b086      	sub	sp, #24
 80010d8:	af02      	add	r7, sp, #8
 80010da:	4b1b      	ldr	r3, [pc, #108]	; (8001148 <vTaskStartScheduler+0x74>)
 80010dc:	9301      	str	r3, [sp, #4]
 80010de:	2300      	movs	r3, #0
 80010e0:	9300      	str	r3, [sp, #0]
 80010e2:	2300      	movs	r3, #0
 80010e4:	2280      	movs	r2, #128	; 0x80
 80010e6:	4919      	ldr	r1, [pc, #100]	; (800114c <vTaskStartScheduler+0x78>)
 80010e8:	4819      	ldr	r0, [pc, #100]	; (8001150 <vTaskStartScheduler+0x7c>)
 80010ea:	f7ff febd 	bl	8000e68 <xTaskCreate>
 80010ee:	60f8      	str	r0, [r7, #12]
 80010f0:	68fb      	ldr	r3, [r7, #12]
 80010f2:	2b01      	cmp	r3, #1
 80010f4:	d115      	bne.n	8001122 <vTaskStartScheduler+0x4e>
 80010f6:	f04f 0350 	mov.w	r3, #80	; 0x50
 80010fa:	f383 8811 	msr	BASEPRI, r3
 80010fe:	f3bf 8f6f 	isb	sy
 8001102:	f3bf 8f4f 	dsb	sy
 8001106:	60bb      	str	r3, [r7, #8]
 8001108:	4b12      	ldr	r3, [pc, #72]	; (8001154 <vTaskStartScheduler+0x80>)
 800110a:	f04f 32ff 	mov.w	r2, #4294967295	; 0xffffffff
 800110e:	601a      	str	r2, [r3, #0]
 8001110:	4b11      	ldr	r3, [pc, #68]	; (8001158 <vTaskStartScheduler+0x84>)
 8001112:	2201      	movs	r2, #1
 8001114:	601a      	str	r2, [r3, #0]
 8001116:	4b11      	ldr	r3, [pc, #68]	; (800115c <vTaskStartScheduler+0x88>)
 8001118:	2200      	movs	r2, #0
 800111a:	601a      	str	r2, [r3, #0]
 800111c:	f000 fd3c 	bl	8001b98 <xPortStartScheduler>
 8001120:	e00d      	b.n	800113e <vTaskStartScheduler+0x6a>
 8001122:	68fb      	ldr	r3, [r7, #12]
 8001124:	f1b3 3fff 	cmp.w	r3, #4294967295	; 0xffffffff
 8001128:	d109      	bne.n	800113e <vTaskStartScheduler+0x6a>
 800112a:	f04f 0350 	mov.w	r3, #80	; 0x50
 800112e:	f383 8811 	msr	BASEPRI, r3
 8001132:	f3bf 8f6f 	isb	sy
 8001136:	f3bf 8f4f 	dsb	sy
 800113a:	607b      	str	r3, [r7, #4]
 800113c:	e7fe      	b.n	800113c <vTaskStartScheduler+0x68>
 800113e:	bf00      	nop
 8001140:	3710      	adds	r7, #16
 8001142:	46bd      	mov	sp, r7
 8001144:	bd80      	pop	{r7, pc}
 8001146:	bf00      	nop
 8001148:	2000057c 	.word	0x2000057c
 800114c:	08002cf4 	.word	0x08002cf4
 8001150:	08001705 	.word	0x08001705
 8001154:	20000578 	.word	0x20000578
 8001158:	20000564 	.word	0x20000564
 800115c:	2000055c 	.word	0x2000055c

08001160 <vTaskSuspendAll>:
 8001160:	b480      	push	{r7}
 8001162:	af00      	add	r7, sp, #0
 8001164:	4b04      	ldr	r3, [pc, #16]	; (8001178 <vTaskSuspendAll+0x18>)
 8001166:	681b      	ldr	r3, [r3, #0]
 8001168:	3301      	adds	r3, #1
 800116a:	4a03      	ldr	r2, [pc, #12]	; (8001178 <vTaskSuspendAll+0x18>)
 800116c:	6013      	str	r3, [r2, #0]
 800116e:	bf00      	nop
 8001170:	46bd      	mov	sp, r7
 8001172:	bc80      	pop	{r7}
 8001174:	4770      	bx	lr
 8001176:	bf00      	nop
 8001178:	20000580 	.word	0x20000580

0800117c <xTaskResumeAll>:
 800117c:	b580      	push	{r7, lr}
 800117e:	b084      	sub	sp, #16
 8001180:	af00      	add	r7, sp, #0
 8001182:	2300      	movs	r3, #0
 8001184:	60fb      	str	r3, [r7, #12]
 8001186:	2300      	movs	r3, #0
 8001188:	60bb      	str	r3, [r7, #8]
 800118a:	4b41      	ldr	r3, [pc, #260]	; (8001290 <xTaskResumeAll+0x114>)
 800118c:	681b      	ldr	r3, [r3, #0]
 800118e:	2b00      	cmp	r3, #0
 8001190:	d109      	bne.n	80011a6 <xTaskResumeAll+0x2a>
 8001192:	f04f 0350 	mov.w	r3, #80	; 0x50
 8001196:	f383 8811 	msr	BASEPRI, r3
 800119a:	f3bf 8f6f 	isb	sy
 800119e:	f3bf 8f4f 	dsb	sy
 80011a2:	603b      	str	r3, [r7, #0]
 80011a4:	e7fe      	b.n	80011a4 <xTaskResumeAll+0x28>
 80011a6:	f000 fd55 	bl	8001c54 <vPortEnterCritical>
 80011aa:	4b39      	ldr	r3, [pc, #228]	; (8001290 <xTaskResumeAll+0x114>)
 80011ac:	681b      	ldr	r3, [r3, #0]
 80011ae:	3b01      	subs	r3, #1
 80011b0:	4a37      	ldr	r2, [pc, #220]	; (8001290 <xTaskResumeAll+0x114>)
 80011b2:	6013      	str	r3, [r2, #0]
 80011b4:	4b36      	ldr	r3, [pc, #216]	; (8001290 <xTaskResumeAll+0x114>)
 80011b6:	681b      	ldr	r3, [r3, #0]
 80011b8:	2b00      	cmp	r3, #0
 80011ba:	d161      	bne.n	8001280 <xTaskResumeAll+0x104>
 80011bc:	4b35      	ldr	r3, [pc, #212]	; (8001294 <xTaskResumeAll+0x118>)
 80011be:	681b      	ldr	r3, [r3, #0]
 80011c0:	2b00      	cmp	r3, #0
 80011c2:	d05d      	beq.n	8001280 <xTaskResumeAll+0x104>
 80011c4:	e02e      	b.n	8001224 <xTaskResumeAll+0xa8>
 80011c6:	4b34      	ldr	r3, [pc, #208]	; (8001298 <xTaskResumeAll+0x11c>)
 80011c8:	68db      	ldr	r3, [r3, #12]
 80011ca:	68db      	ldr	r3, [r3, #12]
 80011cc:	60fb      	str	r3, [r7, #12]
 80011ce:	68fb      	ldr	r3, [r7, #12]
 80011d0:	3318      	adds	r3, #24
 80011d2:	4618      	mov	r0, r3
 80011d4:	f7ff fb31 	bl	800083a <uxListRemove>
 80011d8:	68fb      	ldr	r3, [r7, #12]
 80011da:	3304      	adds	r3, #4
 80011dc:	4618      	mov	r0, r3
 80011de:	f7ff fb2c 	bl	800083a <uxListRemove>
 80011e2:	68fb      	ldr	r3, [r7, #12]
 80011e4:	6adb      	ldr	r3, [r3, #44]	; 0x2c
 80011e6:	2201      	movs	r2, #1
 80011e8:	409a      	lsls	r2, r3
 80011ea:	4b2c      	ldr	r3, [pc, #176]	; (800129c <xTaskResumeAll+0x120>)
 80011ec:	681b      	ldr	r3, [r3, #0]
 80011ee:	4313      	orrs	r3, r2
 80011f0:	4a2a      	ldr	r2, [pc, #168]	; (800129c <xTaskResumeAll+0x120>)
 80011f2:	6013      	str	r3, [r2, #0]
 80011f4:	68fb      	ldr	r3, [r7, #12]
 80011f6:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 80011f8:	4613      	mov	r3, r2
 80011fa:	009b      	lsls	r3, r3, #2
 80011fc:	4413      	add	r3, r2
 80011fe:	009b      	lsls	r3, r3, #2
 8001200:	4a27      	ldr	r2, [pc, #156]	; (80012a0 <xTaskResumeAll+0x124>)
 8001202:	441a      	add	r2, r3
 8001204:	68fb      	ldr	r3, [r7, #12]
 8001206:	3304      	adds	r3, #4
 8001208:	4619      	mov	r1, r3
 800120a:	4610      	mov	r0, r2
 800120c:	f7ff faba 	bl	8000784 <vListInsertEnd>
 8001210:	68fb      	ldr	r3, [r7, #12]
 8001212:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 8001214:	4b23      	ldr	r3, [pc, #140]	; (80012a4 <xTaskResumeAll+0x128>)
 8001216:	681b      	ldr	r3, [r3, #0]
 8001218:	6adb      	ldr	r3, [r3, #44]	; 0x2c
 800121a:	429a      	cmp	r2, r3
 800121c:	d302      	bcc.n	8001224 <xTaskResumeAll+0xa8>
 800121e:	4b22      	ldr	r3, [pc, #136]	; (80012a8 <xTaskResumeAll+0x12c>)
 8001220:	2201      	movs	r2, #1
 8001222:	601a      	str	r2, [r3, #0]
 8001224:	4b1c      	ldr	r3, [pc, #112]	; (8001298 <xTaskResumeAll+0x11c>)
 8001226:	681b      	ldr	r3, [r3, #0]
 8001228:	2b00      	cmp	r3, #0
 800122a:	d1cc      	bne.n	80011c6 <xTaskResumeAll+0x4a>
 800122c:	68fb      	ldr	r3, [r7, #12]
 800122e:	2b00      	cmp	r3, #0
 8001230:	d001      	beq.n	8001236 <xTaskResumeAll+0xba>
 8001232:	f000 fb0b 	bl	800184c <prvResetNextTaskUnblockTime>
 8001236:	4b1d      	ldr	r3, [pc, #116]	; (80012ac <xTaskResumeAll+0x130>)
 8001238:	681b      	ldr	r3, [r3, #0]
 800123a:	607b      	str	r3, [r7, #4]
 800123c:	687b      	ldr	r3, [r7, #4]
 800123e:	2b00      	cmp	r3, #0
 8001240:	d010      	beq.n	8001264 <xTaskResumeAll+0xe8>
 8001242:	f000 f837 	bl	80012b4 <xTaskIncrementTick>
 8001246:	4603      	mov	r3, r0
 8001248:	2b00      	cmp	r3, #0
 800124a:	d002      	beq.n	8001252 <xTaskResumeAll+0xd6>
 800124c:	4b16      	ldr	r3, [pc, #88]	; (80012a8 <xTaskResumeAll+0x12c>)
 800124e:	2201      	movs	r2, #1
 8001250:	601a      	str	r2, [r3, #0]
 8001252:	687b      	ldr	r3, [r7, #4]
 8001254:	3b01      	subs	r3, #1
 8001256:	607b      	str	r3, [r7, #4]
 8001258:	687b      	ldr	r3, [r7, #4]
 800125a:	2b00      	cmp	r3, #0
 800125c:	d1f1      	bne.n	8001242 <xTaskResumeAll+0xc6>
 800125e:	4b13      	ldr	r3, [pc, #76]	; (80012ac <xTaskResumeAll+0x130>)
 8001260:	2200      	movs	r2, #0
 8001262:	601a      	str	r2, [r3, #0]
 8001264:	4b10      	ldr	r3, [pc, #64]	; (80012a8 <xTaskResumeAll+0x12c>)
 8001266:	681b      	ldr	r3, [r3, #0]
 8001268:	2b00      	cmp	r3, #0
 800126a:	d009      	beq.n	8001280 <xTaskResumeAll+0x104>
 800126c:	2301      	movs	r3, #1
 800126e:	60bb      	str	r3, [r7, #8]
 8001270:	4b0f      	ldr	r3, [pc, #60]	; (80012b0 <xTaskResumeAll+0x134>)
 8001272:	f04f 5280 	mov.w	r2, #268435456	; 0x10000000
 8001276:	601a      	str	r2, [r3, #0]
 8001278:	f3bf 8f4f 	dsb	sy
 800127c:	f3bf 8f6f 	isb	sy
 8001280:	f000 fd16 	bl	8001cb0 <vPortExitCritical>
 8001284:	68bb      	ldr	r3, [r7, #8]
 8001286:	4618      	mov	r0, r3
 8001288:	3710      	adds	r7, #16
 800128a:	46bd      	mov	sp, r7
 800128c:	bd80      	pop	{r7, pc}
 800128e:	bf00      	nop
 8001290:	20000580 	.word	0x20000580
 8001294:	20000558 	.word	0x20000558
 8001298:	20000518 	.word	0x20000518
 800129c:	20000560 	.word	0x20000560
 80012a0:	2000045c 	.word	0x2000045c
 80012a4:	20000458 	.word	0x20000458
 80012a8:	2000056c 	.word	0x2000056c
 80012ac:	20000568 	.word	0x20000568
 80012b0:	e000ed04 	.word	0xe000ed04

080012b4 <xTaskIncrementTick>:
 80012b4:	b580      	push	{r7, lr}
 80012b6:	b086      	sub	sp, #24
 80012b8:	af00      	add	r7, sp, #0
 80012ba:	2300      	movs	r3, #0
 80012bc:	617b      	str	r3, [r7, #20]
 80012be:	4b50      	ldr	r3, [pc, #320]	; (8001400 <xTaskIncrementTick+0x14c>)
 80012c0:	681b      	ldr	r3, [r3, #0]
 80012c2:	2b00      	cmp	r3, #0
 80012c4:	f040 808c 	bne.w	80013e0 <xTaskIncrementTick+0x12c>
 80012c8:	4b4e      	ldr	r3, [pc, #312]	; (8001404 <xTaskIncrementTick+0x150>)
 80012ca:	681b      	ldr	r3, [r3, #0]
 80012cc:	3301      	adds	r3, #1
 80012ce:	613b      	str	r3, [r7, #16]
 80012d0:	4a4c      	ldr	r2, [pc, #304]	; (8001404 <xTaskIncrementTick+0x150>)
 80012d2:	693b      	ldr	r3, [r7, #16]
 80012d4:	6013      	str	r3, [r2, #0]
 80012d6:	693b      	ldr	r3, [r7, #16]
 80012d8:	2b00      	cmp	r3, #0
 80012da:	d11f      	bne.n	800131c <xTaskIncrementTick+0x68>
 80012dc:	4b4a      	ldr	r3, [pc, #296]	; (8001408 <xTaskIncrementTick+0x154>)
 80012de:	681b      	ldr	r3, [r3, #0]
 80012e0:	681b      	ldr	r3, [r3, #0]
 80012e2:	2b00      	cmp	r3, #0
 80012e4:	d009      	beq.n	80012fa <xTaskIncrementTick+0x46>
 80012e6:	f04f 0350 	mov.w	r3, #80	; 0x50
 80012ea:	f383 8811 	msr	BASEPRI, r3
 80012ee:	f3bf 8f6f 	isb	sy
 80012f2:	f3bf 8f4f 	dsb	sy
 80012f6:	603b      	str	r3, [r7, #0]
 80012f8:	e7fe      	b.n	80012f8 <xTaskIncrementTick+0x44>
 80012fa:	4b43      	ldr	r3, [pc, #268]	; (8001408 <xTaskIncrementTick+0x154>)
 80012fc:	681b      	ldr	r3, [r3, #0]
 80012fe:	60fb      	str	r3, [r7, #12]
 8001300:	4b42      	ldr	r3, [pc, #264]	; (800140c <xTaskIncrementTick+0x158>)
 8001302:	681b      	ldr	r3, [r3, #0]
 8001304:	4a40      	ldr	r2, [pc, #256]	; (8001408 <xTaskIncrementTick+0x154>)
 8001306:	6013      	str	r3, [r2, #0]
 8001308:	4a40      	ldr	r2, [pc, #256]	; (800140c <xTaskIncrementTick+0x158>)
 800130a:	68fb      	ldr	r3, [r7, #12]
 800130c:	6013      	str	r3, [r2, #0]
 800130e:	4b40      	ldr	r3, [pc, #256]	; (8001410 <xTaskIncrementTick+0x15c>)
 8001310:	681b      	ldr	r3, [r3, #0]
 8001312:	3301      	adds	r3, #1
 8001314:	4a3e      	ldr	r2, [pc, #248]	; (8001410 <xTaskIncrementTick+0x15c>)
 8001316:	6013      	str	r3, [r2, #0]
 8001318:	f000 fa98 	bl	800184c <prvResetNextTaskUnblockTime>
 800131c:	4b3d      	ldr	r3, [pc, #244]	; (8001414 <xTaskIncrementTick+0x160>)
 800131e:	681b      	ldr	r3, [r3, #0]
 8001320:	693a      	ldr	r2, [r7, #16]
 8001322:	429a      	cmp	r2, r3
 8001324:	d34d      	bcc.n	80013c2 <xTaskIncrementTick+0x10e>
 8001326:	4b38      	ldr	r3, [pc, #224]	; (8001408 <xTaskIncrementTick+0x154>)
 8001328:	681b      	ldr	r3, [r3, #0]
 800132a:	681b      	ldr	r3, [r3, #0]
 800132c:	2b00      	cmp	r3, #0
 800132e:	d101      	bne.n	8001334 <xTaskIncrementTick+0x80>
 8001330:	2301      	movs	r3, #1
 8001332:	e000      	b.n	8001336 <xTaskIncrementTick+0x82>
 8001334:	2300      	movs	r3, #0
 8001336:	2b00      	cmp	r3, #0
 8001338:	d004      	beq.n	8001344 <xTaskIncrementTick+0x90>
 800133a:	4b36      	ldr	r3, [pc, #216]	; (8001414 <xTaskIncrementTick+0x160>)
 800133c:	f04f 32ff 	mov.w	r2, #4294967295	; 0xffffffff
 8001340:	601a      	str	r2, [r3, #0]
 8001342:	e03e      	b.n	80013c2 <xTaskIncrementTick+0x10e>
 8001344:	4b30      	ldr	r3, [pc, #192]	; (8001408 <xTaskIncrementTick+0x154>)
 8001346:	681b      	ldr	r3, [r3, #0]
 8001348:	68db      	ldr	r3, [r3, #12]
 800134a:	68db      	ldr	r3, [r3, #12]
 800134c:	60bb      	str	r3, [r7, #8]
 800134e:	68bb      	ldr	r3, [r7, #8]
 8001350:	685b      	ldr	r3, [r3, #4]
 8001352:	607b      	str	r3, [r7, #4]
 8001354:	693a      	ldr	r2, [r7, #16]
 8001356:	687b      	ldr	r3, [r7, #4]
 8001358:	429a      	cmp	r2, r3
 800135a:	d203      	bcs.n	8001364 <xTaskIncrementTick+0xb0>
 800135c:	4a2d      	ldr	r2, [pc, #180]	; (8001414 <xTaskIncrementTick+0x160>)
 800135e:	687b      	ldr	r3, [r7, #4]
 8001360:	6013      	str	r3, [r2, #0]
 8001362:	e02e      	b.n	80013c2 <xTaskIncrementTick+0x10e>
 8001364:	68bb      	ldr	r3, [r7, #8]
 8001366:	3304      	adds	r3, #4
 8001368:	4618      	mov	r0, r3
 800136a:	f7ff fa66 	bl	800083a <uxListRemove>
 800136e:	68bb      	ldr	r3, [r7, #8]
 8001370:	6a9b      	ldr	r3, [r3, #40]	; 0x28
 8001372:	2b00      	cmp	r3, #0
 8001374:	d004      	beq.n	8001380 <xTaskIncrementTick+0xcc>
 8001376:	68bb      	ldr	r3, [r7, #8]
 8001378:	3318      	adds	r3, #24
 800137a:	4618      	mov	r0, r3
 800137c:	f7ff fa5d 	bl	800083a <uxListRemove>
 8001380:	68bb      	ldr	r3, [r7, #8]
 8001382:	6adb      	ldr	r3, [r3, #44]	; 0x2c
 8001384:	2201      	movs	r2, #1
 8001386:	409a      	lsls	r2, r3
 8001388:	4b23      	ldr	r3, [pc, #140]	; (8001418 <xTaskIncrementTick+0x164>)
 800138a:	681b      	ldr	r3, [r3, #0]
 800138c:	4313      	orrs	r3, r2
 800138e:	4a22      	ldr	r2, [pc, #136]	; (8001418 <xTaskIncrementTick+0x164>)
 8001390:	6013      	str	r3, [r2, #0]
 8001392:	68bb      	ldr	r3, [r7, #8]
 8001394:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 8001396:	4613      	mov	r3, r2
 8001398:	009b      	lsls	r3, r3, #2
 800139a:	4413      	add	r3, r2
 800139c:	009b      	lsls	r3, r3, #2
 800139e:	4a1f      	ldr	r2, [pc, #124]	; (800141c <xTaskIncrementTick+0x168>)
 80013a0:	441a      	add	r2, r3
 80013a2:	68bb      	ldr	r3, [r7, #8]
 80013a4:	3304      	adds	r3, #4
 80013a6:	4619      	mov	r1, r3
 80013a8:	4610      	mov	r0, r2
 80013aa:	f7ff f9eb 	bl	8000784 <vListInsertEnd>
 80013ae:	68bb      	ldr	r3, [r7, #8]
 80013b0:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 80013b2:	4b1b      	ldr	r3, [pc, #108]	; (8001420 <xTaskIncrementTick+0x16c>)
 80013b4:	681b      	ldr	r3, [r3, #0]
 80013b6:	6adb      	ldr	r3, [r3, #44]	; 0x2c
 80013b8:	429a      	cmp	r2, r3
 80013ba:	d3b4      	bcc.n	8001326 <xTaskIncrementTick+0x72>
 80013bc:	2301      	movs	r3, #1
 80013be:	617b      	str	r3, [r7, #20]
 80013c0:	e7b1      	b.n	8001326 <xTaskIncrementTick+0x72>
 80013c2:	4b17      	ldr	r3, [pc, #92]	; (8001420 <xTaskIncrementTick+0x16c>)
 80013c4:	681b      	ldr	r3, [r3, #0]
 80013c6:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 80013c8:	4914      	ldr	r1, [pc, #80]	; (800141c <xTaskIncrementTick+0x168>)
 80013ca:	4613      	mov	r3, r2
 80013cc:	009b      	lsls	r3, r3, #2
 80013ce:	4413      	add	r3, r2
 80013d0:	009b      	lsls	r3, r3, #2
 80013d2:	440b      	add	r3, r1
 80013d4:	681b      	ldr	r3, [r3, #0]
 80013d6:	2b01      	cmp	r3, #1
 80013d8:	d907      	bls.n	80013ea <xTaskIncrementTick+0x136>
 80013da:	2301      	movs	r3, #1
 80013dc:	617b      	str	r3, [r7, #20]
 80013de:	e004      	b.n	80013ea <xTaskIncrementTick+0x136>
 80013e0:	4b10      	ldr	r3, [pc, #64]	; (8001424 <xTaskIncrementTick+0x170>)
 80013e2:	681b      	ldr	r3, [r3, #0]
 80013e4:	3301      	adds	r3, #1
 80013e6:	4a0f      	ldr	r2, [pc, #60]	; (8001424 <xTaskIncrementTick+0x170>)
 80013e8:	6013      	str	r3, [r2, #0]
 80013ea:	4b0f      	ldr	r3, [pc, #60]	; (8001428 <xTaskIncrementTick+0x174>)
 80013ec:	681b      	ldr	r3, [r3, #0]
 80013ee:	2b00      	cmp	r3, #0
 80013f0:	d001      	beq.n	80013f6 <xTaskIncrementTick+0x142>
 80013f2:	2301      	movs	r3, #1
 80013f4:	617b      	str	r3, [r7, #20]
 80013f6:	697b      	ldr	r3, [r7, #20]
 80013f8:	4618      	mov	r0, r3
 80013fa:	3718      	adds	r7, #24
 80013fc:	46bd      	mov	sp, r7
 80013fe:	bd80      	pop	{r7, pc}
 8001400:	20000580 	.word	0x20000580
 8001404:	2000055c 	.word	0x2000055c
 8001408:	20000510 	.word	0x20000510
 800140c:	20000514 	.word	0x20000514
 8001410:	20000570 	.word	0x20000570
 8001414:	20000578 	.word	0x20000578
 8001418:	20000560 	.word	0x20000560
 800141c:	2000045c 	.word	0x2000045c
 8001420:	20000458 	.word	0x20000458
 8001424:	20000568 	.word	0x20000568
 8001428:	2000056c 	.word	0x2000056c

0800142c <vTaskSwitchContext>:
 800142c:	b480      	push	{r7}
 800142e:	b087      	sub	sp, #28
 8001430:	af00      	add	r7, sp, #0
 8001432:	4b26      	ldr	r3, [pc, #152]	; (80014cc <vTaskSwitchContext+0xa0>)
 8001434:	681b      	ldr	r3, [r3, #0]
 8001436:	2b00      	cmp	r3, #0
 8001438:	d003      	beq.n	8001442 <vTaskSwitchContext+0x16>
 800143a:	4b25      	ldr	r3, [pc, #148]	; (80014d0 <vTaskSwitchContext+0xa4>)
 800143c:	2201      	movs	r2, #1
 800143e:	601a      	str	r2, [r3, #0]
 8001440:	e03e      	b.n	80014c0 <vTaskSwitchContext+0x94>
 8001442:	4b23      	ldr	r3, [pc, #140]	; (80014d0 <vTaskSwitchContext+0xa4>)
 8001444:	2200      	movs	r2, #0
 8001446:	601a      	str	r2, [r3, #0]
 8001448:	4b22      	ldr	r3, [pc, #136]	; (80014d4 <vTaskSwitchContext+0xa8>)
 800144a:	681b      	ldr	r3, [r3, #0]
 800144c:	60fb      	str	r3, [r7, #12]
 800144e:	68fb      	ldr	r3, [r7, #12]
 8001450:	fab3 f383 	clz	r3, r3
 8001454:	72fb      	strb	r3, [r7, #11]
 8001456:	7afb      	ldrb	r3, [r7, #11]
 8001458:	f1c3 031f 	rsb	r3, r3, #31
 800145c:	617b      	str	r3, [r7, #20]
 800145e:	491e      	ldr	r1, [pc, #120]	; (80014d8 <vTaskSwitchContext+0xac>)
 8001460:	697a      	ldr	r2, [r7, #20]
 8001462:	4613      	mov	r3, r2
 8001464:	009b      	lsls	r3, r3, #2
 8001466:	4413      	add	r3, r2
 8001468:	009b      	lsls	r3, r3, #2
 800146a:	440b      	add	r3, r1
 800146c:	681b      	ldr	r3, [r3, #0]
 800146e:	2b00      	cmp	r3, #0
 8001470:	d109      	bne.n	8001486 <vTaskSwitchContext+0x5a>
 8001472:	f04f 0350 	mov.w	r3, #80	; 0x50
 8001476:	f383 8811 	msr	BASEPRI, r3
 800147a:	f3bf 8f6f 	isb	sy
 800147e:	f3bf 8f4f 	dsb	sy
 8001482:	607b      	str	r3, [r7, #4]
 8001484:	e7fe      	b.n	8001484 <vTaskSwitchContext+0x58>
 8001486:	697a      	ldr	r2, [r7, #20]
 8001488:	4613      	mov	r3, r2
 800148a:	009b      	lsls	r3, r3, #2
 800148c:	4413      	add	r3, r2
 800148e:	009b      	lsls	r3, r3, #2
 8001490:	4a11      	ldr	r2, [pc, #68]	; (80014d8 <vTaskSwitchContext+0xac>)
 8001492:	4413      	add	r3, r2
 8001494:	613b      	str	r3, [r7, #16]
 8001496:	693b      	ldr	r3, [r7, #16]
 8001498:	685b      	ldr	r3, [r3, #4]
 800149a:	685a      	ldr	r2, [r3, #4]
 800149c:	693b      	ldr	r3, [r7, #16]
 800149e:	605a      	str	r2, [r3, #4]
 80014a0:	693b      	ldr	r3, [r7, #16]
 80014a2:	685a      	ldr	r2, [r3, #4]
 80014a4:	693b      	ldr	r3, [r7, #16]
 80014a6:	3308      	adds	r3, #8
 80014a8:	429a      	cmp	r2, r3
 80014aa:	d104      	bne.n	80014b6 <vTaskSwitchContext+0x8a>
 80014ac:	693b      	ldr	r3, [r7, #16]
 80014ae:	685b      	ldr	r3, [r3, #4]
 80014b0:	685a      	ldr	r2, [r3, #4]
 80014b2:	693b      	ldr	r3, [r7, #16]
 80014b4:	605a      	str	r2, [r3, #4]
 80014b6:	693b      	ldr	r3, [r7, #16]
 80014b8:	685b      	ldr	r3, [r3, #4]
 80014ba:	68db      	ldr	r3, [r3, #12]
 80014bc:	4a07      	ldr	r2, [pc, #28]	; (80014dc <vTaskSwitchContext+0xb0>)
 80014be:	6013      	str	r3, [r2, #0]
 80014c0:	bf00      	nop
 80014c2:	371c      	adds	r7, #28
 80014c4:	46bd      	mov	sp, r7
 80014c6:	bc80      	pop	{r7}
 80014c8:	4770      	bx	lr
 80014ca:	bf00      	nop
 80014cc:	20000580 	.word	0x20000580
 80014d0:	2000056c 	.word	0x2000056c
 80014d4:	20000560 	.word	0x20000560
 80014d8:	2000045c 	.word	0x2000045c
 80014dc:	20000458 	.word	0x20000458

080014e0 <vTaskPlaceOnEventList>:
 80014e0:	b580      	push	{r7, lr}
 80014e2:	b084      	sub	sp, #16
 80014e4:	af00      	add	r7, sp, #0
 80014e6:	6078      	str	r0, [r7, #4]
 80014e8:	6039      	str	r1, [r7, #0]
 80014ea:	687b      	ldr	r3, [r7, #4]
 80014ec:	2b00      	cmp	r3, #0
 80014ee:	d109      	bne.n	8001504 <vTaskPlaceOnEventList+0x24>
 80014f0:	f04f 0350 	mov.w	r3, #80	; 0x50
 80014f4:	f383 8811 	msr	BASEPRI, r3
 80014f8:	f3bf 8f6f 	isb	sy
 80014fc:	f3bf 8f4f 	dsb	sy
 8001500:	60fb      	str	r3, [r7, #12]
 8001502:	e7fe      	b.n	8001502 <vTaskPlaceOnEventList+0x22>
 8001504:	4b07      	ldr	r3, [pc, #28]	; (8001524 <vTaskPlaceOnEventList+0x44>)
 8001506:	681b      	ldr	r3, [r3, #0]
 8001508:	3318      	adds	r3, #24
 800150a:	4619      	mov	r1, r3
 800150c:	6878      	ldr	r0, [r7, #4]
 800150e:	f7ff f95c 	bl	80007ca <vListInsert>
 8001512:	2101      	movs	r1, #1
 8001514:	6838      	ldr	r0, [r7, #0]
 8001516:	f000 fa65 	bl	80019e4 <prvAddCurrentTaskToDelayedList>
 800151a:	bf00      	nop
 800151c:	3710      	adds	r7, #16
 800151e:	46bd      	mov	sp, r7
 8001520:	bd80      	pop	{r7, pc}
 8001522:	bf00      	nop
 8001524:	20000458 	.word	0x20000458

08001528 <xTaskRemoveFromEventList>:
 8001528:	b580      	push	{r7, lr}
 800152a:	b086      	sub	sp, #24
 800152c:	af00      	add	r7, sp, #0
 800152e:	6078      	str	r0, [r7, #4]
 8001530:	687b      	ldr	r3, [r7, #4]
 8001532:	68db      	ldr	r3, [r3, #12]
 8001534:	68db      	ldr	r3, [r3, #12]
 8001536:	613b      	str	r3, [r7, #16]
 8001538:	693b      	ldr	r3, [r7, #16]
 800153a:	2b00      	cmp	r3, #0
 800153c:	d109      	bne.n	8001552 <xTaskRemoveFromEventList+0x2a>
 800153e:	f04f 0350 	mov.w	r3, #80	; 0x50
 8001542:	f383 8811 	msr	BASEPRI, r3
 8001546:	f3bf 8f6f 	isb	sy
 800154a:	f3bf 8f4f 	dsb	sy
 800154e:	60fb      	str	r3, [r7, #12]
 8001550:	e7fe      	b.n	8001550 <xTaskRemoveFromEventList+0x28>
 8001552:	693b      	ldr	r3, [r7, #16]
 8001554:	3318      	adds	r3, #24
 8001556:	4618      	mov	r0, r3
 8001558:	f7ff f96f 	bl	800083a <uxListRemove>
 800155c:	4b1d      	ldr	r3, [pc, #116]	; (80015d4 <xTaskRemoveFromEventList+0xac>)
 800155e:	681b      	ldr	r3, [r3, #0]
 8001560:	2b00      	cmp	r3, #0
 8001562:	d11c      	bne.n	800159e <xTaskRemoveFromEventList+0x76>
 8001564:	693b      	ldr	r3, [r7, #16]
 8001566:	3304      	adds	r3, #4
 8001568:	4618      	mov	r0, r3
 800156a:	f7ff f966 	bl	800083a <uxListRemove>
 800156e:	693b      	ldr	r3, [r7, #16]
 8001570:	6adb      	ldr	r3, [r3, #44]	; 0x2c
 8001572:	2201      	movs	r2, #1
 8001574:	409a      	lsls	r2, r3
 8001576:	4b18      	ldr	r3, [pc, #96]	; (80015d8 <xTaskRemoveFromEventList+0xb0>)
 8001578:	681b      	ldr	r3, [r3, #0]
 800157a:	4313      	orrs	r3, r2
 800157c:	4a16      	ldr	r2, [pc, #88]	; (80015d8 <xTaskRemoveFromEventList+0xb0>)
 800157e:	6013      	str	r3, [r2, #0]
 8001580:	693b      	ldr	r3, [r7, #16]
 8001582:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 8001584:	4613      	mov	r3, r2
 8001586:	009b      	lsls	r3, r3, #2
 8001588:	4413      	add	r3, r2
 800158a:	009b      	lsls	r3, r3, #2
 800158c:	4a13      	ldr	r2, [pc, #76]	; (80015dc <xTaskRemoveFromEventList+0xb4>)
 800158e:	441a      	add	r2, r3
 8001590:	693b      	ldr	r3, [r7, #16]
 8001592:	3304      	adds	r3, #4
 8001594:	4619      	mov	r1, r3
 8001596:	4610      	mov	r0, r2
 8001598:	f7ff f8f4 	bl	8000784 <vListInsertEnd>
 800159c:	e005      	b.n	80015aa <xTaskRemoveFromEventList+0x82>
 800159e:	693b      	ldr	r3, [r7, #16]
 80015a0:	3318      	adds	r3, #24
 80015a2:	4619      	mov	r1, r3
 80015a4:	480e      	ldr	r0, [pc, #56]	; (80015e0 <xTaskRemoveFromEventList+0xb8>)
 80015a6:	f7ff f8ed 	bl	8000784 <vListInsertEnd>
 80015aa:	693b      	ldr	r3, [r7, #16]
 80015ac:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 80015ae:	4b0d      	ldr	r3, [pc, #52]	; (80015e4 <xTaskRemoveFromEventList+0xbc>)
 80015b0:	681b      	ldr	r3, [r3, #0]
 80015b2:	6adb      	ldr	r3, [r3, #44]	; 0x2c
 80015b4:	429a      	cmp	r2, r3
 80015b6:	d905      	bls.n	80015c4 <xTaskRemoveFromEventList+0x9c>
 80015b8:	2301      	movs	r3, #1
 80015ba:	617b      	str	r3, [r7, #20]
 80015bc:	4b0a      	ldr	r3, [pc, #40]	; (80015e8 <xTaskRemoveFromEventList+0xc0>)
 80015be:	2201      	movs	r2, #1
 80015c0:	601a      	str	r2, [r3, #0]
 80015c2:	e001      	b.n	80015c8 <xTaskRemoveFromEventList+0xa0>
 80015c4:	2300      	movs	r3, #0
 80015c6:	617b      	str	r3, [r7, #20]
 80015c8:	697b      	ldr	r3, [r7, #20]
 80015ca:	4618      	mov	r0, r3
 80015cc:	3718      	adds	r7, #24
 80015ce:	46bd      	mov	sp, r7
 80015d0:	bd80      	pop	{r7, pc}
 80015d2:	bf00      	nop
 80015d4:	20000580 	.word	0x20000580
 80015d8:	20000560 	.word	0x20000560
 80015dc:	2000045c 	.word	0x2000045c
 80015e0:	20000518 	.word	0x20000518
 80015e4:	20000458 	.word	0x20000458
 80015e8:	2000056c 	.word	0x2000056c

080015ec <vTaskSetTimeOutState>:
 80015ec:	b480      	push	{r7}
 80015ee:	b085      	sub	sp, #20
 80015f0:	af00      	add	r7, sp, #0
 80015f2:	6078      	str	r0, [r7, #4]
 80015f4:	687b      	ldr	r3, [r7, #4]
 80015f6:	2b00      	cmp	r3, #0
 80015f8:	d109      	bne.n	800160e <vTaskSetTimeOutState+0x22>
 80015fa:	f04f 0350 	mov.w	r3, #80	; 0x50
 80015fe:	f383 8811 	msr	BASEPRI, r3
 8001602:	f3bf 8f6f 	isb	sy
 8001606:	f3bf 8f4f 	dsb	sy
 800160a:	60fb      	str	r3, [r7, #12]
 800160c:	e7fe      	b.n	800160c <vTaskSetTimeOutState+0x20>
 800160e:	4b06      	ldr	r3, [pc, #24]	; (8001628 <vTaskSetTimeOutState+0x3c>)
 8001610:	681a      	ldr	r2, [r3, #0]
 8001612:	687b      	ldr	r3, [r7, #4]
 8001614:	601a      	str	r2, [r3, #0]
 8001616:	4b05      	ldr	r3, [pc, #20]	; (800162c <vTaskSetTimeOutState+0x40>)
 8001618:	681a      	ldr	r2, [r3, #0]
 800161a:	687b      	ldr	r3, [r7, #4]
 800161c:	605a      	str	r2, [r3, #4]
 800161e:	bf00      	nop
 8001620:	3714      	adds	r7, #20
 8001622:	46bd      	mov	sp, r7
 8001624:	bc80      	pop	{r7}
 8001626:	4770      	bx	lr
 8001628:	20000570 	.word	0x20000570
 800162c:	2000055c 	.word	0x2000055c

08001630 <xTaskCheckForTimeOut>:
 8001630:	b580      	push	{r7, lr}
 8001632:	b086      	sub	sp, #24
 8001634:	af00      	add	r7, sp, #0
 8001636:	6078      	str	r0, [r7, #4]
 8001638:	6039      	str	r1, [r7, #0]
 800163a:	687b      	ldr	r3, [r7, #4]
 800163c:	2b00      	cmp	r3, #0
 800163e:	d109      	bne.n	8001654 <xTaskCheckForTimeOut+0x24>
 8001640:	f04f 0350 	mov.w	r3, #80	; 0x50
 8001644:	f383 8811 	msr	BASEPRI, r3
 8001648:	f3bf 8f6f 	isb	sy
 800164c:	f3bf 8f4f 	dsb	sy
 8001650:	60fb      	str	r3, [r7, #12]
 8001652:	e7fe      	b.n	8001652 <xTaskCheckForTimeOut+0x22>
 8001654:	683b      	ldr	r3, [r7, #0]
 8001656:	2b00      	cmp	r3, #0
 8001658:	d109      	bne.n	800166e <xTaskCheckForTimeOut+0x3e>
 800165a:	f04f 0350 	mov.w	r3, #80	; 0x50
 800165e:	f383 8811 	msr	BASEPRI, r3
 8001662:	f3bf 8f6f 	isb	sy
 8001666:	f3bf 8f4f 	dsb	sy
 800166a:	60bb      	str	r3, [r7, #8]
 800166c:	e7fe      	b.n	800166c <xTaskCheckForTimeOut+0x3c>
 800166e:	f000 faf1 	bl	8001c54 <vPortEnterCritical>
 8001672:	4b1c      	ldr	r3, [pc, #112]	; (80016e4 <xTaskCheckForTimeOut+0xb4>)
 8001674:	681b      	ldr	r3, [r3, #0]
 8001676:	613b      	str	r3, [r7, #16]
 8001678:	683b      	ldr	r3, [r7, #0]
 800167a:	681b      	ldr	r3, [r3, #0]
 800167c:	f1b3 3fff 	cmp.w	r3, #4294967295	; 0xffffffff
 8001680:	d102      	bne.n	8001688 <xTaskCheckForTimeOut+0x58>
 8001682:	2300      	movs	r3, #0
 8001684:	617b      	str	r3, [r7, #20]
 8001686:	e026      	b.n	80016d6 <xTaskCheckForTimeOut+0xa6>
 8001688:	687b      	ldr	r3, [r7, #4]
 800168a:	681a      	ldr	r2, [r3, #0]
 800168c:	4b16      	ldr	r3, [pc, #88]	; (80016e8 <xTaskCheckForTimeOut+0xb8>)
 800168e:	681b      	ldr	r3, [r3, #0]
 8001690:	429a      	cmp	r2, r3
 8001692:	d007      	beq.n	80016a4 <xTaskCheckForTimeOut+0x74>
 8001694:	687b      	ldr	r3, [r7, #4]
 8001696:	685b      	ldr	r3, [r3, #4]
 8001698:	693a      	ldr	r2, [r7, #16]
 800169a:	429a      	cmp	r2, r3
 800169c:	d302      	bcc.n	80016a4 <xTaskCheckForTimeOut+0x74>
 800169e:	2301      	movs	r3, #1
 80016a0:	617b      	str	r3, [r7, #20]
 80016a2:	e018      	b.n	80016d6 <xTaskCheckForTimeOut+0xa6>
 80016a4:	687b      	ldr	r3, [r7, #4]
 80016a6:	685b      	ldr	r3, [r3, #4]
 80016a8:	693a      	ldr	r2, [r7, #16]
 80016aa:	1ad2      	subs	r2, r2, r3
 80016ac:	683b      	ldr	r3, [r7, #0]
 80016ae:	681b      	ldr	r3, [r3, #0]
 80016b0:	429a      	cmp	r2, r3
 80016b2:	d20e      	bcs.n	80016d2 <xTaskCheckForTimeOut+0xa2>
 80016b4:	683b      	ldr	r3, [r7, #0]
 80016b6:	681a      	ldr	r2, [r3, #0]
 80016b8:	687b      	ldr	r3, [r7, #4]
 80016ba:	6859      	ldr	r1, [r3, #4]
 80016bc:	693b      	ldr	r3, [r7, #16]
 80016be:	1acb      	subs	r3, r1, r3
 80016c0:	441a      	add	r2, r3
 80016c2:	683b      	ldr	r3, [r7, #0]
 80016c4:	601a      	str	r2, [r3, #0]
 80016c6:	6878      	ldr	r0, [r7, #4]
 80016c8:	f7ff ff90 	bl	80015ec <vTaskSetTimeOutState>
 80016cc:	2300      	movs	r3, #0
 80016ce:	617b      	str	r3, [r7, #20]
 80016d0:	e001      	b.n	80016d6 <xTaskCheckForTimeOut+0xa6>
 80016d2:	2301      	movs	r3, #1
 80016d4:	617b      	str	r3, [r7, #20]
 80016d6:	f000 faeb 	bl	8001cb0 <vPortExitCritical>
 80016da:	697b      	ldr	r3, [r7, #20]
 80016dc:	4618      	mov	r0, r3
 80016de:	3718      	adds	r7, #24
 80016e0:	46bd      	mov	sp, r7
 80016e2:	bd80      	pop	{r7, pc}
 80016e4:	2000055c 	.word	0x2000055c
 80016e8:	20000570 	.word	0x20000570

080016ec <vTaskMissedYield>:
 80016ec:	b480      	push	{r7}
 80016ee:	af00      	add	r7, sp, #0
 80016f0:	4b03      	ldr	r3, [pc, #12]	; (8001700 <vTaskMissedYield+0x14>)
 80016f2:	2201      	movs	r2, #1
 80016f4:	601a      	str	r2, [r3, #0]
 80016f6:	bf00      	nop
 80016f8:	46bd      	mov	sp, r7
 80016fa:	bc80      	pop	{r7}
 80016fc:	4770      	bx	lr
 80016fe:	bf00      	nop
 8001700:	2000056c 	.word	0x2000056c

08001704 <prvIdleTask>:
 8001704:	b580      	push	{r7, lr}
 8001706:	b082      	sub	sp, #8
 8001708:	af00      	add	r7, sp, #0
 800170a:	6078      	str	r0, [r7, #4]
 800170c:	f000 f852 	bl	80017b4 <prvCheckTasksWaitingTermination>
 8001710:	4b06      	ldr	r3, [pc, #24]	; (800172c <prvIdleTask+0x28>)
 8001712:	681b      	ldr	r3, [r3, #0]
 8001714:	2b01      	cmp	r3, #1
 8001716:	d9f9      	bls.n	800170c <prvIdleTask+0x8>
 8001718:	4b05      	ldr	r3, [pc, #20]	; (8001730 <prvIdleTask+0x2c>)
 800171a:	f04f 5280 	mov.w	r2, #268435456	; 0x10000000
 800171e:	601a      	str	r2, [r3, #0]
 8001720:	f3bf 8f4f 	dsb	sy
 8001724:	f3bf 8f6f 	isb	sy
 8001728:	e7f0      	b.n	800170c <prvIdleTask+0x8>
 800172a:	bf00      	nop
 800172c:	2000045c 	.word	0x2000045c
 8001730:	e000ed04 	.word	0xe000ed04

08001734 <prvInitialiseTaskLists>:
 8001734:	b580      	push	{r7, lr}
 8001736:	b082      	sub	sp, #8
 8001738:	af00      	add	r7, sp, #0
 800173a:	2300      	movs	r3, #0
 800173c:	607b      	str	r3, [r7, #4]
 800173e:	e00c      	b.n	800175a <prvInitialiseTaskLists+0x26>
 8001740:	687a      	ldr	r2, [r7, #4]
 8001742:	4613      	mov	r3, r2
 8001744:	009b      	lsls	r3, r3, #2
 8001746:	4413      	add	r3, r2
 8001748:	009b      	lsls	r3, r3, #2
 800174a:	4a12      	ldr	r2, [pc, #72]	; (8001794 <prvInitialiseTaskLists+0x60>)
 800174c:	4413      	add	r3, r2
 800174e:	4618      	mov	r0, r3
 8001750:	f7fe ffed 	bl	800072e <vListInitialise>
 8001754:	687b      	ldr	r3, [r7, #4]
 8001756:	3301      	adds	r3, #1
 8001758:	607b      	str	r3, [r7, #4]
 800175a:	687b      	ldr	r3, [r7, #4]
 800175c:	2b06      	cmp	r3, #6
 800175e:	d9ef      	bls.n	8001740 <prvInitialiseTaskLists+0xc>
 8001760:	480d      	ldr	r0, [pc, #52]	; (8001798 <prvInitialiseTaskLists+0x64>)
 8001762:	f7fe ffe4 	bl	800072e <vListInitialise>
 8001766:	480d      	ldr	r0, [pc, #52]	; (800179c <prvInitialiseTaskLists+0x68>)
 8001768:	f7fe ffe1 	bl	800072e <vListInitialise>
 800176c:	480c      	ldr	r0, [pc, #48]	; (80017a0 <prvInitialiseTaskLists+0x6c>)
 800176e:	f7fe ffde 	bl	800072e <vListInitialise>
 8001772:	480c      	ldr	r0, [pc, #48]	; (80017a4 <prvInitialiseTaskLists+0x70>)
 8001774:	f7fe ffdb 	bl	800072e <vListInitialise>
 8001778:	480b      	ldr	r0, [pc, #44]	; (80017a8 <prvInitialiseTaskLists+0x74>)
 800177a:	f7fe ffd8 	bl	800072e <vListInitialise>
 800177e:	4b0b      	ldr	r3, [pc, #44]	; (80017ac <prvInitialiseTaskLists+0x78>)
 8001780:	4a05      	ldr	r2, [pc, #20]	; (8001798 <prvInitialiseTaskLists+0x64>)
 8001782:	601a      	str	r2, [r3, #0]
 8001784:	4b0a      	ldr	r3, [pc, #40]	; (80017b0 <prvInitialiseTaskLists+0x7c>)
 8001786:	4a05      	ldr	r2, [pc, #20]	; (800179c <prvInitialiseTaskLists+0x68>)
 8001788:	601a      	str	r2, [r3, #0]
 800178a:	bf00      	nop
 800178c:	3708      	adds	r7, #8
 800178e:	46bd      	mov	sp, r7
 8001790:	bd80      	pop	{r7, pc}
 8001792:	bf00      	nop
 8001794:	2000045c 	.word	0x2000045c
 8001798:	200004e8 	.word	0x200004e8
 800179c:	200004fc 	.word	0x200004fc
 80017a0:	20000518 	.word	0x20000518
 80017a4:	2000052c 	.word	0x2000052c
 80017a8:	20000544 	.word	0x20000544
 80017ac:	20000510 	.word	0x20000510
 80017b0:	20000514 	.word	0x20000514

080017b4 <prvCheckTasksWaitingTermination>:
 80017b4:	b580      	push	{r7, lr}
 80017b6:	b082      	sub	sp, #8
 80017b8:	af00      	add	r7, sp, #0
 80017ba:	e028      	b.n	800180e <prvCheckTasksWaitingTermination+0x5a>
 80017bc:	f7ff fcd0 	bl	8001160 <vTaskSuspendAll>
 80017c0:	4b17      	ldr	r3, [pc, #92]	; (8001820 <prvCheckTasksWaitingTermination+0x6c>)
 80017c2:	681b      	ldr	r3, [r3, #0]
 80017c4:	2b00      	cmp	r3, #0
 80017c6:	bf0c      	ite	eq
 80017c8:	2301      	moveq	r3, #1
 80017ca:	2300      	movne	r3, #0
 80017cc:	b2db      	uxtb	r3, r3
 80017ce:	607b      	str	r3, [r7, #4]
 80017d0:	f7ff fcd4 	bl	800117c <xTaskResumeAll>
 80017d4:	687b      	ldr	r3, [r7, #4]
 80017d6:	2b00      	cmp	r3, #0
 80017d8:	d119      	bne.n	800180e <prvCheckTasksWaitingTermination+0x5a>
 80017da:	f000 fa3b 	bl	8001c54 <vPortEnterCritical>
 80017de:	4b10      	ldr	r3, [pc, #64]	; (8001820 <prvCheckTasksWaitingTermination+0x6c>)
 80017e0:	68db      	ldr	r3, [r3, #12]
 80017e2:	68db      	ldr	r3, [r3, #12]
 80017e4:	603b      	str	r3, [r7, #0]
 80017e6:	683b      	ldr	r3, [r7, #0]
 80017e8:	3304      	adds	r3, #4
 80017ea:	4618      	mov	r0, r3
 80017ec:	f7ff f825 	bl	800083a <uxListRemove>
 80017f0:	4b0c      	ldr	r3, [pc, #48]	; (8001824 <prvCheckTasksWaitingTermination+0x70>)
 80017f2:	681b      	ldr	r3, [r3, #0]
 80017f4:	3b01      	subs	r3, #1
 80017f6:	4a0b      	ldr	r2, [pc, #44]	; (8001824 <prvCheckTasksWaitingTermination+0x70>)
 80017f8:	6013      	str	r3, [r2, #0]
 80017fa:	4b0b      	ldr	r3, [pc, #44]	; (8001828 <prvCheckTasksWaitingTermination+0x74>)
 80017fc:	681b      	ldr	r3, [r3, #0]
 80017fe:	3b01      	subs	r3, #1
 8001800:	4a09      	ldr	r2, [pc, #36]	; (8001828 <prvCheckTasksWaitingTermination+0x74>)
 8001802:	6013      	str	r3, [r2, #0]
 8001804:	f000 fa54 	bl	8001cb0 <vPortExitCritical>
 8001808:	6838      	ldr	r0, [r7, #0]
 800180a:	f000 f80f 	bl	800182c <prvDeleteTCB>
 800180e:	4b06      	ldr	r3, [pc, #24]	; (8001828 <prvCheckTasksWaitingTermination+0x74>)
 8001810:	681b      	ldr	r3, [r3, #0]
 8001812:	2b00      	cmp	r3, #0
 8001814:	d1d2      	bne.n	80017bc <prvCheckTasksWaitingTermination+0x8>
 8001816:	bf00      	nop
 8001818:	3708      	adds	r7, #8
 800181a:	46bd      	mov	sp, r7
 800181c:	bd80      	pop	{r7, pc}
 800181e:	bf00      	nop
 8001820:	2000052c 	.word	0x2000052c
 8001824:	20000558 	.word	0x20000558
 8001828:	20000540 	.word	0x20000540

0800182c <prvDeleteTCB>:
 800182c:	b580      	push	{r7, lr}
 800182e:	b082      	sub	sp, #8
 8001830:	af00      	add	r7, sp, #0
 8001832:	6078      	str	r0, [r7, #4]
 8001834:	687b      	ldr	r3, [r7, #4]
 8001836:	6b1b      	ldr	r3, [r3, #48]	; 0x30
 8001838:	4618      	mov	r0, r3
 800183a:	f000 fbbd 	bl	8001fb8 <vPortFree>
 800183e:	6878      	ldr	r0, [r7, #4]
 8001840:	f000 fbba 	bl	8001fb8 <vPortFree>
 8001844:	bf00      	nop
 8001846:	3708      	adds	r7, #8
 8001848:	46bd      	mov	sp, r7
 800184a:	bd80      	pop	{r7, pc}

0800184c <prvResetNextTaskUnblockTime>:
 800184c:	b480      	push	{r7}
 800184e:	b083      	sub	sp, #12
 8001850:	af00      	add	r7, sp, #0
 8001852:	4b0e      	ldr	r3, [pc, #56]	; (800188c <prvResetNextTaskUnblockTime+0x40>)
 8001854:	681b      	ldr	r3, [r3, #0]
 8001856:	681b      	ldr	r3, [r3, #0]
 8001858:	2b00      	cmp	r3, #0
 800185a:	d101      	bne.n	8001860 <prvResetNextTaskUnblockTime+0x14>
 800185c:	2301      	movs	r3, #1
 800185e:	e000      	b.n	8001862 <prvResetNextTaskUnblockTime+0x16>
 8001860:	2300      	movs	r3, #0
 8001862:	2b00      	cmp	r3, #0
 8001864:	d004      	beq.n	8001870 <prvResetNextTaskUnblockTime+0x24>
 8001866:	4b0a      	ldr	r3, [pc, #40]	; (8001890 <prvResetNextTaskUnblockTime+0x44>)
 8001868:	f04f 32ff 	mov.w	r2, #4294967295	; 0xffffffff
 800186c:	601a      	str	r2, [r3, #0]
 800186e:	e008      	b.n	8001882 <prvResetNextTaskUnblockTime+0x36>
 8001870:	4b06      	ldr	r3, [pc, #24]	; (800188c <prvResetNextTaskUnblockTime+0x40>)
 8001872:	681b      	ldr	r3, [r3, #0]
 8001874:	68db      	ldr	r3, [r3, #12]
 8001876:	68db      	ldr	r3, [r3, #12]
 8001878:	607b      	str	r3, [r7, #4]
 800187a:	687b      	ldr	r3, [r7, #4]
 800187c:	685b      	ldr	r3, [r3, #4]
 800187e:	4a04      	ldr	r2, [pc, #16]	; (8001890 <prvResetNextTaskUnblockTime+0x44>)
 8001880:	6013      	str	r3, [r2, #0]
 8001882:	bf00      	nop
 8001884:	370c      	adds	r7, #12
 8001886:	46bd      	mov	sp, r7
 8001888:	bc80      	pop	{r7}
 800188a:	4770      	bx	lr
 800188c:	20000510 	.word	0x20000510
 8001890:	20000578 	.word	0x20000578

08001894 <xTaskGetSchedulerState>:
 8001894:	b480      	push	{r7}
 8001896:	b083      	sub	sp, #12
 8001898:	af00      	add	r7, sp, #0
 800189a:	4b0b      	ldr	r3, [pc, #44]	; (80018c8 <xTaskGetSchedulerState+0x34>)
 800189c:	681b      	ldr	r3, [r3, #0]
 800189e:	2b00      	cmp	r3, #0
 80018a0:	d102      	bne.n	80018a8 <xTaskGetSchedulerState+0x14>
 80018a2:	2301      	movs	r3, #1
 80018a4:	607b      	str	r3, [r7, #4]
 80018a6:	e008      	b.n	80018ba <xTaskGetSchedulerState+0x26>
 80018a8:	4b08      	ldr	r3, [pc, #32]	; (80018cc <xTaskGetSchedulerState+0x38>)
 80018aa:	681b      	ldr	r3, [r3, #0]
 80018ac:	2b00      	cmp	r3, #0
 80018ae:	d102      	bne.n	80018b6 <xTaskGetSchedulerState+0x22>
 80018b0:	2302      	movs	r3, #2
 80018b2:	607b      	str	r3, [r7, #4]
 80018b4:	e001      	b.n	80018ba <xTaskGetSchedulerState+0x26>
 80018b6:	2300      	movs	r3, #0
 80018b8:	607b      	str	r3, [r7, #4]
 80018ba:	687b      	ldr	r3, [r7, #4]
 80018bc:	4618      	mov	r0, r3
 80018be:	370c      	adds	r7, #12
 80018c0:	46bd      	mov	sp, r7
 80018c2:	bc80      	pop	{r7}
 80018c4:	4770      	bx	lr
 80018c6:	bf00      	nop
 80018c8:	20000564 	.word	0x20000564
 80018cc:	20000580 	.word	0x20000580

080018d0 <vTaskPriorityInherit>:
 80018d0:	b580      	push	{r7, lr}
 80018d2:	b084      	sub	sp, #16
 80018d4:	af00      	add	r7, sp, #0
 80018d6:	6078      	str	r0, [r7, #4]
 80018d8:	687b      	ldr	r3, [r7, #4]
 80018da:	60fb      	str	r3, [r7, #12]
 80018dc:	687b      	ldr	r3, [r7, #4]
 80018de:	2b00      	cmp	r3, #0
 80018e0:	d062      	beq.n	80019a8 <vTaskPriorityInherit+0xd8>
 80018e2:	68fb      	ldr	r3, [r7, #12]
 80018e4:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 80018e6:	4b32      	ldr	r3, [pc, #200]	; (80019b0 <vTaskPriorityInherit+0xe0>)
 80018e8:	681b      	ldr	r3, [r3, #0]
 80018ea:	6adb      	ldr	r3, [r3, #44]	; 0x2c
 80018ec:	429a      	cmp	r2, r3
 80018ee:	d25b      	bcs.n	80019a8 <vTaskPriorityInherit+0xd8>
 80018f0:	68fb      	ldr	r3, [r7, #12]
 80018f2:	699b      	ldr	r3, [r3, #24]
 80018f4:	2b00      	cmp	r3, #0
 80018f6:	db06      	blt.n	8001906 <vTaskPriorityInherit+0x36>
 80018f8:	4b2d      	ldr	r3, [pc, #180]	; (80019b0 <vTaskPriorityInherit+0xe0>)
 80018fa:	681b      	ldr	r3, [r3, #0]
 80018fc:	6adb      	ldr	r3, [r3, #44]	; 0x2c
 80018fe:	f1c3 0207 	rsb	r2, r3, #7
 8001902:	68fb      	ldr	r3, [r7, #12]
 8001904:	619a      	str	r2, [r3, #24]
 8001906:	68fb      	ldr	r3, [r7, #12]
 8001908:	6959      	ldr	r1, [r3, #20]
 800190a:	68fb      	ldr	r3, [r7, #12]
 800190c:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 800190e:	4613      	mov	r3, r2
 8001910:	009b      	lsls	r3, r3, #2
 8001912:	4413      	add	r3, r2
 8001914:	009b      	lsls	r3, r3, #2
 8001916:	4a27      	ldr	r2, [pc, #156]	; (80019b4 <vTaskPriorityInherit+0xe4>)
 8001918:	4413      	add	r3, r2
 800191a:	4299      	cmp	r1, r3
 800191c:	d101      	bne.n	8001922 <vTaskPriorityInherit+0x52>
 800191e:	2301      	movs	r3, #1
 8001920:	e000      	b.n	8001924 <vTaskPriorityInherit+0x54>
 8001922:	2300      	movs	r3, #0
 8001924:	2b00      	cmp	r3, #0
 8001926:	d03a      	beq.n	800199e <vTaskPriorityInherit+0xce>
 8001928:	68fb      	ldr	r3, [r7, #12]
 800192a:	3304      	adds	r3, #4
 800192c:	4618      	mov	r0, r3
 800192e:	f7fe ff84 	bl	800083a <uxListRemove>
 8001932:	4603      	mov	r3, r0
 8001934:	2b00      	cmp	r3, #0
 8001936:	d115      	bne.n	8001964 <vTaskPriorityInherit+0x94>
 8001938:	68fb      	ldr	r3, [r7, #12]
 800193a:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 800193c:	491d      	ldr	r1, [pc, #116]	; (80019b4 <vTaskPriorityInherit+0xe4>)
 800193e:	4613      	mov	r3, r2
 8001940:	009b      	lsls	r3, r3, #2
 8001942:	4413      	add	r3, r2
 8001944:	009b      	lsls	r3, r3, #2
 8001946:	440b      	add	r3, r1
 8001948:	681b      	ldr	r3, [r3, #0]
 800194a:	2b00      	cmp	r3, #0
 800194c:	d10a      	bne.n	8001964 <vTaskPriorityInherit+0x94>
 800194e:	68fb      	ldr	r3, [r7, #12]
 8001950:	6adb      	ldr	r3, [r3, #44]	; 0x2c
 8001952:	2201      	movs	r2, #1
 8001954:	fa02 f303 	lsl.w	r3, r2, r3
 8001958:	43da      	mvns	r2, r3
 800195a:	4b17      	ldr	r3, [pc, #92]	; (80019b8 <vTaskPriorityInherit+0xe8>)
 800195c:	681b      	ldr	r3, [r3, #0]
 800195e:	4013      	ands	r3, r2
 8001960:	4a15      	ldr	r2, [pc, #84]	; (80019b8 <vTaskPriorityInherit+0xe8>)
 8001962:	6013      	str	r3, [r2, #0]
 8001964:	4b12      	ldr	r3, [pc, #72]	; (80019b0 <vTaskPriorityInherit+0xe0>)
 8001966:	681b      	ldr	r3, [r3, #0]
 8001968:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 800196a:	68fb      	ldr	r3, [r7, #12]
 800196c:	62da      	str	r2, [r3, #44]	; 0x2c
 800196e:	68fb      	ldr	r3, [r7, #12]
 8001970:	6adb      	ldr	r3, [r3, #44]	; 0x2c
 8001972:	2201      	movs	r2, #1
 8001974:	409a      	lsls	r2, r3
 8001976:	4b10      	ldr	r3, [pc, #64]	; (80019b8 <vTaskPriorityInherit+0xe8>)
 8001978:	681b      	ldr	r3, [r3, #0]
 800197a:	4313      	orrs	r3, r2
 800197c:	4a0e      	ldr	r2, [pc, #56]	; (80019b8 <vTaskPriorityInherit+0xe8>)
 800197e:	6013      	str	r3, [r2, #0]
 8001980:	68fb      	ldr	r3, [r7, #12]
 8001982:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 8001984:	4613      	mov	r3, r2
 8001986:	009b      	lsls	r3, r3, #2
 8001988:	4413      	add	r3, r2
 800198a:	009b      	lsls	r3, r3, #2
 800198c:	4a09      	ldr	r2, [pc, #36]	; (80019b4 <vTaskPriorityInherit+0xe4>)
 800198e:	441a      	add	r2, r3
 8001990:	68fb      	ldr	r3, [r7, #12]
 8001992:	3304      	adds	r3, #4
 8001994:	4619      	mov	r1, r3
 8001996:	4610      	mov	r0, r2
 8001998:	f7fe fef4 	bl	8000784 <vListInsertEnd>
 800199c:	e004      	b.n	80019a8 <vTaskPriorityInherit+0xd8>
 800199e:	4b04      	ldr	r3, [pc, #16]	; (80019b0 <vTaskPriorityInherit+0xe0>)
 80019a0:	681b      	ldr	r3, [r3, #0]
 80019a2:	6ada      	ldr	r2, [r3, #44]	; 0x2c
 80019a4:	68fb      	ldr	r3, [r7, #12]
 80019a6:	62da      	str	r2, [r3, #44]	; 0x2c
 80019a8:	bf00      	nop
 80019aa:	3710      	adds	r7, #16
 80019ac:	46bd      	mov	sp, r7
 80019ae:	bd80      	pop	{r7, pc}
 80019b0:	20000458 	.word	0x20000458
 80019b4:	2000045c 	.word	0x2000045c
 80019b8:	20000560 	.word	0x20000560

080019bc <pvTaskIncrementMutexHeldCount>:
 80019bc:	b480      	push	{r7}
 80019be:	af00      	add	r7, sp, #0
 80019c0:	4b07      	ldr	r3, [pc, #28]	; (80019e0 <pvTaskIncrementMutexHeldCount+0x24>)
 80019c2:	681b      	ldr	r3, [r3, #0]
 80019c4:	2b00      	cmp	r3, #0
 80019c6:	d004      	beq.n	80019d2 <pvTaskIncrementMutexHeldCount+0x16>
 80019c8:	4b05      	ldr	r3, [pc, #20]	; (80019e0 <pvTaskIncrementMutexHeldCount+0x24>)
 80019ca:	681b      	ldr	r3, [r3, #0]
 80019cc:	6d1a      	ldr	r2, [r3, #80]	; 0x50
 80019ce:	3201      	adds	r2, #1
 80019d0:	651a      	str	r2, [r3, #80]	; 0x50
 80019d2:	4b03      	ldr	r3, [pc, #12]	; (80019e0 <pvTaskIncrementMutexHeldCount+0x24>)
 80019d4:	681b      	ldr	r3, [r3, #0]
 80019d6:	4618      	mov	r0, r3
 80019d8:	46bd      	mov	sp, r7
 80019da:	bc80      	pop	{r7}
 80019dc:	4770      	bx	lr
 80019de:	bf00      	nop
 80019e0:	20000458 	.word	0x20000458

080019e4 <prvAddCurrentTaskToDelayedList>:
 80019e4:	b580      	push	{r7, lr}
 80019e6:	b084      	sub	sp, #16
 80019e8:	af00      	add	r7, sp, #0
 80019ea:	6078      	str	r0, [r7, #4]
 80019ec:	6039      	str	r1, [r7, #0]
 80019ee:	4b29      	ldr	r3, [pc, #164]	; (8001a94 <prvAddCurrentTaskToDelayedList+0xb0>)
 80019f0:	681b      	ldr	r3, [r3, #0]
 80019f2:	60fb      	str	r3, [r7, #12]
 80019f4:	4b28      	ldr	r3, [pc, #160]	; (8001a98 <prvAddCurrentTaskToDelayedList+0xb4>)
 80019f6:	681b      	ldr	r3, [r3, #0]
 80019f8:	3304      	adds	r3, #4
 80019fa:	4618      	mov	r0, r3
 80019fc:	f7fe ff1d 	bl	800083a <uxListRemove>
 8001a00:	4603      	mov	r3, r0
 8001a02:	2b00      	cmp	r3, #0
 8001a04:	d10b      	bne.n	8001a1e <prvAddCurrentTaskToDelayedList+0x3a>
 8001a06:	4b24      	ldr	r3, [pc, #144]	; (8001a98 <prvAddCurrentTaskToDelayedList+0xb4>)
 8001a08:	681b      	ldr	r3, [r3, #0]
 8001a0a:	6adb      	ldr	r3, [r3, #44]	; 0x2c
 8001a0c:	2201      	movs	r2, #1
 8001a0e:	fa02 f303 	lsl.w	r3, r2, r3
 8001a12:	43da      	mvns	r2, r3
 8001a14:	4b21      	ldr	r3, [pc, #132]	; (8001a9c <prvAddCurrentTaskToDelayedList+0xb8>)
 8001a16:	681b      	ldr	r3, [r3, #0]
 8001a18:	4013      	ands	r3, r2
 8001a1a:	4a20      	ldr	r2, [pc, #128]	; (8001a9c <prvAddCurrentTaskToDelayedList+0xb8>)
 8001a1c:	6013      	str	r3, [r2, #0]
 8001a1e:	687b      	ldr	r3, [r7, #4]
 8001a20:	f1b3 3fff 	cmp.w	r3, #4294967295	; 0xffffffff
 8001a24:	d10a      	bne.n	8001a3c <prvAddCurrentTaskToDelayedList+0x58>
 8001a26:	683b      	ldr	r3, [r7, #0]
 8001a28:	2b00      	cmp	r3, #0
 8001a2a:	d007      	beq.n	8001a3c <prvAddCurrentTaskToDelayedList+0x58>
 8001a2c:	4b1a      	ldr	r3, [pc, #104]	; (8001a98 <prvAddCurrentTaskToDelayedList+0xb4>)
 8001a2e:	681b      	ldr	r3, [r3, #0]
 8001a30:	3304      	adds	r3, #4
 8001a32:	4619      	mov	r1, r3
 8001a34:	481a      	ldr	r0, [pc, #104]	; (8001aa0 <prvAddCurrentTaskToDelayedList+0xbc>)
 8001a36:	f7fe fea5 	bl	8000784 <vListInsertEnd>
 8001a3a:	e026      	b.n	8001a8a <prvAddCurrentTaskToDelayedList+0xa6>
 8001a3c:	68fa      	ldr	r2, [r7, #12]
 8001a3e:	687b      	ldr	r3, [r7, #4]
 8001a40:	4413      	add	r3, r2
 8001a42:	60bb      	str	r3, [r7, #8]
 8001a44:	4b14      	ldr	r3, [pc, #80]	; (8001a98 <prvAddCurrentTaskToDelayedList+0xb4>)
 8001a46:	681b      	ldr	r3, [r3, #0]
 8001a48:	68ba      	ldr	r2, [r7, #8]
 8001a4a:	605a      	str	r2, [r3, #4]
 8001a4c:	68ba      	ldr	r2, [r7, #8]
 8001a4e:	68fb      	ldr	r3, [r7, #12]
 8001a50:	429a      	cmp	r2, r3
 8001a52:	d209      	bcs.n	8001a68 <prvAddCurrentTaskToDelayedList+0x84>
 8001a54:	4b13      	ldr	r3, [pc, #76]	; (8001aa4 <prvAddCurrentTaskToDelayedList+0xc0>)
 8001a56:	681a      	ldr	r2, [r3, #0]
 8001a58:	4b0f      	ldr	r3, [pc, #60]	; (8001a98 <prvAddCurrentTaskToDelayedList+0xb4>)
 8001a5a:	681b      	ldr	r3, [r3, #0]
 8001a5c:	3304      	adds	r3, #4
 8001a5e:	4619      	mov	r1, r3
 8001a60:	4610      	mov	r0, r2
 8001a62:	f7fe feb2 	bl	80007ca <vListInsert>
 8001a66:	e010      	b.n	8001a8a <prvAddCurrentTaskToDelayedList+0xa6>
 8001a68:	4b0f      	ldr	r3, [pc, #60]	; (8001aa8 <prvAddCurrentTaskToDelayedList+0xc4>)
 8001a6a:	681a      	ldr	r2, [r3, #0]
 8001a6c:	4b0a      	ldr	r3, [pc, #40]	; (8001a98 <prvAddCurrentTaskToDelayedList+0xb4>)
 8001a6e:	681b      	ldr	r3, [r3, #0]
 8001a70:	3304      	adds	r3, #4
 8001a72:	4619      	mov	r1, r3
 8001a74:	4610      	mov	r0, r2
 8001a76:	f7fe fea8 	bl	80007ca <vListInsert>
 8001a7a:	4b0c      	ldr	r3, [pc, #48]	; (8001aac <prvAddCurrentTaskToDelayedList+0xc8>)
 8001a7c:	681b      	ldr	r3, [r3, #0]
 8001a7e:	68ba      	ldr	r2, [r7, #8]
 8001a80:	429a      	cmp	r2, r3
 8001a82:	d202      	bcs.n	8001a8a <prvAddCurrentTaskToDelayedList+0xa6>
 8001a84:	4a09      	ldr	r2, [pc, #36]	; (8001aac <prvAddCurrentTaskToDelayedList+0xc8>)
 8001a86:	68bb      	ldr	r3, [r7, #8]
 8001a88:	6013      	str	r3, [r2, #0]
 8001a8a:	bf00      	nop
 8001a8c:	3710      	adds	r7, #16
 8001a8e:	46bd      	mov	sp, r7
 8001a90:	bd80      	pop	{r7, pc}
 8001a92:	bf00      	nop
 8001a94:	2000055c 	.word	0x2000055c
 8001a98:	20000458 	.word	0x20000458
 8001a9c:	20000560 	.word	0x20000560
 8001aa0:	20000544 	.word	0x20000544
 8001aa4:	20000514 	.word	0x20000514
 8001aa8:	20000510 	.word	0x20000510
 8001aac:	20000578 	.word	0x20000578

08001ab0 <pxPortInitialiseStack>:
 8001ab0:	b480      	push	{r7}
 8001ab2:	b085      	sub	sp, #20
 8001ab4:	af00      	add	r7, sp, #0
 8001ab6:	60f8      	str	r0, [r7, #12]
 8001ab8:	60b9      	str	r1, [r7, #8]
 8001aba:	607a      	str	r2, [r7, #4]
 8001abc:	68fb      	ldr	r3, [r7, #12]
 8001abe:	3b04      	subs	r3, #4
 8001ac0:	60fb      	str	r3, [r7, #12]
 8001ac2:	68fb      	ldr	r3, [r7, #12]
 8001ac4:	f04f 7280 	mov.w	r2, #16777216	; 0x1000000
 8001ac8:	601a      	str	r2, [r3, #0]
 8001aca:	68fb      	ldr	r3, [r7, #12]
 8001acc:	3b04      	subs	r3, #4
 8001ace:	60fb      	str	r3, [r7, #12]
 8001ad0:	68bb      	ldr	r3, [r7, #8]
 8001ad2:	f023 0201 	bic.w	r2, r3, #1
 8001ad6:	68fb      	ldr	r3, [r7, #12]
 8001ad8:	601a      	str	r2, [r3, #0]
 8001ada:	68fb      	ldr	r3, [r7, #12]
 8001adc:	3b04      	subs	r3, #4
 8001ade:	60fb      	str	r3, [r7, #12]
 8001ae0:	4a08      	ldr	r2, [pc, #32]	; (8001b04 <pxPortInitialiseStack+0x54>)
 8001ae2:	68fb      	ldr	r3, [r7, #12]
 8001ae4:	601a      	str	r2, [r3, #0]
 8001ae6:	68fb      	ldr	r3, [r7, #12]
 8001ae8:	3b14      	subs	r3, #20
 8001aea:	60fb      	str	r3, [r7, #12]
 8001aec:	687a      	ldr	r2, [r7, #4]
 8001aee:	68fb      	ldr	r3, [r7, #12]
 8001af0:	601a      	str	r2, [r3, #0]
 8001af2:	68fb      	ldr	r3, [r7, #12]
 8001af4:	3b20      	subs	r3, #32
 8001af6:	60fb      	str	r3, [r7, #12]
 8001af8:	68fb      	ldr	r3, [r7, #12]
 8001afa:	4618      	mov	r0, r3
 8001afc:	3714      	adds	r7, #20
 8001afe:	46bd      	mov	sp, r7
 8001b00:	bc80      	pop	{r7}
 8001b02:	4770      	bx	lr
 8001b04:	08001b09 	.word	0x08001b09

08001b08 <prvTaskExitError>:
 8001b08:	b480      	push	{r7}
 8001b0a:	b083      	sub	sp, #12
 8001b0c:	af00      	add	r7, sp, #0
 8001b0e:	4b0c      	ldr	r3, [pc, #48]	; (8001b40 <prvTaskExitError+0x38>)
 8001b10:	681b      	ldr	r3, [r3, #0]
 8001b12:	f1b3 3fff 	cmp.w	r3, #4294967295	; 0xffffffff
 8001b16:	d009      	beq.n	8001b2c <prvTaskExitError+0x24>
 8001b18:	f04f 0350 	mov.w	r3, #80	; 0x50
 8001b1c:	f383 8811 	msr	BASEPRI, r3
 8001b20:	f3bf 8f6f 	isb	sy
 8001b24:	f3bf 8f4f 	dsb	sy
 8001b28:	607b      	str	r3, [r7, #4]
 8001b2a:	e7fe      	b.n	8001b2a <prvTaskExitError+0x22>
 8001b2c:	f04f 0350 	mov.w	r3, #80	; 0x50
 8001b30:	f383 8811 	msr	BASEPRI, r3
 8001b34:	f3bf 8f6f 	isb	sy
 8001b38:	f3bf 8f4f 	dsb	sy
 8001b3c:	603b      	str	r3, [r7, #0]
 8001b3e:	e7fe      	b.n	8001b3e <prvTaskExitError+0x36>
 8001b40:	20000008 	.word	0x20000008
	...

08001b50 <SVC_Handler>:
 8001b50:	4b07      	ldr	r3, [pc, #28]	; (8001b70 <pxCurrentTCBConst2>)
 8001b52:	6819      	ldr	r1, [r3, #0]
 8001b54:	6808      	ldr	r0, [r1, #0]
 8001b56:	e8b0 0ff0 	ldmia.w	r0!, {r4, r5, r6, r7, r8, r9, sl, fp}
 8001b5a:	f380 8809 	msr	PSP, r0
 8001b5e:	f3bf 8f6f 	isb	sy
 8001b62:	f04f 0000 	mov.w	r0, #0
 8001b66:	f380 8811 	msr	BASEPRI, r0
 8001b6a:	f04e 0e0d 	orr.w	lr, lr, #13
 8001b6e:	4770      	bx	lr

08001b70 <pxCurrentTCBConst2>:
 8001b70:	20000458 	.word	0x20000458
 8001b74:	bf00      	nop
 8001b76:	bf00      	nop

08001b78 <prvPortStartFirstTask>:
 8001b78:	4806      	ldr	r0, [pc, #24]	; (8001b94 <prvPortStartFirstTask+0x1c>)
 8001b7a:	6800      	ldr	r0, [r0, #0]
 8001b7c:	6800      	ldr	r0, [r0, #0]
 8001b7e:	f380 8808 	msr	MSP, r0
 8001b82:	b662      	cpsie	i
 8001b84:	b661      	cpsie	f
 8001b86:	f3bf 8f4f 	dsb	sy
 8001b8a:	f3bf 8f6f 	isb	sy
 8001b8e:	df00      	svc	0
 8001b90:	bf00      	nop
 8001b92:	bf00      	nop
 8001b94:	e000ed08 	.word	0xe000ed08

08001b98 <xPortStartScheduler>:
 8001b98:	b580      	push	{r7, lr}
 8001b9a:	b084      	sub	sp, #16
 8001b9c:	af00      	add	r7, sp, #0
 8001b9e:	4b28      	ldr	r3, [pc, #160]	; (8001c40 <xPortStartScheduler+0xa8>)
 8001ba0:	60fb      	str	r3, [r7, #12]
 8001ba2:	68fb      	ldr	r3, [r7, #12]
 8001ba4:	781b      	ldrb	r3, [r3, #0]
 8001ba6:	b2db      	uxtb	r3, r3
 8001ba8:	60bb      	str	r3, [r7, #8]
 8001baa:	68fb      	ldr	r3, [r7, #12]
 8001bac:	22ff      	movs	r2, #255	; 0xff
 8001bae:	701a      	strb	r2, [r3, #0]
 8001bb0:	68fb      	ldr	r3, [r7, #12]
 8001bb2:	781b      	ldrb	r3, [r3, #0]
 8001bb4:	b2db      	uxtb	r3, r3
 8001bb6:	71fb      	strb	r3, [r7, #7]
 8001bb8:	79fb      	ldrb	r3, [r7, #7]
 8001bba:	b2db      	uxtb	r3, r3
 8001bbc:	f003 0350 	and.w	r3, r3, #80	; 0x50
 8001bc0:	b2da      	uxtb	r2, r3
 8001bc2:	4b20      	ldr	r3, [pc, #128]	; (8001c44 <xPortStartScheduler+0xac>)
 8001bc4:	701a      	strb	r2, [r3, #0]
 8001bc6:	4b20      	ldr	r3, [pc, #128]	; (8001c48 <xPortStartScheduler+0xb0>)
 8001bc8:	2207      	movs	r2, #7
 8001bca:	601a      	str	r2, [r3, #0]
 8001bcc:	e009      	b.n	8001be2 <xPortStartScheduler+0x4a>
 8001bce:	4b1e      	ldr	r3, [pc, #120]	; (8001c48 <xPortStartScheduler+0xb0>)
 8001bd0:	681b      	ldr	r3, [r3, #0]
 8001bd2:	3b01      	subs	r3, #1
 8001bd4:	4a1c      	ldr	r2, [pc, #112]	; (8001c48 <xPortStartScheduler+0xb0>)
 8001bd6:	6013      	str	r3, [r2, #0]
 8001bd8:	79fb      	ldrb	r3, [r7, #7]
 8001bda:	b2db      	uxtb	r3, r3
 8001bdc:	005b      	lsls	r3, r3, #1
 8001bde:	b2db      	uxtb	r3, r3
 8001be0:	71fb      	strb	r3, [r7, #7]
 8001be2:	79fb      	ldrb	r3, [r7, #7]
 8001be4:	b2db      	uxtb	r3, r3
 8001be6:	f003 0380 	and.w	r3, r3, #128	; 0x80
 8001bea:	2b80      	cmp	r3, #128	; 0x80
 8001bec:	d0ef      	beq.n	8001bce <xPortStartScheduler+0x36>
 8001bee:	4b16      	ldr	r3, [pc, #88]	; (8001c48 <xPortStartScheduler+0xb0>)
 8001bf0:	681b      	ldr	r3, [r3, #0]
 8001bf2:	021b      	lsls	r3, r3, #8
 8001bf4:	4a14      	ldr	r2, [pc, #80]	; (8001c48 <xPortStartScheduler+0xb0>)
 8001bf6:	6013      	str	r3, [r2, #0]
 8001bf8:	4b13      	ldr	r3, [pc, #76]	; (8001c48 <xPortStartScheduler+0xb0>)
 8001bfa:	681b      	ldr	r3, [r3, #0]
 8001bfc:	f403 63e0 	and.w	r3, r3, #1792	; 0x700
 8001c00:	4a11      	ldr	r2, [pc, #68]	; (8001c48 <xPortStartScheduler+0xb0>)
 8001c02:	6013      	str	r3, [r2, #0]
 8001c04:	68bb      	ldr	r3, [r7, #8]
 8001c06:	b2da      	uxtb	r2, r3
 8001c08:	68fb      	ldr	r3, [r7, #12]
 8001c0a:	701a      	strb	r2, [r3, #0]
 8001c0c:	4b0f      	ldr	r3, [pc, #60]	; (8001c4c <xPortStartScheduler+0xb4>)
 8001c0e:	681b      	ldr	r3, [r3, #0]
 8001c10:	4a0e      	ldr	r2, [pc, #56]	; (8001c4c <xPortStartScheduler+0xb4>)
 8001c12:	f443 0370 	orr.w	r3, r3, #15728640	; 0xf00000
 8001c16:	6013      	str	r3, [r2, #0]
 8001c18:	4b0c      	ldr	r3, [pc, #48]	; (8001c4c <xPortStartScheduler+0xb4>)
 8001c1a:	681b      	ldr	r3, [r3, #0]
 8001c1c:	4a0b      	ldr	r2, [pc, #44]	; (8001c4c <xPortStartScheduler+0xb4>)
 8001c1e:	f043 4370 	orr.w	r3, r3, #4026531840	; 0xf0000000
 8001c22:	6013      	str	r3, [r2, #0]
 8001c24:	f000 f8b0 	bl	8001d88 <vPortSetupTimerInterrupt>
 8001c28:	4b09      	ldr	r3, [pc, #36]	; (8001c50 <xPortStartScheduler+0xb8>)
 8001c2a:	2200      	movs	r2, #0
 8001c2c:	601a      	str	r2, [r3, #0]
 8001c2e:	f7ff ffa3 	bl	8001b78 <prvPortStartFirstTask>
 8001c32:	f7ff ff69 	bl	8001b08 <prvTaskExitError>
 8001c36:	2300      	movs	r3, #0
 8001c38:	4618      	mov	r0, r3
 8001c3a:	3710      	adds	r7, #16
 8001c3c:	46bd      	mov	sp, r7
 8001c3e:	bd80      	pop	{r7, pc}
 8001c40:	e000e400 	.word	0xe000e400
 8001c44:	20000584 	.word	0x20000584
 8001c48:	20000588 	.word	0x20000588
 8001c4c:	e000ed20 	.word	0xe000ed20
 8001c50:	20000008 	.word	0x20000008

08001c54 <vPortEnterCritical>:
 8001c54:	b480      	push	{r7}
 8001c56:	b083      	sub	sp, #12
 8001c58:	af00      	add	r7, sp, #0
 8001c5a:	f04f 0350 	mov.w	r3, #80	; 0x50
 8001c5e:	f383 8811 	msr	BASEPRI, r3
 8001c62:	f3bf 8f6f 	isb	sy
 8001c66:	f3bf 8f4f 	dsb	sy
 8001c6a:	607b      	str	r3, [r7, #4]
 8001c6c:	4b0e      	ldr	r3, [pc, #56]	; (8001ca8 <vPortEnterCritical+0x54>)
 8001c6e:	681b      	ldr	r3, [r3, #0]
 8001c70:	3301      	adds	r3, #1
 8001c72:	4a0d      	ldr	r2, [pc, #52]	; (8001ca8 <vPortEnterCritical+0x54>)
 8001c74:	6013      	str	r3, [r2, #0]
 8001c76:	4b0c      	ldr	r3, [pc, #48]	; (8001ca8 <vPortEnterCritical+0x54>)
 8001c78:	681b      	ldr	r3, [r3, #0]
 8001c7a:	2b01      	cmp	r3, #1
 8001c7c:	d10e      	bne.n	8001c9c <vPortEnterCritical+0x48>
 8001c7e:	4b0b      	ldr	r3, [pc, #44]	; (8001cac <vPortEnterCritical+0x58>)
 8001c80:	681b      	ldr	r3, [r3, #0]
 8001c82:	b2db      	uxtb	r3, r3
 8001c84:	2b00      	cmp	r3, #0
 8001c86:	d009      	beq.n	8001c9c <vPortEnterCritical+0x48>
 8001c88:	f04f 0350 	mov.w	r3, #80	; 0x50
 8001c8c:	f383 8811 	msr	BASEPRI, r3
 8001c90:	f3bf 8f6f 	isb	sy
 8001c94:	f3bf 8f4f 	dsb	sy
 8001c98:	603b      	str	r3, [r7, #0]
 8001c9a:	e7fe      	b.n	8001c9a <vPortEnterCritical+0x46>
 8001c9c:	bf00      	nop
 8001c9e:	370c      	adds	r7, #12
 8001ca0:	46bd      	mov	sp, r7
 8001ca2:	bc80      	pop	{r7}
 8001ca4:	4770      	bx	lr
 8001ca6:	bf00      	nop
 8001ca8:	20000008 	.word	0x20000008
 8001cac:	e000ed04 	.word	0xe000ed04

08001cb0 <vPortExitCritical>:
 8001cb0:	b480      	push	{r7}
 8001cb2:	b083      	sub	sp, #12
 8001cb4:	af00      	add	r7, sp, #0
 8001cb6:	4b10      	ldr	r3, [pc, #64]	; (8001cf8 <vPortExitCritical+0x48>)
 8001cb8:	681b      	ldr	r3, [r3, #0]
 8001cba:	2b00      	cmp	r3, #0
 8001cbc:	d109      	bne.n	8001cd2 <vPortExitCritical+0x22>
 8001cbe:	f04f 0350 	mov.w	r3, #80	; 0x50
 8001cc2:	f383 8811 	msr	BASEPRI, r3
 8001cc6:	f3bf 8f6f 	isb	sy
 8001cca:	f3bf 8f4f 	dsb	sy
 8001cce:	607b      	str	r3, [r7, #4]
 8001cd0:	e7fe      	b.n	8001cd0 <vPortExitCritical+0x20>
 8001cd2:	4b09      	ldr	r3, [pc, #36]	; (8001cf8 <vPortExitCritical+0x48>)
 8001cd4:	681b      	ldr	r3, [r3, #0]
 8001cd6:	3b01      	subs	r3, #1
 8001cd8:	4a07      	ldr	r2, [pc, #28]	; (8001cf8 <vPortExitCritical+0x48>)
 8001cda:	6013      	str	r3, [r2, #0]
 8001cdc:	4b06      	ldr	r3, [pc, #24]	; (8001cf8 <vPortExitCritical+0x48>)
 8001cde:	681b      	ldr	r3, [r3, #0]
 8001ce0:	2b00      	cmp	r3, #0
 8001ce2:	d104      	bne.n	8001cee <vPortExitCritical+0x3e>
 8001ce4:	2300      	movs	r3, #0
 8001ce6:	603b      	str	r3, [r7, #0]
 8001ce8:	683b      	ldr	r3, [r7, #0]
 8001cea:	f383 8811 	msr	BASEPRI, r3
 8001cee:	bf00      	nop
 8001cf0:	370c      	adds	r7, #12
 8001cf2:	46bd      	mov	sp, r7
 8001cf4:	bc80      	pop	{r7}
 8001cf6:	4770      	bx	lr
 8001cf8:	20000008 	.word	0x20000008
 8001cfc:	00000000 	.word	0x00000000

08001d00 <PendSV_Handler>:
 8001d00:	f3ef 8009 	mrs	r0, PSP
 8001d04:	f3bf 8f6f 	isb	sy
 8001d08:	4b0d      	ldr	r3, [pc, #52]	; (8001d40 <pxCurrentTCBConst>)
 8001d0a:	681a      	ldr	r2, [r3, #0]
 8001d0c:	e920 0ff0 	stmdb	r0!, {r4, r5, r6, r7, r8, r9, sl, fp}
 8001d10:	6010      	str	r0, [r2, #0]
 8001d12:	e92d 4008 	stmdb	sp!, {r3, lr}
 8001d16:	f04f 0050 	mov.w	r0, #80	; 0x50
 8001d1a:	f380 8811 	msr	BASEPRI, r0
 8001d1e:	f7ff fb85 	bl	800142c <vTaskSwitchContext>
 8001d22:	f04f 0000 	mov.w	r0, #0
 8001d26:	f380 8811 	msr	BASEPRI, r0
 8001d2a:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
 8001d2e:	6819      	ldr	r1, [r3, #0]
 8001d30:	6808      	ldr	r0, [r1, #0]
 8001d32:	e8b0 0ff0 	ldmia.w	r0!, {r4, r5, r6, r7, r8, r9, sl, fp}
 8001d36:	f380 8809 	msr	PSP, r0
 8001d3a:	f3bf 8f6f 	isb	sy
 8001d3e:	4770      	bx	lr

08001d40 <pxCurrentTCBConst>:
 8001d40:	20000458 	.word	0x20000458
 8001d44:	bf00      	nop
 8001d46:	bf00      	nop

08001d48 <xPortSysTickHandler>:
 8001d48:	b580      	push	{r7, lr}
 8001d4a:	b082      	sub	sp, #8
 8001d4c:	af00      	add	r7, sp, #0
 8001d4e:	f04f 0350 	mov.w	r3, #80	; 0x50
 8001d52:	f383 8811 	msr	BASEPRI, r3
 8001d56:	f3bf 8f6f 	isb	sy
 8001d5a:	f3bf 8f4f 	dsb	sy
 8001d5e:	607b      	str	r3, [r7, #4]
 8001d60:	f7ff faa8 	bl	80012b4 <xTaskIncrementTick>
 8001d64:	4603      	mov	r3, r0
 8001d66:	2b00      	cmp	r3, #0
 8001d68:	d003      	beq.n	8001d72 <xPortSysTickHandler+0x2a>
 8001d6a:	4b06      	ldr	r3, [pc, #24]	; (8001d84 <xPortSysTickHandler+0x3c>)
 8001d6c:	f04f 5280 	mov.w	r2, #268435456	; 0x10000000
 8001d70:	601a      	str	r2, [r3, #0]
 8001d72:	2300      	movs	r3, #0
 8001d74:	603b      	str	r3, [r7, #0]
 8001d76:	683b      	ldr	r3, [r7, #0]
 8001d78:	f383 8811 	msr	BASEPRI, r3
 8001d7c:	bf00      	nop
 8001d7e:	3708      	adds	r7, #8
 8001d80:	46bd      	mov	sp, r7
 8001d82:	bd80      	pop	{r7, pc}
 8001d84:	e000ed04 	.word	0xe000ed04

08001d88 <vPortSetupTimerInterrupt>:
 8001d88:	b480      	push	{r7}
 8001d8a:	af00      	add	r7, sp, #0
 8001d8c:	4b07      	ldr	r3, [pc, #28]	; (8001dac <vPortSetupTimerInterrupt+0x24>)
 8001d8e:	681b      	ldr	r3, [r3, #0]
 8001d90:	4a07      	ldr	r2, [pc, #28]	; (8001db0 <vPortSetupTimerInterrupt+0x28>)
 8001d92:	fba2 2303 	umull	r2, r3, r2, r3
 8001d96:	099b      	lsrs	r3, r3, #6
 8001d98:	4a06      	ldr	r2, [pc, #24]	; (8001db4 <vPortSetupTimerInterrupt+0x2c>)
 8001d9a:	3b01      	subs	r3, #1
 8001d9c:	6013      	str	r3, [r2, #0]
 8001d9e:	4b06      	ldr	r3, [pc, #24]	; (8001db8 <vPortSetupTimerInterrupt+0x30>)
 8001da0:	2207      	movs	r2, #7
 8001da2:	601a      	str	r2, [r3, #0]
 8001da4:	bf00      	nop
 8001da6:	46bd      	mov	sp, r7
 8001da8:	bc80      	pop	{r7}
 8001daa:	4770      	bx	lr
 8001dac:	2000000c 	.word	0x2000000c
 8001db0:	10624dd3 	.word	0x10624dd3
 8001db4:	e000e014 	.word	0xe000e014
 8001db8:	e000e010 	.word	0xe000e010

08001dbc <vPortValidateInterruptPriority>:
 8001dbc:	b480      	push	{r7}
 8001dbe:	b085      	sub	sp, #20
 8001dc0:	af00      	add	r7, sp, #0
 8001dc2:	f3ef 8305 	mrs	r3, IPSR
 8001dc6:	60fb      	str	r3, [r7, #12]
 8001dc8:	68fb      	ldr	r3, [r7, #12]
 8001dca:	2b0f      	cmp	r3, #15
 8001dcc:	d913      	bls.n	8001df6 <vPortValidateInterruptPriority+0x3a>
 8001dce:	4a15      	ldr	r2, [pc, #84]	; (8001e24 <vPortValidateInterruptPriority+0x68>)
 8001dd0:	68fb      	ldr	r3, [r7, #12]
 8001dd2:	4413      	add	r3, r2
 8001dd4:	781b      	ldrb	r3, [r3, #0]
 8001dd6:	72fb      	strb	r3, [r7, #11]
 8001dd8:	4b13      	ldr	r3, [pc, #76]	; (8001e28 <vPortValidateInterruptPriority+0x6c>)
 8001dda:	781b      	ldrb	r3, [r3, #0]
 8001ddc:	7afa      	ldrb	r2, [r7, #11]
 8001dde:	429a      	cmp	r2, r3
 8001de0:	d209      	bcs.n	8001df6 <vPortValidateInterruptPriority+0x3a>
 8001de2:	f04f 0350 	mov.w	r3, #80	; 0x50
 8001de6:	f383 8811 	msr	BASEPRI, r3
 8001dea:	f3bf 8f6f 	isb	sy
 8001dee:	f3bf 8f4f 	dsb	sy
 8001df2:	607b      	str	r3, [r7, #4]
 8001df4:	e7fe      	b.n	8001df4 <vPortValidateInterruptPriority+0x38>
 8001df6:	4b0d      	ldr	r3, [pc, #52]	; (8001e2c <vPortValidateInterruptPriority+0x70>)
 8001df8:	681b      	ldr	r3, [r3, #0]
 8001dfa:	f403 62e0 	and.w	r2, r3, #1792	; 0x700
 8001dfe:	4b0c      	ldr	r3, [pc, #48]	; (8001e30 <vPortValidateInterruptPriority+0x74>)
 8001e00:	681b      	ldr	r3, [r3, #0]
 8001e02:	429a      	cmp	r2, r3
 8001e04:	d909      	bls.n	8001e1a <vPortValidateInterruptPriority+0x5e>
 8001e06:	f04f 0350 	mov.w	r3, #80	; 0x50
 8001e0a:	f383 8811 	msr	BASEPRI, r3
 8001e0e:	f3bf 8f6f 	isb	sy
 8001e12:	f3bf 8f4f 	dsb	sy
 8001e16:	603b      	str	r3, [r7, #0]
 8001e18:	e7fe      	b.n	8001e18 <vPortValidateInterruptPriority+0x5c>
 8001e1a:	bf00      	nop
 8001e1c:	3714      	adds	r7, #20
 8001e1e:	46bd      	mov	sp, r7
 8001e20:	bc80      	pop	{r7}
 8001e22:	4770      	bx	lr
 8001e24:	e000e3f0 	.word	0xe000e3f0
 8001e28:	20000584 	.word	0x20000584
 8001e2c:	e000ed0c 	.word	0xe000ed0c
 8001e30:	20000588 	.word	0x20000588

08001e34 <pvPortMalloc>:
 8001e34:	b580      	push	{r7, lr}
 8001e36:	b08a      	sub	sp, #40	; 0x28
 8001e38:	af00      	add	r7, sp, #0
 8001e3a:	6078      	str	r0, [r7, #4]
 8001e3c:	2300      	movs	r3, #0
 8001e3e:	61fb      	str	r3, [r7, #28]
 8001e40:	f7ff f98e 	bl	8001160 <vTaskSuspendAll>
 8001e44:	4b57      	ldr	r3, [pc, #348]	; (8001fa4 <pvPortMalloc+0x170>)
 8001e46:	681b      	ldr	r3, [r3, #0]
 8001e48:	2b00      	cmp	r3, #0
 8001e4a:	d101      	bne.n	8001e50 <pvPortMalloc+0x1c>
 8001e4c:	f000 f90c 	bl	8002068 <prvHeapInit>
 8001e50:	4b55      	ldr	r3, [pc, #340]	; (8001fa8 <pvPortMalloc+0x174>)
 8001e52:	681a      	ldr	r2, [r3, #0]
 8001e54:	687b      	ldr	r3, [r7, #4]
 8001e56:	4013      	ands	r3, r2
 8001e58:	2b00      	cmp	r3, #0
 8001e5a:	f040 808c 	bne.w	8001f76 <pvPortMalloc+0x142>
 8001e5e:	687b      	ldr	r3, [r7, #4]
 8001e60:	2b00      	cmp	r3, #0
 8001e62:	d01c      	beq.n	8001e9e <pvPortMalloc+0x6a>
 8001e64:	2208      	movs	r2, #8
 8001e66:	687b      	ldr	r3, [r7, #4]
 8001e68:	4413      	add	r3, r2
 8001e6a:	607b      	str	r3, [r7, #4]
 8001e6c:	687b      	ldr	r3, [r7, #4]
 8001e6e:	f003 0307 	and.w	r3, r3, #7
 8001e72:	2b00      	cmp	r3, #0
 8001e74:	d013      	beq.n	8001e9e <pvPortMalloc+0x6a>
 8001e76:	687b      	ldr	r3, [r7, #4]
 8001e78:	f023 0307 	bic.w	r3, r3, #7
 8001e7c:	3308      	adds	r3, #8
 8001e7e:	607b      	str	r3, [r7, #4]
 8001e80:	687b      	ldr	r3, [r7, #4]
 8001e82:	f003 0307 	and.w	r3, r3, #7
 8001e86:	2b00      	cmp	r3, #0
 8001e88:	d009      	beq.n	8001e9e <pvPortMalloc+0x6a>
 8001e8a:	f04f 0350 	mov.w	r3, #80	; 0x50
 8001e8e:	f383 8811 	msr	BASEPRI, r3
 8001e92:	f3bf 8f6f 	isb	sy
 8001e96:	f3bf 8f4f 	dsb	sy
 8001e9a:	617b      	str	r3, [r7, #20]
 8001e9c:	e7fe      	b.n	8001e9c <pvPortMalloc+0x68>
 8001e9e:	687b      	ldr	r3, [r7, #4]
 8001ea0:	2b00      	cmp	r3, #0
 8001ea2:	d068      	beq.n	8001f76 <pvPortMalloc+0x142>
 8001ea4:	4b41      	ldr	r3, [pc, #260]	; (8001fac <pvPortMalloc+0x178>)
 8001ea6:	681b      	ldr	r3, [r3, #0]
 8001ea8:	687a      	ldr	r2, [r7, #4]
 8001eaa:	429a      	cmp	r2, r3
 8001eac:	d863      	bhi.n	8001f76 <pvPortMalloc+0x142>
 8001eae:	4b40      	ldr	r3, [pc, #256]	; (8001fb0 <pvPortMalloc+0x17c>)
 8001eb0:	623b      	str	r3, [r7, #32]
 8001eb2:	4b3f      	ldr	r3, [pc, #252]	; (8001fb0 <pvPortMalloc+0x17c>)
 8001eb4:	681b      	ldr	r3, [r3, #0]
 8001eb6:	627b      	str	r3, [r7, #36]	; 0x24
 8001eb8:	e004      	b.n	8001ec4 <pvPortMalloc+0x90>
 8001eba:	6a7b      	ldr	r3, [r7, #36]	; 0x24
 8001ebc:	623b      	str	r3, [r7, #32]
 8001ebe:	6a7b      	ldr	r3, [r7, #36]	; 0x24
 8001ec0:	681b      	ldr	r3, [r3, #0]
 8001ec2:	627b      	str	r3, [r7, #36]	; 0x24
 8001ec4:	6a7b      	ldr	r3, [r7, #36]	; 0x24
 8001ec6:	685b      	ldr	r3, [r3, #4]
 8001ec8:	687a      	ldr	r2, [r7, #4]
 8001eca:	429a      	cmp	r2, r3
 8001ecc:	d903      	bls.n	8001ed6 <pvPortMalloc+0xa2>
 8001ece:	6a7b      	ldr	r3, [r7, #36]	; 0x24
 8001ed0:	681b      	ldr	r3, [r3, #0]
 8001ed2:	2b00      	cmp	r3, #0
 8001ed4:	d1f1      	bne.n	8001eba <pvPortMalloc+0x86>
 8001ed6:	4b33      	ldr	r3, [pc, #204]	; (8001fa4 <pvPortMalloc+0x170>)
 8001ed8:	681b      	ldr	r3, [r3, #0]
 8001eda:	6a7a      	ldr	r2, [r7, #36]	; 0x24
 8001edc:	429a      	cmp	r2, r3
 8001ede:	d04a      	beq.n	8001f76 <pvPortMalloc+0x142>
 8001ee0:	6a3b      	ldr	r3, [r7, #32]
 8001ee2:	681b      	ldr	r3, [r3, #0]
 8001ee4:	2208      	movs	r2, #8
 8001ee6:	4413      	add	r3, r2
 8001ee8:	61fb      	str	r3, [r7, #28]
 8001eea:	6a7b      	ldr	r3, [r7, #36]	; 0x24
 8001eec:	681a      	ldr	r2, [r3, #0]
 8001eee:	6a3b      	ldr	r3, [r7, #32]
 8001ef0:	601a      	str	r2, [r3, #0]
 8001ef2:	6a7b      	ldr	r3, [r7, #36]	; 0x24
 8001ef4:	685a      	ldr	r2, [r3, #4]
 8001ef6:	687b      	ldr	r3, [r7, #4]
 8001ef8:	1ad2      	subs	r2, r2, r3
 8001efa:	2308      	movs	r3, #8
 8001efc:	005b      	lsls	r3, r3, #1
 8001efe:	429a      	cmp	r2, r3
 8001f00:	d91e      	bls.n	8001f40 <pvPortMalloc+0x10c>
 8001f02:	6a7a      	ldr	r2, [r7, #36]	; 0x24
 8001f04:	687b      	ldr	r3, [r7, #4]
 8001f06:	4413      	add	r3, r2
 8001f08:	61bb      	str	r3, [r7, #24]
 8001f0a:	69bb      	ldr	r3, [r7, #24]
 8001f0c:	f003 0307 	and.w	r3, r3, #7
 8001f10:	2b00      	cmp	r3, #0
 8001f12:	d009      	beq.n	8001f28 <pvPortMalloc+0xf4>
 8001f14:	f04f 0350 	mov.w	r3, #80	; 0x50
 8001f18:	f383 8811 	msr	BASEPRI, r3
 8001f1c:	f3bf 8f6f 	isb	sy
 8001f20:	f3bf 8f4f 	dsb	sy
 8001f24:	613b      	str	r3, [r7, #16]
 8001f26:	e7fe      	b.n	8001f26 <pvPortMalloc+0xf2>
 8001f28:	6a7b      	ldr	r3, [r7, #36]	; 0x24
 8001f2a:	685a      	ldr	r2, [r3, #4]
 8001f2c:	687b      	ldr	r3, [r7, #4]
 8001f2e:	1ad2      	subs	r2, r2, r3
 8001f30:	69bb      	ldr	r3, [r7, #24]
 8001f32:	605a      	str	r2, [r3, #4]
 8001f34:	6a7b      	ldr	r3, [r7, #36]	; 0x24
 8001f36:	687a      	ldr	r2, [r7, #4]
 8001f38:	605a      	str	r2, [r3, #4]
 8001f3a:	69b8      	ldr	r0, [r7, #24]
 8001f3c:	f000 f8f6 	bl	800212c <prvInsertBlockIntoFreeList>
 8001f40:	4b1a      	ldr	r3, [pc, #104]	; (8001fac <pvPortMalloc+0x178>)
 8001f42:	681a      	ldr	r2, [r3, #0]
 8001f44:	6a7b      	ldr	r3, [r7, #36]	; 0x24
 8001f46:	685b      	ldr	r3, [r3, #4]
 8001f48:	1ad3      	subs	r3, r2, r3
 8001f4a:	4a18      	ldr	r2, [pc, #96]	; (8001fac <pvPortMalloc+0x178>)
 8001f4c:	6013      	str	r3, [r2, #0]
 8001f4e:	4b17      	ldr	r3, [pc, #92]	; (8001fac <pvPortMalloc+0x178>)
 8001f50:	681a      	ldr	r2, [r3, #0]
 8001f52:	4b18      	ldr	r3, [pc, #96]	; (8001fb4 <pvPortMalloc+0x180>)
 8001f54:	681b      	ldr	r3, [r3, #0]
 8001f56:	429a      	cmp	r2, r3
 8001f58:	d203      	bcs.n	8001f62 <pvPortMalloc+0x12e>
 8001f5a:	4b14      	ldr	r3, [pc, #80]	; (8001fac <pvPortMalloc+0x178>)
 8001f5c:	681b      	ldr	r3, [r3, #0]
 8001f5e:	4a15      	ldr	r2, [pc, #84]	; (8001fb4 <pvPortMalloc+0x180>)
 8001f60:	6013      	str	r3, [r2, #0]
 8001f62:	6a7b      	ldr	r3, [r7, #36]	; 0x24
 8001f64:	685a      	ldr	r2, [r3, #4]
 8001f66:	4b10      	ldr	r3, [pc, #64]	; (8001fa8 <pvPortMalloc+0x174>)
 8001f68:	681b      	ldr	r3, [r3, #0]
 8001f6a:	431a      	orrs	r2, r3
 8001f6c:	6a7b      	ldr	r3, [r7, #36]	; 0x24
 8001f6e:	605a      	str	r2, [r3, #4]
 8001f70:	6a7b      	ldr	r3, [r7, #36]	; 0x24
 8001f72:	2200      	movs	r2, #0
 8001f74:	601a      	str	r2, [r3, #0]
 8001f76:	f7ff f901 	bl	800117c <xTaskResumeAll>
 8001f7a:	69fb      	ldr	r3, [r7, #28]
 8001f7c:	f003 0307 	and.w	r3, r3, #7
 8001f80:	2b00      	cmp	r3, #0
 8001f82:	d009      	beq.n	8001f98 <pvPortMalloc+0x164>
 8001f84:	f04f 0350 	mov.w	r3, #80	; 0x50
 8001f88:	f383 8811 	msr	BASEPRI, r3
 8001f8c:	f3bf 8f6f 	isb	sy
 8001f90:	f3bf 8f4f 	dsb	sy
 8001f94:	60fb      	str	r3, [r7, #12]
 8001f96:	e7fe      	b.n	8001f96 <pvPortMalloc+0x162>
 8001f98:	69fb      	ldr	r3, [r7, #28]
 8001f9a:	4618      	mov	r0, r3
 8001f9c:	3728      	adds	r7, #40	; 0x28
 8001f9e:	46bd      	mov	sp, r7
 8001fa0:	bd80      	pop	{r7, pc}
 8001fa2:	bf00      	nop
 8001fa4:	20004194 	.word	0x20004194
 8001fa8:	200041a0 	.word	0x200041a0
 8001fac:	20004198 	.word	0x20004198
 8001fb0:	2000418c 	.word	0x2000418c
 8001fb4:	2000419c 	.word	0x2000419c

08001fb8 <vPortFree>:
 8001fb8:	b580      	push	{r7, lr}
 8001fba:	b086      	sub	sp, #24
 8001fbc:	af00      	add	r7, sp, #0
 8001fbe:	6078      	str	r0, [r7, #4]
 8001fc0:	687b      	ldr	r3, [r7, #4]
 8001fc2:	617b      	str	r3, [r7, #20]
 8001fc4:	687b      	ldr	r3, [r7, #4]
 8001fc6:	2b00      	cmp	r3, #0
 8001fc8:	d046      	beq.n	8002058 <vPortFree+0xa0>
 8001fca:	2308      	movs	r3, #8
 8001fcc:	425b      	negs	r3, r3
 8001fce:	697a      	ldr	r2, [r7, #20]
 8001fd0:	4413      	add	r3, r2
 8001fd2:	617b      	str	r3, [r7, #20]
 8001fd4:	697b      	ldr	r3, [r7, #20]
 8001fd6:	613b      	str	r3, [r7, #16]
 8001fd8:	693b      	ldr	r3, [r7, #16]
 8001fda:	685a      	ldr	r2, [r3, #4]
 8001fdc:	4b20      	ldr	r3, [pc, #128]	; (8002060 <vPortFree+0xa8>)
 8001fde:	681b      	ldr	r3, [r3, #0]
 8001fe0:	4013      	ands	r3, r2
 8001fe2:	2b00      	cmp	r3, #0
 8001fe4:	d109      	bne.n	8001ffa <vPortFree+0x42>
 8001fe6:	f04f 0350 	mov.w	r3, #80	; 0x50
 8001fea:	f383 8811 	msr	BASEPRI, r3
 8001fee:	f3bf 8f6f 	isb	sy
 8001ff2:	f3bf 8f4f 	dsb	sy
 8001ff6:	60fb      	str	r3, [r7, #12]
 8001ff8:	e7fe      	b.n	8001ff8 <vPortFree+0x40>
 8001ffa:	693b      	ldr	r3, [r7, #16]
 8001ffc:	681b      	ldr	r3, [r3, #0]
 8001ffe:	2b00      	cmp	r3, #0
 8002000:	d009      	beq.n	8002016 <vPortFree+0x5e>
 8002002:	f04f 0350 	mov.w	r3, #80	; 0x50
 8002006:	f383 8811 	msr	BASEPRI, r3
 800200a:	f3bf 8f6f 	isb	sy
 800200e:	f3bf 8f4f 	dsb	sy
 8002012:	60bb      	str	r3, [r7, #8]
 8002014:	e7fe      	b.n	8002014 <vPortFree+0x5c>
 8002016:	693b      	ldr	r3, [r7, #16]
 8002018:	685a      	ldr	r2, [r3, #4]
 800201a:	4b11      	ldr	r3, [pc, #68]	; (8002060 <vPortFree+0xa8>)
 800201c:	681b      	ldr	r3, [r3, #0]
 800201e:	4013      	ands	r3, r2
 8002020:	2b00      	cmp	r3, #0
 8002022:	d019      	beq.n	8002058 <vPortFree+0xa0>
 8002024:	693b      	ldr	r3, [r7, #16]
 8002026:	681b      	ldr	r3, [r3, #0]
 8002028:	2b00      	cmp	r3, #0
 800202a:	d115      	bne.n	8002058 <vPortFree+0xa0>
 800202c:	693b      	ldr	r3, [r7, #16]
 800202e:	685a      	ldr	r2, [r3, #4]
 8002030:	4b0b      	ldr	r3, [pc, #44]	; (8002060 <vPortFree+0xa8>)
 8002032:	681b      	ldr	r3, [r3, #0]
 8002034:	43db      	mvns	r3, r3
 8002036:	401a      	ands	r2, r3
 8002038:	693b      	ldr	r3, [r7, #16]
 800203a:	605a      	str	r2, [r3, #4]
 800203c:	f7ff f890 	bl	8001160 <vTaskSuspendAll>
 8002040:	693b      	ldr	r3, [r7, #16]
 8002042:	685a      	ldr	r2, [r3, #4]
 8002044:	4b07      	ldr	r3, [pc, #28]	; (8002064 <vPortFree+0xac>)
 8002046:	681b      	ldr	r3, [r3, #0]
 8002048:	4413      	add	r3, r2
 800204a:	4a06      	ldr	r2, [pc, #24]	; (8002064 <vPortFree+0xac>)
 800204c:	6013      	str	r3, [r2, #0]
 800204e:	6938      	ldr	r0, [r7, #16]
 8002050:	f000 f86c 	bl	800212c <prvInsertBlockIntoFreeList>
 8002054:	f7ff f892 	bl	800117c <xTaskResumeAll>
 8002058:	bf00      	nop
 800205a:	3718      	adds	r7, #24
 800205c:	46bd      	mov	sp, r7
 800205e:	bd80      	pop	{r7, pc}
 8002060:	200041a0 	.word	0x200041a0
 8002064:	20004198 	.word	0x20004198

08002068 <prvHeapInit>:
 8002068:	b480      	push	{r7}
 800206a:	b085      	sub	sp, #20
 800206c:	af00      	add	r7, sp, #0
 800206e:	f44f 5370 	mov.w	r3, #15360	; 0x3c00
 8002072:	60bb      	str	r3, [r7, #8]
 8002074:	4b27      	ldr	r3, [pc, #156]	; (8002114 <prvHeapInit+0xac>)
 8002076:	60fb      	str	r3, [r7, #12]
 8002078:	68fb      	ldr	r3, [r7, #12]
 800207a:	f003 0307 	and.w	r3, r3, #7
 800207e:	2b00      	cmp	r3, #0
 8002080:	d00c      	beq.n	800209c <prvHeapInit+0x34>
 8002082:	68fb      	ldr	r3, [r7, #12]
 8002084:	3307      	adds	r3, #7
 8002086:	60fb      	str	r3, [r7, #12]
 8002088:	68fb      	ldr	r3, [r7, #12]
 800208a:	f023 0307 	bic.w	r3, r3, #7
 800208e:	60fb      	str	r3, [r7, #12]
 8002090:	68ba      	ldr	r2, [r7, #8]
 8002092:	68fb      	ldr	r3, [r7, #12]
 8002094:	1ad3      	subs	r3, r2, r3
 8002096:	4a1f      	ldr	r2, [pc, #124]	; (8002114 <prvHeapInit+0xac>)
 8002098:	4413      	add	r3, r2
 800209a:	60bb      	str	r3, [r7, #8]
 800209c:	68fb      	ldr	r3, [r7, #12]
 800209e:	607b      	str	r3, [r7, #4]
 80020a0:	4a1d      	ldr	r2, [pc, #116]	; (8002118 <prvHeapInit+0xb0>)
 80020a2:	687b      	ldr	r3, [r7, #4]
 80020a4:	6013      	str	r3, [r2, #0]
 80020a6:	4b1c      	ldr	r3, [pc, #112]	; (8002118 <prvHeapInit+0xb0>)
 80020a8:	2200      	movs	r2, #0
 80020aa:	605a      	str	r2, [r3, #4]
 80020ac:	687b      	ldr	r3, [r7, #4]
 80020ae:	68ba      	ldr	r2, [r7, #8]
 80020b0:	4413      	add	r3, r2
 80020b2:	60fb      	str	r3, [r7, #12]
 80020b4:	2208      	movs	r2, #8
 80020b6:	68fb      	ldr	r3, [r7, #12]
 80020b8:	1a9b      	subs	r3, r3, r2
 80020ba:	60fb      	str	r3, [r7, #12]
 80020bc:	68fb      	ldr	r3, [r7, #12]
 80020be:	f023 0307 	bic.w	r3, r3, #7
 80020c2:	60fb      	str	r3, [r7, #12]
 80020c4:	68fb      	ldr	r3, [r7, #12]
 80020c6:	4a15      	ldr	r2, [pc, #84]	; (800211c <prvHeapInit+0xb4>)
 80020c8:	6013      	str	r3, [r2, #0]
 80020ca:	4b14      	ldr	r3, [pc, #80]	; (800211c <prvHeapInit+0xb4>)
 80020cc:	681b      	ldr	r3, [r3, #0]
 80020ce:	2200      	movs	r2, #0
 80020d0:	605a      	str	r2, [r3, #4]
 80020d2:	4b12      	ldr	r3, [pc, #72]	; (800211c <prvHeapInit+0xb4>)
 80020d4:	681b      	ldr	r3, [r3, #0]
 80020d6:	2200      	movs	r2, #0
 80020d8:	601a      	str	r2, [r3, #0]
 80020da:	687b      	ldr	r3, [r7, #4]
 80020dc:	603b      	str	r3, [r7, #0]
 80020de:	683b      	ldr	r3, [r7, #0]
 80020e0:	68fa      	ldr	r2, [r7, #12]
 80020e2:	1ad2      	subs	r2, r2, r3
 80020e4:	683b      	ldr	r3, [r7, #0]
 80020e6:	605a      	str	r2, [r3, #4]
 80020e8:	4b0c      	ldr	r3, [pc, #48]	; (800211c <prvHeapInit+0xb4>)
 80020ea:	681a      	ldr	r2, [r3, #0]
 80020ec:	683b      	ldr	r3, [r7, #0]
 80020ee:	601a      	str	r2, [r3, #0]
 80020f0:	683b      	ldr	r3, [r7, #0]
 80020f2:	685b      	ldr	r3, [r3, #4]
 80020f4:	4a0a      	ldr	r2, [pc, #40]	; (8002120 <prvHeapInit+0xb8>)
 80020f6:	6013      	str	r3, [r2, #0]
 80020f8:	683b      	ldr	r3, [r7, #0]
 80020fa:	685b      	ldr	r3, [r3, #4]
 80020fc:	4a09      	ldr	r2, [pc, #36]	; (8002124 <prvHeapInit+0xbc>)
 80020fe:	6013      	str	r3, [r2, #0]
 8002100:	4b09      	ldr	r3, [pc, #36]	; (8002128 <prvHeapInit+0xc0>)
 8002102:	f04f 4200 	mov.w	r2, #2147483648	; 0x80000000
 8002106:	601a      	str	r2, [r3, #0]
 8002108:	bf00      	nop
 800210a:	3714      	adds	r7, #20
 800210c:	46bd      	mov	sp, r7
 800210e:	bc80      	pop	{r7}
 8002110:	4770      	bx	lr
 8002112:	bf00      	nop
 8002114:	2000058c 	.word	0x2000058c
 8002118:	2000418c 	.word	0x2000418c
 800211c:	20004194 	.word	0x20004194
 8002120:	2000419c 	.word	0x2000419c
 8002124:	20004198 	.word	0x20004198
 8002128:	200041a0 	.word	0x200041a0

0800212c <prvInsertBlockIntoFreeList>:
 800212c:	b480      	push	{r7}
 800212e:	b085      	sub	sp, #20
 8002130:	af00      	add	r7, sp, #0
 8002132:	6078      	str	r0, [r7, #4]
 8002134:	4b27      	ldr	r3, [pc, #156]	; (80021d4 <prvInsertBlockIntoFreeList+0xa8>)
 8002136:	60fb      	str	r3, [r7, #12]
 8002138:	e002      	b.n	8002140 <prvInsertBlockIntoFreeList+0x14>
 800213a:	68fb      	ldr	r3, [r7, #12]
 800213c:	681b      	ldr	r3, [r3, #0]
 800213e:	60fb      	str	r3, [r7, #12]
 8002140:	68fb      	ldr	r3, [r7, #12]
 8002142:	681b      	ldr	r3, [r3, #0]
 8002144:	687a      	ldr	r2, [r7, #4]
 8002146:	429a      	cmp	r2, r3
 8002148:	d8f7      	bhi.n	800213a <prvInsertBlockIntoFreeList+0xe>
 800214a:	68fb      	ldr	r3, [r7, #12]
 800214c:	60bb      	str	r3, [r7, #8]
 800214e:	68fb      	ldr	r3, [r7, #12]
 8002150:	685b      	ldr	r3, [r3, #4]
 8002152:	68ba      	ldr	r2, [r7, #8]
 8002154:	4413      	add	r3, r2
 8002156:	687a      	ldr	r2, [r7, #4]
 8002158:	429a      	cmp	r2, r3
 800215a:	d108      	bne.n	800216e <prvInsertBlockIntoFreeList+0x42>
 800215c:	68fb      	ldr	r3, [r7, #12]
 800215e:	685a      	ldr	r2, [r3, #4]
 8002160:	687b      	ldr	r3, [r7, #4]
 8002162:	685b      	ldr	r3, [r3, #4]
 8002164:	441a      	add	r2, r3
 8002166:	68fb      	ldr	r3, [r7, #12]
 8002168:	605a      	str	r2, [r3, #4]
 800216a:	68fb      	ldr	r3, [r7, #12]
 800216c:	607b      	str	r3, [r7, #4]
 800216e:	687b      	ldr	r3, [r7, #4]
 8002170:	60bb      	str	r3, [r7, #8]
 8002172:	687b      	ldr	r3, [r7, #4]
 8002174:	685b      	ldr	r3, [r3, #4]
 8002176:	68ba      	ldr	r2, [r7, #8]
 8002178:	441a      	add	r2, r3
 800217a:	68fb      	ldr	r3, [r7, #12]
 800217c:	681b      	ldr	r3, [r3, #0]
 800217e:	429a      	cmp	r2, r3
 8002180:	d118      	bne.n	80021b4 <prvInsertBlockIntoFreeList+0x88>
 8002182:	68fb      	ldr	r3, [r7, #12]
 8002184:	681a      	ldr	r2, [r3, #0]
 8002186:	4b14      	ldr	r3, [pc, #80]	; (80021d8 <prvInsertBlockIntoFreeList+0xac>)
 8002188:	681b      	ldr	r3, [r3, #0]
 800218a:	429a      	cmp	r2, r3
 800218c:	d00d      	beq.n	80021aa <prvInsertBlockIntoFreeList+0x7e>
 800218e:	687b      	ldr	r3, [r7, #4]
 8002190:	685a      	ldr	r2, [r3, #4]
 8002192:	68fb      	ldr	r3, [r7, #12]
 8002194:	681b      	ldr	r3, [r3, #0]
 8002196:	685b      	ldr	r3, [r3, #4]
 8002198:	441a      	add	r2, r3
 800219a:	687b      	ldr	r3, [r7, #4]
 800219c:	605a      	str	r2, [r3, #4]
 800219e:	68fb      	ldr	r3, [r7, #12]
 80021a0:	681b      	ldr	r3, [r3, #0]
 80021a2:	681a      	ldr	r2, [r3, #0]
 80021a4:	687b      	ldr	r3, [r7, #4]
 80021a6:	601a      	str	r2, [r3, #0]
 80021a8:	e008      	b.n	80021bc <prvInsertBlockIntoFreeList+0x90>
 80021aa:	4b0b      	ldr	r3, [pc, #44]	; (80021d8 <prvInsertBlockIntoFreeList+0xac>)
 80021ac:	681a      	ldr	r2, [r3, #0]
 80021ae:	687b      	ldr	r3, [r7, #4]
 80021b0:	601a      	str	r2, [r3, #0]
 80021b2:	e003      	b.n	80021bc <prvInsertBlockIntoFreeList+0x90>
 80021b4:	68fb      	ldr	r3, [r7, #12]
 80021b6:	681a      	ldr	r2, [r3, #0]
 80021b8:	687b      	ldr	r3, [r7, #4]
 80021ba:	601a      	str	r2, [r3, #0]
 80021bc:	68fa      	ldr	r2, [r7, #12]
 80021be:	687b      	ldr	r3, [r7, #4]
 80021c0:	429a      	cmp	r2, r3
 80021c2:	d002      	beq.n	80021ca <prvInsertBlockIntoFreeList+0x9e>
 80021c4:	68fb      	ldr	r3, [r7, #12]
 80021c6:	687a      	ldr	r2, [r7, #4]
 80021c8:	601a      	str	r2, [r3, #0]
 80021ca:	bf00      	nop
 80021cc:	3714      	adds	r7, #20
 80021ce:	46bd      	mov	sp, r7
 80021d0:	bc80      	pop	{r7}
 80021d2:	4770      	bx	lr
 80021d4:	2000418c 	.word	0x2000418c
 80021d8:	20004194 	.word	0x20004194

080021dc <aflCall>:
 80021dc:	df3f      	svc	63	; 0x3f
 80021de:	4770      	bx	lr
 80021e0:	bf00      	nop
 80021e2:	4618      	mov	r0, r3

080021e4 <startForkserver>:
 80021e4:	b580      	push	{r7, lr}
 80021e6:	b082      	sub	sp, #8
 80021e8:	af00      	add	r7, sp, #0
 80021ea:	6078      	str	r0, [r7, #4]
 80021ec:	4b08      	ldr	r3, [pc, #32]	; (8002210 <startForkserver+0x2c>)
 80021ee:	681b      	ldr	r3, [r3, #0]
 80021f0:	2b00      	cmp	r3, #0
 80021f2:	d001      	beq.n	80021f8 <startForkserver+0x14>
 80021f4:	2300      	movs	r3, #0
 80021f6:	e006      	b.n	8002206 <startForkserver+0x22>
 80021f8:	687b      	ldr	r3, [r7, #4]
 80021fa:	2200      	movs	r2, #0
 80021fc:	4619      	mov	r1, r3
 80021fe:	2001      	movs	r0, #1
 8002200:	f7ff ffec 	bl	80021dc <aflCall>
 8002204:	4603      	mov	r3, r0
 8002206:	4618      	mov	r0, r3
 8002208:	3708      	adds	r7, #8
 800220a:	46bd      	mov	sp, r7
 800220c:	bd80      	pop	{r7, pc}
 800220e:	bf00      	nop
 8002210:	200041a4 	.word	0x200041a4

08002214 <main>:
 8002214:	b580      	push	{r7, lr}
 8002216:	af00      	add	r7, sp, #0
 8002218:	f000 fbf8 	bl	8002a0c <SystemInit>
 800221c:	2000      	movs	r0, #0
 800221e:	f7ff ffe1 	bl	80021e4 <startForkserver>
 8002222:	f000 f847 	bl	80022b4 <modbusSlaveStartTread>
 8002226:	f7fe ff55 	bl	80010d4 <vTaskStartScheduler>
 800222a:	2300      	movs	r3, #0
 800222c:	4618      	mov	r0, r3
 800222e:	bd80      	pop	{r7, pc}

08002230 <NVIC_EnableIRQ>:
 8002230:	b480      	push	{r7}
 8002232:	b083      	sub	sp, #12
 8002234:	af00      	add	r7, sp, #0
 8002236:	4603      	mov	r3, r0
 8002238:	71fb      	strb	r3, [r7, #7]
 800223a:	79fb      	ldrb	r3, [r7, #7]
 800223c:	f003 021f 	and.w	r2, r3, #31
 8002240:	4906      	ldr	r1, [pc, #24]	; (800225c <NVIC_EnableIRQ+0x2c>)
 8002242:	f997 3007 	ldrsb.w	r3, [r7, #7]
 8002246:	095b      	lsrs	r3, r3, #5
 8002248:	2001      	movs	r0, #1
 800224a:	fa00 f202 	lsl.w	r2, r0, r2
 800224e:	f841 2023 	str.w	r2, [r1, r3, lsl #2]
 8002252:	bf00      	nop
 8002254:	370c      	adds	r7, #12
 8002256:	46bd      	mov	sp, r7
 8002258:	bc80      	pop	{r7}
 800225a:	4770      	bx	lr
 800225c:	e000e100 	.word	0xe000e100

08002260 <NVIC_SetPriority>:
 8002260:	b480      	push	{r7}
 8002262:	b083      	sub	sp, #12
 8002264:	af00      	add	r7, sp, #0
 8002266:	4603      	mov	r3, r0
 8002268:	6039      	str	r1, [r7, #0]
 800226a:	71fb      	strb	r3, [r7, #7]
 800226c:	f997 3007 	ldrsb.w	r3, [r7, #7]
 8002270:	2b00      	cmp	r3, #0
 8002272:	da0b      	bge.n	800228c <NVIC_SetPriority+0x2c>
 8002274:	683b      	ldr	r3, [r7, #0]
 8002276:	b2da      	uxtb	r2, r3
 8002278:	490c      	ldr	r1, [pc, #48]	; (80022ac <NVIC_SetPriority+0x4c>)
 800227a:	79fb      	ldrb	r3, [r7, #7]
 800227c:	f003 030f 	and.w	r3, r3, #15
 8002280:	3b04      	subs	r3, #4
 8002282:	0112      	lsls	r2, r2, #4
 8002284:	b2d2      	uxtb	r2, r2
 8002286:	440b      	add	r3, r1
 8002288:	761a      	strb	r2, [r3, #24]
 800228a:	e009      	b.n	80022a0 <NVIC_SetPriority+0x40>
 800228c:	683b      	ldr	r3, [r7, #0]
 800228e:	b2da      	uxtb	r2, r3
 8002290:	4907      	ldr	r1, [pc, #28]	; (80022b0 <NVIC_SetPriority+0x50>)
 8002292:	f997 3007 	ldrsb.w	r3, [r7, #7]
 8002296:	0112      	lsls	r2, r2, #4
 8002298:	b2d2      	uxtb	r2, r2
 800229a:	440b      	add	r3, r1
 800229c:	f883 2300 	strb.w	r2, [r3, #768]	; 0x300
 80022a0:	bf00      	nop
 80022a2:	370c      	adds	r7, #12
 80022a4:	46bd      	mov	sp, r7
 80022a6:	bc80      	pop	{r7}
 80022a8:	4770      	bx	lr
 80022aa:	bf00      	nop
 80022ac:	e000ed00 	.word	0xe000ed00
 80022b0:	e000e100 	.word	0xe000e100

080022b4 <modbusSlaveStartTread>:
 80022b4:	b580      	push	{r7, lr}
 80022b6:	b082      	sub	sp, #8
 80022b8:	af02      	add	r7, sp, #8
 80022ba:	4b06      	ldr	r3, [pc, #24]	; (80022d4 <modbusSlaveStartTread+0x20>)
 80022bc:	9301      	str	r3, [sp, #4]
 80022be:	2301      	movs	r3, #1
 80022c0:	9300      	str	r3, [sp, #0]
 80022c2:	2300      	movs	r3, #0
 80022c4:	2280      	movs	r2, #128	; 0x80
 80022c6:	4904      	ldr	r1, [pc, #16]	; (80022d8 <modbusSlaveStartTread+0x24>)
 80022c8:	4804      	ldr	r0, [pc, #16]	; (80022dc <modbusSlaveStartTread+0x28>)
 80022ca:	f7fe fdcd 	bl	8000e68 <xTaskCreate>
 80022ce:	bf00      	nop
 80022d0:	46bd      	mov	sp, r7
 80022d2:	bd80      	pop	{r7, pc}
 80022d4:	200042b0 	.word	0x200042b0
 80022d8:	08002cfc 	.word	0x08002cfc
 80022dc:	080022e1 	.word	0x080022e1

080022e0 <modbusSlaveHandler>:
 80022e0:	b580      	push	{r7, lr}
 80022e2:	b084      	sub	sp, #16
 80022e4:	af00      	add	r7, sp, #0
 80022e6:	6078      	str	r0, [r7, #4]
 80022e8:	f000 f824 	bl	8002334 <modbusSlaveHardwareInit>
 80022ec:	4b10      	ldr	r3, [pc, #64]	; (8002330 <modbusSlaveHandler+0x50>)
 80022ee:	6818      	ldr	r0, [r3, #0]
 80022f0:	2300      	movs	r3, #0
 80022f2:	2201      	movs	r2, #1
 80022f4:	2100      	movs	r1, #0
 80022f6:	f7fe fc17 	bl	8000b28 <xQueueGenericReceive>
 80022fa:	f000 f9df 	bl	80026bc <modbusSlaveCheckFrameSize>
 80022fe:	4603      	mov	r3, r0
 8002300:	2b00      	cmp	r3, #0
 8002302:	d102      	bne.n	800230a <modbusSlaveHandler+0x2a>
 8002304:	f000 f9a4 	bl	8002650 <modbusSlaveStartReceiving>
 8002308:	e011      	b.n	800232e <modbusSlaveHandler+0x4e>
 800230a:	f000 f9e7 	bl	80026dc <modbusSlaveCheckID>
 800230e:	4603      	mov	r3, r0
 8002310:	2b00      	cmp	r3, #0
 8002312:	d102      	bne.n	800231a <modbusSlaveHandler+0x3a>
 8002314:	f000 f99c 	bl	8002650 <modbusSlaveStartReceiving>
 8002318:	e009      	b.n	800232e <modbusSlaveHandler+0x4e>
 800231a:	f000 f9ef 	bl	80026fc <modbusSlaveCheckCRC>
 800231e:	f000 fa73 	bl	8002808 <modbusSlaveParseFrame>
 8002322:	4603      	mov	r3, r0
 8002324:	81fb      	strh	r3, [r7, #14]
 8002326:	89fb      	ldrh	r3, [r7, #14]
 8002328:	4618      	mov	r0, r3
 800232a:	f000 f9b1 	bl	8002690 <modbusSlaveStartTransmitting>
 800232e:	e7dd      	b.n	80022ec <modbusSlaveHandler+0xc>
 8002330:	200042ac 	.word	0x200042ac

08002334 <modbusSlaveHardwareInit>:
 8002334:	b580      	push	{r7, lr}
 8002336:	b084      	sub	sp, #16
 8002338:	af00      	add	r7, sp, #0
 800233a:	2300      	movs	r3, #0
 800233c:	72fb      	strb	r3, [r7, #11]
 800233e:	2203      	movs	r2, #3
 8002340:	2100      	movs	r1, #0
 8002342:	2001      	movs	r0, #1
 8002344:	f7fe fb0a 	bl	800095c <xQueueGenericCreate>
 8002348:	4602      	mov	r2, r0
 800234a:	4b78      	ldr	r3, [pc, #480]	; (800252c <modbusSlaveHardwareInit+0x1f8>)
 800234c:	601a      	str	r2, [r3, #0]
 800234e:	4b77      	ldr	r3, [pc, #476]	; (800252c <modbusSlaveHardwareInit+0x1f8>)
 8002350:	681b      	ldr	r3, [r3, #0]
 8002352:	2b00      	cmp	r3, #0
 8002354:	d101      	bne.n	800235a <modbusSlaveHardwareInit+0x26>
 8002356:	7afb      	ldrb	r3, [r7, #11]
 8002358:	e0e4      	b.n	8002524 <modbusSlaveHardwareInit+0x1f0>
 800235a:	4b75      	ldr	r3, [pc, #468]	; (8002530 <modbusSlaveHardwareInit+0x1fc>)
 800235c:	699b      	ldr	r3, [r3, #24]
 800235e:	4a74      	ldr	r2, [pc, #464]	; (8002530 <modbusSlaveHardwareInit+0x1fc>)
 8002360:	f443 4380 	orr.w	r3, r3, #16384	; 0x4000
 8002364:	6193      	str	r3, [r2, #24]
 8002366:	4b72      	ldr	r3, [pc, #456]	; (8002530 <modbusSlaveHardwareInit+0x1fc>)
 8002368:	695b      	ldr	r3, [r3, #20]
 800236a:	4a71      	ldr	r2, [pc, #452]	; (8002530 <modbusSlaveHardwareInit+0x1fc>)
 800236c:	f443 3300 	orr.w	r3, r3, #131072	; 0x20000
 8002370:	6153      	str	r3, [r2, #20]
 8002372:	4b6f      	ldr	r3, [pc, #444]	; (8002530 <modbusSlaveHardwareInit+0x1fc>)
 8002374:	695b      	ldr	r3, [r3, #20]
 8002376:	4a6e      	ldr	r2, [pc, #440]	; (8002530 <modbusSlaveHardwareInit+0x1fc>)
 8002378:	f043 0301 	orr.w	r3, r3, #1
 800237c:	6153      	str	r3, [r2, #20]
 800237e:	f04f 4390 	mov.w	r3, #1207959552	; 0x48000000
 8002382:	681b      	ldr	r3, [r3, #0]
 8002384:	f04f 4290 	mov.w	r2, #1207959552	; 0x48000000
 8002388:	f423 1370 	bic.w	r3, r3, #3932160	; 0x3c0000
 800238c:	6013      	str	r3, [r2, #0]
 800238e:	f04f 4390 	mov.w	r3, #1207959552	; 0x48000000
 8002392:	681b      	ldr	r3, [r3, #0]
 8002394:	f04f 4290 	mov.w	r2, #1207959552	; 0x48000000
 8002398:	f443 1320 	orr.w	r3, r3, #2621440	; 0x280000
 800239c:	6013      	str	r3, [r2, #0]
 800239e:	f04f 4390 	mov.w	r3, #1207959552	; 0x48000000
 80023a2:	685b      	ldr	r3, [r3, #4]
 80023a4:	f04f 4290 	mov.w	r2, #1207959552	; 0x48000000
 80023a8:	f423 63c0 	bic.w	r3, r3, #1536	; 0x600
 80023ac:	6053      	str	r3, [r2, #4]
 80023ae:	f04f 4390 	mov.w	r3, #1207959552	; 0x48000000
 80023b2:	689b      	ldr	r3, [r3, #8]
 80023b4:	f04f 4290 	mov.w	r2, #1207959552	; 0x48000000
 80023b8:	f443 1370 	orr.w	r3, r3, #3932160	; 0x3c0000
 80023bc:	6093      	str	r3, [r2, #8]
 80023be:	f04f 4390 	mov.w	r3, #1207959552	; 0x48000000
 80023c2:	68db      	ldr	r3, [r3, #12]
 80023c4:	f04f 4290 	mov.w	r2, #1207959552	; 0x48000000
 80023c8:	f423 1370 	bic.w	r3, r3, #3932160	; 0x3c0000
 80023cc:	60d3      	str	r3, [r2, #12]
 80023ce:	f04f 4390 	mov.w	r3, #1207959552	; 0x48000000
 80023d2:	68db      	ldr	r3, [r3, #12]
 80023d4:	f04f 4290 	mov.w	r2, #1207959552	; 0x48000000
 80023d8:	f443 13a0 	orr.w	r3, r3, #1310720	; 0x140000
 80023dc:	60d3      	str	r3, [r2, #12]
 80023de:	f04f 4390 	mov.w	r3, #1207959552	; 0x48000000
 80023e2:	6a5b      	ldr	r3, [r3, #36]	; 0x24
 80023e4:	f04f 4290 	mov.w	r2, #1207959552	; 0x48000000
 80023e8:	f423 637f 	bic.w	r3, r3, #4080	; 0xff0
 80023ec:	6253      	str	r3, [r2, #36]	; 0x24
 80023ee:	f04f 4390 	mov.w	r3, #1207959552	; 0x48000000
 80023f2:	6a5b      	ldr	r3, [r3, #36]	; 0x24
 80023f4:	f04f 4290 	mov.w	r2, #1207959552	; 0x48000000
 80023f8:	f443 63ee 	orr.w	r3, r3, #1904	; 0x770
 80023fc:	6253      	str	r3, [r2, #36]	; 0x24
 80023fe:	2000      	movs	r0, #0
 8002400:	f7fe f834 	bl	800046c <LL_RCC_GetUSARTClockFreq>
 8002404:	6078      	str	r0, [r7, #4]
 8002406:	687b      	ldr	r3, [r7, #4]
 8002408:	4a4a      	ldr	r2, [pc, #296]	; (8002534 <modbusSlaveHardwareInit+0x200>)
 800240a:	fba2 2303 	umull	r2, r3, r2, r3
 800240e:	0c1b      	lsrs	r3, r3, #16
 8002410:	60fb      	str	r3, [r7, #12]
 8002412:	687b      	ldr	r3, [r7, #4]
 8002414:	4a47      	ldr	r2, [pc, #284]	; (8002534 <modbusSlaveHardwareInit+0x200>)
 8002416:	fba2 1203 	umull	r1, r2, r2, r3
 800241a:	0c12      	lsrs	r2, r2, #16
 800241c:	f44f 31e1 	mov.w	r1, #115200	; 0x1c200
 8002420:	fb01 f202 	mul.w	r2, r1, r2
 8002424:	1a9b      	subs	r3, r3, r2
 8002426:	603b      	str	r3, [r7, #0]
 8002428:	683b      	ldr	r3, [r7, #0]
 800242a:	f5b3 4f61 	cmp.w	r3, #57600	; 0xe100
 800242e:	d902      	bls.n	8002436 <modbusSlaveHardwareInit+0x102>
 8002430:	68fb      	ldr	r3, [r7, #12]
 8002432:	3301      	adds	r3, #1
 8002434:	60fb      	str	r3, [r7, #12]
 8002436:	4b40      	ldr	r3, [pc, #256]	; (8002538 <modbusSlaveHardwareInit+0x204>)
 8002438:	681b      	ldr	r3, [r3, #0]
 800243a:	4b3f      	ldr	r3, [pc, #252]	; (8002538 <modbusSlaveHardwareInit+0x204>)
 800243c:	2200      	movs	r2, #0
 800243e:	601a      	str	r2, [r3, #0]
 8002440:	4b3d      	ldr	r3, [pc, #244]	; (8002538 <modbusSlaveHardwareInit+0x204>)
 8002442:	685b      	ldr	r3, [r3, #4]
 8002444:	4b3c      	ldr	r3, [pc, #240]	; (8002538 <modbusSlaveHardwareInit+0x204>)
 8002446:	2200      	movs	r2, #0
 8002448:	605a      	str	r2, [r3, #4]
 800244a:	4b3b      	ldr	r3, [pc, #236]	; (8002538 <modbusSlaveHardwareInit+0x204>)
 800244c:	689b      	ldr	r3, [r3, #8]
 800244e:	4b3a      	ldr	r3, [pc, #232]	; (8002538 <modbusSlaveHardwareInit+0x204>)
 8002450:	2200      	movs	r2, #0
 8002452:	609a      	str	r2, [r3, #8]
 8002454:	4a38      	ldr	r2, [pc, #224]	; (8002538 <modbusSlaveHardwareInit+0x204>)
 8002456:	68fb      	ldr	r3, [r7, #12]
 8002458:	60d3      	str	r3, [r2, #12]
 800245a:	4b37      	ldr	r3, [pc, #220]	; (8002538 <modbusSlaveHardwareInit+0x204>)
 800245c:	681b      	ldr	r3, [r3, #0]
 800245e:	4a36      	ldr	r2, [pc, #216]	; (8002538 <modbusSlaveHardwareInit+0x204>)
 8002460:	f043 6380 	orr.w	r3, r3, #67108864	; 0x4000000
 8002464:	f043 030c 	orr.w	r3, r3, #12
 8002468:	6013      	str	r3, [r2, #0]
 800246a:	4b33      	ldr	r3, [pc, #204]	; (8002538 <modbusSlaveHardwareInit+0x204>)
 800246c:	685b      	ldr	r3, [r3, #4]
 800246e:	4a32      	ldr	r2, [pc, #200]	; (8002538 <modbusSlaveHardwareInit+0x204>)
 8002470:	f443 0300 	orr.w	r3, r3, #8388608	; 0x800000
 8002474:	6053      	str	r3, [r2, #4]
 8002476:	4b30      	ldr	r3, [pc, #192]	; (8002538 <modbusSlaveHardwareInit+0x204>)
 8002478:	689b      	ldr	r3, [r3, #8]
 800247a:	4a2f      	ldr	r2, [pc, #188]	; (8002538 <modbusSlaveHardwareInit+0x204>)
 800247c:	f043 03c0 	orr.w	r3, r3, #192	; 0xc0
 8002480:	6093      	str	r3, [r2, #8]
 8002482:	4b2d      	ldr	r3, [pc, #180]	; (8002538 <modbusSlaveHardwareInit+0x204>)
 8002484:	221e      	movs	r2, #30
 8002486:	615a      	str	r2, [r3, #20]
 8002488:	2107      	movs	r1, #7
 800248a:	2025      	movs	r0, #37	; 0x25
 800248c:	f7ff fee8 	bl	8002260 <NVIC_SetPriority>
 8002490:	2025      	movs	r0, #37	; 0x25
 8002492:	f7ff fecd 	bl	8002230 <NVIC_EnableIRQ>
 8002496:	4b29      	ldr	r3, [pc, #164]	; (800253c <modbusSlaveHardwareInit+0x208>)
 8002498:	681b      	ldr	r3, [r3, #0]
 800249a:	4b28      	ldr	r3, [pc, #160]	; (800253c <modbusSlaveHardwareInit+0x208>)
 800249c:	2200      	movs	r2, #0
 800249e:	601a      	str	r2, [r3, #0]
 80024a0:	4b26      	ldr	r3, [pc, #152]	; (800253c <modbusSlaveHardwareInit+0x208>)
 80024a2:	681b      	ldr	r3, [r3, #0]
 80024a4:	4a25      	ldr	r2, [pc, #148]	; (800253c <modbusSlaveHardwareInit+0x208>)
 80024a6:	f443 5342 	orr.w	r3, r3, #12416	; 0x3080
 80024aa:	f043 0302 	orr.w	r3, r3, #2
 80024ae:	6013      	str	r3, [r2, #0]
 80024b0:	4b22      	ldr	r3, [pc, #136]	; (800253c <modbusSlaveHardwareInit+0x208>)
 80024b2:	f44f 7280 	mov.w	r2, #256	; 0x100
 80024b6:	605a      	str	r2, [r3, #4]
 80024b8:	4b20      	ldr	r3, [pc, #128]	; (800253c <modbusSlaveHardwareInit+0x208>)
 80024ba:	4a21      	ldr	r2, [pc, #132]	; (8002540 <modbusSlaveHardwareInit+0x20c>)
 80024bc:	609a      	str	r2, [r3, #8]
 80024be:	4b1f      	ldr	r3, [pc, #124]	; (800253c <modbusSlaveHardwareInit+0x208>)
 80024c0:	4a20      	ldr	r2, [pc, #128]	; (8002544 <modbusSlaveHardwareInit+0x210>)
 80024c2:	60da      	str	r2, [r3, #12]
 80024c4:	2107      	movs	r1, #7
 80024c6:	200f      	movs	r0, #15
 80024c8:	f7ff feca 	bl	8002260 <NVIC_SetPriority>
 80024cc:	200f      	movs	r0, #15
 80024ce:	f7ff feaf 	bl	8002230 <NVIC_EnableIRQ>
 80024d2:	4b1d      	ldr	r3, [pc, #116]	; (8002548 <modbusSlaveHardwareInit+0x214>)
 80024d4:	681b      	ldr	r3, [r3, #0]
 80024d6:	4b1c      	ldr	r3, [pc, #112]	; (8002548 <modbusSlaveHardwareInit+0x214>)
 80024d8:	2200      	movs	r2, #0
 80024da:	601a      	str	r2, [r3, #0]
 80024dc:	4b1a      	ldr	r3, [pc, #104]	; (8002548 <modbusSlaveHardwareInit+0x214>)
 80024de:	681b      	ldr	r3, [r3, #0]
 80024e0:	4a19      	ldr	r2, [pc, #100]	; (8002548 <modbusSlaveHardwareInit+0x214>)
 80024e2:	f443 5342 	orr.w	r3, r3, #12416	; 0x3080
 80024e6:	f043 0312 	orr.w	r3, r3, #18
 80024ea:	6013      	str	r3, [r2, #0]
 80024ec:	4b16      	ldr	r3, [pc, #88]	; (8002548 <modbusSlaveHardwareInit+0x214>)
 80024ee:	4a17      	ldr	r2, [pc, #92]	; (800254c <modbusSlaveHardwareInit+0x218>)
 80024f0:	609a      	str	r2, [r3, #8]
 80024f2:	4b15      	ldr	r3, [pc, #84]	; (8002548 <modbusSlaveHardwareInit+0x214>)
 80024f4:	4a13      	ldr	r2, [pc, #76]	; (8002544 <modbusSlaveHardwareInit+0x210>)
 80024f6:	60da      	str	r2, [r3, #12]
 80024f8:	2107      	movs	r1, #7
 80024fa:	200e      	movs	r0, #14
 80024fc:	f7ff feb0 	bl	8002260 <NVIC_SetPriority>
 8002500:	200e      	movs	r0, #14
 8002502:	f7ff fe95 	bl	8002230 <NVIC_EnableIRQ>
 8002506:	4b0c      	ldr	r3, [pc, #48]	; (8002538 <modbusSlaveHardwareInit+0x204>)
 8002508:	681b      	ldr	r3, [r3, #0]
 800250a:	4a0b      	ldr	r2, [pc, #44]	; (8002538 <modbusSlaveHardwareInit+0x204>)
 800250c:	f043 0301 	orr.w	r3, r3, #1
 8002510:	6013      	str	r3, [r2, #0]
 8002512:	4b0a      	ldr	r3, [pc, #40]	; (800253c <modbusSlaveHardwareInit+0x208>)
 8002514:	681b      	ldr	r3, [r3, #0]
 8002516:	4a09      	ldr	r2, [pc, #36]	; (800253c <modbusSlaveHardwareInit+0x208>)
 8002518:	f043 0301 	orr.w	r3, r3, #1
 800251c:	6013      	str	r3, [r2, #0]
 800251e:	2301      	movs	r3, #1
 8002520:	72fb      	strb	r3, [r7, #11]
 8002522:	7afb      	ldrb	r3, [r7, #11]
 8002524:	4618      	mov	r0, r3
 8002526:	3710      	adds	r7, #16
 8002528:	46bd      	mov	sp, r7
 800252a:	bd80      	pop	{r7, pc}
 800252c:	200042ac 	.word	0x200042ac
 8002530:	40021000 	.word	0x40021000
 8002534:	91a2b3c5 	.word	0x91a2b3c5
 8002538:	40013800 	.word	0x40013800
 800253c:	40020058 	.word	0x40020058
 8002540:	40013824 	.word	0x40013824
 8002544:	200041a8 	.word	0x200041a8
 8002548:	40020044 	.word	0x40020044
 800254c:	40013828 	.word	0x40013828

08002550 <DMA1_Channel4_IRQHandler>:
 8002550:	b580      	push	{r7, lr}
 8002552:	af00      	add	r7, sp, #0
 8002554:	4b07      	ldr	r3, [pc, #28]	; (8002574 <DMA1_Channel4_IRQHandler+0x24>)
 8002556:	685b      	ldr	r3, [r3, #4]
 8002558:	4a06      	ldr	r2, [pc, #24]	; (8002574 <DMA1_Channel4_IRQHandler+0x24>)
 800255a:	f443 5300 	orr.w	r3, r3, #8192	; 0x2000
 800255e:	6053      	str	r3, [r2, #4]
 8002560:	4b05      	ldr	r3, [pc, #20]	; (8002578 <DMA1_Channel4_IRQHandler+0x28>)
 8002562:	681b      	ldr	r3, [r3, #0]
 8002564:	4a04      	ldr	r2, [pc, #16]	; (8002578 <DMA1_Channel4_IRQHandler+0x28>)
 8002566:	f023 0301 	bic.w	r3, r3, #1
 800256a:	6013      	str	r3, [r2, #0]
 800256c:	f000 f870 	bl	8002650 <modbusSlaveStartReceiving>
 8002570:	bf00      	nop
 8002572:	bd80      	pop	{r7, pc}
 8002574:	40020000 	.word	0x40020000
 8002578:	40020044 	.word	0x40020044

0800257c <DMA1_Channel5_IRQHandler>:
 800257c:	b580      	push	{r7, lr}
 800257e:	af00      	add	r7, sp, #0
 8002580:	4b0e      	ldr	r3, [pc, #56]	; (80025bc <DMA1_Channel5_IRQHandler+0x40>)
 8002582:	685b      	ldr	r3, [r3, #4]
 8002584:	4a0d      	ldr	r2, [pc, #52]	; (80025bc <DMA1_Channel5_IRQHandler+0x40>)
 8002586:	f443 3300 	orr.w	r3, r3, #131072	; 0x20000
 800258a:	6053      	str	r3, [r2, #4]
 800258c:	4b0c      	ldr	r3, [pc, #48]	; (80025c0 <DMA1_Channel5_IRQHandler+0x44>)
 800258e:	681b      	ldr	r3, [r3, #0]
 8002590:	4a0b      	ldr	r2, [pc, #44]	; (80025c0 <DMA1_Channel5_IRQHandler+0x44>)
 8002592:	f023 0301 	bic.w	r3, r3, #1
 8002596:	6013      	str	r3, [r2, #0]
 8002598:	4b0a      	ldr	r3, [pc, #40]	; (80025c4 <DMA1_Channel5_IRQHandler+0x48>)
 800259a:	681b      	ldr	r3, [r3, #0]
 800259c:	4a09      	ldr	r2, [pc, #36]	; (80025c4 <DMA1_Channel5_IRQHandler+0x48>)
 800259e:	f023 6380 	bic.w	r3, r3, #67108864	; 0x4000000
 80025a2:	6013      	str	r3, [r2, #0]
 80025a4:	4b08      	ldr	r3, [pc, #32]	; (80025c8 <DMA1_Channel5_IRQHandler+0x4c>)
 80025a6:	f44f 7280 	mov.w	r2, #256	; 0x100
 80025aa:	801a      	strh	r2, [r3, #0]
 80025ac:	4b07      	ldr	r3, [pc, #28]	; (80025cc <DMA1_Channel5_IRQHandler+0x50>)
 80025ae:	681b      	ldr	r3, [r3, #0]
 80025b0:	2100      	movs	r1, #0
 80025b2:	4618      	mov	r0, r3
 80025b4:	f7fe fa2e 	bl	8000a14 <xQueueGiveFromISR>
 80025b8:	bf00      	nop
 80025ba:	bd80      	pop	{r7, pc}
 80025bc:	40020000 	.word	0x40020000
 80025c0:	40020058 	.word	0x40020058
 80025c4:	40013800 	.word	0x40013800
 80025c8:	200042a8 	.word	0x200042a8
 80025cc:	200042ac 	.word	0x200042ac

080025d0 <USART1_IRQHandler>:
 80025d0:	b580      	push	{r7, lr}
 80025d2:	af00      	add	r7, sp, #0
 80025d4:	4b19      	ldr	r3, [pc, #100]	; (800263c <USART1_IRQHandler+0x6c>)
 80025d6:	2200      	movs	r2, #0
 80025d8:	801a      	strh	r2, [r3, #0]
 80025da:	4b19      	ldr	r3, [pc, #100]	; (8002640 <USART1_IRQHandler+0x70>)
 80025dc:	69db      	ldr	r3, [r3, #28]
 80025de:	f403 6300 	and.w	r3, r3, #2048	; 0x800
 80025e2:	2b00      	cmp	r3, #0
 80025e4:	d028      	beq.n	8002638 <USART1_IRQHandler+0x68>
 80025e6:	4b16      	ldr	r3, [pc, #88]	; (8002640 <USART1_IRQHandler+0x70>)
 80025e8:	6a1b      	ldr	r3, [r3, #32]
 80025ea:	4a15      	ldr	r2, [pc, #84]	; (8002640 <USART1_IRQHandler+0x70>)
 80025ec:	f443 6300 	orr.w	r3, r3, #2048	; 0x800
 80025f0:	6213      	str	r3, [r2, #32]
 80025f2:	4b13      	ldr	r3, [pc, #76]	; (8002640 <USART1_IRQHandler+0x70>)
 80025f4:	681b      	ldr	r3, [r3, #0]
 80025f6:	4a12      	ldr	r2, [pc, #72]	; (8002640 <USART1_IRQHandler+0x70>)
 80025f8:	f023 6380 	bic.w	r3, r3, #67108864	; 0x4000000
 80025fc:	6013      	str	r3, [r2, #0]
 80025fe:	4b11      	ldr	r3, [pc, #68]	; (8002644 <USART1_IRQHandler+0x74>)
 8002600:	685b      	ldr	r3, [r3, #4]
 8002602:	b29b      	uxth	r3, r3
 8002604:	f5c3 7380 	rsb	r3, r3, #256	; 0x100
 8002608:	b29a      	uxth	r2, r3
 800260a:	4b0f      	ldr	r3, [pc, #60]	; (8002648 <USART1_IRQHandler+0x78>)
 800260c:	801a      	strh	r2, [r3, #0]
 800260e:	4b0d      	ldr	r3, [pc, #52]	; (8002644 <USART1_IRQHandler+0x74>)
 8002610:	681b      	ldr	r3, [r3, #0]
 8002612:	4a0c      	ldr	r2, [pc, #48]	; (8002644 <USART1_IRQHandler+0x74>)
 8002614:	f023 0301 	bic.w	r3, r3, #1
 8002618:	6013      	str	r3, [r2, #0]
 800261a:	4b09      	ldr	r3, [pc, #36]	; (8002640 <USART1_IRQHandler+0x70>)
 800261c:	8c9b      	ldrh	r3, [r3, #36]	; 0x24
 800261e:	b29a      	uxth	r2, r3
 8002620:	4b06      	ldr	r3, [pc, #24]	; (800263c <USART1_IRQHandler+0x6c>)
 8002622:	881b      	ldrh	r3, [r3, #0]
 8002624:	4413      	add	r3, r2
 8002626:	b29a      	uxth	r2, r3
 8002628:	4b04      	ldr	r3, [pc, #16]	; (800263c <USART1_IRQHandler+0x6c>)
 800262a:	801a      	strh	r2, [r3, #0]
 800262c:	4b07      	ldr	r3, [pc, #28]	; (800264c <USART1_IRQHandler+0x7c>)
 800262e:	681b      	ldr	r3, [r3, #0]
 8002630:	2100      	movs	r1, #0
 8002632:	4618      	mov	r0, r3
 8002634:	f7fe f9ee 	bl	8000a14 <xQueueGiveFromISR>
 8002638:	bf00      	nop
 800263a:	bd80      	pop	{r7, pc}
 800263c:	200042b4 	.word	0x200042b4
 8002640:	40013800 	.word	0x40013800
 8002644:	40020058 	.word	0x40020058
 8002648:	200042a8 	.word	0x200042a8
 800264c:	200042ac 	.word	0x200042ac

08002650 <modbusSlaveStartReceiving>:
 8002650:	b480      	push	{r7}
 8002652:	af00      	add	r7, sp, #0
 8002654:	4b0b      	ldr	r3, [pc, #44]	; (8002684 <modbusSlaveStartReceiving+0x34>)
 8002656:	f44f 7280 	mov.w	r2, #256	; 0x100
 800265a:	605a      	str	r2, [r3, #4]
 800265c:	4b09      	ldr	r3, [pc, #36]	; (8002684 <modbusSlaveStartReceiving+0x34>)
 800265e:	681b      	ldr	r3, [r3, #0]
 8002660:	4a08      	ldr	r2, [pc, #32]	; (8002684 <modbusSlaveStartReceiving+0x34>)
 8002662:	f043 0301 	orr.w	r3, r3, #1
 8002666:	6013      	str	r3, [r2, #0]
 8002668:	4b07      	ldr	r3, [pc, #28]	; (8002688 <modbusSlaveStartReceiving+0x38>)
 800266a:	681b      	ldr	r3, [r3, #0]
 800266c:	4a06      	ldr	r2, [pc, #24]	; (8002688 <modbusSlaveStartReceiving+0x38>)
 800266e:	f043 6380 	orr.w	r3, r3, #67108864	; 0x4000000
 8002672:	6013      	str	r3, [r2, #0]
 8002674:	4b05      	ldr	r3, [pc, #20]	; (800268c <modbusSlaveStartReceiving+0x3c>)
 8002676:	2200      	movs	r2, #0
 8002678:	801a      	strh	r2, [r3, #0]
 800267a:	bf00      	nop
 800267c:	46bd      	mov	sp, r7
 800267e:	bc80      	pop	{r7}
 8002680:	4770      	bx	lr
 8002682:	bf00      	nop
 8002684:	40020058 	.word	0x40020058
 8002688:	40013800 	.word	0x40013800
 800268c:	200042a8 	.word	0x200042a8

08002690 <modbusSlaveStartTransmitting>:
 8002690:	b480      	push	{r7}
 8002692:	b083      	sub	sp, #12
 8002694:	af00      	add	r7, sp, #0
 8002696:	4603      	mov	r3, r0
 8002698:	80fb      	strh	r3, [r7, #6]
 800269a:	4a07      	ldr	r2, [pc, #28]	; (80026b8 <modbusSlaveStartTransmitting+0x28>)
 800269c:	88fb      	ldrh	r3, [r7, #6]
 800269e:	6053      	str	r3, [r2, #4]
 80026a0:	4b05      	ldr	r3, [pc, #20]	; (80026b8 <modbusSlaveStartTransmitting+0x28>)
 80026a2:	681b      	ldr	r3, [r3, #0]
 80026a4:	4a04      	ldr	r2, [pc, #16]	; (80026b8 <modbusSlaveStartTransmitting+0x28>)
 80026a6:	f043 0301 	orr.w	r3, r3, #1
 80026aa:	6013      	str	r3, [r2, #0]
 80026ac:	bf00      	nop
 80026ae:	370c      	adds	r7, #12
 80026b0:	46bd      	mov	sp, r7
 80026b2:	bc80      	pop	{r7}
 80026b4:	4770      	bx	lr
 80026b6:	bf00      	nop
 80026b8:	40020044 	.word	0x40020044

080026bc <modbusSlaveCheckFrameSize>:
 80026bc:	b480      	push	{r7}
 80026be:	af00      	add	r7, sp, #0
 80026c0:	4b05      	ldr	r3, [pc, #20]	; (80026d8 <modbusSlaveCheckFrameSize+0x1c>)
 80026c2:	881b      	ldrh	r3, [r3, #0]
 80026c4:	b29b      	uxth	r3, r3
 80026c6:	2b05      	cmp	r3, #5
 80026c8:	d901      	bls.n	80026ce <modbusSlaveCheckFrameSize+0x12>
 80026ca:	2301      	movs	r3, #1
 80026cc:	e000      	b.n	80026d0 <modbusSlaveCheckFrameSize+0x14>
 80026ce:	2300      	movs	r3, #0
 80026d0:	4618      	mov	r0, r3
 80026d2:	46bd      	mov	sp, r7
 80026d4:	bc80      	pop	{r7}
 80026d6:	4770      	bx	lr
 80026d8:	200042a8 	.word	0x200042a8

080026dc <modbusSlaveCheckID>:
 80026dc:	b480      	push	{r7}
 80026de:	af00      	add	r7, sp, #0
 80026e0:	4b05      	ldr	r3, [pc, #20]	; (80026f8 <modbusSlaveCheckID+0x1c>)
 80026e2:	781b      	ldrb	r3, [r3, #0]
 80026e4:	2b01      	cmp	r3, #1
 80026e6:	d101      	bne.n	80026ec <modbusSlaveCheckID+0x10>
 80026e8:	2301      	movs	r3, #1
 80026ea:	e000      	b.n	80026ee <modbusSlaveCheckID+0x12>
 80026ec:	2300      	movs	r3, #0
 80026ee:	4618      	mov	r0, r3
 80026f0:	46bd      	mov	sp, r7
 80026f2:	bc80      	pop	{r7}
 80026f4:	4770      	bx	lr
 80026f6:	bf00      	nop
 80026f8:	200041a8 	.word	0x200041a8

080026fc <modbusSlaveCheckCRC>:
 80026fc:	b580      	push	{r7, lr}
 80026fe:	b082      	sub	sp, #8
 8002700:	af00      	add	r7, sp, #0
 8002702:	4b14      	ldr	r3, [pc, #80]	; (8002754 <modbusSlaveCheckCRC+0x58>)
 8002704:	881b      	ldrh	r3, [r3, #0]
 8002706:	b29b      	uxth	r3, r3
 8002708:	3b01      	subs	r3, #1
 800270a:	4a13      	ldr	r2, [pc, #76]	; (8002758 <modbusSlaveCheckCRC+0x5c>)
 800270c:	5cd3      	ldrb	r3, [r2, r3]
 800270e:	021b      	lsls	r3, r3, #8
 8002710:	b21a      	sxth	r2, r3
 8002712:	4b10      	ldr	r3, [pc, #64]	; (8002754 <modbusSlaveCheckCRC+0x58>)
 8002714:	881b      	ldrh	r3, [r3, #0]
 8002716:	b29b      	uxth	r3, r3
 8002718:	3b02      	subs	r3, #2
 800271a:	490f      	ldr	r1, [pc, #60]	; (8002758 <modbusSlaveCheckCRC+0x5c>)
 800271c:	5ccb      	ldrb	r3, [r1, r3]
 800271e:	b21b      	sxth	r3, r3
 8002720:	4313      	orrs	r3, r2
 8002722:	b21b      	sxth	r3, r3
 8002724:	80fb      	strh	r3, [r7, #6]
 8002726:	4b0b      	ldr	r3, [pc, #44]	; (8002754 <modbusSlaveCheckCRC+0x58>)
 8002728:	881b      	ldrh	r3, [r3, #0]
 800272a:	b29b      	uxth	r3, r3
 800272c:	3b02      	subs	r3, #2
 800272e:	b29b      	uxth	r3, r3
 8002730:	4619      	mov	r1, r3
 8002732:	4809      	ldr	r0, [pc, #36]	; (8002758 <modbusSlaveCheckCRC+0x5c>)
 8002734:	f000 f812 	bl	800275c <modbusSlaveGetCRC>
 8002738:	4603      	mov	r3, r0
 800273a:	80bb      	strh	r3, [r7, #4]
 800273c:	88fa      	ldrh	r2, [r7, #6]
 800273e:	88bb      	ldrh	r3, [r7, #4]
 8002740:	429a      	cmp	r2, r3
 8002742:	d101      	bne.n	8002748 <modbusSlaveCheckCRC+0x4c>
 8002744:	2301      	movs	r3, #1
 8002746:	e000      	b.n	800274a <modbusSlaveCheckCRC+0x4e>
 8002748:	2300      	movs	r3, #0
 800274a:	4618      	mov	r0, r3
 800274c:	3708      	adds	r7, #8
 800274e:	46bd      	mov	sp, r7
 8002750:	bd80      	pop	{r7, pc}
 8002752:	bf00      	nop
 8002754:	200042a8 	.word	0x200042a8
 8002758:	200041a8 	.word	0x200041a8

0800275c <modbusSlaveGetCRC>:
 800275c:	b480      	push	{r7}
 800275e:	b085      	sub	sp, #20
 8002760:	af00      	add	r7, sp, #0
 8002762:	6078      	str	r0, [r7, #4]
 8002764:	460b      	mov	r3, r1
 8002766:	807b      	strh	r3, [r7, #2]
 8002768:	f64f 73ff 	movw	r3, #65535	; 0xffff
 800276c:	81fb      	strh	r3, [r7, #14]
 800276e:	2300      	movs	r3, #0
 8002770:	81bb      	strh	r3, [r7, #12]
 8002772:	e026      	b.n	80027c2 <modbusSlaveGetCRC+0x66>
 8002774:	89bb      	ldrh	r3, [r7, #12]
 8002776:	687a      	ldr	r2, [r7, #4]
 8002778:	4413      	add	r3, r2
 800277a:	781b      	ldrb	r3, [r3, #0]
 800277c:	b29a      	uxth	r2, r3
 800277e:	89fb      	ldrh	r3, [r7, #14]
 8002780:	4053      	eors	r3, r2
 8002782:	81fb      	strh	r3, [r7, #14]
 8002784:	2308      	movs	r3, #8
 8002786:	60bb      	str	r3, [r7, #8]
 8002788:	e015      	b.n	80027b6 <modbusSlaveGetCRC+0x5a>
 800278a:	89fb      	ldrh	r3, [r7, #14]
 800278c:	f003 0301 	and.w	r3, r3, #1
 8002790:	2b00      	cmp	r3, #0
 8002792:	d00a      	beq.n	80027aa <modbusSlaveGetCRC+0x4e>
 8002794:	89fb      	ldrh	r3, [r7, #14]
 8002796:	085b      	lsrs	r3, r3, #1
 8002798:	81fb      	strh	r3, [r7, #14]
 800279a:	89fb      	ldrh	r3, [r7, #14]
 800279c:	f483 43bf 	eor.w	r3, r3, #24448	; 0x5f80
 80027a0:	f083 037e 	eor.w	r3, r3, #126	; 0x7e
 80027a4:	43db      	mvns	r3, r3
 80027a6:	81fb      	strh	r3, [r7, #14]
 80027a8:	e002      	b.n	80027b0 <modbusSlaveGetCRC+0x54>
 80027aa:	89fb      	ldrh	r3, [r7, #14]
 80027ac:	085b      	lsrs	r3, r3, #1
 80027ae:	81fb      	strh	r3, [r7, #14]
 80027b0:	68bb      	ldr	r3, [r7, #8]
 80027b2:	3b01      	subs	r3, #1
 80027b4:	60bb      	str	r3, [r7, #8]
 80027b6:	68bb      	ldr	r3, [r7, #8]
 80027b8:	2b00      	cmp	r3, #0
 80027ba:	d1e6      	bne.n	800278a <modbusSlaveGetCRC+0x2e>
 80027bc:	89bb      	ldrh	r3, [r7, #12]
 80027be:	3301      	adds	r3, #1
 80027c0:	81bb      	strh	r3, [r7, #12]
 80027c2:	89ba      	ldrh	r2, [r7, #12]
 80027c4:	887b      	ldrh	r3, [r7, #2]
 80027c6:	429a      	cmp	r2, r3
 80027c8:	d3d4      	bcc.n	8002774 <modbusSlaveGetCRC+0x18>
 80027ca:	89fb      	ldrh	r3, [r7, #14]
 80027cc:	4618      	mov	r0, r3
 80027ce:	3714      	adds	r7, #20
 80027d0:	46bd      	mov	sp, r7
 80027d2:	bc80      	pop	{r7}
 80027d4:	4770      	bx	lr
	...

080027d8 <modbusSlaveErrorSet>:
 80027d8:	b480      	push	{r7}
 80027da:	b083      	sub	sp, #12
 80027dc:	af00      	add	r7, sp, #0
 80027de:	4603      	mov	r3, r0
 80027e0:	71fb      	strb	r3, [r7, #7]
 80027e2:	4b08      	ldr	r3, [pc, #32]	; (8002804 <modbusSlaveErrorSet+0x2c>)
 80027e4:	785b      	ldrb	r3, [r3, #1]
 80027e6:	f063 037f 	orn	r3, r3, #127	; 0x7f
 80027ea:	b2da      	uxtb	r2, r3
 80027ec:	4b05      	ldr	r3, [pc, #20]	; (8002804 <modbusSlaveErrorSet+0x2c>)
 80027ee:	705a      	strb	r2, [r3, #1]
 80027f0:	4a04      	ldr	r2, [pc, #16]	; (8002804 <modbusSlaveErrorSet+0x2c>)
 80027f2:	79fb      	ldrb	r3, [r7, #7]
 80027f4:	7093      	strb	r3, [r2, #2]
 80027f6:	2305      	movs	r3, #5
 80027f8:	4618      	mov	r0, r3
 80027fa:	370c      	adds	r7, #12
 80027fc:	46bd      	mov	sp, r7
 80027fe:	bc80      	pop	{r7}
 8002800:	4770      	bx	lr
 8002802:	bf00      	nop
 8002804:	200041a8 	.word	0x200041a8

08002808 <modbusSlaveParseFrame>:
 8002808:	b580      	push	{r7, lr}
 800280a:	b086      	sub	sp, #24
 800280c:	af00      	add	r7, sp, #0
 800280e:	4b77      	ldr	r3, [pc, #476]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 8002810:	785b      	ldrb	r3, [r3, #1]
 8002812:	747b      	strb	r3, [r7, #17]
 8002814:	2300      	movs	r3, #0
 8002816:	82fb      	strh	r3, [r7, #22]
 8002818:	7c7b      	ldrb	r3, [r7, #17]
 800281a:	2b03      	cmp	r3, #3
 800281c:	d152      	bne.n	80028c4 <modbusSlaveParseFrame+0xbc>
 800281e:	4b73      	ldr	r3, [pc, #460]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 8002820:	789b      	ldrb	r3, [r3, #2]
 8002822:	021b      	lsls	r3, r3, #8
 8002824:	b21a      	sxth	r2, r3
 8002826:	4b71      	ldr	r3, [pc, #452]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 8002828:	78db      	ldrb	r3, [r3, #3]
 800282a:	b21b      	sxth	r3, r3
 800282c:	4313      	orrs	r3, r2
 800282e:	b21b      	sxth	r3, r3
 8002830:	813b      	strh	r3, [r7, #8]
 8002832:	4b6e      	ldr	r3, [pc, #440]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 8002834:	791b      	ldrb	r3, [r3, #4]
 8002836:	021b      	lsls	r3, r3, #8
 8002838:	b21a      	sxth	r2, r3
 800283a:	4b6c      	ldr	r3, [pc, #432]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 800283c:	795b      	ldrb	r3, [r3, #5]
 800283e:	b21b      	sxth	r3, r3
 8002840:	4313      	orrs	r3, r2
 8002842:	b21b      	sxth	r3, r3
 8002844:	80fb      	strh	r3, [r7, #6]
 8002846:	893a      	ldrh	r2, [r7, #8]
 8002848:	88fb      	ldrh	r3, [r7, #6]
 800284a:	4413      	add	r3, r2
 800284c:	f5b3 7f80 	cmp.w	r3, #256	; 0x100
 8002850:	dc02      	bgt.n	8002858 <modbusSlaveParseFrame+0x50>
 8002852:	88fb      	ldrh	r3, [r7, #6]
 8002854:	2b7e      	cmp	r3, #126	; 0x7e
 8002856:	d905      	bls.n	8002864 <modbusSlaveParseFrame+0x5c>
 8002858:	2002      	movs	r0, #2
 800285a:	f7ff ffbd 	bl	80027d8 <modbusSlaveErrorSet>
 800285e:	4603      	mov	r3, r0
 8002860:	82fb      	strh	r3, [r7, #22]
 8002862:	e0a6      	b.n	80029b2 <modbusSlaveParseFrame+0x1aa>
 8002864:	2300      	movs	r3, #0
 8002866:	82bb      	strh	r3, [r7, #20]
 8002868:	e01c      	b.n	80028a4 <modbusSlaveParseFrame+0x9c>
 800286a:	893a      	ldrh	r2, [r7, #8]
 800286c:	8abb      	ldrh	r3, [r7, #20]
 800286e:	4413      	add	r3, r2
 8002870:	4a5f      	ldr	r2, [pc, #380]	; (80029f0 <modbusSlaveParseFrame+0x1e8>)
 8002872:	f832 3013 	ldrh.w	r3, [r2, r3, lsl #1]
 8002876:	0a1b      	lsrs	r3, r3, #8
 8002878:	b29a      	uxth	r2, r3
 800287a:	8abb      	ldrh	r3, [r7, #20]
 800287c:	005b      	lsls	r3, r3, #1
 800287e:	3303      	adds	r3, #3
 8002880:	b2d1      	uxtb	r1, r2
 8002882:	4a5a      	ldr	r2, [pc, #360]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 8002884:	54d1      	strb	r1, [r2, r3]
 8002886:	893a      	ldrh	r2, [r7, #8]
 8002888:	8abb      	ldrh	r3, [r7, #20]
 800288a:	4413      	add	r3, r2
 800288c:	4a58      	ldr	r2, [pc, #352]	; (80029f0 <modbusSlaveParseFrame+0x1e8>)
 800288e:	f832 2013 	ldrh.w	r2, [r2, r3, lsl #1]
 8002892:	8abb      	ldrh	r3, [r7, #20]
 8002894:	005b      	lsls	r3, r3, #1
 8002896:	3304      	adds	r3, #4
 8002898:	b2d1      	uxtb	r1, r2
 800289a:	4a54      	ldr	r2, [pc, #336]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 800289c:	54d1      	strb	r1, [r2, r3]
 800289e:	8abb      	ldrh	r3, [r7, #20]
 80028a0:	3301      	adds	r3, #1
 80028a2:	82bb      	strh	r3, [r7, #20]
 80028a4:	8aba      	ldrh	r2, [r7, #20]
 80028a6:	88fb      	ldrh	r3, [r7, #6]
 80028a8:	429a      	cmp	r2, r3
 80028aa:	d3de      	bcc.n	800286a <modbusSlaveParseFrame+0x62>
 80028ac:	88fb      	ldrh	r3, [r7, #6]
 80028ae:	b2db      	uxtb	r3, r3
 80028b0:	005b      	lsls	r3, r3, #1
 80028b2:	b2da      	uxtb	r2, r3
 80028b4:	4b4d      	ldr	r3, [pc, #308]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 80028b6:	709a      	strb	r2, [r3, #2]
 80028b8:	4b4c      	ldr	r3, [pc, #304]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 80028ba:	789b      	ldrb	r3, [r3, #2]
 80028bc:	b29b      	uxth	r3, r3
 80028be:	3305      	adds	r3, #5
 80028c0:	82fb      	strh	r3, [r7, #22]
 80028c2:	e076      	b.n	80029b2 <modbusSlaveParseFrame+0x1aa>
 80028c4:	7c7b      	ldrb	r3, [r7, #17]
 80028c6:	2b06      	cmp	r3, #6
 80028c8:	d125      	bne.n	8002916 <modbusSlaveParseFrame+0x10e>
 80028ca:	4b48      	ldr	r3, [pc, #288]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 80028cc:	789b      	ldrb	r3, [r3, #2]
 80028ce:	021b      	lsls	r3, r3, #8
 80028d0:	b21a      	sxth	r2, r3
 80028d2:	4b46      	ldr	r3, [pc, #280]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 80028d4:	78db      	ldrb	r3, [r3, #3]
 80028d6:	b21b      	sxth	r3, r3
 80028d8:	4313      	orrs	r3, r2
 80028da:	b21b      	sxth	r3, r3
 80028dc:	817b      	strh	r3, [r7, #10]
 80028de:	897b      	ldrh	r3, [r7, #10]
 80028e0:	f5b3 7f80 	cmp.w	r3, #256	; 0x100
 80028e4:	d905      	bls.n	80028f2 <modbusSlaveParseFrame+0xea>
 80028e6:	2002      	movs	r0, #2
 80028e8:	f7ff ff76 	bl	80027d8 <modbusSlaveErrorSet>
 80028ec:	4603      	mov	r3, r0
 80028ee:	82fb      	strh	r3, [r7, #22]
 80028f0:	e05f      	b.n	80029b2 <modbusSlaveParseFrame+0x1aa>
 80028f2:	4b3e      	ldr	r3, [pc, #248]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 80028f4:	791b      	ldrb	r3, [r3, #4]
 80028f6:	021b      	lsls	r3, r3, #8
 80028f8:	b21a      	sxth	r2, r3
 80028fa:	4b3c      	ldr	r3, [pc, #240]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 80028fc:	795b      	ldrb	r3, [r3, #5]
 80028fe:	b21b      	sxth	r3, r3
 8002900:	4313      	orrs	r3, r2
 8002902:	b21a      	sxth	r2, r3
 8002904:	897b      	ldrh	r3, [r7, #10]
 8002906:	b291      	uxth	r1, r2
 8002908:	4a39      	ldr	r2, [pc, #228]	; (80029f0 <modbusSlaveParseFrame+0x1e8>)
 800290a:	f822 1013 	strh.w	r1, [r2, r3, lsl #1]
 800290e:	4b39      	ldr	r3, [pc, #228]	; (80029f4 <modbusSlaveParseFrame+0x1ec>)
 8002910:	881b      	ldrh	r3, [r3, #0]
 8002912:	82fb      	strh	r3, [r7, #22]
 8002914:	e04d      	b.n	80029b2 <modbusSlaveParseFrame+0x1aa>
 8002916:	7c7b      	ldrb	r3, [r7, #17]
 8002918:	2b10      	cmp	r3, #16
 800291a:	d145      	bne.n	80029a8 <modbusSlaveParseFrame+0x1a0>
 800291c:	4b33      	ldr	r3, [pc, #204]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 800291e:	789b      	ldrb	r3, [r3, #2]
 8002920:	021b      	lsls	r3, r3, #8
 8002922:	b21a      	sxth	r2, r3
 8002924:	4b31      	ldr	r3, [pc, #196]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 8002926:	78db      	ldrb	r3, [r3, #3]
 8002928:	b21b      	sxth	r3, r3
 800292a:	4313      	orrs	r3, r2
 800292c:	b21b      	sxth	r3, r3
 800292e:	81fb      	strh	r3, [r7, #14]
 8002930:	4b2e      	ldr	r3, [pc, #184]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 8002932:	791b      	ldrb	r3, [r3, #4]
 8002934:	021b      	lsls	r3, r3, #8
 8002936:	b21a      	sxth	r2, r3
 8002938:	4b2c      	ldr	r3, [pc, #176]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 800293a:	795b      	ldrb	r3, [r3, #5]
 800293c:	b21b      	sxth	r3, r3
 800293e:	4313      	orrs	r3, r2
 8002940:	b21b      	sxth	r3, r3
 8002942:	81bb      	strh	r3, [r7, #12]
 8002944:	89fa      	ldrh	r2, [r7, #14]
 8002946:	89bb      	ldrh	r3, [r7, #12]
 8002948:	4413      	add	r3, r2
 800294a:	f5b3 7f80 	cmp.w	r3, #256	; 0x100
 800294e:	dc02      	bgt.n	8002956 <modbusSlaveParseFrame+0x14e>
 8002950:	89bb      	ldrh	r3, [r7, #12]
 8002952:	2b7e      	cmp	r3, #126	; 0x7e
 8002954:	d905      	bls.n	8002962 <modbusSlaveParseFrame+0x15a>
 8002956:	2002      	movs	r0, #2
 8002958:	f7ff ff3e 	bl	80027d8 <modbusSlaveErrorSet>
 800295c:	4603      	mov	r3, r0
 800295e:	82fb      	strh	r3, [r7, #22]
 8002960:	e027      	b.n	80029b2 <modbusSlaveParseFrame+0x1aa>
 8002962:	2300      	movs	r3, #0
 8002964:	827b      	strh	r3, [r7, #18]
 8002966:	e018      	b.n	800299a <modbusSlaveParseFrame+0x192>
 8002968:	8a7b      	ldrh	r3, [r7, #18]
 800296a:	005b      	lsls	r3, r3, #1
 800296c:	3307      	adds	r3, #7
 800296e:	4a1f      	ldr	r2, [pc, #124]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 8002970:	5cd3      	ldrb	r3, [r2, r3]
 8002972:	021b      	lsls	r3, r3, #8
 8002974:	b21a      	sxth	r2, r3
 8002976:	8a7b      	ldrh	r3, [r7, #18]
 8002978:	005b      	lsls	r3, r3, #1
 800297a:	3308      	adds	r3, #8
 800297c:	491b      	ldr	r1, [pc, #108]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 800297e:	5ccb      	ldrb	r3, [r1, r3]
 8002980:	b21b      	sxth	r3, r3
 8002982:	4313      	orrs	r3, r2
 8002984:	b219      	sxth	r1, r3
 8002986:	89fa      	ldrh	r2, [r7, #14]
 8002988:	8a7b      	ldrh	r3, [r7, #18]
 800298a:	4413      	add	r3, r2
 800298c:	b289      	uxth	r1, r1
 800298e:	4a18      	ldr	r2, [pc, #96]	; (80029f0 <modbusSlaveParseFrame+0x1e8>)
 8002990:	f822 1013 	strh.w	r1, [r2, r3, lsl #1]
 8002994:	8a7b      	ldrh	r3, [r7, #18]
 8002996:	3301      	adds	r3, #1
 8002998:	827b      	strh	r3, [r7, #18]
 800299a:	8a7a      	ldrh	r2, [r7, #18]
 800299c:	89bb      	ldrh	r3, [r7, #12]
 800299e:	429a      	cmp	r2, r3
 80029a0:	d3e2      	bcc.n	8002968 <modbusSlaveParseFrame+0x160>
 80029a2:	2308      	movs	r3, #8
 80029a4:	82fb      	strh	r3, [r7, #22]
 80029a6:	e004      	b.n	80029b2 <modbusSlaveParseFrame+0x1aa>
 80029a8:	2001      	movs	r0, #1
 80029aa:	f7ff ff15 	bl	80027d8 <modbusSlaveErrorSet>
 80029ae:	4603      	mov	r3, r0
 80029b0:	82fb      	strh	r3, [r7, #22]
 80029b2:	8afb      	ldrh	r3, [r7, #22]
 80029b4:	3b02      	subs	r3, #2
 80029b6:	b29b      	uxth	r3, r3
 80029b8:	4619      	mov	r1, r3
 80029ba:	480c      	ldr	r0, [pc, #48]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 80029bc:	f7ff fece 	bl	800275c <modbusSlaveGetCRC>
 80029c0:	4603      	mov	r3, r0
 80029c2:	80bb      	strh	r3, [r7, #4]
 80029c4:	8afb      	ldrh	r3, [r7, #22]
 80029c6:	3b02      	subs	r3, #2
 80029c8:	88ba      	ldrh	r2, [r7, #4]
 80029ca:	b2d1      	uxtb	r1, r2
 80029cc:	4a07      	ldr	r2, [pc, #28]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 80029ce:	54d1      	strb	r1, [r2, r3]
 80029d0:	88bb      	ldrh	r3, [r7, #4]
 80029d2:	0a1b      	lsrs	r3, r3, #8
 80029d4:	b29a      	uxth	r2, r3
 80029d6:	8afb      	ldrh	r3, [r7, #22]
 80029d8:	3b01      	subs	r3, #1
 80029da:	b2d1      	uxtb	r1, r2
 80029dc:	4a03      	ldr	r2, [pc, #12]	; (80029ec <modbusSlaveParseFrame+0x1e4>)
 80029de:	54d1      	strb	r1, [r2, r3]
 80029e0:	8afb      	ldrh	r3, [r7, #22]
 80029e2:	4618      	mov	r0, r3
 80029e4:	3718      	adds	r7, #24
 80029e6:	46bd      	mov	sp, r7
 80029e8:	bd80      	pop	{r7, pc}
 80029ea:	bf00      	nop
 80029ec:	200041a8 	.word	0x200041a8
 80029f0:	200042bc 	.word	0x200042bc
 80029f4:	200042a8 	.word	0x200042a8

080029f8 <SysTick_Handler>:
 80029f8:	b580      	push	{r7, lr}
 80029fa:	af00      	add	r7, sp, #0
 80029fc:	f7fd fc8a 	bl	8000314 <HAL_IncTick>
 8002a00:	f7fd fc9a 	bl	8000338 <HAL_SYSTICK_IRQHandler>
 8002a04:	f7fd fe88 	bl	8000718 <osSystickHandler>
 8002a08:	bf00      	nop
 8002a0a:	bd80      	pop	{r7, pc}

08002a0c <SystemInit>:
 8002a0c:	b480      	push	{r7}
 8002a0e:	af00      	add	r7, sp, #0
 8002a10:	4b1b      	ldr	r3, [pc, #108]	; (8002a80 <SystemInit+0x74>)
 8002a12:	681b      	ldr	r3, [r3, #0]
 8002a14:	4a1a      	ldr	r2, [pc, #104]	; (8002a80 <SystemInit+0x74>)
 8002a16:	f043 0301 	orr.w	r3, r3, #1
 8002a1a:	6013      	str	r3, [r2, #0]
 8002a1c:	4b18      	ldr	r3, [pc, #96]	; (8002a80 <SystemInit+0x74>)
 8002a1e:	685a      	ldr	r2, [r3, #4]
 8002a20:	4917      	ldr	r1, [pc, #92]	; (8002a80 <SystemInit+0x74>)
 8002a22:	4b18      	ldr	r3, [pc, #96]	; (8002a84 <SystemInit+0x78>)
 8002a24:	4013      	ands	r3, r2
 8002a26:	604b      	str	r3, [r1, #4]
 8002a28:	4b15      	ldr	r3, [pc, #84]	; (8002a80 <SystemInit+0x74>)
 8002a2a:	681b      	ldr	r3, [r3, #0]
 8002a2c:	4a14      	ldr	r2, [pc, #80]	; (8002a80 <SystemInit+0x74>)
 8002a2e:	f023 7384 	bic.w	r3, r3, #17301504	; 0x1080000
 8002a32:	f423 3380 	bic.w	r3, r3, #65536	; 0x10000
 8002a36:	6013      	str	r3, [r2, #0]
 8002a38:	4b11      	ldr	r3, [pc, #68]	; (8002a80 <SystemInit+0x74>)
 8002a3a:	681b      	ldr	r3, [r3, #0]
 8002a3c:	4a10      	ldr	r2, [pc, #64]	; (8002a80 <SystemInit+0x74>)
 8002a3e:	f423 2380 	bic.w	r3, r3, #262144	; 0x40000
 8002a42:	6013      	str	r3, [r2, #0]
 8002a44:	4b0e      	ldr	r3, [pc, #56]	; (8002a80 <SystemInit+0x74>)
 8002a46:	685b      	ldr	r3, [r3, #4]
 8002a48:	4a0d      	ldr	r2, [pc, #52]	; (8002a80 <SystemInit+0x74>)
 8002a4a:	f423 03fe 	bic.w	r3, r3, #8323072	; 0x7f0000
 8002a4e:	6053      	str	r3, [r2, #4]
 8002a50:	4b0b      	ldr	r3, [pc, #44]	; (8002a80 <SystemInit+0x74>)
 8002a52:	6adb      	ldr	r3, [r3, #44]	; 0x2c
 8002a54:	4a0a      	ldr	r2, [pc, #40]	; (8002a80 <SystemInit+0x74>)
 8002a56:	f023 030f 	bic.w	r3, r3, #15
 8002a5a:	62d3      	str	r3, [r2, #44]	; 0x2c
 8002a5c:	4b08      	ldr	r3, [pc, #32]	; (8002a80 <SystemInit+0x74>)
 8002a5e:	6b1a      	ldr	r2, [r3, #48]	; 0x30
 8002a60:	4907      	ldr	r1, [pc, #28]	; (8002a80 <SystemInit+0x74>)
 8002a62:	4b09      	ldr	r3, [pc, #36]	; (8002a88 <SystemInit+0x7c>)
 8002a64:	4013      	ands	r3, r2
 8002a66:	630b      	str	r3, [r1, #48]	; 0x30
 8002a68:	4b05      	ldr	r3, [pc, #20]	; (8002a80 <SystemInit+0x74>)
 8002a6a:	2200      	movs	r2, #0
 8002a6c:	609a      	str	r2, [r3, #8]
 8002a6e:	4b07      	ldr	r3, [pc, #28]	; (8002a8c <SystemInit+0x80>)
 8002a70:	f04f 6200 	mov.w	r2, #134217728	; 0x8000000
 8002a74:	609a      	str	r2, [r3, #8]
 8002a76:	bf00      	nop
 8002a78:	46bd      	mov	sp, r7
 8002a7a:	bc80      	pop	{r7}
 8002a7c:	4770      	bx	lr
 8002a7e:	bf00      	nop
 8002a80:	40021000 	.word	0x40021000
 8002a84:	f87fc00c 	.word	0xf87fc00c
 8002a88:	ff00fccc 	.word	0xff00fccc
 8002a8c:	e000ed00 	.word	0xe000ed00

08002a90 <Reset_Handler>:
 8002a90:	f8df d034 	ldr.w	sp, [pc, #52]	; 8002ac8 <LoopForever+0x2>
 8002a94:	2100      	movs	r1, #0
 8002a96:	e003      	b.n	8002aa0 <LoopCopyDataInit>

08002a98 <CopyDataInit>:
 8002a98:	4b0c      	ldr	r3, [pc, #48]	; (8002acc <LoopForever+0x6>)
 8002a9a:	585b      	ldr	r3, [r3, r1]
 8002a9c:	5043      	str	r3, [r0, r1]
 8002a9e:	3104      	adds	r1, #4

08002aa0 <LoopCopyDataInit>:
 8002aa0:	480b      	ldr	r0, [pc, #44]	; (8002ad0 <LoopForever+0xa>)
 8002aa2:	4b0c      	ldr	r3, [pc, #48]	; (8002ad4 <LoopForever+0xe>)
 8002aa4:	1842      	adds	r2, r0, r1
 8002aa6:	429a      	cmp	r2, r3
 8002aa8:	d3f6      	bcc.n	8002a98 <CopyDataInit>
 8002aaa:	4a0b      	ldr	r2, [pc, #44]	; (8002ad8 <LoopForever+0x12>)
 8002aac:	e002      	b.n	8002ab4 <LoopFillZerobss>

08002aae <FillZerobss>:
 8002aae:	2300      	movs	r3, #0
 8002ab0:	f842 3b04 	str.w	r3, [r2], #4

08002ab4 <LoopFillZerobss>:
 8002ab4:	4b09      	ldr	r3, [pc, #36]	; (8002adc <LoopForever+0x16>)
 8002ab6:	429a      	cmp	r2, r3
 8002ab8:	d3f9      	bcc.n	8002aae <FillZerobss>
 8002aba:	f7ff ffa7 	bl	8002a0c <SystemInit>
 8002abe:	f000 f811 	bl	8002ae4 <__libc_init_array>
 8002ac2:	f7ff fba7 	bl	8002214 <main>

08002ac6 <LoopForever>:
 8002ac6:	e7fe      	b.n	8002ac6 <LoopForever>
 8002ac8:	20010000 	.word	0x20010000
 8002acc:	08002d30 	.word	0x08002d30
 8002ad0:	20000000 	.word	0x20000000
 8002ad4:	2000043c 	.word	0x2000043c
 8002ad8:	2000043c 	.word	0x2000043c
 8002adc:	200044e0 	.word	0x200044e0

08002ae0 <ADC1_2_IRQHandler>:
 8002ae0:	e7fe      	b.n	8002ae0 <ADC1_2_IRQHandler>
	...

08002ae4 <__libc_init_array>:
 8002ae4:	b570      	push	{r4, r5, r6, lr}
 8002ae6:	4e0d      	ldr	r6, [pc, #52]	; (8002b1c <__libc_init_array+0x38>)
 8002ae8:	4d0d      	ldr	r5, [pc, #52]	; (8002b20 <__libc_init_array+0x3c>)
 8002aea:	1b76      	subs	r6, r6, r5
 8002aec:	10b6      	asrs	r6, r6, #2
 8002aee:	d006      	beq.n	8002afe <__libc_init_array+0x1a>
 8002af0:	2400      	movs	r4, #0
 8002af2:	3401      	adds	r4, #1
 8002af4:	f855 3b04 	ldr.w	r3, [r5], #4
 8002af8:	4798      	blx	r3
 8002afa:	42a6      	cmp	r6, r4
 8002afc:	d1f9      	bne.n	8002af2 <__libc_init_array+0xe>
 8002afe:	4e09      	ldr	r6, [pc, #36]	; (8002b24 <__libc_init_array+0x40>)
 8002b00:	4d09      	ldr	r5, [pc, #36]	; (8002b28 <__libc_init_array+0x44>)
 8002b02:	1b76      	subs	r6, r6, r5
 8002b04:	f000 f8ea 	bl	8002cdc <_init>
 8002b08:	10b6      	asrs	r6, r6, #2
 8002b0a:	d006      	beq.n	8002b1a <__libc_init_array+0x36>
 8002b0c:	2400      	movs	r4, #0
 8002b0e:	3401      	adds	r4, #1
 8002b10:	f855 3b04 	ldr.w	r3, [r5], #4
 8002b14:	4798      	blx	r3
 8002b16:	42a6      	cmp	r6, r4
 8002b18:	d1f9      	bne.n	8002b0e <__libc_init_array+0x2a>
 8002b1a:	bd70      	pop	{r4, r5, r6, pc}
 8002b1c:	08002d24 	.word	0x08002d24
 8002b20:	08002d24 	.word	0x08002d24
 8002b24:	08002d2c 	.word	0x08002d2c
 8002b28:	08002d24 	.word	0x08002d24

08002b2c <memset>:
 8002b2c:	b4f0      	push	{r4, r5, r6, r7}
 8002b2e:	0786      	lsls	r6, r0, #30
 8002b30:	d043      	beq.n	8002bba <memset+0x8e>
 8002b32:	1e54      	subs	r4, r2, #1
 8002b34:	2a00      	cmp	r2, #0
 8002b36:	d03e      	beq.n	8002bb6 <memset+0x8a>
 8002b38:	b2ca      	uxtb	r2, r1
 8002b3a:	4603      	mov	r3, r0
 8002b3c:	e002      	b.n	8002b44 <memset+0x18>
 8002b3e:	f114 34ff 	adds.w	r4, r4, #4294967295	; 0xffffffff
 8002b42:	d338      	bcc.n	8002bb6 <memset+0x8a>
 8002b44:	f803 2b01 	strb.w	r2, [r3], #1
 8002b48:	079d      	lsls	r5, r3, #30
 8002b4a:	d1f8      	bne.n	8002b3e <memset+0x12>
 8002b4c:	2c03      	cmp	r4, #3
 8002b4e:	d92b      	bls.n	8002ba8 <memset+0x7c>
 8002b50:	b2cd      	uxtb	r5, r1
 8002b52:	ea45 2505 	orr.w	r5, r5, r5, lsl #8
 8002b56:	2c0f      	cmp	r4, #15
 8002b58:	ea45 4505 	orr.w	r5, r5, r5, lsl #16
 8002b5c:	d916      	bls.n	8002b8c <memset+0x60>
 8002b5e:	f1a4 0710 	sub.w	r7, r4, #16
 8002b62:	093f      	lsrs	r7, r7, #4
 8002b64:	f103 0620 	add.w	r6, r3, #32
 8002b68:	eb06 1607 	add.w	r6, r6, r7, lsl #4
 8002b6c:	f103 0210 	add.w	r2, r3, #16
 8002b70:	e942 5504 	strd	r5, r5, [r2, #-16]
 8002b74:	e942 5502 	strd	r5, r5, [r2, #-8]
 8002b78:	3210      	adds	r2, #16
 8002b7a:	42b2      	cmp	r2, r6
 8002b7c:	d1f8      	bne.n	8002b70 <memset+0x44>
 8002b7e:	f004 040f 	and.w	r4, r4, #15
 8002b82:	3701      	adds	r7, #1
 8002b84:	2c03      	cmp	r4, #3
 8002b86:	eb03 1307 	add.w	r3, r3, r7, lsl #4
 8002b8a:	d90d      	bls.n	8002ba8 <memset+0x7c>
 8002b8c:	461e      	mov	r6, r3
 8002b8e:	4622      	mov	r2, r4
 8002b90:	3a04      	subs	r2, #4
 8002b92:	2a03      	cmp	r2, #3
 8002b94:	f846 5b04 	str.w	r5, [r6], #4
 8002b98:	d8fa      	bhi.n	8002b90 <memset+0x64>
 8002b9a:	1f22      	subs	r2, r4, #4
 8002b9c:	f022 0203 	bic.w	r2, r2, #3
 8002ba0:	3204      	adds	r2, #4
 8002ba2:	4413      	add	r3, r2
 8002ba4:	f004 0403 	and.w	r4, r4, #3
 8002ba8:	b12c      	cbz	r4, 8002bb6 <memset+0x8a>
 8002baa:	b2c9      	uxtb	r1, r1
 8002bac:	441c      	add	r4, r3
 8002bae:	f803 1b01 	strb.w	r1, [r3], #1
 8002bb2:	429c      	cmp	r4, r3
 8002bb4:	d1fb      	bne.n	8002bae <memset+0x82>
 8002bb6:	bcf0      	pop	{r4, r5, r6, r7}
 8002bb8:	4770      	bx	lr
 8002bba:	4614      	mov	r4, r2
 8002bbc:	4603      	mov	r3, r0
 8002bbe:	e7c5      	b.n	8002b4c <memset+0x20>

08002bc0 <register_fini>:
 8002bc0:	4b02      	ldr	r3, [pc, #8]	; (8002bcc <register_fini+0xc>)
 8002bc2:	b113      	cbz	r3, 8002bca <register_fini+0xa>
 8002bc4:	4802      	ldr	r0, [pc, #8]	; (8002bd0 <register_fini+0x10>)
 8002bc6:	f000 b805 	b.w	8002bd4 <atexit>
 8002bca:	4770      	bx	lr
 8002bcc:	00000000 	.word	0x00000000
 8002bd0:	08002be1 	.word	0x08002be1

08002bd4 <atexit>:
 8002bd4:	2300      	movs	r3, #0
 8002bd6:	4601      	mov	r1, r0
 8002bd8:	461a      	mov	r2, r3
 8002bda:	4618      	mov	r0, r3
 8002bdc:	f000 b81e 	b.w	8002c1c <__register_exitproc>

08002be0 <__libc_fini_array>:
 8002be0:	b538      	push	{r3, r4, r5, lr}
 8002be2:	4c0a      	ldr	r4, [pc, #40]	; (8002c0c <__libc_fini_array+0x2c>)
 8002be4:	4d0a      	ldr	r5, [pc, #40]	; (8002c10 <__libc_fini_array+0x30>)
 8002be6:	1b64      	subs	r4, r4, r5
 8002be8:	10a4      	asrs	r4, r4, #2
 8002bea:	d00a      	beq.n	8002c02 <__libc_fini_array+0x22>
 8002bec:	f104 4380 	add.w	r3, r4, #1073741824	; 0x40000000
 8002bf0:	3b01      	subs	r3, #1
 8002bf2:	eb05 0583 	add.w	r5, r5, r3, lsl #2
 8002bf6:	3c01      	subs	r4, #1
 8002bf8:	f855 3904 	ldr.w	r3, [r5], #-4
 8002bfc:	4798      	blx	r3
 8002bfe:	2c00      	cmp	r4, #0
 8002c00:	d1f9      	bne.n	8002bf6 <__libc_fini_array+0x16>
 8002c02:	e8bd 4038 	ldmia.w	sp!, {r3, r4, r5, lr}
 8002c06:	f000 b86f 	b.w	8002ce8 <_fini>
 8002c0a:	bf00      	nop
 8002c0c:	08002d30 	.word	0x08002d30
 8002c10:	08002d2c 	.word	0x08002d2c

08002c14 <__retarget_lock_acquire_recursive>:
 8002c14:	4770      	bx	lr
 8002c16:	bf00      	nop

08002c18 <__retarget_lock_release_recursive>:
 8002c18:	4770      	bx	lr
 8002c1a:	bf00      	nop

08002c1c <__register_exitproc>:
 8002c1c:	e92d 43f8 	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
 8002c20:	4d2b      	ldr	r5, [pc, #172]	; (8002cd0 <__register_exitproc+0xb4>)
 8002c22:	4606      	mov	r6, r0
 8002c24:	6828      	ldr	r0, [r5, #0]
 8002c26:	4698      	mov	r8, r3
 8002c28:	460f      	mov	r7, r1
 8002c2a:	4691      	mov	r9, r2
 8002c2c:	f7ff fff2 	bl	8002c14 <__retarget_lock_acquire_recursive>
 8002c30:	4b28      	ldr	r3, [pc, #160]	; (8002cd4 <__register_exitproc+0xb8>)
 8002c32:	681c      	ldr	r4, [r3, #0]
 8002c34:	f8d4 3148 	ldr.w	r3, [r4, #328]	; 0x148
 8002c38:	2b00      	cmp	r3, #0
 8002c3a:	d03d      	beq.n	8002cb8 <__register_exitproc+0x9c>
 8002c3c:	685a      	ldr	r2, [r3, #4]
 8002c3e:	2a1f      	cmp	r2, #31
 8002c40:	dc0d      	bgt.n	8002c5e <__register_exitproc+0x42>
 8002c42:	f102 0c01 	add.w	ip, r2, #1
 8002c46:	bb16      	cbnz	r6, 8002c8e <__register_exitproc+0x72>
 8002c48:	3202      	adds	r2, #2
 8002c4a:	f8c3 c004 	str.w	ip, [r3, #4]
 8002c4e:	6828      	ldr	r0, [r5, #0]
 8002c50:	f843 7022 	str.w	r7, [r3, r2, lsl #2]
 8002c54:	f7ff ffe0 	bl	8002c18 <__retarget_lock_release_recursive>
 8002c58:	2000      	movs	r0, #0
 8002c5a:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
 8002c5e:	4b1e      	ldr	r3, [pc, #120]	; (8002cd8 <__register_exitproc+0xbc>)
 8002c60:	b37b      	cbz	r3, 8002cc2 <__register_exitproc+0xa6>
 8002c62:	f44f 70c8 	mov.w	r0, #400	; 0x190
 8002c66:	f3af 8000 	nop.w
 8002c6a:	4603      	mov	r3, r0
 8002c6c:	b348      	cbz	r0, 8002cc2 <__register_exitproc+0xa6>
 8002c6e:	f8d4 2148 	ldr.w	r2, [r4, #328]	; 0x148
 8002c72:	2100      	movs	r1, #0
 8002c74:	e9c0 2100 	strd	r2, r1, [r0]
 8002c78:	f04f 0c01 	mov.w	ip, #1
 8002c7c:	f8c4 0148 	str.w	r0, [r4, #328]	; 0x148
 8002c80:	460a      	mov	r2, r1
 8002c82:	f8c0 1188 	str.w	r1, [r0, #392]	; 0x188
 8002c86:	f8c0 118c 	str.w	r1, [r0, #396]	; 0x18c
 8002c8a:	2e00      	cmp	r6, #0
 8002c8c:	d0dc      	beq.n	8002c48 <__register_exitproc+0x2c>
 8002c8e:	eb03 0182 	add.w	r1, r3, r2, lsl #2
 8002c92:	2401      	movs	r4, #1
 8002c94:	f8c1 9088 	str.w	r9, [r1, #136]	; 0x88
 8002c98:	f8d3 0188 	ldr.w	r0, [r3, #392]	; 0x188
 8002c9c:	4094      	lsls	r4, r2
 8002c9e:	4320      	orrs	r0, r4
 8002ca0:	2e02      	cmp	r6, #2
 8002ca2:	f8c3 0188 	str.w	r0, [r3, #392]	; 0x188
 8002ca6:	f8c1 8108 	str.w	r8, [r1, #264]	; 0x108
 8002caa:	d1cd      	bne.n	8002c48 <__register_exitproc+0x2c>
 8002cac:	f8d3 118c 	ldr.w	r1, [r3, #396]	; 0x18c
 8002cb0:	430c      	orrs	r4, r1
 8002cb2:	f8c3 418c 	str.w	r4, [r3, #396]	; 0x18c
 8002cb6:	e7c7      	b.n	8002c48 <__register_exitproc+0x2c>
 8002cb8:	f504 73a6 	add.w	r3, r4, #332	; 0x14c
 8002cbc:	f8c4 3148 	str.w	r3, [r4, #328]	; 0x148
 8002cc0:	e7bc      	b.n	8002c3c <__register_exitproc+0x20>
 8002cc2:	6828      	ldr	r0, [r5, #0]
 8002cc4:	f7ff ffa8 	bl	8002c18 <__retarget_lock_release_recursive>
 8002cc8:	f04f 30ff 	mov.w	r0, #4294967295	; 0xffffffff
 8002ccc:	e7c5      	b.n	8002c5a <__register_exitproc+0x3e>
 8002cce:	bf00      	nop
 8002cd0:	20000438 	.word	0x20000438
 8002cd4:	08002d20 	.word	0x08002d20
 8002cd8:	00000000 	.word	0x00000000

08002cdc <_init>:
 8002cdc:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 8002cde:	bf00      	nop
 8002ce0:	bcf8      	pop	{r3, r4, r5, r6, r7}
 8002ce2:	bc08      	pop	{r3}
 8002ce4:	469e      	mov	lr, r3
 8002ce6:	4770      	bx	lr

08002ce8 <_fini>:
 8002ce8:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 8002cea:	bf00      	nop
 8002cec:	bcf8      	pop	{r3, r4, r5, r6, r7}
 8002cee:	bc08      	pop	{r3}
 8002cf0:	469e      	mov	lr, r3
 8002cf2:	4770      	bx	lr
