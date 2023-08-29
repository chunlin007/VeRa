
/home/chunlin/TSIS/dir_analyze/DICE-advance/DICE-Evaluation/ARM/Fuzzing/Firmware/Binaries-No-Ins/NRF52832_uart.elf:     file format elf32-littlearm


Disassembly of section .text:

00000000 <__isr_vector>:
       0:	20010000 	.word	0x20010000
       4:	00001221 	.word	0x00001221
       8:	00001249 	.word	0x00001249
       c:	0000124b 	.word	0x0000124b
      10:	0000124d 	.word	0x0000124d
      14:	0000124f 	.word	0x0000124f
      18:	00001251 	.word	0x00001251
	...
      2c:	00001253 	.word	0x00001253
      30:	00001255 	.word	0x00001255
      34:	00000000 	.word	0x00000000
      38:	00001257 	.word	0x00001257
      3c:	00001259 	.word	0x00001259
      40:	0000125b 	.word	0x0000125b
      44:	0000125b 	.word	0x0000125b
      48:	00000ea5 	.word	0x00000ea5
      4c:	0000125b 	.word	0x0000125b
      50:	0000125b 	.word	0x0000125b
      54:	0000125b 	.word	0x0000125b
      58:	0000125b 	.word	0x0000125b
      5c:	0000125b 	.word	0x0000125b
      60:	0000125b 	.word	0x0000125b
      64:	0000125b 	.word	0x0000125b
      68:	0000125b 	.word	0x0000125b
      6c:	0000125b 	.word	0x0000125b
      70:	0000125b 	.word	0x0000125b
      74:	0000125b 	.word	0x0000125b
      78:	0000125b 	.word	0x0000125b
      7c:	0000125b 	.word	0x0000125b
      80:	0000125b 	.word	0x0000125b
      84:	0000125b 	.word	0x0000125b
      88:	0000125b 	.word	0x0000125b
      8c:	0000125b 	.word	0x0000125b
      90:	0000125b 	.word	0x0000125b
      94:	0000125b 	.word	0x0000125b
      98:	0000125b 	.word	0x0000125b
      9c:	0000125b 	.word	0x0000125b
      a0:	0000125b 	.word	0x0000125b
      a4:	0000125b 	.word	0x0000125b
      a8:	0000125b 	.word	0x0000125b
      ac:	0000125b 	.word	0x0000125b
      b0:	0000125b 	.word	0x0000125b
      b4:	0000125b 	.word	0x0000125b
	...
      c0:	0000125b 	.word	0x0000125b
      c4:	0000125b 	.word	0x0000125b
      c8:	0000125b 	.word	0x0000125b
      cc:	0000125b 	.word	0x0000125b
      d0:	0000125b 	.word	0x0000125b
      d4:	0000125b 	.word	0x0000125b
      d8:	0000125b 	.word	0x0000125b
	...

00000400 <__do_global_dtors_aux>:
     400:	b510      	push	{r4, lr}
     402:	4c05      	ldr	r4, [pc, #20]	; (418 <__do_global_dtors_aux+0x18>)
     404:	7823      	ldrb	r3, [r4, #0]
     406:	b933      	cbnz	r3, 416 <__do_global_dtors_aux+0x16>
     408:	4b04      	ldr	r3, [pc, #16]	; (41c <__do_global_dtors_aux+0x1c>)
     40a:	b113      	cbz	r3, 412 <__do_global_dtors_aux+0x12>
     40c:	4804      	ldr	r0, [pc, #16]	; (420 <__do_global_dtors_aux+0x20>)
     40e:	f3af 8000 	nop.w
     412:	2301      	movs	r3, #1
     414:	7023      	strb	r3, [r4, #0]
     416:	bd10      	pop	{r4, pc}
     418:	20000078 	.word	0x20000078
     41c:	00000000 	.word	0x00000000
     420:	000025d8 	.word	0x000025d8

#00000424 <frame_dummy>:
#     424:	b508      	push	{r3, lr}
#     426:	4b03      	ldr	r3, [pc, #12]	; (434 <frame_dummy+0x10>)
#     428:	b11b      	cbz	r3, 432 <frame_dummy+0xe>
     42a:	4903      	ldr	r1, [pc, #12]	; (438 <frame_dummy+0x14>)
     42c:	4803      	ldr	r0, [pc, #12]	; (43c <frame_dummy+0x18>)
     42e:	f3af 8000 	nop.w
#     432:	bd08      	pop	{r3, pc}
     434:	00000000 	.word	0x00000000
     438:	2000007c 	.word	0x2000007c
     43c:	000025d8 	.word	0x000025d8

#00000440 <_mainCRTStartup>:
#     440:	4b15      	ldr	r3, [pc, #84]	; (498 <_mainCRTStartup+0x58>)
#     442:	2b00      	cmp	r3, #0
#     444:	bf08      	it	eq
#     446:	4b13      	ldreq	r3, [pc, #76]	; (494 <_mainCRTStartup+0x54>)
#     448:	469d      	mov	sp, r3
#     44a:	f5a3 3a80 	sub.w	sl, r3, #65536	; 0x10000
#     44e:	2100      	movs	r1, #0
#     450:	468b      	mov	fp, r1
#     452:	460f      	mov	r7, r1
#     454:	4813      	ldr	r0, [pc, #76]	; (4a4 <_mainCRTStartup+0x64>)
#     456:	4a14      	ldr	r2, [pc, #80]	; (4a8 <_mainCRTStartup+0x68>)
#     458:	1a12      	subs	r2, r2, r0
#     45a:	f000 f863 	bl	524 <memset>
#     45e:	4b0f      	ldr	r3, [pc, #60]	; (49c <_mainCRTStartup+0x5c>)
#     460:	2b00      	cmp	r3, #0
#     462:	d000      	beq.n	466 <_mainCRTStartup+0x26>
     464:	4798      	blx	r3
#     466:	4b0e      	ldr	r3, [pc, #56]	; (4a0 <_mainCRTStartup+0x60>)
#     468:	2b00      	cmp	r3, #0
#     46a:	d000      	beq.n	46e <_mainCRTStartup+0x2e>
     46c:	4798      	blx	r3
#     46e:	2000      	movs	r0, #0
#     470:	2100      	movs	r1, #0
#     472:	0004      	movs	r4, r0
#     474:	000d      	movs	r5, r1
#     476:	480d      	ldr	r0, [pc, #52]	; (4ac <_mainCRTStartup+0x6c>)
#     478:	2800      	cmp	r0, #0
#     47a:	d002      	beq.n	482 <_mainCRTStartup+0x42>
     47c:	480c      	ldr	r0, [pc, #48]	; (4b0 <_mainCRTStartup+0x70>)
     47e:	f3af 8000 	nop.w
#     482:	f000 f82b 	bl	4dc <__libc_init_array>
#     486:	0020      	movs	r0, r4
#     488:	0029      	movs	r1, r5
#     48a:	f000 fe87 	bl	119c <main>
     48e:	f000 f811 	bl	4b4 <exit>
     492:	bf00      	nop
     494:	00080000 	.word	0x00080000
     498:	20010000 	.word	0x20010000
	...
     4a4:	20000078 	.word	0x20000078
     4a8:	20000300 	.word	0x20000300
	...

000004b4 <exit>:
     4b4:	b508      	push	{r3, lr}
     4b6:	4b07      	ldr	r3, [pc, #28]	; (4d4 <exit+0x20>)
     4b8:	4604      	mov	r4, r0
     4ba:	b113      	cbz	r3, 4c2 <exit+0xe>
     4bc:	2100      	movs	r1, #0
     4be:	f3af 8000 	nop.w
     4c2:	4b05      	ldr	r3, [pc, #20]	; (4d8 <exit+0x24>)
     4c4:	6818      	ldr	r0, [r3, #0]
     4c6:	6a83      	ldr	r3, [r0, #40]	; 0x28
     4c8:	b103      	cbz	r3, 4cc <exit+0x18>
     4ca:	4798      	blx	r3
     4cc:	4620      	mov	r0, r4
     4ce:	f000 f831 	bl	534 <_exit>
     4d2:	bf00      	nop
     4d4:	00000000 	.word	0x00000000
     4d8:	000024f0 	.word	0x000024f0

#000004dc <__libc_init_array>:
#     4dc:	b570      	push	{r4, r5, r6, lr}
#     4de:	4d0d      	ldr	r5, [pc, #52]	; (514 <__libc_init_array+0x38>)
#     4e0:	4c0d      	ldr	r4, [pc, #52]	; (518 <__libc_init_array+0x3c>)
#     4e2:	1b64      	subs	r4, r4, r5
#     4e4:	10a4      	asrs	r4, r4, #2
#     4e6:	2600      	movs	r6, #0
#     4e8:	42a6      	cmp	r6, r4
#     4ea:	d109      	bne.n	500 <__libc_init_array+0x24>
#     4ec:	4d0b      	ldr	r5, [pc, #44]	; (51c <__libc_init_array+0x40>)
#     4ee:	4c0c      	ldr	r4, [pc, #48]	; (520 <__libc_init_array+0x44>)
#     4f0:	f001 fff2 	bl	24d8 <_init>
#     4f4:	1b64      	subs	r4, r4, r5
#     4f6:	10a4      	asrs	r4, r4, #2
#     4f8:	2600      	movs	r6, #0
#     4fa:	42a6      	cmp	r6, r4
#     4fc:	d105      	bne.n	50a <__libc_init_array+0x2e>
#     4fe:	bd70      	pop	{r4, r5, r6, pc}
     500:	f855 3b04 	ldr.w	r3, [r5], #4
     504:	4798      	blx	r3
     506:	3601      	adds	r6, #1
     508:	e7ee      	b.n	4e8 <__libc_init_array+0xc>
#     50a:	f855 3b04 	ldr.w	r3, [r5], #4
#     50e:	4798      	blx	r3
#     510:	3601      	adds	r6, #1
#     512:	e7f2      	b.n	4fa <__libc_init_array+0x1e>
     514:	20000070 	.word	0x20000070
     518:	20000070 	.word	0x20000070
     51c:	20000070 	.word	0x20000070
     520:	20000074 	.word	0x20000074

#00000524 <memset>:
#     524:	4402      	add	r2, r0
#     526:	4603      	mov	r3, r0
#     528:	4293      	cmp	r3, r2
#     52a:	d100      	bne.n	52e <memset+0xa>
#     52c:	4770      	bx	lr
#     52e:	f803 1b01 	strb.w	r1, [r3], #1
#     532:	e7f9      	b.n	528 <memset+0x4>

00000534 <_exit>:
     534:	e7fe      	b.n	534 <_exit>
     536:	bf00      	nop

#00000538 <app_error_handler_bare>:
#     538:	b500      	push	{lr}
#     53a:	b085      	sub	sp, #20
#     53c:	2100      	movs	r1, #0
#     53e:	4603      	mov	r3, r0
#     540:	aa01      	add	r2, sp, #4
#     542:	f244 0001 	movw	r0, #16385	; 0x4001
#     546:	9303      	str	r3, [sp, #12]
#     548:	f8ad 1004 	strh.w	r1, [sp, #4]
#     54c:	9102      	str	r1, [sp, #8]
#     54e:	f000 f803 	bl	558 <app_error_fault_handler>
     552:	b005      	add	sp, #20
     554:	f85d fb04 	ldr.w	pc, [sp], #4

#00000558 <app_error_fault_handler>:
#     558:	f3bf 8f4f 	dsb	sy
#     55c:	4905      	ldr	r1, [pc, #20]	; (574 <app_error_fault_handler+0x1c>)
#     55e:	4b06      	ldr	r3, [pc, #24]	; (578 <app_error_fault_handler+0x20>)
#     560:	68ca      	ldr	r2, [r1, #12]
#     562:	f402 62e0 	and.w	r2, r2, #1792	; 0x700
#     566:	4313      	orrs	r3, r2
#     568:	60cb      	str	r3, [r1, #12]
#     56a:	f3bf 8f4f 	dsb	sy
#     56e:	bf00      	nop
#     570:	e7fd      	b.n	56e <app_error_fault_handler+0x16>
     572:	bf00      	nop
     574:	e000ed00 	.word	0xe000ed00
     578:	05fa0004 	.word	0x05fa0004

#0000057c <app_fifo_init>:
#     57c:	b159      	cbz	r1, 596 <app_fifo_init+0x1a>
#     57e:	b142      	cbz	r2, 592 <app_fifo_init+0x16>
#     580:	1e53      	subs	r3, r2, #1
#     582:	401a      	ands	r2, r3
#     584:	d105      	bne.n	592 <app_fifo_init+0x16>
#     586:	6082      	str	r2, [r0, #8]
#     588:	6001      	str	r1, [r0, #0]
#     58a:	8083      	strh	r3, [r0, #4]
#     58c:	60c2      	str	r2, [r0, #12]
#     58e:	4610      	mov	r0, r2
#     590:	4770      	bx	lr
     592:	2009      	movs	r0, #9
     594:	4770      	bx	lr
     596:	200e      	movs	r0, #14
     598:	4770      	bx	lr
     59a:	bf00      	nop

#0000059c <app_fifo_put>:
#     59c:	b410      	push	{r4}
#     59e:	6884      	ldr	r4, [r0, #8]
#     5a0:	68c2      	ldr	r2, [r0, #12]
#     5a2:	4603      	mov	r3, r0
#     5a4:	8880      	ldrh	r0, [r0, #4]
#     5a6:	1b12      	subs	r2, r2, r4
#     5a8:	4290      	cmp	r0, r2
#     5aa:	d202      	bcs.n	5b2 <app_fifo_put+0x16>
     5ac:	2004      	movs	r0, #4
     5ae:	bc10      	pop	{r4}
     5b0:	4770      	bx	lr
#     5b2:	68da      	ldr	r2, [r3, #12]
#     5b4:	681c      	ldr	r4, [r3, #0]
#     5b6:	4002      	ands	r2, r0
#     5b8:	2000      	movs	r0, #0
#     5ba:	54a1      	strb	r1, [r4, r2]
#     5bc:	68da      	ldr	r2, [r3, #12]
#     5be:	3201      	adds	r2, #1
#     5c0:	60da      	str	r2, [r3, #12]
#     5c2:	bc10      	pop	{r4}
#     5c4:	4770      	bx	lr
     5c6:	bf00      	nop

#000005c8 <app_fifo_get>:
#     5c8:	4603      	mov	r3, r0
#     5ca:	6880      	ldr	r0, [r0, #8]
#     5cc:	68da      	ldr	r2, [r3, #12]
#     5ce:	4290      	cmp	r0, r2
#     5d0:	d00c      	beq.n	5ec <app_fifo_get+0x24>
#     5d2:	b410      	push	{r4}
#     5d4:	6898      	ldr	r0, [r3, #8]
#     5d6:	889a      	ldrh	r2, [r3, #4]
#     5d8:	681c      	ldr	r4, [r3, #0]
#     5da:	4002      	ands	r2, r0
#     5dc:	2000      	movs	r0, #0
#     5de:	5ca2      	ldrb	r2, [r4, r2]
#     5e0:	700a      	strb	r2, [r1, #0]
#     5e2:	689a      	ldr	r2, [r3, #8]
#     5e4:	3201      	adds	r2, #1
#     5e6:	609a      	str	r2, [r3, #8]
#     5e8:	bc10      	pop	{r4}
#     5ea:	4770      	bx	lr
#     5ec:	2005      	movs	r0, #5
#     5ee:	4770      	bx	lr

#000005f0 <uart_event_handler>:
#     5f0:	b530      	push	{r4, r5, lr}
#     5f2:	7804      	ldrb	r4, [r0, #0]
#     5f4:	2c01      	cmp	r4, #1
#     5f6:	b083      	sub	sp, #12
#     5f8:	d004      	beq.n	604 <uart_event_handler+0x14>
#     5fa:	2c02      	cmp	r4, #2
#     5fc:	d02d      	beq.n	65a <uart_event_handler+0x6a>
#     5fe:	b1f4      	cbz	r4, 63e <uart_event_handler+0x4e>
#     600:	b003      	add	sp, #12
#     602:	bd30      	pop	{r4, r5, pc}
#     604:	6843      	ldr	r3, [r0, #4]
#     606:	4d26      	ldr	r5, [pc, #152]	; (6a0 <uart_event_handler+0xb0>)
#     608:	7819      	ldrb	r1, [r3, #0]
#     60a:	4628      	mov	r0, r5
#     60c:	f7ff ffc6 	bl	59c <app_fifo_put>
#     610:	2800      	cmp	r0, #0
#     612:	d131      	bne.n	678 <uart_event_handler+0x88>
#     614:	68aa      	ldr	r2, [r5, #8]
#     616:	68eb      	ldr	r3, [r5, #12]
#     618:	429a      	cmp	r2, r3
#     61a:	d005      	beq.n	628 <uart_event_handler+0x38>
#     61c:	4b21      	ldr	r3, [pc, #132]	; (6a4 <uart_event_handler+0xb4>)
#     61e:	f88d 0000 	strb.w	r0, [sp]
#     622:	681b      	ldr	r3, [r3, #0]
#     624:	4668      	mov	r0, sp
#     626:	4798      	blx	r3
#     628:	68a9      	ldr	r1, [r5, #8]
#     62a:	68eb      	ldr	r3, [r5, #12]
#     62c:	88aa      	ldrh	r2, [r5, #4]
#     62e:	1a5b      	subs	r3, r3, r1
#     630:	429a      	cmp	r2, r3
#     632:	d22f      	bcs.n	694 <uart_event_handler+0xa4>
     634:	4b1c      	ldr	r3, [pc, #112]	; (6a8 <uart_event_handler+0xb8>)
     636:	2201      	movs	r2, #1
     638:	701a      	strb	r2, [r3, #0]
     63a:	b003      	add	sp, #12
     63c:	bd30      	pop	{r4, r5, pc}
#     63e:	491b      	ldr	r1, [pc, #108]	; (6ac <uart_event_handler+0xbc>)
#     640:	481b      	ldr	r0, [pc, #108]	; (6b0 <uart_event_handler+0xc0>)
#     642:	f7ff ffc1 	bl	5c8 <app_fifo_get>
#     646:	b1f8      	cbz	r0, 688 <uart_event_handler+0x98>
     648:	4b16      	ldr	r3, [pc, #88]	; (6a4 <uart_event_handler+0xb4>)
     64a:	2203      	movs	r2, #3
     64c:	681b      	ldr	r3, [r3, #0]
     64e:	f88d 2000 	strb.w	r2, [sp]
     652:	4668      	mov	r0, sp
     654:	4798      	blx	r3
     656:	b003      	add	sp, #12
     658:	bd30      	pop	{r4, r5, pc}
#     65a:	68c3      	ldr	r3, [r0, #12]
#     65c:	4915      	ldr	r1, [pc, #84]	; (6b4 <uart_event_handler+0xc4>)
#     65e:	4816      	ldr	r0, [pc, #88]	; (6b8 <uart_event_handler+0xc8>)
#     660:	9301      	str	r3, [sp, #4]
#     662:	2201      	movs	r2, #1
#     664:	f88d 4000 	strb.w	r4, [sp]
#     668:	f000 fac2 	bl	bf0 <nrf_drv_uart_rx>
#     66c:	4b0d      	ldr	r3, [pc, #52]	; (6a4 <uart_event_handler+0xb4>)
#     66e:	4668      	mov	r0, sp
#     670:	681b      	ldr	r3, [r3, #0]
#     672:	4798      	blx	r3
     674:	b003      	add	sp, #12
     676:	bd30      	pop	{r4, r5, pc}
     678:	4b0a      	ldr	r3, [pc, #40]	; (6a4 <uart_event_handler+0xb4>)
     67a:	9001      	str	r0, [sp, #4]
     67c:	681b      	ldr	r3, [r3, #0]
     67e:	f88d 4000 	strb.w	r4, [sp]
     682:	4668      	mov	r0, sp
     684:	4798      	blx	r3
     686:	e7cf      	b.n	628 <uart_event_handler+0x38>
#     688:	4908      	ldr	r1, [pc, #32]	; (6ac <uart_event_handler+0xbc>)
#     68a:	480b      	ldr	r0, [pc, #44]	; (6b8 <uart_event_handler+0xc8>)
#     68c:	2201      	movs	r2, #1
#     68e:	f000 f9f5 	bl	a7c <nrf_drv_uart_tx>
#     692:	e7b5      	b.n	600 <uart_event_handler+0x10>
#     694:	4907      	ldr	r1, [pc, #28]	; (6b4 <uart_event_handler+0xc4>)
#     696:	4808      	ldr	r0, [pc, #32]	; (6b8 <uart_event_handler+0xc8>)
#     698:	2201      	movs	r2, #1
#     69a:	f000 faa9 	bl	bf0 <nrf_drv_uart_rx>
#     69e:	e7af      	b.n	600 <uart_event_handler+0x10>
     6a0:	20000098 	.word	0x20000098
     6a4:	20000094 	.word	0x20000094
     6a8:	200000a8 	.word	0x200000a8
     6ac:	200000c0 	.word	0x200000c0
     6b0:	200000ac 	.word	0x200000ac
     6b4:	200000bc 	.word	0x200000bc
     6b8:	20000064 	.word	0x20000064

#000006bc <app_uart_init>:
#     6bc:	e92d 43f0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, lr}
#     6c0:	4c2f      	ldr	r4, [pc, #188]	; (780 <app_uart_init+0xc4>)
#     6c2:	b089      	sub	sp, #36	; 0x24
#     6c4:	6022      	str	r2, [r4, #0]
#     6c6:	2900      	cmp	r1, #0
#     6c8:	d052      	beq.n	770 <app_uart_init+0xb4>
#     6ca:	888a      	ldrh	r2, [r1, #4]
#     6cc:	4680      	mov	r8, r0
#     6ce:	460c      	mov	r4, r1
#     6d0:	482c      	ldr	r0, [pc, #176]	; (784 <app_uart_init+0xc8>)
#     6d2:	6809      	ldr	r1, [r1, #0]
#     6d4:	4699      	mov	r9, r3
#     6d6:	f7ff ff51 	bl	57c <app_fifo_init>
#     6da:	b110      	cbz	r0, 6e2 <app_uart_init+0x26>
     6dc:	b009      	add	sp, #36	; 0x24
     6de:	e8bd 83f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, pc}
#     6e2:	89a2      	ldrh	r2, [r4, #12]
#     6e4:	68a1      	ldr	r1, [r4, #8]
#     6e6:	4828      	ldr	r0, [pc, #160]	; (788 <app_uart_init+0xcc>)
#     6e8:	f7ff ff48 	bl	57c <app_fifo_init>
#     6ec:	2800      	cmp	r0, #0
#     6ee:	d1f5      	bne.n	6dc <app_uart_init+0x20>
#     6f0:	4d26      	ldr	r5, [pc, #152]	; (78c <app_uart_init+0xd0>)
#     6f2:	f898 c010 	ldrb.w	ip, [r8, #16]
#     6f6:	f8d8 7000 	ldr.w	r7, [r8]
#     6fa:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
#     6fc:	466c      	mov	r4, sp
#     6fe:	c40f      	stmia	r4!, {r0, r1, r2, r3}
#     700:	e895 000f 	ldmia.w	r5, {r0, r1, r2, r3}
#     704:	f898 5011 	ldrb.w	r5, [r8, #17]
#     708:	9701      	str	r7, [sp, #4]
#     70a:	f1bc 0c00 	subs.w	ip, ip, #0
#     70e:	bf18      	it	ne
#     710:	f04f 0c01 	movne.w	ip, #1
#     714:	2d00      	cmp	r5, #0
#     716:	e9d8 6502 	ldrd	r6, r5, [r8, #8]
#     71a:	e884 000f 	stmia.w	r4, {r0, r1, r2, r3}
#     71e:	bf14      	ite	ne
#     720:	230e      	movne	r3, #14
#     722:	2300      	moveq	r3, #0
#     724:	f8d8 4004 	ldr.w	r4, [r8, #4]
#     728:	f88d 3015 	strb.w	r3, [sp, #21]
#     72c:	4a18      	ldr	r2, [pc, #96]	; (790 <app_uart_init+0xd4>)
#     72e:	f8d8 3014 	ldr.w	r3, [r8, #20]
#     732:	4818      	ldr	r0, [pc, #96]	; (794 <app_uart_init+0xd8>)
#     734:	f88d 901c 	strb.w	r9, [sp, #28]
#     738:	4669      	mov	r1, sp
#     73a:	e9cd 5602 	strd	r5, r6, [sp, #8]
#     73e:	f88d c014 	strb.w	ip, [sp, #20]
#     742:	9306      	str	r3, [sp, #24]
#     744:	9400      	str	r4, [sp, #0]
#     746:	f000 f8c7 	bl	8d8 <nrf_drv_uart_init>
#     74a:	2800      	cmp	r0, #0
#     74c:	d1c6      	bne.n	6dc <app_uart_init+0x20>
#     74e:	f8d8 3000 	ldr.w	r3, [r8]
#     752:	4a11      	ldr	r2, [pc, #68]	; (798 <app_uart_init+0xdc>)
#     754:	3301      	adds	r3, #1
#     756:	7010      	strb	r0, [r2, #0]
#     758:	d0c0      	beq.n	6dc <app_uart_init+0x20>
#     75a:	f89d 301d 	ldrb.w	r3, [sp, #29]
#     75e:	b15b      	cbz	r3, 778 <app_uart_init+0xbc>
#     760:	490e      	ldr	r1, [pc, #56]	; (79c <app_uart_init+0xe0>)
#     762:	480c      	ldr	r0, [pc, #48]	; (794 <app_uart_init+0xd8>)
#     764:	2201      	movs	r2, #1
#     766:	f000 fa43 	bl	bf0 <nrf_drv_uart_rx>
#     76a:	b009      	add	sp, #36	; 0x24
#     76c:	e8bd 83f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, pc}
     770:	2007      	movs	r0, #7
     772:	b009      	add	sp, #36	; 0x24
     774:	e8bd 83f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, pc}
     778:	4806      	ldr	r0, [pc, #24]	; (794 <app_uart_init+0xd8>)
     77a:	f000 fb6d 	bl	e58 <nrf_drv_uart_rx_enable>
     77e:	e7ef      	b.n	760 <app_uart_init+0xa4>
     780:	20000094 	.word	0x20000094
     784:	20000098 	.word	0x20000098
     788:	200000ac 	.word	0x200000ac
     78c:	000024f4 	.word	0x000024f4
     790:	000005f1 	.word	0x000005f1
     794:	20000064 	.word	0x20000064
     798:	200000a8 	.word	0x200000a8
     79c:	200000bc 	.word	0x200000bc

#000007a0 <app_uart_get>:
#     7a0:	b570      	push	{r4, r5, r6, lr}
#     7a2:	4d0b      	ldr	r5, [pc, #44]	; (7d0 <app_uart_get+0x30>)
#     7a4:	4601      	mov	r1, r0
#     7a6:	480b      	ldr	r0, [pc, #44]	; (7d4 <app_uart_get+0x34>)
#     7a8:	782e      	ldrb	r6, [r5, #0]
#     7aa:	f7ff ff0d 	bl	5c8 <app_fifo_get>
#     7ae:	4604      	mov	r4, r0
#     7b0:	b90e      	cbnz	r6, 7b6 <app_uart_get+0x16>
#     7b2:	4620      	mov	r0, r4
#     7b4:	bd70      	pop	{r4, r5, r6, pc}
     7b6:	2300      	movs	r3, #0
     7b8:	4907      	ldr	r1, [pc, #28]	; (7d8 <app_uart_get+0x38>)
     7ba:	4808      	ldr	r0, [pc, #32]	; (7dc <app_uart_get+0x3c>)
     7bc:	702b      	strb	r3, [r5, #0]
     7be:	2201      	movs	r2, #1
     7c0:	f000 fa16 	bl	bf0 <nrf_drv_uart_rx>
     7c4:	2800      	cmp	r0, #0
     7c6:	d0f4      	beq.n	7b2 <app_uart_get+0x12>
     7c8:	f7ff feb6 	bl	538 <app_error_handler_bare>
     7cc:	4620      	mov	r0, r4
     7ce:	bd70      	pop	{r4, r5, r6, pc}
     7d0:	200000a8 	.word	0x200000a8
     7d4:	20000098 	.word	0x20000098
     7d8:	200000bc 	.word	0x200000bc
     7dc:	20000064 	.word	0x20000064

#000007e0 <app_uart_put>:
#     7e0:	b510      	push	{r4, lr}
#     7e2:	4601      	mov	r1, r0
#     7e4:	480c      	ldr	r0, [pc, #48]	; (818 <app_uart_put+0x38>)
#     7e6:	f7ff fed9 	bl	59c <app_fifo_put>
#     7ea:	4604      	mov	r4, r0
#     7ec:	b108      	cbz	r0, 7f2 <app_uart_put+0x12>
#     7ee:	4620      	mov	r0, r4
#     7f0:	bd10      	pop	{r4, pc}
#     7f2:	480a      	ldr	r0, [pc, #40]	; (81c <app_uart_put+0x3c>)
#     7f4:	f000 f9f0 	bl	bd8 <nrf_drv_uart_tx_in_progress>
#     7f8:	2800      	cmp	r0, #0
#     7fa:	d1f8      	bne.n	7ee <app_uart_put+0xe>
#     7fc:	4908      	ldr	r1, [pc, #32]	; (820 <app_uart_put+0x40>)
#     7fe:	4806      	ldr	r0, [pc, #24]	; (818 <app_uart_put+0x38>)
#     800:	f7ff fee2 	bl	5c8 <app_fifo_get>
#     804:	2800      	cmp	r0, #0
#     806:	d1f2      	bne.n	7ee <app_uart_put+0xe>
#     808:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
#     80c:	4904      	ldr	r1, [pc, #16]	; (820 <app_uart_put+0x40>)
#     80e:	4803      	ldr	r0, [pc, #12]	; (81c <app_uart_put+0x3c>)
#     810:	2201      	movs	r2, #1
#     812:	f000 b933 	b.w	a7c <nrf_drv_uart_tx>
     816:	bf00      	nop
     818:	200000ac 	.word	0x200000ac
     81c:	20000064 	.word	0x20000064
     820:	200000c0 	.word	0x200000c0

#00000824 <_write>:
#     824:	b570      	push	{r4, r5, r6, lr}
#     826:	1e16      	subs	r6, r2, #0
#     828:	dd07      	ble.n	83a <_write+0x16>
#     82a:	460c      	mov	r4, r1
#     82c:	198d      	adds	r5, r1, r6
#     82e:	f814 0b01 	ldrb.w	r0, [r4], #1
#     832:	f7ff ffd5 	bl	7e0 <app_uart_put>
#     836:	42a5      	cmp	r5, r4
#     838:	d1f9      	bne.n	82e <_write+0xa>
#     83a:	4630      	mov	r0, r6
#     83c:	bd70      	pop	{r4, r5, r6, pc}
     83e:	bf00      	nop

00000840 <_read>:
     840:	b510      	push	{r4, lr}
     842:	460c      	mov	r4, r1
     844:	4620      	mov	r0, r4
     846:	f7ff ffab 	bl	7a0 <app_uart_get>
     84a:	2805      	cmp	r0, #5
     84c:	d0fa      	beq.n	844 <_read+0x4>
     84e:	2001      	movs	r0, #1
     850:	bd10      	pop	{r4, pc}
     852:	bf00      	nop

#00000854 <bsp_board_leds_init>:
#     854:	b430      	push	{r4, r5}
#     856:	f04f 43a0 	mov.w	r3, #1342177280	; 0x50000000
#     85a:	2203      	movs	r2, #3
#     85c:	f44f 3500 	mov.w	r5, #131072	; 0x20000
#     860:	f44f 2480 	mov.w	r4, #262144	; 0x40000
#     864:	f44f 2000 	mov.w	r0, #524288	; 0x80000
#     868:	f44f 1180 	mov.w	r1, #1048576	; 0x100000
#     86c:	f8c3 2744 	str.w	r2, [r3, #1860]	; 0x744
#     870:	f8c3 2748 	str.w	r2, [r3, #1864]	; 0x748
#     874:	f8c3 274c 	str.w	r2, [r3, #1868]	; 0x74c
#     878:	f8c3 2750 	str.w	r2, [r3, #1872]	; 0x750
#     87c:	f8c3 5508 	str.w	r5, [r3, #1288]	; 0x508
#     880:	f8c3 4508 	str.w	r4, [r3, #1288]	; 0x508
#     884:	f8c3 0508 	str.w	r0, [r3, #1288]	; 0x508
#     888:	f8c3 1508 	str.w	r1, [r3, #1288]	; 0x508
#     88c:	bc30      	pop	{r4, r5}
#     88e:	4770      	bx	lr

#00000890 <nrf_drv_common_irq_enable>:
#     890:	2800      	cmp	r0, #0
#     892:	db16      	blt.n	8c2 <nrf_drv_common_irq_enable+0x32>
#     894:	f100 4360 	add.w	r3, r0, #3758096384	; 0xe0000000
#     898:	0149      	lsls	r1, r1, #5
#     89a:	f503 4361 	add.w	r3, r3, #57600	; 0xe100
#     89e:	b2c9      	uxtb	r1, r1
#     8a0:	f883 1300 	strb.w	r1, [r3, #768]	; 0x300
#     8a4:	b2c2      	uxtb	r2, r0
#     8a6:	0943      	lsrs	r3, r0, #5
#     8a8:	009b      	lsls	r3, r3, #2
#     8aa:	f103 4360 	add.w	r3, r3, #3758096384	; 0xe0000000
#     8ae:	f503 4361 	add.w	r3, r3, #57600	; 0xe100
#     8b2:	f002 011f 	and.w	r1, r2, #31
#     8b6:	2201      	movs	r2, #1
#     8b8:	408a      	lsls	r2, r1
#     8ba:	f8c3 2180 	str.w	r2, [r3, #384]	; 0x180
#     8be:	601a      	str	r2, [r3, #0]
#     8c0:	4770      	bx	lr
     8c2:	4b04      	ldr	r3, [pc, #16]	; (8d4 <nrf_drv_common_irq_enable+0x44>)
     8c4:	f000 020f 	and.w	r2, r0, #15
     8c8:	4413      	add	r3, r2
     8ca:	0149      	lsls	r1, r1, #5
     8cc:	b2c9      	uxtb	r1, r1
     8ce:	7619      	strb	r1, [r3, #24]
     8d0:	b2c2      	uxtb	r2, r0
     8d2:	e7e8      	b.n	8a6 <nrf_drv_common_irq_enable+0x16>
     8d4:	e000ecfc 	.word	0xe000ecfc

#000008d8 <nrf_drv_uart_init>:
#     8d8:	b5f0      	push	{r4, r5, r6, r7, lr}
#     8da:	4d65      	ldr	r5, [pc, #404]	; (a70 <nrf_drv_uart_init+0x198>)
#     8dc:	7903      	ldrb	r3, [r0, #4]
#     8de:	4604      	mov	r4, r0
#     8e0:	eb05 1043 	add.w	r0, r5, r3, lsl #5
#     8e4:	b083      	sub	sp, #12
#     8e6:	7ec7      	ldrb	r7, [r0, #27]
#     8e8:	2f00      	cmp	r7, #0
#     8ea:	f040 8098 	bne.w	a1e <nrf_drv_uart_init+0x146>
#     8ee:	015e      	lsls	r6, r3, #5
#     8f0:	7f4b      	ldrb	r3, [r1, #29]
#     8f2:	7703      	strb	r3, [r0, #28]
#     8f4:	680b      	ldr	r3, [r1, #0]
#     8f6:	1c58      	adds	r0, r3, #1
#     8f8:	d00c      	beq.n	914 <nrf_drv_uart_init+0x3c>
#     8fa:	2001      	movs	r0, #1
#     8fc:	f04f 47a0 	mov.w	r7, #1342177280	; 0x50000000
#     900:	fa00 f303 	lsl.w	r3, r0, r3
#     904:	f8c7 3508 	str.w	r3, [r7, #1288]	; 0x508
#     908:	680b      	ldr	r3, [r1, #0]
#     90a:	f503 73e0 	add.w	r3, r3, #448	; 0x1c0
#     90e:	2003      	movs	r0, #3
#     910:	f847 0023 	str.w	r0, [r7, r3, lsl #2]
#     914:	684b      	ldr	r3, [r1, #4]
#     916:	1c5f      	adds	r7, r3, #1
#     918:	d006      	beq.n	928 <nrf_drv_uart_init+0x50>
#     91a:	f503 73e0 	add.w	r3, r3, #448	; 0x1c0
#     91e:	f04f 40a0 	mov.w	r0, #1342177280	; 0x50000000
#     922:	2700      	movs	r7, #0
#     924:	f840 7023 	str.w	r7, [r0, r3, lsl #2]
#     928:	7923      	ldrb	r3, [r4, #4]
#     92a:	eb05 1343 	add.w	r3, r5, r3, lsl #5
#     92e:	7f1b      	ldrb	r3, [r3, #28]
#     930:	2b00      	cmp	r3, #0
#     932:	d13e      	bne.n	9b2 <nrf_drv_uart_init+0xda>
     934:	6820      	ldr	r0, [r4, #0]
     936:	698f      	ldr	r7, [r1, #24]
     938:	f8c0 7524 	str.w	r7, [r0, #1316]	; 0x524
     93c:	f891 c014 	ldrb.w	ip, [r1, #20]
     940:	7d48      	ldrb	r0, [r1, #21]
     942:	6827      	ldr	r7, [r4, #0]
     944:	ea40 000c 	orr.w	r0, r0, ip
     948:	f8c7 056c 	str.w	r0, [r7, #1388]	; 0x56c
     94c:	e9d1 c700 	ldrd	ip, r7, [r1]
     950:	6820      	ldr	r0, [r4, #0]
     952:	f8c0 7514 	str.w	r7, [r0, #1300]	; 0x514
     956:	f8c0 c50c 	str.w	ip, [r0, #1292]	; 0x50c
     95a:	7d08      	ldrb	r0, [r1, #20]
     95c:	2801      	cmp	r0, #1
     95e:	d07d      	beq.n	a5c <nrf_drv_uart_init+0x184>
#     960:	19ab      	adds	r3, r5, r6
#     962:	605a      	str	r2, [r3, #4]
#     964:	690b      	ldr	r3, [r1, #16]
#     966:	51ab      	str	r3, [r5, r6]
#     968:	b17a      	cbz	r2, 98a <nrf_drv_uart_init+0xb2>
#     96a:	7923      	ldrb	r3, [r4, #4]
#     96c:	7f09      	ldrb	r1, [r1, #28]
#     96e:	eb05 1343 	add.w	r3, r5, r3, lsl #5
#     972:	7f1b      	ldrb	r3, [r3, #28]
#     974:	2b00      	cmp	r3, #0
#     976:	d059      	beq.n	a2c <nrf_drv_uart_init+0x154>
#     978:	6823      	ldr	r3, [r4, #0]
#     97a:	4a3e      	ldr	r2, [pc, #248]	; (a74 <nrf_drv_uart_init+0x19c>)
#     97c:	f8c3 2304 	str.w	r2, [r3, #772]	; 0x304
#     980:	6820      	ldr	r0, [r4, #0]
#     982:	f340 3007 	sbfx	r0, r0, #12, #8
#     986:	f7ff ff83 	bl	890 <nrf_drv_common_irq_enable>
#     98a:	7923      	ldrb	r3, [r4, #4]
#     98c:	6822      	ldr	r2, [r4, #0]
#     98e:	eb05 1343 	add.w	r3, r5, r3, lsl #5
#     992:	7f1b      	ldrb	r3, [r3, #28]
#     994:	2b00      	cmp	r3, #0
#     996:	d045      	beq.n	a24 <nrf_drv_uart_init+0x14c>
#     998:	2308      	movs	r3, #8
#     99a:	f8c2 3500 	str.w	r3, [r2, #1280]	; 0x500
#     99e:	4435      	add	r5, r6
#     9a0:	2300      	movs	r3, #0
#     9a2:	f44f 7280 	mov.w	r2, #256	; 0x100
#     9a6:	4618      	mov	r0, r3
#     9a8:	762b      	strb	r3, [r5, #24]
#     9aa:	82eb      	strh	r3, [r5, #22]
#     9ac:	836a      	strh	r2, [r5, #26]
#     9ae:	b003      	add	sp, #12
#     9b0:	bdf0      	pop	{r4, r5, r6, r7, pc}
#     9b2:	6823      	ldr	r3, [r4, #0]
#     9b4:	6988      	ldr	r0, [r1, #24]
#     9b6:	f8c3 0524 	str.w	r0, [r3, #1316]	; 0x524
#     9ba:	7d0f      	ldrb	r7, [r1, #20]
#     9bc:	7d4b      	ldrb	r3, [r1, #21]
#     9be:	6820      	ldr	r0, [r4, #0]
#     9c0:	433b      	orrs	r3, r7
#     9c2:	f8c0 356c 	str.w	r3, [r0, #1388]	; 0x56c
#     9c6:	e9d1 7000 	ldrd	r7, r0, [r1]
#     9ca:	6823      	ldr	r3, [r4, #0]
#     9cc:	f8c3 750c 	str.w	r7, [r3, #1292]	; 0x50c
#     9d0:	f8c3 0514 	str.w	r0, [r3, #1300]	; 0x514
#     9d4:	7d0b      	ldrb	r3, [r1, #20]
#     9d6:	2b01      	cmp	r3, #1
#     9d8:	d1c2      	bne.n	960 <nrf_drv_uart_init+0x88>
#     9da:	688b      	ldr	r3, [r1, #8]
#     9dc:	1c58      	adds	r0, r3, #1
#     9de:	d006      	beq.n	9ee <nrf_drv_uart_init+0x116>
#     9e0:	f503 73e0 	add.w	r3, r3, #448	; 0x1c0
#     9e4:	f04f 40a0 	mov.w	r0, #1342177280	; 0x50000000
#     9e8:	2700      	movs	r7, #0
#     9ea:	f840 7023 	str.w	r7, [r0, r3, lsl #2]
#     9ee:	68cb      	ldr	r3, [r1, #12]
#     9f0:	1c58      	adds	r0, r3, #1
#     9f2:	d00d      	beq.n	a10 <nrf_drv_uart_init+0x138>
#     9f4:	2001      	movs	r0, #1
#     9f6:	f04f 47a0 	mov.w	r7, #1342177280	; 0x50000000
#     9fa:	fa00 f303 	lsl.w	r3, r0, r3
#     9fe:	f8c7 3508 	str.w	r3, [r7, #1288]	; 0x508
#     a02:	68cb      	ldr	r3, [r1, #12]
#     a04:	f503 73e0 	add.w	r3, r3, #448	; 0x1c0
#     a08:	2003      	movs	r0, #3
#     a0a:	f847 0023 	str.w	r0, [r7, r3, lsl #2]
#     a0e:	68cb      	ldr	r3, [r1, #12]
#     a10:	6820      	ldr	r0, [r4, #0]
#     a12:	688f      	ldr	r7, [r1, #8]
#     a14:	f8c0 3508 	str.w	r3, [r0, #1288]	; 0x508
#     a18:	f8c0 7510 	str.w	r7, [r0, #1296]	; 0x510
#     a1c:	e7a0      	b.n	960 <nrf_drv_uart_init+0x88>
     a1e:	2008      	movs	r0, #8
     a20:	b003      	add	sp, #12
     a22:	bdf0      	pop	{r4, r5, r6, r7, pc}
     a24:	2304      	movs	r3, #4
     a26:	f8c2 3500 	str.w	r3, [r2, #1280]	; 0x500
     a2a:	e7b8      	b.n	99e <nrf_drv_uart_init+0xc6>
     a2c:	6822      	ldr	r2, [r4, #0]
     a2e:	4812      	ldr	r0, [pc, #72]	; (a78 <nrf_drv_uart_init+0x1a0>)
     a30:	f8c2 311c 	str.w	r3, [r2, #284]	; 0x11c
     a34:	f8d2 211c 	ldr.w	r2, [r2, #284]	; 0x11c
     a38:	9200      	str	r2, [sp, #0]
     a3a:	6822      	ldr	r2, [r4, #0]
     a3c:	9f00      	ldr	r7, [sp, #0]
     a3e:	f8c2 3144 	str.w	r3, [r2, #324]	; 0x144
     a42:	f8d2 2144 	ldr.w	r2, [r2, #324]	; 0x144
     a46:	6823      	ldr	r3, [r4, #0]
     a48:	9201      	str	r2, [sp, #4]
     a4a:	9a01      	ldr	r2, [sp, #4]
     a4c:	f8c3 0304 	str.w	r0, [r3, #772]	; 0x304
     a50:	6820      	ldr	r0, [r4, #0]
     a52:	f340 3007 	sbfx	r0, r0, #12, #8
     a56:	f7ff ff1b 	bl	890 <nrf_drv_common_irq_enable>
     a5a:	e796      	b.n	98a <nrf_drv_uart_init+0xb2>
     a5c:	6888      	ldr	r0, [r1, #8]
     a5e:	1c47      	adds	r7, r0, #1
     a60:	d0c5      	beq.n	9ee <nrf_drv_uart_init+0x116>
     a62:	f500 70e0 	add.w	r0, r0, #448	; 0x1c0
     a66:	f04f 47a0 	mov.w	r7, #1342177280	; 0x50000000
     a6a:	f847 3020 	str.w	r3, [r7, r0, lsl #2]
     a6e:	e7be      	b.n	9ee <nrf_drv_uart_init+0x116>
     a70:	200000c4 	.word	0x200000c4
     a74:	00020310 	.word	0x00020310
     a78:	00020080 	.word	0x00020080

#00000a7c <nrf_drv_uart_tx>:
#     a7c:	b5f0      	push	{r4, r5, r6, r7, lr}
#     a7e:	4c55      	ldr	r4, [pc, #340]	; (bd4 <nrf_drv_uart_tx+0x158>)
#     a80:	7903      	ldrb	r3, [r0, #4]
#     a82:	eb04 1543 	add.w	r5, r4, r3, lsl #5
#     a86:	b087      	sub	sp, #28
#     a88:	7f2d      	ldrb	r5, [r5, #28]
#     a8a:	015b      	lsls	r3, r3, #5
#     a8c:	b125      	cbz	r5, a98 <nrf_drv_uart_tx+0x1c>
#     a8e:	f001 4560 	and.w	r5, r1, #3758096384	; 0xe0000000
#     a92:	f1b5 5f00 	cmp.w	r5, #536870912	; 0x20000000
#     a96:	d159      	bne.n	b4c <nrf_drv_uart_tx+0xd0>
#     a98:	4423      	add	r3, r4
#     a9a:	7d9d      	ldrb	r5, [r3, #22]
#     a9c:	2d00      	cmp	r5, #0
#     a9e:	d158      	bne.n	b52 <nrf_drv_uart_tx+0xd6>
#     aa0:	759a      	strb	r2, [r3, #22]
#     aa2:	6099      	str	r1, [r3, #8]
#     aa4:	829d      	strh	r5, [r3, #20]
#     aa6:	7901      	ldrb	r1, [r0, #4]
#     aa8:	eb04 1341 	add.w	r3, r4, r1, lsl #5
#     aac:	0149      	lsls	r1, r1, #5
#     aae:	7f1a      	ldrb	r2, [r3, #28]
#     ab0:	bb1a      	cbnz	r2, afa <nrf_drv_uart_tx+0x7e>
     ab2:	6805      	ldr	r5, [r0, #0]
     ab4:	f8c5 211c 	str.w	r2, [r5, #284]	; 0x11c
     ab8:	f8d5 611c 	ldr.w	r6, [r5, #284]	; 0x11c
     abc:	6805      	ldr	r5, [r0, #0]
     abe:	9604      	str	r6, [sp, #16]
     ac0:	2601      	movs	r6, #1
     ac2:	9f04      	ldr	r7, [sp, #16]
     ac4:	60ae      	str	r6, [r5, #8]
     ac6:	6805      	ldr	r5, [r0, #0]
     ac8:	689f      	ldr	r7, [r3, #8]
     aca:	f8c5 211c 	str.w	r2, [r5, #284]	; 0x11c
     ace:	f8d5 211c 	ldr.w	r2, [r5, #284]	; 0x11c
     ad2:	9205      	str	r2, [sp, #20]
     ad4:	9a05      	ldr	r2, [sp, #20]
     ad6:	f8b3 c014 	ldrh.w	ip, [r3, #20]
     ada:	8a9a      	ldrh	r2, [r3, #20]
     adc:	685e      	ldr	r6, [r3, #4]
     ade:	fa1f fc8c 	uxth.w	ip, ip
     ae2:	3201      	adds	r2, #1
     ae4:	f817 c00c 	ldrb.w	ip, [r7, ip]
     ae8:	b292      	uxth	r2, r2
     aea:	829a      	strh	r2, [r3, #20]
     aec:	f8c5 c51c 	str.w	ip, [r5, #1308]	; 0x51c
     af0:	2e00      	cmp	r6, #0
     af2:	d031      	beq.n	b58 <nrf_drv_uart_tx+0xdc>
#     af4:	2000      	movs	r0, #0
#     af6:	b007      	add	sp, #28
#     af8:	bdf0      	pop	{r4, r5, r6, r7, pc}
#     afa:	6802      	ldr	r2, [r0, #0]
#     afc:	689e      	ldr	r6, [r3, #8]
#     afe:	f8c2 5120 	str.w	r5, [r2, #288]	; 0x120
#     b02:	f8d2 2120 	ldr.w	r2, [r2, #288]	; 0x120
#     b06:	9201      	str	r2, [sp, #4]
#     b08:	6802      	ldr	r2, [r0, #0]
#     b0a:	9f01      	ldr	r7, [sp, #4]
#     b0c:	f8c2 5158 	str.w	r5, [r2, #344]	; 0x158
#     b10:	f8d2 5158 	ldr.w	r5, [r2, #344]	; 0x158
#     b14:	6802      	ldr	r2, [r0, #0]
#     b16:	9502      	str	r5, [sp, #8]
#     b18:	7d9d      	ldrb	r5, [r3, #22]
#     b1a:	9f02      	ldr	r7, [sp, #8]
#     b1c:	f8c2 6544 	str.w	r6, [r2, #1348]	; 0x544
#     b20:	f8c2 5548 	str.w	r5, [r2, #1352]	; 0x548
#     b24:	6802      	ldr	r2, [r0, #0]
#     b26:	2501      	movs	r5, #1
#     b28:	6095      	str	r5, [r2, #8]
#     b2a:	685b      	ldr	r3, [r3, #4]
#     b2c:	2b00      	cmp	r3, #0
#     b2e:	d1e1      	bne.n	af4 <nrf_drv_uart_tx+0x78>
     b30:	6803      	ldr	r3, [r0, #0]
     b32:	e001      	b.n	b38 <nrf_drv_uart_tx+0xbc>
     b34:	2800      	cmp	r0, #0
     b36:	d14a      	bne.n	bce <nrf_drv_uart_tx+0x152>
     b38:	f8d3 2120 	ldr.w	r2, [r3, #288]	; 0x120
     b3c:	f8d3 0158 	ldr.w	r0, [r3, #344]	; 0x158
     b40:	2a00      	cmp	r2, #0
     b42:	d0f7      	beq.n	b34 <nrf_drv_uart_tx+0xb8>
     b44:	2800      	cmp	r0, #0
     b46:	bf18      	it	ne
     b48:	200f      	movne	r0, #15
     b4a:	e03b      	b.n	bc4 <nrf_drv_uart_tx+0x148>
     b4c:	2010      	movs	r0, #16
     b4e:	b007      	add	sp, #28
     b50:	bdf0      	pop	{r4, r5, r6, r7, pc}
     b52:	2011      	movs	r0, #17
     b54:	b007      	add	sp, #28
     b56:	bdf0      	pop	{r4, r5, r6, r7, pc}
     b58:	7d9d      	ldrb	r5, [r3, #22]
     b5a:	8a9a      	ldrh	r2, [r3, #20]
     b5c:	b292      	uxth	r2, r2
     b5e:	42aa      	cmp	r2, r5
     b60:	d223      	bcs.n	baa <nrf_drv_uart_tx+0x12e>
     b62:	f8d0 c000 	ldr.w	ip, [r0]
     b66:	e004      	b.n	b72 <nrf_drv_uart_tx+0xf6>
     b68:	8a9a      	ldrh	r2, [r3, #20]
     b6a:	b292      	uxth	r2, r2
     b6c:	f5b2 7f80 	cmp.w	r2, #256	; 0x100
     b70:	d003      	beq.n	b7a <nrf_drv_uart_tx+0xfe>
     b72:	f8dc 211c 	ldr.w	r2, [ip, #284]	; 0x11c
     b76:	2a00      	cmp	r2, #0
     b78:	d0f6      	beq.n	b68 <nrf_drv_uart_tx+0xec>
     b7a:	8a9a      	ldrh	r2, [r3, #20]
     b7c:	b292      	uxth	r2, r2
     b7e:	f5b2 7f80 	cmp.w	r2, #256	; 0x100
     b82:	d0ea      	beq.n	b5a <nrf_drv_uart_tx+0xde>
     b84:	f8cc 611c 	str.w	r6, [ip, #284]	; 0x11c
     b88:	f8dc 211c 	ldr.w	r2, [ip, #284]	; 0x11c
     b8c:	9203      	str	r2, [sp, #12]
     b8e:	9a03      	ldr	r2, [sp, #12]
     b90:	f8b3 e014 	ldrh.w	lr, [r3, #20]
     b94:	8a9a      	ldrh	r2, [r3, #20]
     b96:	fa1f fe8e 	uxth.w	lr, lr
     b9a:	3201      	adds	r2, #1
     b9c:	f817 e00e 	ldrb.w	lr, [r7, lr]
     ba0:	b292      	uxth	r2, r2
     ba2:	829a      	strh	r2, [r3, #20]
     ba4:	f8cc e51c 	str.w	lr, [ip, #1308]	; 0x51c
     ba8:	e7d7      	b.n	b5a <nrf_drv_uart_tx+0xde>
     baa:	8a9b      	ldrh	r3, [r3, #20]
     bac:	b29b      	uxth	r3, r3
     bae:	f5b3 7f80 	cmp.w	r3, #256	; 0x100
     bb2:	d00c      	beq.n	bce <nrf_drv_uart_tx+0x152>
     bb4:	6802      	ldr	r2, [r0, #0]
     bb6:	f8d2 311c 	ldr.w	r3, [r2, #284]	; 0x11c
     bba:	2b00      	cmp	r3, #0
     bbc:	d0fb      	beq.n	bb6 <nrf_drv_uart_tx+0x13a>
     bbe:	2301      	movs	r3, #1
     bc0:	60d3      	str	r3, [r2, #12]
     bc2:	2000      	movs	r0, #0
     bc4:	440c      	add	r4, r1
     bc6:	2300      	movs	r3, #0
     bc8:	75a3      	strb	r3, [r4, #22]
     bca:	b007      	add	sp, #28
     bcc:	bdf0      	pop	{r4, r5, r6, r7, pc}
     bce:	200f      	movs	r0, #15
     bd0:	e7f8      	b.n	bc4 <nrf_drv_uart_tx+0x148>
     bd2:	bf00      	nop
     bd4:	200000c4 	.word	0x200000c4

#00000bd8 <nrf_drv_uart_tx_in_progress>:
#     bd8:	7902      	ldrb	r2, [r0, #4]
#     bda:	4b04      	ldr	r3, [pc, #16]	; (bec <nrf_drv_uart_tx_in_progress+0x14>)
#     bdc:	eb03 1342 	add.w	r3, r3, r2, lsl #5
#     be0:	7d98      	ldrb	r0, [r3, #22]
#     be2:	3800      	subs	r0, #0
#     be4:	bf18      	it	ne
#     be6:	2001      	movne	r0, #1
#     be8:	4770      	bx	lr
     bea:	bf00      	nop
     bec:	200000c4 	.word	0x200000c4

#00000bf0 <nrf_drv_uart_rx>:
#     bf0:	b4f0      	push	{r4, r5, r6, r7}
#     bf2:	4603      	mov	r3, r0
#     bf4:	4c97      	ldr	r4, [pc, #604]	; (e54 <nrf_drv_uart_rx+0x264>)
#     bf6:	7900      	ldrb	r0, [r0, #4]
#     bf8:	eb04 1640 	add.w	r6, r4, r0, lsl #5
#     bfc:	b088      	sub	sp, #32
#     bfe:	7f35      	ldrb	r5, [r6, #28]
#     c00:	0140      	lsls	r0, r0, #5
#     c02:	b36d      	cbz	r5, c60 <nrf_drv_uart_rx+0x70>
#     c04:	f001 4560 	and.w	r5, r1, #3758096384	; 0xe0000000
#     c08:	f1b5 5f00 	cmp.w	r5, #536870912	; 0x20000000
#     c0c:	f040 809c 	bne.w	d48 <nrf_drv_uart_rx+0x158>
#     c10:	6875      	ldr	r5, [r6, #4]
#     c12:	2d00      	cmp	r5, #0
#     c14:	d062      	beq.n	cdc <nrf_drv_uart_rx+0xec>
#     c16:	681d      	ldr	r5, [r3, #0]
#     c18:	f44f 7604 	mov.w	r6, #528	; 0x210
#     c1c:	f8c5 6308 	str.w	r6, [r5, #776]	; 0x308
#     c20:	1825      	adds	r5, r4, r0
#     c22:	7dee      	ldrb	r6, [r5, #23]
#     c24:	b346      	cbz	r6, c78 <nrf_drv_uart_rx+0x88>
     c26:	7e2d      	ldrb	r5, [r5, #24]
     c28:	2d00      	cmp	r5, #0
     c2a:	f040 80f5 	bne.w	e18 <nrf_drv_uart_rx+0x228>
     c2e:	4420      	add	r0, r4
     c30:	6101      	str	r1, [r0, #16]
     c32:	7602      	strb	r2, [r0, #24]
     c34:	7918      	ldrb	r0, [r3, #4]
     c36:	eb04 1640 	add.w	r6, r4, r0, lsl #5
     c3a:	0145      	lsls	r5, r0, #5
     c3c:	7f30      	ldrb	r0, [r6, #28]
     c3e:	2800      	cmp	r0, #0
     c40:	f040 8086 	bne.w	d50 <nrf_drv_uart_rx+0x160>
     c44:	1961      	adds	r1, r4, r5
     c46:	684a      	ldr	r2, [r1, #4]
     c48:	2a00      	cmp	r2, #0
     c4a:	f000 809d 	beq.w	d88 <nrf_drv_uart_rx+0x198>
     c4e:	681b      	ldr	r3, [r3, #0]
     c50:	f44f 7201 	mov.w	r2, #516	; 0x204
     c54:	f8c3 2304 	str.w	r2, [r3, #772]	; 0x304
     c58:	2000      	movs	r0, #0
     c5a:	b008      	add	sp, #32
     c5c:	bcf0      	pop	{r4, r5, r6, r7}
     c5e:	4770      	bx	lr
     c60:	6875      	ldr	r5, [r6, #4]
     c62:	2d00      	cmp	r5, #0
     c64:	d03a      	beq.n	cdc <nrf_drv_uart_rx+0xec>
     c66:	681d      	ldr	r5, [r3, #0]
     c68:	f44f 7601 	mov.w	r6, #516	; 0x204
     c6c:	f8c5 6308 	str.w	r6, [r5, #776]	; 0x308
     c70:	1825      	adds	r5, r4, r0
     c72:	7dee      	ldrb	r6, [r5, #23]
     c74:	2e00      	cmp	r6, #0
     c76:	d1d6      	bne.n	c26 <nrf_drv_uart_rx+0x36>
#     c78:	4420      	add	r0, r4
#     c7a:	2600      	movs	r6, #0
#     c7c:	75c2      	strb	r2, [r0, #23]
#     c7e:	60c1      	str	r1, [r0, #12]
#     c80:	7646      	strb	r6, [r0, #25]
#     c82:	7606      	strb	r6, [r0, #24]
#     c84:	7918      	ldrb	r0, [r3, #4]
#     c86:	eb04 1740 	add.w	r7, r4, r0, lsl #5
#     c8a:	0145      	lsls	r5, r0, #5
#     c8c:	7f38      	ldrb	r0, [r7, #28]
#     c8e:	2800      	cmp	r0, #0
#     c90:	d045      	beq.n	d1e <nrf_drv_uart_rx+0x12e>
#     c92:	6818      	ldr	r0, [r3, #0]
#     c94:	f8c0 6110 	str.w	r6, [r0, #272]	; 0x110
#     c98:	f8d0 5110 	ldr.w	r5, [r0, #272]	; 0x110
#     c9c:	6818      	ldr	r0, [r3, #0]
#     c9e:	9501      	str	r5, [sp, #4]
#     ca0:	9d01      	ldr	r5, [sp, #4]
#     ca2:	f8c0 6144 	str.w	r6, [r0, #324]	; 0x144
#     ca6:	f8d0 5144 	ldr.w	r5, [r0, #324]	; 0x144
#     caa:	6818      	ldr	r0, [r3, #0]
#     cac:	9502      	str	r5, [sp, #8]
#     cae:	9d02      	ldr	r5, [sp, #8]
#     cb0:	f8c0 1534 	str.w	r1, [r0, #1332]	; 0x534
#     cb4:	f8c0 2538 	str.w	r2, [r0, #1336]	; 0x538
#     cb8:	681a      	ldr	r2, [r3, #0]
#     cba:	2101      	movs	r1, #1
#     cbc:	6011      	str	r1, [r2, #0]
#     cbe:	791a      	ldrb	r2, [r3, #4]
#     cc0:	681b      	ldr	r3, [r3, #0]
#     cc2:	eb04 1142 	add.w	r1, r4, r2, lsl #5
#     cc6:	0155      	lsls	r5, r2, #5
#     cc8:	684a      	ldr	r2, [r1, #4]
#     cca:	b1aa      	cbz	r2, cf8 <nrf_drv_uart_rx+0x108>
#     ccc:	f44f 7204 	mov.w	r2, #528	; 0x210
#     cd0:	2000      	movs	r0, #0
#     cd2:	f8c3 2304 	str.w	r2, [r3, #772]	; 0x304
#     cd6:	b008      	add	sp, #32
#     cd8:	bcf0      	pop	{r4, r5, r6, r7}
#     cda:	4770      	bx	lr
     cdc:	7df5      	ldrb	r5, [r6, #23]
     cde:	2d00      	cmp	r5, #0
     ce0:	d0ca      	beq.n	c78 <nrf_drv_uart_rx+0x88>
     ce2:	7e35      	ldrb	r5, [r6, #24]
     ce4:	2d00      	cmp	r5, #0
     ce6:	d0a2      	beq.n	c2e <nrf_drv_uart_rx+0x3e>
     ce8:	2011      	movs	r0, #17
     cea:	e7b6      	b.n	c5a <nrf_drv_uart_rx+0x6a>
     cec:	2a00      	cmp	r2, #0
     cee:	f040 80a9 	bne.w	e44 <nrf_drv_uart_rx+0x254>
     cf2:	2800      	cmp	r0, #0
     cf4:	f040 80aa 	bne.w	e4c <nrf_drv_uart_rx+0x25c>
     cf8:	f8d3 1110 	ldr.w	r1, [r3, #272]	; 0x110
     cfc:	f8d3 2144 	ldr.w	r2, [r3, #324]	; 0x144
     d00:	f8d3 0124 	ldr.w	r0, [r3, #292]	; 0x124
     d04:	2900      	cmp	r1, #0
     d06:	d0f1      	beq.n	cec <nrf_drv_uart_rx+0xfc>
     d08:	2800      	cmp	r0, #0
     d0a:	f04f 0300 	mov.w	r3, #0
     d0e:	442c      	add	r4, r5
     d10:	bf18      	it	ne
     d12:	2003      	movne	r0, #3
     d14:	429a      	cmp	r2, r3
     d16:	bf18      	it	ne
     d18:	200f      	movne	r0, #15
     d1a:	75e3      	strb	r3, [r4, #23]
     d1c:	e79d      	b.n	c5a <nrf_drv_uart_rx+0x6a>
     d1e:	7eba      	ldrb	r2, [r7, #26]
     d20:	2a00      	cmp	r2, #0
     d22:	d18f      	bne.n	c44 <nrf_drv_uart_rx+0x54>
     d24:	6819      	ldr	r1, [r3, #0]
     d26:	f8c1 2124 	str.w	r2, [r1, #292]	; 0x124
     d2a:	f8d1 0124 	ldr.w	r0, [r1, #292]	; 0x124
     d2e:	6819      	ldr	r1, [r3, #0]
     d30:	9003      	str	r0, [sp, #12]
     d32:	9803      	ldr	r0, [sp, #12]
     d34:	f8c1 2108 	str.w	r2, [r1, #264]	; 0x108
     d38:	f8d1 1108 	ldr.w	r1, [r1, #264]	; 0x108
     d3c:	681a      	ldr	r2, [r3, #0]
     d3e:	9104      	str	r1, [sp, #16]
     d40:	2101      	movs	r1, #1
     d42:	9804      	ldr	r0, [sp, #16]
     d44:	6011      	str	r1, [r2, #0]
     d46:	e77d      	b.n	c44 <nrf_drv_uart_rx+0x54>
     d48:	2010      	movs	r0, #16
     d4a:	b008      	add	sp, #32
     d4c:	bcf0      	pop	{r4, r5, r6, r7}
     d4e:	4770      	bx	lr
     d50:	6818      	ldr	r0, [r3, #0]
     d52:	2500      	movs	r5, #0
     d54:	f8c0 5110 	str.w	r5, [r0, #272]	; 0x110
     d58:	f8d0 6110 	ldr.w	r6, [r0, #272]	; 0x110
     d5c:	6818      	ldr	r0, [r3, #0]
     d5e:	9601      	str	r6, [sp, #4]
     d60:	9e01      	ldr	r6, [sp, #4]
     d62:	f8c0 5144 	str.w	r5, [r0, #324]	; 0x144
     d66:	f8d0 5144 	ldr.w	r5, [r0, #324]	; 0x144
     d6a:	6818      	ldr	r0, [r3, #0]
     d6c:	9502      	str	r5, [sp, #8]
     d6e:	9d02      	ldr	r5, [sp, #8]
     d70:	f8c0 1534 	str.w	r1, [r0, #1332]	; 0x534
     d74:	f8c0 2538 	str.w	r2, [r0, #1336]	; 0x538
     d78:	6819      	ldr	r1, [r3, #0]
     d7a:	f8d1 2200 	ldr.w	r2, [r1, #512]	; 0x200
     d7e:	f042 0220 	orr.w	r2, r2, #32
     d82:	f8c1 2200 	str.w	r2, [r1, #512]	; 0x200
     d86:	e79a      	b.n	cbe <nrf_drv_uart_rx+0xce>
     d88:	6818      	ldr	r0, [r3, #0]
     d8a:	f8c0 2144 	str.w	r2, [r0, #324]	; 0x144
     d8e:	f8d0 2144 	ldr.w	r2, [r0, #324]	; 0x144
     d92:	9205      	str	r2, [sp, #20]
     d94:	9a05      	ldr	r2, [sp, #20]
     d96:	681f      	ldr	r7, [r3, #0]
     d98:	f8d7 2124 	ldr.w	r2, [r7, #292]	; 0x124
     d9c:	f8d7 6108 	ldr.w	r6, [r7, #264]	; 0x108
     da0:	f8d7 0144 	ldr.w	r0, [r7, #324]	; 0x144
     da4:	b946      	cbnz	r6, db8 <nrf_drv_uart_rx+0x1c8>
     da6:	2800      	cmp	r0, #0
     da8:	d12f      	bne.n	e0a <nrf_drv_uart_rx+0x21a>
     daa:	2a00      	cmp	r2, #0
     dac:	d0f4      	beq.n	d98 <nrf_drv_uart_rx+0x1a8>
     dae:	442c      	add	r4, r5
     db0:	2300      	movs	r3, #0
     db2:	75e3      	strb	r3, [r4, #23]
     db4:	2003      	movs	r0, #3
     db6:	e750      	b.n	c5a <nrf_drv_uart_rx+0x6a>
     db8:	2a00      	cmp	r2, #0
     dba:	d1f8      	bne.n	dae <nrf_drv_uart_rx+0x1be>
     dbc:	bb38      	cbnz	r0, e0e <nrf_drv_uart_rx+0x21e>
     dbe:	7dca      	ldrb	r2, [r1, #23]
     dc0:	f8c7 0108 	str.w	r0, [r7, #264]	; 0x108
     dc4:	b18a      	cbz	r2, dea <nrf_drv_uart_rx+0x1fa>
     dc6:	f8d7 2108 	ldr.w	r2, [r7, #264]	; 0x108
     dca:	9206      	str	r2, [sp, #24]
     dcc:	9a06      	ldr	r2, [sp, #24]
     dce:	7e4a      	ldrb	r2, [r1, #25]
     dd0:	f8d7 6518 	ldr.w	r6, [r7, #1304]	; 0x518
     dd4:	68cf      	ldr	r7, [r1, #12]
     dd6:	54be      	strb	r6, [r7, r2]
     dd8:	7e4a      	ldrb	r2, [r1, #25]
     dda:	7dce      	ldrb	r6, [r1, #23]
     ddc:	3201      	adds	r2, #1
     dde:	b2d2      	uxtb	r2, r2
     de0:	764a      	strb	r2, [r1, #25]
     de2:	7e4a      	ldrb	r2, [r1, #25]
     de4:	4296      	cmp	r6, r2
     de6:	d8d6      	bhi.n	d96 <nrf_drv_uart_rx+0x1a6>
     de8:	e006      	b.n	df8 <nrf_drv_uart_rx+0x208>
     dea:	f8d7 2108 	ldr.w	r2, [r7, #264]	; 0x108
     dee:	9207      	str	r2, [sp, #28]
     df0:	9a07      	ldr	r2, [sp, #28]
     df2:	f8d7 2518 	ldr.w	r2, [r7, #1304]	; 0x518
     df6:	7e4a      	ldrb	r2, [r1, #25]
     df8:	442c      	add	r4, r5
     dfa:	2100      	movs	r1, #0
     dfc:	7ea2      	ldrb	r2, [r4, #26]
     dfe:	75e1      	strb	r1, [r4, #23]
     e00:	b1b2      	cbz	r2, e30 <nrf_drv_uart_rx+0x240>
     e02:	681b      	ldr	r3, [r3, #0]
     e04:	2201      	movs	r2, #1
     e06:	601a      	str	r2, [r3, #0]
     e08:	e727      	b.n	c5a <nrf_drv_uart_rx+0x6a>
     e0a:	2a00      	cmp	r2, #0
     e0c:	d1cf      	bne.n	dae <nrf_drv_uart_rx+0x1be>
     e0e:	442c      	add	r4, r5
     e10:	2300      	movs	r3, #0
     e12:	75e3      	strb	r3, [r4, #23]
     e14:	200f      	movs	r0, #15
     e16:	e720      	b.n	c5a <nrf_drv_uart_rx+0x6a>
     e18:	791a      	ldrb	r2, [r3, #4]
     e1a:	681b      	ldr	r3, [r3, #0]
     e1c:	eb04 1442 	add.w	r4, r4, r2, lsl #5
     e20:	7f22      	ldrb	r2, [r4, #28]
     e22:	b14a      	cbz	r2, e38 <nrf_drv_uart_rx+0x248>
     e24:	f44f 7204 	mov.w	r2, #528	; 0x210
     e28:	f8c3 2304 	str.w	r2, [r3, #772]	; 0x304
     e2c:	2011      	movs	r0, #17
     e2e:	e714      	b.n	c5a <nrf_drv_uart_rx+0x6a>
     e30:	681b      	ldr	r3, [r3, #0]
     e32:	2201      	movs	r2, #1
     e34:	605a      	str	r2, [r3, #4]
     e36:	e710      	b.n	c5a <nrf_drv_uart_rx+0x6a>
     e38:	f44f 7201 	mov.w	r2, #516	; 0x204
     e3c:	f8c3 2304 	str.w	r2, [r3, #772]	; 0x304
     e40:	2011      	movs	r0, #17
     e42:	e70a      	b.n	c5a <nrf_drv_uart_rx+0x6a>
     e44:	442c      	add	r4, r5
     e46:	200f      	movs	r0, #15
     e48:	75e1      	strb	r1, [r4, #23]
     e4a:	e706      	b.n	c5a <nrf_drv_uart_rx+0x6a>
     e4c:	442c      	add	r4, r5
     e4e:	2003      	movs	r0, #3
     e50:	75e2      	strb	r2, [r4, #23]
     e52:	e702      	b.n	c5a <nrf_drv_uart_rx+0x6a>
     e54:	200000c4 	.word	0x200000c4

00000e58 <nrf_drv_uart_rx_enable>:
     e58:	4a11      	ldr	r2, [pc, #68]	; (ea0 <nrf_drv_uart_rx_enable+0x48>)
     e5a:	7903      	ldrb	r3, [r0, #4]
     e5c:	eb02 1343 	add.w	r3, r2, r3, lsl #5
     e60:	7f19      	ldrb	r1, [r3, #28]
     e62:	b9d9      	cbnz	r1, e9c <nrf_drv_uart_rx_enable+0x44>
     e64:	7e9b      	ldrb	r3, [r3, #26]
     e66:	b9cb      	cbnz	r3, e9c <nrf_drv_uart_rx_enable+0x44>
     e68:	b410      	push	{r4}
     e6a:	6801      	ldr	r1, [r0, #0]
     e6c:	b083      	sub	sp, #12
     e6e:	f8c1 3124 	str.w	r3, [r1, #292]	; 0x124
     e72:	f8d1 4124 	ldr.w	r4, [r1, #292]	; 0x124
     e76:	6801      	ldr	r1, [r0, #0]
     e78:	9400      	str	r4, [sp, #0]
     e7a:	9c00      	ldr	r4, [sp, #0]
     e7c:	f8c1 3108 	str.w	r3, [r1, #264]	; 0x108
     e80:	f8d1 3108 	ldr.w	r3, [r1, #264]	; 0x108
     e84:	6801      	ldr	r1, [r0, #0]
     e86:	9301      	str	r3, [sp, #4]
     e88:	2301      	movs	r3, #1
     e8a:	9c01      	ldr	r4, [sp, #4]
     e8c:	600b      	str	r3, [r1, #0]
     e8e:	7901      	ldrb	r1, [r0, #4]
     e90:	eb02 1241 	add.w	r2, r2, r1, lsl #5
     e94:	7693      	strb	r3, [r2, #26]
     e96:	b003      	add	sp, #12
     e98:	bc10      	pop	{r4}
     e9a:	4770      	bx	lr
     e9c:	4770      	bx	lr
     e9e:	bf00      	nop
     ea0:	200000c4 	.word	0x200000c4

#00000ea4 <UARTE0_UART0_IRQHandler>:
#     ea4:	b570      	push	{r4, r5, r6, lr}
#     ea6:	4ca8      	ldr	r4, [pc, #672]	; (1148 <UARTE0_UART0_IRQHandler+0x2a4>)
#     ea8:	7f23      	ldrb	r3, [r4, #28]
#     eaa:	b08e      	sub	sp, #56	; 0x38
#     eac:	2b00      	cmp	r3, #0
#     eae:	d074      	beq.n	f9a <UARTE0_UART0_IRQHandler+0xf6>
#     eb0:	4ba6      	ldr	r3, [pc, #664]	; (114c <UARTE0_UART0_IRQHandler+0x2a8>)
#     eb2:	f8d3 2124 	ldr.w	r2, [r3, #292]	; 0x124
#     eb6:	2a00      	cmp	r2, #0
#     eb8:	d045      	beq.n	f46 <UARTE0_UART0_IRQHandler+0xa2>
#     eba:	2200      	movs	r2, #0
#     ebc:	f8c3 2124 	str.w	r2, [r3, #292]	; 0x124
#     ec0:	f8d3 1124 	ldr.w	r1, [r3, #292]	; 0x124
#     ec4:	9102      	str	r1, [sp, #8]
#     ec6:	2102      	movs	r1, #2
#     ec8:	f88d 1028 	strb.w	r1, [sp, #40]	; 0x28
#     ecc:	9902      	ldr	r1, [sp, #8]
#     ece:	f8d3 1480 	ldr.w	r1, [r3, #1152]	; 0x480
#     ed2:	f8c3 1480 	str.w	r1, [r3, #1152]	; 0x480
#     ed6:	910d      	str	r1, [sp, #52]	; 0x34
#     ed8:	f8d3 153c 	ldr.w	r1, [r3, #1340]	; 0x53c
#     edc:	68e3      	ldr	r3, [r4, #12]
#     ede:	f88d 1030 	strb.w	r1, [sp, #48]	; 0x30
#     ee2:	930b      	str	r3, [sp, #44]	; 0x2c
#     ee4:	6821      	ldr	r1, [r4, #0]
#     ee6:	6863      	ldr	r3, [r4, #4]
#     ee8:	75e2      	strb	r2, [r4, #23]
#     eea:	7622      	strb	r2, [r4, #24]
#     eec:	a80a      	add	r0, sp, #40	; 0x28
#     eee:	4798      	blx	r3
#     ef0:	4b96      	ldr	r3, [pc, #600]	; (114c <UARTE0_UART0_IRQHandler+0x2a8>)
#     ef2:	f8d3 2144 	ldr.w	r2, [r3, #324]	; 0x144
#     ef6:	b152      	cbz	r2, f0e <UARTE0_UART0_IRQHandler+0x6a>
#     ef8:	2200      	movs	r2, #0
#     efa:	f8c3 2144 	str.w	r2, [r3, #324]	; 0x144
#     efe:	f8d3 0144 	ldr.w	r0, [r3, #324]	; 0x144
#     f02:	7de1      	ldrb	r1, [r4, #23]
#     f04:	9001      	str	r0, [sp, #4]
#     f06:	9801      	ldr	r0, [sp, #4]
#     f08:	2900      	cmp	r1, #0
#     f0a:	f040 80e9 	bne.w	10e0 <UARTE0_UART0_IRQHandler+0x23c>
#     f0e:	4b8f      	ldr	r3, [pc, #572]	; (114c <UARTE0_UART0_IRQHandler+0x2a8>)
#     f10:	f8d3 2120 	ldr.w	r2, [r3, #288]	; 0x120
#     f14:	b1aa      	cbz	r2, f42 <UARTE0_UART0_IRQHandler+0x9e>
#     f16:	2200      	movs	r2, #0
#     f18:	f8c3 2120 	str.w	r2, [r3, #288]	; 0x120
#     f1c:	f8d3 0120 	ldr.w	r0, [r3, #288]	; 0x120
#     f20:	7da1      	ldrb	r1, [r4, #22]
#     f22:	9000      	str	r0, [sp, #0]
#     f24:	9800      	ldr	r0, [sp, #0]
#     f26:	b161      	cbz	r1, f42 <UARTE0_UART0_IRQHandler+0x9e>
#     f28:	f8d3 154c 	ldr.w	r1, [r3, #1356]	; 0x54c
#     f2c:	68a3      	ldr	r3, [r4, #8]
#     f2e:	f88d 1030 	strb.w	r1, [sp, #48]	; 0x30
#     f32:	930b      	str	r3, [sp, #44]	; 0x2c
#     f34:	f88d 2028 	strb.w	r2, [sp, #40]	; 0x28
#     f38:	e9d4 1300 	ldrd	r1, r3, [r4]
#     f3c:	75a2      	strb	r2, [r4, #22]
#     f3e:	a80a      	add	r0, sp, #40	; 0x28
#     f40:	4798      	blx	r3
#     f42:	b00e      	add	sp, #56	; 0x38
#     f44:	bd70      	pop	{r4, r5, r6, pc}
#     f46:	f8d3 1110 	ldr.w	r1, [r3, #272]	; 0x110
#     f4a:	2900      	cmp	r1, #0
#     f4c:	d0d0      	beq.n	ef0 <UARTE0_UART0_IRQHandler+0x4c>
#     f4e:	f8c3 2110 	str.w	r2, [r3, #272]	; 0x110
#     f52:	f8d3 1110 	ldr.w	r1, [r3, #272]	; 0x110
#     f56:	9103      	str	r1, [sp, #12]
#     f58:	9903      	ldr	r1, [sp, #12]
#     f5a:	f8d3 153c 	ldr.w	r1, [r3, #1340]	; 0x53c
#     f5e:	7de0      	ldrb	r0, [r4, #23]
#     f60:	b2c9      	uxtb	r1, r1
#     f62:	4288      	cmp	r0, r1
#     f64:	d1c4      	bne.n	ef0 <UARTE0_UART0_IRQHandler+0x4c>
     f66:	7e21      	ldrb	r1, [r4, #24]
     f68:	2900      	cmp	r1, #0
     f6a:	f000 80e0 	beq.w	112e <UARTE0_UART0_IRQHandler+0x28a>
     f6e:	f8d3 5200 	ldr.w	r5, [r3, #512]	; 0x200
     f72:	75e1      	strb	r1, [r4, #23]
     f74:	f025 0520 	bic.w	r5, r5, #32
     f78:	f8c3 5200 	str.w	r5, [r3, #512]	; 0x200
     f7c:	e9d4 6503 	ldrd	r6, r5, [r4, #12]
     f80:	2301      	movs	r3, #1
     f82:	f88d 0030 	strb.w	r0, [sp, #48]	; 0x30
     f86:	f88d 3028 	strb.w	r3, [sp, #40]	; 0x28
     f8a:	6821      	ldr	r1, [r4, #0]
     f8c:	6863      	ldr	r3, [r4, #4]
     f8e:	7622      	strb	r2, [r4, #24]
     f90:	960b      	str	r6, [sp, #44]	; 0x2c
     f92:	60e5      	str	r5, [r4, #12]
     f94:	a80a      	add	r0, sp, #40	; 0x28
     f96:	4798      	blx	r3
     f98:	e7aa      	b.n	ef0 <UARTE0_UART0_IRQHandler+0x4c>
     f9a:	4a6c      	ldr	r2, [pc, #432]	; (114c <UARTE0_UART0_IRQHandler+0x2a8>)
     f9c:	f8d2 1304 	ldr.w	r1, [r2, #772]	; 0x304
     fa0:	0589      	lsls	r1, r1, #22
     fa2:	d567      	bpl.n	1074 <UARTE0_UART0_IRQHandler+0x1d0>
     fa4:	f8d2 1124 	ldr.w	r1, [r2, #292]	; 0x124
     fa8:	2900      	cmp	r1, #0
     faa:	d063      	beq.n	1074 <UARTE0_UART0_IRQHandler+0x1d0>
     fac:	f8c2 3124 	str.w	r3, [r2, #292]	; 0x124
     fb0:	f8d2 1124 	ldr.w	r1, [r2, #292]	; 0x124
     fb4:	7ea3      	ldrb	r3, [r4, #26]
     fb6:	9107      	str	r1, [sp, #28]
     fb8:	f44f 7101 	mov.w	r1, #516	; 0x204
     fbc:	9807      	ldr	r0, [sp, #28]
     fbe:	f8c2 1308 	str.w	r1, [r2, #776]	; 0x308
     fc2:	b90b      	cbnz	r3, fc8 <UARTE0_UART0_IRQHandler+0x124>
     fc4:	2301      	movs	r3, #1
     fc6:	6053      	str	r3, [r2, #4]
     fc8:	4a60      	ldr	r2, [pc, #384]	; (114c <UARTE0_UART0_IRQHandler+0x2a8>)
     fca:	2302      	movs	r3, #2
     fcc:	f88d 3028 	strb.w	r3, [sp, #40]	; 0x28
     fd0:	f8d2 3480 	ldr.w	r3, [r2, #1152]	; 0x480
     fd4:	f8c2 3480 	str.w	r3, [r2, #1152]	; 0x480
     fd8:	7de0      	ldrb	r0, [r4, #23]
     fda:	68e2      	ldr	r2, [r4, #12]
     fdc:	930d      	str	r3, [sp, #52]	; 0x34
     fde:	2300      	movs	r3, #0
     fe0:	f88d 0030 	strb.w	r0, [sp, #48]	; 0x30
     fe4:	75e3      	strb	r3, [r4, #23]
     fe6:	7623      	strb	r3, [r4, #24]
     fe8:	6821      	ldr	r1, [r4, #0]
     fea:	6863      	ldr	r3, [r4, #4]
     fec:	920b      	str	r2, [sp, #44]	; 0x2c
     fee:	a80a      	add	r0, sp, #40	; 0x28
     ff0:	4798      	blx	r3
     ff2:	4b56      	ldr	r3, [pc, #344]	; (114c <UARTE0_UART0_IRQHandler+0x2a8>)
     ff4:	f8d3 211c 	ldr.w	r2, [r3, #284]	; 0x11c
     ff8:	b1c2      	cbz	r2, 102c <UARTE0_UART0_IRQHandler+0x188>
     ffa:	8aa2      	ldrh	r2, [r4, #20]
     ffc:	7da1      	ldrb	r1, [r4, #22]
     ffe:	b292      	uxth	r2, r2
    1000:	428a      	cmp	r2, r1
    1002:	f04f 0200 	mov.w	r2, #0
    1006:	f8c3 211c 	str.w	r2, [r3, #284]	; 0x11c
    100a:	d378      	bcc.n	10fe <UARTE0_UART0_IRQHandler+0x25a>
    100c:	f8d3 311c 	ldr.w	r3, [r3, #284]	; 0x11c
    1010:	9305      	str	r3, [sp, #20]
    1012:	9b05      	ldr	r3, [sp, #20]
    1014:	b151      	cbz	r1, 102c <UARTE0_UART0_IRQHandler+0x188>
    1016:	68a3      	ldr	r3, [r4, #8]
    1018:	f88d 1030 	strb.w	r1, [sp, #48]	; 0x30
    101c:	930b      	str	r3, [sp, #44]	; 0x2c
    101e:	f88d 2028 	strb.w	r2, [sp, #40]	; 0x28
    1022:	e9d4 1300 	ldrd	r1, r3, [r4]
    1026:	75a2      	strb	r2, [r4, #22]
    1028:	a80a      	add	r0, sp, #40	; 0x28
    102a:	4798      	blx	r3
    102c:	4b47      	ldr	r3, [pc, #284]	; (114c <UARTE0_UART0_IRQHandler+0x2a8>)
    102e:	f8d3 2144 	ldr.w	r2, [r3, #324]	; 0x144
    1032:	2a00      	cmp	r2, #0
    1034:	d085      	beq.n	f42 <UARTE0_UART0_IRQHandler+0x9e>
    1036:	2200      	movs	r2, #0
    1038:	f8c3 2144 	str.w	r2, [r3, #324]	; 0x144
    103c:	f8d3 1144 	ldr.w	r1, [r3, #324]	; 0x144
    1040:	7ea2      	ldrb	r2, [r4, #26]
    1042:	9104      	str	r1, [sp, #16]
    1044:	9904      	ldr	r1, [sp, #16]
    1046:	b10a      	cbz	r2, 104c <UARTE0_UART0_IRQHandler+0x1a8>
    1048:	2201      	movs	r2, #1
    104a:	601a      	str	r2, [r3, #0]
    104c:	7de3      	ldrb	r3, [r4, #23]
    104e:	2b00      	cmp	r3, #0
    1050:	f43f af77 	beq.w	f42 <UARTE0_UART0_IRQHandler+0x9e>
    1054:	2300      	movs	r3, #0
    1056:	7e61      	ldrb	r1, [r4, #25]
    1058:	68e2      	ldr	r2, [r4, #12]
    105a:	75e3      	strb	r3, [r4, #23]
    105c:	2301      	movs	r3, #1
    105e:	f88d 1030 	strb.w	r1, [sp, #48]	; 0x30
    1062:	f88d 3028 	strb.w	r3, [sp, #40]	; 0x28
    1066:	920b      	str	r2, [sp, #44]	; 0x2c
    1068:	e9d4 1300 	ldrd	r1, r3, [r4]
    106c:	a80a      	add	r0, sp, #40	; 0x28
    106e:	4798      	blx	r3
    1070:	b00e      	add	sp, #56	; 0x38
    1072:	bd70      	pop	{r4, r5, r6, pc}
    1074:	4b35      	ldr	r3, [pc, #212]	; (114c <UARTE0_UART0_IRQHandler+0x2a8>)
    1076:	f8d3 2304 	ldr.w	r2, [r3, #772]	; 0x304
    107a:	0752      	lsls	r2, r2, #29
    107c:	d5b9      	bpl.n	ff2 <UARTE0_UART0_IRQHandler+0x14e>
    107e:	f8d3 2108 	ldr.w	r2, [r3, #264]	; 0x108
    1082:	2a00      	cmp	r2, #0
    1084:	d0b5      	beq.n	ff2 <UARTE0_UART0_IRQHandler+0x14e>
    1086:	7de2      	ldrb	r2, [r4, #23]
    1088:	2a00      	cmp	r2, #0
    108a:	d047      	beq.n	111c <UARTE0_UART0_IRQHandler+0x278>
    108c:	2200      	movs	r2, #0
    108e:	f8c3 2108 	str.w	r2, [r3, #264]	; 0x108
    1092:	f8d3 2108 	ldr.w	r2, [r3, #264]	; 0x108
    1096:	9208      	str	r2, [sp, #32]
    1098:	9a08      	ldr	r2, [sp, #32]
    109a:	68e1      	ldr	r1, [r4, #12]
    109c:	7e62      	ldrb	r2, [r4, #25]
    109e:	f8d3 3518 	ldr.w	r3, [r3, #1304]	; 0x518
    10a2:	548b      	strb	r3, [r1, r2]
    10a4:	7e63      	ldrb	r3, [r4, #25]
    10a6:	7de2      	ldrb	r2, [r4, #23]
    10a8:	3301      	adds	r3, #1
    10aa:	b2db      	uxtb	r3, r3
    10ac:	7663      	strb	r3, [r4, #25]
    10ae:	7e63      	ldrb	r3, [r4, #25]
    10b0:	4293      	cmp	r3, r2
    10b2:	d19e      	bne.n	ff2 <UARTE0_UART0_IRQHandler+0x14e>
    10b4:	7e23      	ldrb	r3, [r4, #24]
    10b6:	2b00      	cmp	r3, #0
    10b8:	d04a      	beq.n	1150 <UARTE0_UART0_IRQHandler+0x2ac>
    10ba:	7e60      	ldrb	r0, [r4, #25]
    10bc:	68e5      	ldr	r5, [r4, #12]
    10be:	6921      	ldr	r1, [r4, #16]
    10c0:	75e3      	strb	r3, [r4, #23]
    10c2:	2201      	movs	r2, #1
    10c4:	2300      	movs	r3, #0
    10c6:	f88d 0030 	strb.w	r0, [sp, #48]	; 0x30
    10ca:	60e1      	str	r1, [r4, #12]
    10cc:	7623      	strb	r3, [r4, #24]
    10ce:	7663      	strb	r3, [r4, #25]
    10d0:	950b      	str	r5, [sp, #44]	; 0x2c
    10d2:	e9d4 1300 	ldrd	r1, r3, [r4]
    10d6:	f88d 2028 	strb.w	r2, [sp, #40]	; 0x28
    10da:	a80a      	add	r0, sp, #40	; 0x28
    10dc:	4798      	blx	r3
    10de:	e788      	b.n	ff2 <UARTE0_UART0_IRQHandler+0x14e>
#    10e0:	f8d3 353c 	ldr.w	r3, [r3, #1340]	; 0x53c
#    10e4:	68e1      	ldr	r1, [r4, #12]
#    10e6:	f88d 3030 	strb.w	r3, [sp, #48]	; 0x30
#    10ea:	2301      	movs	r3, #1
#    10ec:	910b      	str	r1, [sp, #44]	; 0x2c
#    10ee:	f88d 3028 	strb.w	r3, [sp, #40]	; 0x28
#    10f2:	75e2      	strb	r2, [r4, #23]
#    10f4:	e9d4 1300 	ldrd	r1, r3, [r4]
#    10f8:	a80a      	add	r0, sp, #40	; 0x28
#    10fa:	4798      	blx	r3
#    10fc:	e707      	b.n	f0e <UARTE0_UART0_IRQHandler+0x6a>
    10fe:	f8d3 211c 	ldr.w	r2, [r3, #284]	; 0x11c
    1102:	9206      	str	r2, [sp, #24]
    1104:	9a06      	ldr	r2, [sp, #24]
    1106:	8aa1      	ldrh	r1, [r4, #20]
    1108:	8aa2      	ldrh	r2, [r4, #20]
    110a:	68a0      	ldr	r0, [r4, #8]
    110c:	b289      	uxth	r1, r1
    110e:	3201      	adds	r2, #1
    1110:	5c41      	ldrb	r1, [r0, r1]
    1112:	b292      	uxth	r2, r2
    1114:	82a2      	strh	r2, [r4, #20]
    1116:	f8c3 151c 	str.w	r1, [r3, #1308]	; 0x51c
    111a:	e787      	b.n	102c <UARTE0_UART0_IRQHandler+0x188>
    111c:	f8c3 2108 	str.w	r2, [r3, #264]	; 0x108
    1120:	f8d3 1108 	ldr.w	r1, [r3, #264]	; 0x108
    1124:	9109      	str	r1, [sp, #36]	; 0x24
    1126:	9909      	ldr	r1, [sp, #36]	; 0x24
    1128:	f8d3 3518 	ldr.w	r3, [r3, #1304]	; 0x518
    112c:	e7bf      	b.n	10ae <UARTE0_UART0_IRQHandler+0x20a>
    112e:	68e2      	ldr	r2, [r4, #12]
    1130:	75e1      	strb	r1, [r4, #23]
    1132:	2301      	movs	r3, #1
    1134:	f88d 0030 	strb.w	r0, [sp, #48]	; 0x30
    1138:	f88d 3028 	strb.w	r3, [sp, #40]	; 0x28
    113c:	920b      	str	r2, [sp, #44]	; 0x2c
    113e:	e9d4 1300 	ldrd	r1, r3, [r4]
    1142:	a80a      	add	r0, sp, #40	; 0x28
    1144:	4798      	blx	r3
    1146:	e6d3      	b.n	ef0 <UARTE0_UART0_IRQHandler+0x4c>
    1148:	200000c4 	.word	0x200000c4
    114c:	40002000 	.word	0x40002000
    1150:	7ea3      	ldrb	r3, [r4, #26]
    1152:	b913      	cbnz	r3, 115a <UARTE0_UART0_IRQHandler+0x2b6>
    1154:	4b0b      	ldr	r3, [pc, #44]	; (1184 <UARTE0_UART0_IRQHandler+0x2e0>)
    1156:	2201      	movs	r2, #1
    1158:	605a      	str	r2, [r3, #4]
    115a:	4a0a      	ldr	r2, [pc, #40]	; (1184 <UARTE0_UART0_IRQHandler+0x2e0>)
    115c:	68e0      	ldr	r0, [r4, #12]
    115e:	6863      	ldr	r3, [r4, #4]
    1160:	f44f 7101 	mov.w	r1, #516	; 0x204
    1164:	f8c2 1308 	str.w	r1, [r2, #776]	; 0x308
    1168:	7e62      	ldrb	r2, [r4, #25]
    116a:	f88d 2030 	strb.w	r2, [sp, #48]	; 0x30
    116e:	2500      	movs	r5, #0
    1170:	2201      	movs	r2, #1
    1172:	900b      	str	r0, [sp, #44]	; 0x2c
    1174:	6821      	ldr	r1, [r4, #0]
    1176:	75e5      	strb	r5, [r4, #23]
    1178:	f88d 2028 	strb.w	r2, [sp, #40]	; 0x28
    117c:	a80a      	add	r0, sp, #40	; 0x28
    117e:	4798      	blx	r3
    1180:	e737      	b.n	ff2 <UARTE0_UART0_IRQHandler+0x14e>
    1182:	bf00      	nop
    1184:	40002000 	.word	0x40002000

#00001188 <uart_error_handle>:
#    1188:	7803      	ldrb	r3, [r0, #0]
#    118a:	2b02      	cmp	r3, #2
#    118c:	d002      	beq.n	1194 <uart_error_handle+0xc>
#    118e:	2b01      	cmp	r3, #1
#    1190:	d000      	beq.n	1194 <uart_error_handle+0xc>
#    1192:	4770      	bx	lr
#    1194:	6840      	ldr	r0, [r0, #4]
#    1196:	f7ff b9cf 	b.w	538 <app_error_handler_bare>
    119a:	bf00      	nop

#0000119c <main>:
#    119c:	b530      	push	{r4, r5, lr}
#    119e:	4d1a      	ldr	r5, [pc, #104]	; (1208 <main+0x6c>)
#    11a0:	b08b      	sub	sp, #44	; 0x2c
#    11a2:	f7ff fb57 	bl	854 <bsp_board_leds_init>
#    11a6:	4b19      	ldr	r3, [pc, #100]	; (120c <main+0x70>)
#    11a8:	9300      	str	r3, [sp, #0]
#    11aa:	cd0f      	ldmia	r5!, {r0, r1, r2, r3}
#    11ac:	ac04      	add	r4, sp, #16
#    11ae:	c40f      	stmia	r4!, {r0, r1, r2, r3}
#    11b0:	e895 0003 	ldmia.w	r5, {r0, r1}
#    11b4:	4d16      	ldr	r5, [pc, #88]	; (1210 <main+0x74>)
#    11b6:	4a17      	ldr	r2, [pc, #92]	; (1214 <main+0x78>)
#    11b8:	e884 0003 	stmia.w	r4, {r0, r1}
#    11bc:	2307      	movs	r3, #7
#    11be:	f44f 7480 	mov.w	r4, #256	; 0x100
#    11c2:	4669      	mov	r1, sp
#    11c4:	a804      	add	r0, sp, #16
#    11c6:	e9cd 5402 	strd	r5, r4, [sp, #8]
#    11ca:	9401      	str	r4, [sp, #4]
#    11cc:	f7ff fa76 	bl	6bc <app_uart_init>
#    11d0:	b9b8      	cbnz	r0, 1202 <main+0x66>
#    11d2:	4811      	ldr	r0, [pc, #68]	; (1218 <main+0x7c>)
#    11d4:	f000 f9aa 	bl	152c <iprintf>
#    11d8:	4668      	mov	r0, sp
#    11da:	f7ff fae1 	bl	7a0 <app_uart_get>
#    11de:	2800      	cmp	r0, #0
#    11e0:	d1fa      	bne.n	11d8 <main+0x3c>
    11e2:	f89d 0000 	ldrb.w	r0, [sp]
    11e6:	f7ff fafb 	bl	7e0 <app_uart_put>
    11ea:	2800      	cmp	r0, #0
    11ec:	d1f9      	bne.n	11e2 <main+0x46>
    11ee:	f89d 3000 	ldrb.w	r3, [sp]
    11f2:	f003 03df 	and.w	r3, r3, #223	; 0xdf
    11f6:	2b51      	cmp	r3, #81	; 0x51
    11f8:	d1ee      	bne.n	11d8 <main+0x3c>
    11fa:	4808      	ldr	r0, [pc, #32]	; (121c <main+0x80>)
    11fc:	f000 f996 	bl	152c <iprintf>
    1200:	e7fe      	b.n	1200 <main+0x64>
    1202:	f7ff f999 	bl	538 <app_error_handler_bare>
    1206:	e7e4      	b.n	11d2 <main+0x36>
    1208:	0000252c 	.word	0x0000252c
    120c:	200000e4 	.word	0x200000e4
    1210:	200001e4 	.word	0x200001e4
    1214:	00001189 	.word	0x00001189
    1218:	00002514 	.word	0x00002514
    121c:	00002520 	.word	0x00002520

#00001220 <Reset_Handler>:
#    1220:	4906      	ldr	r1, [pc, #24]	; (123c <Reset_Handler+0x1c>)
#    1222:	4a07      	ldr	r2, [pc, #28]	; (1240 <Reset_Handler+0x20>)
#    1224:	4b07      	ldr	r3, [pc, #28]	; (1244 <Reset_Handler+0x24>)
#    1226:	1a9b      	subs	r3, r3, r2
#    1228:	dd03      	ble.n	1232 <Reset_Handler+0x12>
#    122a:	3b04      	subs	r3, #4
#    122c:	58c8      	ldr	r0, [r1, r3]
#    122e:	50d0      	str	r0, [r2, r3]
#    1230:	dcfb      	bgt.n	122a <Reset_Handler+0xa>
#    1232:	f000 f813 	bl	125c <SystemInit>
#    1236:	f7ff f903 	bl	440 <_mainCRTStartup>
    123a:	0000      	.short	0x0000
    123c:	000025e4 	.word	0x000025e4
    1240:	20000000 	.word	0x20000000
    1244:	20000078 	.word	0x20000078

00001248 <NMI_Handler>:
    1248:	e7fe      	b.n	1248 <NMI_Handler>

0000124a <HardFault_Handler>:
    124a:	e7fe      	b.n	124a <HardFault_Handler>

0000124c <MemoryManagement_Handler>:
    124c:	e7fe      	b.n	124c <MemoryManagement_Handler>

0000124e <BusFault_Handler>:
    124e:	e7fe      	b.n	124e <BusFault_Handler>

00001250 <UsageFault_Handler>:
    1250:	e7fe      	b.n	1250 <UsageFault_Handler>

00001252 <SVC_Handler>:
    1252:	e7fe      	b.n	1252 <SVC_Handler>

00001254 <DebugMon_Handler>:
    1254:	e7fe      	b.n	1254 <DebugMon_Handler>

00001256 <PendSV_Handler>:
    1256:	e7fe      	b.n	1256 <PendSV_Handler>

00001258 <SysTick_Handler>:
    1258:	e7fe      	b.n	1258 <SysTick_Handler>

0000125a <Default_Handler>:
    125a:	e7fe      	b.n	125a <Default_Handler>

#0000125c <SystemInit>:
#    125c:	b430      	push	{r4, r5}
#    125e:	4b9e      	ldr	r3, [pc, #632]	; (14d8 <SystemInit+0x27c>)
#    1260:	781b      	ldrb	r3, [r3, #0]
#    1262:	2b06      	cmp	r3, #6
#    1264:	d010      	beq.n	1288 <SystemInit+0x2c>
#    1266:	f04f 2310 	mov.w	r3, #268439552	; 0x10001000
#    126a:	f8d3 2200 	ldr.w	r2, [r3, #512]	; 0x200
#    126e:	2a00      	cmp	r2, #0
#    1270:	f2c0 8100 	blt.w	1474 <SystemInit+0x218>
#    1274:	f8d3 3204 	ldr.w	r3, [r3, #516]	; 0x204
#    1278:	2b00      	cmp	r3, #0
#    127a:	f2c0 80fb 	blt.w	1474 <SystemInit+0x218>
#    127e:	4b97      	ldr	r3, [pc, #604]	; (14dc <SystemInit+0x280>)
#    1280:	4a97      	ldr	r2, [pc, #604]	; (14e0 <SystemInit+0x284>)
#    1282:	601a      	str	r2, [r3, #0]
#    1284:	bc30      	pop	{r4, r5}
#    1286:	4770      	bx	lr
    1288:	4b96      	ldr	r3, [pc, #600]	; (14e4 <SystemInit+0x288>)
    128a:	681b      	ldr	r3, [r3, #0]
    128c:	071b      	lsls	r3, r3, #28
    128e:	d1ea      	bne.n	1266 <SystemInit+0xa>
    1290:	4b95      	ldr	r3, [pc, #596]	; (14e8 <SystemInit+0x28c>)
    1292:	681b      	ldr	r3, [r3, #0]
    1294:	f003 03f0 	and.w	r3, r3, #240	; 0xf0
    1298:	2b30      	cmp	r3, #48	; 0x30
    129a:	d060      	beq.n	135e <SystemInit+0x102>
    129c:	4b92      	ldr	r3, [pc, #584]	; (14e8 <SystemInit+0x28c>)
    129e:	681b      	ldr	r3, [r3, #0]
    12a0:	f003 02f0 	and.w	r2, r3, #240	; 0xf0
    12a4:	2a30      	cmp	r2, #48	; 0x30
    12a6:	d04b      	beq.n	1340 <SystemInit+0xe4>
    12a8:	f003 03e0 	and.w	r3, r3, #224	; 0xe0
    12ac:	2b40      	cmp	r3, #64	; 0x40
    12ae:	d047      	beq.n	1340 <SystemInit+0xe4>
    12b0:	4b8d      	ldr	r3, [pc, #564]	; (14e8 <SystemInit+0x28c>)
    12b2:	681b      	ldr	r3, [r3, #0]
    12b4:	f003 03f0 	and.w	r3, r3, #240	; 0xf0
    12b8:	2b30      	cmp	r3, #48	; 0x30
    12ba:	f000 80cb 	beq.w	1454 <SystemInit+0x1f8>
    12be:	4b8a      	ldr	r3, [pc, #552]	; (14e8 <SystemInit+0x28c>)
    12c0:	681b      	ldr	r3, [r3, #0]
    12c2:	f003 02f0 	and.w	r2, r3, #240	; 0xf0
    12c6:	2a30      	cmp	r2, #48	; 0x30
    12c8:	d028      	beq.n	131c <SystemInit+0xc0>
    12ca:	f003 03e0 	and.w	r3, r3, #224	; 0xe0
    12ce:	2b40      	cmp	r3, #64	; 0x40
    12d0:	d024      	beq.n	131c <SystemInit+0xc0>
    12d2:	4b85      	ldr	r3, [pc, #532]	; (14e8 <SystemInit+0x28c>)
    12d4:	681b      	ldr	r3, [r3, #0]
    12d6:	f003 03f0 	and.w	r3, r3, #240	; 0xf0
    12da:	2b30      	cmp	r3, #48	; 0x30
    12dc:	f000 80ac 	beq.w	1438 <SystemInit+0x1dc>
    12e0:	4b81      	ldr	r3, [pc, #516]	; (14e8 <SystemInit+0x28c>)
    12e2:	681b      	ldr	r3, [r3, #0]
    12e4:	f003 03f0 	and.w	r3, r3, #240	; 0xf0
    12e8:	2b30      	cmp	r3, #48	; 0x30
    12ea:	f000 808e 	beq.w	140a <SystemInit+0x1ae>
    12ee:	4b7e      	ldr	r3, [pc, #504]	; (14e8 <SystemInit+0x28c>)
    12f0:	681b      	ldr	r3, [r3, #0]
    12f2:	f003 03f0 	and.w	r3, r3, #240	; 0xf0
    12f6:	2b50      	cmp	r3, #80	; 0x50
    12f8:	d035      	beq.n	1366 <SystemInit+0x10a>
    12fa:	4b7b      	ldr	r3, [pc, #492]	; (14e8 <SystemInit+0x28c>)
    12fc:	681b      	ldr	r3, [r3, #0]
    12fe:	f003 02f0 	and.w	r2, r3, #240	; 0xf0
    1302:	2a30      	cmp	r2, #48	; 0x30
    1304:	d003      	beq.n	130e <SystemInit+0xb2>
    1306:	f003 03e0 	and.w	r3, r3, #224	; 0xe0
    130a:	2b40      	cmp	r3, #64	; 0x40
    130c:	d1ab      	bne.n	1266 <SystemInit+0xa>
    130e:	4b77      	ldr	r3, [pc, #476]	; (14ec <SystemInit+0x290>)
    1310:	4a77      	ldr	r2, [pc, #476]	; (14f0 <SystemInit+0x294>)
    1312:	681b      	ldr	r3, [r3, #0]
    1314:	f003 034f 	and.w	r3, r3, #79	; 0x4f
    1318:	6013      	str	r3, [r2, #0]
    131a:	e7a4      	b.n	1266 <SystemInit+0xa>
    131c:	4a6e      	ldr	r2, [pc, #440]	; (14d8 <SystemInit+0x27c>)
    131e:	7811      	ldrb	r1, [r2, #0]
    1320:	f04f 4380 	mov.w	r3, #1073741824	; 0x40000000
    1324:	2200      	movs	r2, #0
    1326:	2906      	cmp	r1, #6
    1328:	f8c3 210c 	str.w	r2, [r3, #268]	; 0x10c
    132c:	f8c3 2110 	str.w	r2, [r3, #272]	; 0x110
    1330:	f8c3 2538 	str.w	r2, [r3, #1336]	; 0x538
    1334:	d197      	bne.n	1266 <SystemInit+0xa>
    1336:	4b6b      	ldr	r3, [pc, #428]	; (14e4 <SystemInit+0x288>)
    1338:	681b      	ldr	r3, [r3, #0]
    133a:	0718      	lsls	r0, r3, #28
    133c:	d193      	bne.n	1266 <SystemInit+0xa>
    133e:	e7c8      	b.n	12d2 <SystemInit+0x76>
    1340:	4b6c      	ldr	r3, [pc, #432]	; (14f4 <SystemInit+0x298>)
    1342:	4a65      	ldr	r2, [pc, #404]	; (14d8 <SystemInit+0x27c>)
    1344:	681b      	ldr	r3, [r3, #0]
    1346:	7812      	ldrb	r2, [r2, #0]
    1348:	496b      	ldr	r1, [pc, #428]	; (14f8 <SystemInit+0x29c>)
    134a:	f3c3 3342 	ubfx	r3, r3, #13, #3
    134e:	2a06      	cmp	r2, #6
    1350:	600b      	str	r3, [r1, #0]
    1352:	d188      	bne.n	1266 <SystemInit+0xa>
    1354:	4b63      	ldr	r3, [pc, #396]	; (14e4 <SystemInit+0x288>)
    1356:	681b      	ldr	r3, [r3, #0]
    1358:	071d      	lsls	r5, r3, #28
    135a:	d184      	bne.n	1266 <SystemInit+0xa>
    135c:	e7a8      	b.n	12b0 <SystemInit+0x54>
    135e:	4b67      	ldr	r3, [pc, #412]	; (14fc <SystemInit+0x2a0>)
    1360:	4a67      	ldr	r2, [pc, #412]	; (1500 <SystemInit+0x2a4>)
    1362:	601a      	str	r2, [r3, #0]
    1364:	e79a      	b.n	129c <SystemInit+0x40>
    1366:	f04f 5280 	mov.w	r2, #268435456	; 0x10000000
    136a:	4b66      	ldr	r3, [pc, #408]	; (1504 <SystemInit+0x2a8>)
    136c:	f8d2 1404 	ldr.w	r1, [r2, #1028]	; 0x404
    1370:	f8c3 1520 	str.w	r1, [r3, #1312]	; 0x520
    1374:	f8d2 1408 	ldr.w	r1, [r2, #1032]	; 0x408
    1378:	f8c3 1524 	str.w	r1, [r3, #1316]	; 0x524
    137c:	f8d2 140c 	ldr.w	r1, [r2, #1036]	; 0x40c
    1380:	f8c3 1528 	str.w	r1, [r3, #1320]	; 0x528
    1384:	f8d2 1410 	ldr.w	r1, [r2, #1040]	; 0x410
    1388:	f8c3 152c 	str.w	r1, [r3, #1324]	; 0x52c
    138c:	f8d2 1414 	ldr.w	r1, [r2, #1044]	; 0x414
    1390:	f8c3 1530 	str.w	r1, [r3, #1328]	; 0x530
    1394:	f8d2 1418 	ldr.w	r1, [r2, #1048]	; 0x418
    1398:	f8c3 1534 	str.w	r1, [r3, #1332]	; 0x534
    139c:	f8d2 141c 	ldr.w	r1, [r2, #1052]	; 0x41c
    13a0:	f8c3 1540 	str.w	r1, [r3, #1344]	; 0x540
    13a4:	f8d2 1420 	ldr.w	r1, [r2, #1056]	; 0x420
    13a8:	f8c3 1544 	str.w	r1, [r3, #1348]	; 0x544
    13ac:	f8d2 1424 	ldr.w	r1, [r2, #1060]	; 0x424
    13b0:	f8c3 1548 	str.w	r1, [r3, #1352]	; 0x548
    13b4:	f8d2 1428 	ldr.w	r1, [r2, #1064]	; 0x428
    13b8:	f8c3 154c 	str.w	r1, [r3, #1356]	; 0x54c
    13bc:	f8d2 142c 	ldr.w	r1, [r2, #1068]	; 0x42c
    13c0:	f8c3 1550 	str.w	r1, [r3, #1360]	; 0x550
    13c4:	f8d2 1430 	ldr.w	r1, [r2, #1072]	; 0x430
    13c8:	f8c3 1554 	str.w	r1, [r3, #1364]	; 0x554
    13cc:	f8d2 1434 	ldr.w	r1, [r2, #1076]	; 0x434
    13d0:	f8c3 1560 	str.w	r1, [r3, #1376]	; 0x560
    13d4:	f8d2 1438 	ldr.w	r1, [r2, #1080]	; 0x438
    13d8:	f8c3 1564 	str.w	r1, [r3, #1380]	; 0x564
    13dc:	f8d2 143c 	ldr.w	r1, [r2, #1084]	; 0x43c
    13e0:	f8c3 1568 	str.w	r1, [r3, #1384]	; 0x568
    13e4:	f8d2 1440 	ldr.w	r1, [r2, #1088]	; 0x440
    13e8:	483b      	ldr	r0, [pc, #236]	; (14d8 <SystemInit+0x27c>)
    13ea:	f8c3 156c 	str.w	r1, [r3, #1388]	; 0x56c
    13ee:	f8d2 1444 	ldr.w	r1, [r2, #1092]	; 0x444
    13f2:	7802      	ldrb	r2, [r0, #0]
    13f4:	f8c3 1570 	str.w	r1, [r3, #1392]	; 0x570
    13f8:	2a06      	cmp	r2, #6
    13fa:	f47f af34 	bne.w	1266 <SystemInit+0xa>
    13fe:	4b39      	ldr	r3, [pc, #228]	; (14e4 <SystemInit+0x288>)
    1400:	681b      	ldr	r3, [r3, #0]
    1402:	071b      	lsls	r3, r3, #28
    1404:	f47f af2f 	bne.w	1266 <SystemInit+0xa>
    1408:	e777      	b.n	12fa <SystemInit+0x9e>
    140a:	4b33      	ldr	r3, [pc, #204]	; (14d8 <SystemInit+0x27c>)
    140c:	4c3e      	ldr	r4, [pc, #248]	; (1508 <SystemInit+0x2ac>)
    140e:	781b      	ldrb	r3, [r3, #0]
    1410:	493e      	ldr	r1, [pc, #248]	; (150c <SystemInit+0x2b0>)
    1412:	483f      	ldr	r0, [pc, #252]	; (1510 <SystemInit+0x2b4>)
    1414:	4a3f      	ldr	r2, [pc, #252]	; (1514 <SystemInit+0x2b8>)
    1416:	2505      	movs	r5, #5
    1418:	6025      	str	r5, [r4, #0]
    141a:	2501      	movs	r5, #1
    141c:	600d      	str	r5, [r1, #0]
    141e:	2400      	movs	r4, #0
    1420:	213f      	movs	r1, #63	; 0x3f
    1422:	2b06      	cmp	r3, #6
#    1424:	6004      	str	r4, [r0, #0]
#    1426:	6011      	str	r1, [r2, #0]
#    1428:	f47f af1d 	bne.w	1266 <SystemInit+0xa>
    142c:	4b2d      	ldr	r3, [pc, #180]	; (14e4 <SystemInit+0x288>)
    142e:	681b      	ldr	r3, [r3, #0]
    1430:	071a      	lsls	r2, r3, #28
#    1432:	f47f af18 	bne.w	1266 <SystemInit+0xa>
    1436:	e75a      	b.n	12ee <SystemInit+0x92>
    1438:	4b27      	ldr	r3, [pc, #156]	; (14d8 <SystemInit+0x27c>)
    143a:	4a37      	ldr	r2, [pc, #220]	; (1518 <SystemInit+0x2bc>)
    143c:	781b      	ldrb	r3, [r3, #0]
    143e:	2103      	movs	r1, #3
#    1440:	2b06      	cmp	r3, #6
#    1442:	6011      	str	r1, [r2, #0]
#    1444:	f47f af0f 	bne.w	1266 <SystemInit+0xa>
#    1448:	4b26      	ldr	r3, [pc, #152]	; (14e4 <SystemInit+0x288>)
#    144a:	681b      	ldr	r3, [r3, #0]
    144c:	0719      	lsls	r1, r3, #28
#    144e:	f47f af0a 	bne.w	1266 <SystemInit+0xa>
#    1452:	e745      	b.n	12e0 <SystemInit+0x84>
#    1454:	4a31      	ldr	r2, [pc, #196]	; (151c <SystemInit+0x2c0>)
#    1456:	4920      	ldr	r1, [pc, #128]	; (14d8 <SystemInit+0x27c>)
#    1458:	68d3      	ldr	r3, [r2, #12]
#    145a:	7809      	ldrb	r1, [r1, #0]
    145c:	f023 7380 	bic.w	r3, r3, #16777216	; 0x1000000
#    1460:	2906      	cmp	r1, #6
#    1462:	60d3      	str	r3, [r2, #12]
    1464:	f47f aeff 	bne.w	1266 <SystemInit+0xa>
#    1468:	4b1e      	ldr	r3, [pc, #120]	; (14e4 <SystemInit+0x288>)
#    146a:	681b      	ldr	r3, [r3, #0]
    146c:	071c      	lsls	r4, r3, #28
#    146e:	f47f aefa 	bne.w	1266 <SystemInit+0xa>
#    1472:	e724      	b.n	12be <SystemInit+0x62>
#    1474:	4a2a      	ldr	r2, [pc, #168]	; (1520 <SystemInit+0x2c4>)
#    1476:	2301      	movs	r3, #1
#    1478:	f8c2 3504 	str.w	r3, [r2, #1284]	; 0x504
    147c:	f8d2 3400 	ldr.w	r3, [r2, #1024]	; 0x400
    1480:	2b00      	cmp	r3, #0
#    1482:	d0fb      	beq.n	147c <SystemInit+0x220>
    1484:	f04f 2310 	mov.w	r3, #268439552	; 0x10001000
#    1488:	2115      	movs	r1, #21
#    148a:	4a25      	ldr	r2, [pc, #148]	; (1520 <SystemInit+0x2c4>)
    148c:	f8c3 1200 	str.w	r1, [r3, #512]	; 0x200
    1490:	f8d2 3400 	ldr.w	r3, [r2, #1024]	; 0x400
    1494:	2b00      	cmp	r3, #0
    1496:	d0fb      	beq.n	1490 <SystemInit+0x234>
    1498:	f04f 2310 	mov.w	r3, #268439552	; 0x10001000
    149c:	2115      	movs	r1, #21
    149e:	4a20      	ldr	r2, [pc, #128]	; (1520 <SystemInit+0x2c4>)
    14a0:	f8c3 1204 	str.w	r1, [r3, #516]	; 0x204
    14a4:	f8d2 3400 	ldr.w	r3, [r2, #1024]	; 0x400
    14a8:	2b00      	cmp	r3, #0
    14aa:	d0fb      	beq.n	14a4 <SystemInit+0x248>
    14ac:	2300      	movs	r3, #0
    14ae:	491c      	ldr	r1, [pc, #112]	; (1520 <SystemInit+0x2c4>)
    14b0:	f8c2 3504 	str.w	r3, [r2, #1284]	; 0x504
    14b4:	f8d1 3400 	ldr.w	r3, [r1, #1024]	; 0x400
    14b8:	2b00      	cmp	r3, #0
    14ba:	d0fb      	beq.n	14b4 <SystemInit+0x258>
    14bc:	f3bf 8f4f 	dsb	sy
    14c0:	4918      	ldr	r1, [pc, #96]	; (1524 <SystemInit+0x2c8>)
    14c2:	4b19      	ldr	r3, [pc, #100]	; (1528 <SystemInit+0x2cc>)
    14c4:	68ca      	ldr	r2, [r1, #12]
    14c6:	f402 62e0 	and.w	r2, r2, #1792	; 0x700
    14ca:	4313      	orrs	r3, r2
    14cc:	60cb      	str	r3, [r1, #12]
    14ce:	f3bf 8f4f 	dsb	sy
    14d2:	bf00      	nop
    14d4:	e7fd      	b.n	14d2 <SystemInit+0x276>
    14d6:	bf00      	nop
    14d8:	f0000fe0 	.word	0xf0000fe0
#    14dc:	2000006c 	.word	0x2000006c
#    14e0:	03d09000 	.word	0x03d09000
#    14e4:	f0000fe4 	.word	0xf0000fe4
#    14e8:	f0000fe8 	.word	0xf0000fe8
#    14ec:	10000258 	.word	0x10000258
#    14f0:	40000ee4 	.word	0x40000ee4
#    14f4:	10000244 	.word	0x10000244
#    14f8:	4000053c 	.word	0x4000053c
#    14fc:	4007c074 	.word	0x4007c074
    1500:	baadf00d 	.word	0xbaadf00d
    1504:	4000c000 	.word	0x4000c000
    1508:	40005610 	.word	0x40005610
    150c:	40005688 	.word	0x40005688
#    1510:	40005618 	.word	0x40005618
    1514:	40005614 	.word	0x40005614
    1518:	400005a0 	.word	0x400005a0
    151c:	e000edf0 	.word	0xe000edf0
    1520:	4001e000 	.word	0x4001e000
#    1524:	e000ed00 	.word	0xe000ed00
#    1528:	05fa0004 	.word	0x05fa0004

#0000152c <iprintf>:
#    152c:	b40f      	push	{r0, r1, r2, r3}
#    152e:	4b0a      	ldr	r3, [pc, #40]	; (1558 <iprintf+0x2c>)
#    1530:	b513      	push	{r0, r1, r4, lr}
#    1532:	681c      	ldr	r4, [r3, #0]
#    1534:	b124      	cbz	r4, 1540 <iprintf+0x14>
#    1536:	69a3      	ldr	r3, [r4, #24]
#    1538:	b913      	cbnz	r3, 1540 <iprintf+0x14>
#    153a:	4620      	mov	r0, r4
#    153c:	f000 f866 	bl	160c <__sinit>
#    1540:	ab05      	add	r3, sp, #20
#    1542:	9a04      	ldr	r2, [sp, #16]
#    1544:	68a1      	ldr	r1, [r4, #8]
#    1546:	9301      	str	r3, [sp, #4]
#    1548:	4620      	mov	r0, r4
#    154a:	f000 f981 	bl	1850 <_vfiprintf_r>
#    154e:	b002      	add	sp, #8
#    1550:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
#    1554:	b004      	add	sp, #16
#    1556:	4770      	bx	lr
#    1558:	20000000 	.word	0x20000000

#0000155c <std>:
#    155c:	2300      	movs	r3, #0
#    155e:	b510      	push	{r4, lr}
#    1560:	4604      	mov	r4, r0
#    1562:	e9c0 3300 	strd	r3, r3, [r0]
#    1566:	e9c0 3304 	strd	r3, r3, [r0, #16]
#    156a:	6083      	str	r3, [r0, #8]
#    156c:	8181      	strh	r1, [r0, #12]
#    156e:	6643      	str	r3, [r0, #100]	; 0x64
#    1570:	81c2      	strh	r2, [r0, #14]
#    1572:	6183      	str	r3, [r0, #24]
#    1574:	4619      	mov	r1, r3
#    1576:	2208      	movs	r2, #8
#    1578:	305c      	adds	r0, #92	; 0x5c
#    157a:	f7fe ffd3 	bl	524 <memset>
#    157e:	4b05      	ldr	r3, [pc, #20]	; (1594 <std+0x38>)
#    1580:	6263      	str	r3, [r4, #36]	; 0x24
#    1582:	4b05      	ldr	r3, [pc, #20]	; (1598 <std+0x3c>)
#    1584:	62a3      	str	r3, [r4, #40]	; 0x28
#    1586:	4b05      	ldr	r3, [pc, #20]	; (159c <std+0x40>)
#    1588:	62e3      	str	r3, [r4, #44]	; 0x2c
#    158a:	4b05      	ldr	r3, [pc, #20]	; (15a0 <std+0x44>)
#    158c:	6224      	str	r4, [r4, #32]
#    158e:	6323      	str	r3, [r4, #48]	; 0x30
#    1590:	bd10      	pop	{r4, pc}
    1592:	bf00      	nop
    1594:	00001df9 	.word	0x00001df9
    1598:	00001e1b 	.word	0x00001e1b
#    159c:	00001e53 	.word	0x00001e53
#    15a0:	00001e77 	.word	0x00001e77

000015a4 <_cleanup_r>:
#    15a4:	4901      	ldr	r1, [pc, #4]	; (15ac <_cleanup_r+0x8>)
#    15a6:	f000 b8af 	b.w	1708 <_fwalk_reent>
#    15aa:	bf00      	nop
    15ac:	00002151 	.word	0x00002151

#000015b0 <__sfmoreglue>:
#    15b0:	b570      	push	{r4, r5, r6, lr}
#    15b2:	1e4a      	subs	r2, r1, #1
#    15b4:	2568      	movs	r5, #104	; 0x68
#    15b6:	4355      	muls	r5, r2
#    15b8:	460e      	mov	r6, r1
#    15ba:	f105 0174 	add.w	r1, r5, #116	; 0x74
#    15be:	f000 f8c5 	bl	174c <_malloc_r>
#    15c2:	4604      	mov	r4, r0
#    15c4:	b140      	cbz	r0, 15d8 <__sfmoreglue+0x28>
#    15c6:	2100      	movs	r1, #0
#    15c8:	e9c0 1600 	strd	r1, r6, [r0]
#    15cc:	300c      	adds	r0, #12
#    15ce:	60a0      	str	r0, [r4, #8]
#    15d0:	f105 0268 	add.w	r2, r5, #104	; 0x68
#    15d4:	f7fe ffa6 	bl	524 <memset>
#    15d8:	4620      	mov	r0, r4
#    15da:	bd70      	pop	{r4, r5, r6, pc}

#000015dc <__sfp_lock_acquire>:
#    15dc:	4801      	ldr	r0, [pc, #4]	; (15e4 <__sfp_lock_acquire+0x8>)
#    15de:	f000 b8b3 	b.w	1748 <__retarget_lock_acquire_recursive>
#    15e2:	bf00      	nop
#    15e4:	200002f8 	.word	0x200002f8

#000015e8 <__sfp_lock_release>:
#    15e8:	4801      	ldr	r0, [pc, #4]	; (15f0 <__sfp_lock_release+0x8>)
#    15ea:	f000 b8ae 	b.w	174a <__retarget_lock_release_recursive>
#    15ee:	bf00      	nop
#    15f0:	200002f8 	.word	0x200002f8

#000015f4 <__sinit_lock_acquire>:
#    15f4:	4801      	ldr	r0, [pc, #4]	; (15fc <__sinit_lock_acquire+0x8>)
#    15f6:	f000 b8a7 	b.w	1748 <__retarget_lock_acquire_recursive>
#    15fa:	bf00      	nop
#    15fc:	200002f3 	.word	0x200002f3

#00001600 <__sinit_lock_release>:
#    1600:	4801      	ldr	r0, [pc, #4]	; (1608 <__sinit_lock_release+0x8>)
#    1602:	f000 b8a2 	b.w	174a <__retarget_lock_release_recursive>
#    1606:	bf00      	nop
#    1608:	200002f3 	.word	0x200002f3

#0000160c <__sinit>:
#    160c:	b510      	push	{r4, lr}
#    160e:	4604      	mov	r4, r0
#    1610:	f7ff fff0 	bl	15f4 <__sinit_lock_acquire>
#    1614:	69a3      	ldr	r3, [r4, #24]
#    1616:	b11b      	cbz	r3, 1620 <__sinit+0x14>
#    1618:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
#    161c:	f7ff bff0 	b.w	1600 <__sinit_lock_release>
#    1620:	e9c4 3312 	strd	r3, r3, [r4, #72]	; 0x48
#    1624:	6523      	str	r3, [r4, #80]	; 0x50
#    1626:	4b13      	ldr	r3, [pc, #76]	; (1674 <__sinit+0x68>)
#    1628:	4a13      	ldr	r2, [pc, #76]	; (1678 <__sinit+0x6c>)
#    162a:	681b      	ldr	r3, [r3, #0]
#    162c:	62a2      	str	r2, [r4, #40]	; 0x28
#    162e:	42a3      	cmp	r3, r4
#    1630:	bf04      	itt	eq
#    1632:	2301      	moveq	r3, #1
#    1634:	61a3      	streq	r3, [r4, #24]
#    1636:	4620      	mov	r0, r4
#    1638:	f000 f820 	bl	167c <__sfp>
#    163c:	6060      	str	r0, [r4, #4]
#    163e:	4620      	mov	r0, r4
#    1640:	f000 f81c 	bl	167c <__sfp>
#    1644:	60a0      	str	r0, [r4, #8]
#    1646:	4620      	mov	r0, r4
#    1648:	f000 f818 	bl	167c <__sfp>
#    164c:	2200      	movs	r2, #0
#    164e:	60e0      	str	r0, [r4, #12]
#    1650:	2104      	movs	r1, #4
#    1652:	6860      	ldr	r0, [r4, #4]
#    1654:	f7ff ff82 	bl	155c <std>
#    1658:	68a0      	ldr	r0, [r4, #8]
#    165a:	2201      	movs	r2, #1
#    165c:	2109      	movs	r1, #9
#    165e:	f7ff ff7d 	bl	155c <std>
#    1662:	68e0      	ldr	r0, [r4, #12]
#    1664:	2202      	movs	r2, #2
#    1666:	2112      	movs	r1, #18
#    1668:	f7ff ff78 	bl	155c <std>
#    166c:	2301      	movs	r3, #1
#    166e:	61a3      	str	r3, [r4, #24]
#    1670:	e7d2      	b.n	1618 <__sinit+0xc>
#    1672:	bf00      	nop
    1674:	000024f0 	.word	0x000024f0
    1678:	000015a5 	.word	0x000015a5

#0000167c <__sfp>:
#    167c:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
#    167e:	4607      	mov	r7, r0
#    1680:	f7ff ffac 	bl	15dc <__sfp_lock_acquire>
#    1684:	4b1e      	ldr	r3, [pc, #120]	; (1700 <__sfp+0x84>)
#    1686:	681e      	ldr	r6, [r3, #0]
#    1688:	69b3      	ldr	r3, [r6, #24]
#    168a:	b913      	cbnz	r3, 1692 <__sfp+0x16>
#    168c:	4630      	mov	r0, r6
#    168e:	f7ff ffbd 	bl	160c <__sinit>
#    1692:	3648      	adds	r6, #72	; 0x48
#    1694:	e9d6 3401 	ldrd	r3, r4, [r6, #4]
#    1698:	3b01      	subs	r3, #1
#    169a:	d503      	bpl.n	16a4 <__sfp+0x28>
#    169c:	6833      	ldr	r3, [r6, #0]
#    169e:	b30b      	cbz	r3, 16e4 <__sfp+0x68>
#    16a0:	6836      	ldr	r6, [r6, #0]
#    16a2:	e7f7      	b.n	1694 <__sfp+0x18>
#    16a4:	f9b4 500c 	ldrsh.w	r5, [r4, #12]
#    16a8:	b9d5      	cbnz	r5, 16e0 <__sfp+0x64>
#    16aa:	4b16      	ldr	r3, [pc, #88]	; (1704 <__sfp+0x88>)
#    16ac:	60e3      	str	r3, [r4, #12]
#    16ae:	f104 0058 	add.w	r0, r4, #88	; 0x58
#    16b2:	6665      	str	r5, [r4, #100]	; 0x64
#    16b4:	f000 f847 	bl	1746 <__retarget_lock_init_recursive>
#    16b8:	f7ff ff96 	bl	15e8 <__sfp_lock_release>
#    16bc:	e9c4 5501 	strd	r5, r5, [r4, #4]
#    16c0:	e9c4 5504 	strd	r5, r5, [r4, #16]
#    16c4:	6025      	str	r5, [r4, #0]
#    16c6:	61a5      	str	r5, [r4, #24]
#    16c8:	2208      	movs	r2, #8
#    16ca:	4629      	mov	r1, r5
#    16cc:	f104 005c 	add.w	r0, r4, #92	; 0x5c
#    16d0:	f7fe ff28 	bl	524 <memset>
#    16d4:	e9c4 550d 	strd	r5, r5, [r4, #52]	; 0x34
#    16d8:	e9c4 5512 	strd	r5, r5, [r4, #72]	; 0x48
#    16dc:	4620      	mov	r0, r4
#    16de:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
#    16e0:	3468      	adds	r4, #104	; 0x68
#    16e2:	e7d9      	b.n	1698 <__sfp+0x1c>
#    16e4:	2104      	movs	r1, #4
#    16e6:	4638      	mov	r0, r7
#    16e8:	f7ff ff62 	bl	15b0 <__sfmoreglue>
#    16ec:	4604      	mov	r4, r0
#    16ee:	6030      	str	r0, [r6, #0]
#    16f0:	2800      	cmp	r0, #0
#    16f2:	d1d5      	bne.n	16a0 <__sfp+0x24>
    16f4:	f7ff ff78 	bl	15e8 <__sfp_lock_release>
    16f8:	230c      	movs	r3, #12
#    16fa:	603b      	str	r3, [r7, #0]
#    16fc:	e7ee      	b.n	16dc <__sfp+0x60>
#    16fe:	bf00      	nop
#    1700:	000024f0 	.word	0x000024f0
#    1704:	ffff0001 	.word	0xffff0001

00001708 <_fwalk_reent>:
#    1708:	e92d 43f8 	stmdb	sp!, {r3, r4, r5, r6, r7, r8, r9, lr}
    170c:	4606      	mov	r6, r0
#    170e:	4688      	mov	r8, r1
#    1710:	f100 0448 	add.w	r4, r0, #72	; 0x48
#    1714:	2700      	movs	r7, #0
#    1716:	e9d4 9501 	ldrd	r9, r5, [r4, #4]
#    171a:	f1b9 0901 	subs.w	r9, r9, #1
#    171e:	d505      	bpl.n	172c <_fwalk_reent+0x24>
#    1720:	6824      	ldr	r4, [r4, #0]
#    1722:	2c00      	cmp	r4, #0
#    1724:	d1f7      	bne.n	1716 <_fwalk_reent+0xe>
    1726:	4638      	mov	r0, r7
#    1728:	e8bd 83f8 	ldmia.w	sp!, {r3, r4, r5, r6, r7, r8, r9, pc}
#    172c:	89ab      	ldrh	r3, [r5, #12]
#    172e:	2b01      	cmp	r3, #1
    1730:	d907      	bls.n	1742 <_fwalk_reent+0x3a>
#    1732:	f9b5 300e 	ldrsh.w	r3, [r5, #14]
    1736:	3301      	adds	r3, #1
#    1738:	d003      	beq.n	1742 <_fwalk_reent+0x3a>
#    173a:	4629      	mov	r1, r5
    173c:	4630      	mov	r0, r6
#    173e:	47c0      	blx	r8
    1740:	4307      	orrs	r7, r0
#    1742:	3568      	adds	r5, #104	; 0x68
#    1744:	e7e9      	b.n	171a <_fwalk_reent+0x12>

#00001746 <__retarget_lock_init_recursive>:
#    1746:	4770      	bx	lr

#00001748 <__retarget_lock_acquire_recursive>:
#    1748:	4770      	bx	lr

#0000174a <__retarget_lock_release_recursive>:
#    174a:	4770      	bx	lr

#0000174c <_malloc_r>:
#    174c:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
#    174e:	1ccd      	adds	r5, r1, #3
#    1750:	f025 0503 	bic.w	r5, r5, #3
#    1754:	3508      	adds	r5, #8
#    1756:	2d0c      	cmp	r5, #12
#    1758:	bf38      	it	cc
#    175a:	250c      	movcc	r5, #12
#    175c:	2d00      	cmp	r5, #0
#    175e:	4606      	mov	r6, r0
#    1760:	db01      	blt.n	1766 <_malloc_r+0x1a>
#    1762:	42a9      	cmp	r1, r5
#    1764:	d903      	bls.n	176e <_malloc_r+0x22>
#    1766:	230c      	movs	r3, #12
    1768:	6033      	str	r3, [r6, #0]
#    176a:	2000      	movs	r0, #0
#    176c:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
#    176e:	f000 fdf7 	bl	2360 <__malloc_lock>
#    1772:	4921      	ldr	r1, [pc, #132]	; (17f8 <_malloc_r+0xac>)
#    1774:	680a      	ldr	r2, [r1, #0]
#    1776:	4614      	mov	r4, r2
#    1778:	b99c      	cbnz	r4, 17a2 <_malloc_r+0x56>
#    177a:	4f20      	ldr	r7, [pc, #128]	; (17fc <_malloc_r+0xb0>)
#    177c:	683b      	ldr	r3, [r7, #0]
#    177e:	b923      	cbnz	r3, 178a <_malloc_r+0x3e>
#    1780:	4621      	mov	r1, r4
#    1782:	4630      	mov	r0, r6
#    1784:	f000 fb28 	bl	1dd8 <_sbrk_r>
#    1788:	6038      	str	r0, [r7, #0]
#    178a:	4629      	mov	r1, r5
#    178c:	4630      	mov	r0, r6
#    178e:	f000 fb23 	bl	1dd8 <_sbrk_r>
#    1792:	1c43      	adds	r3, r0, #1
#    1794:	d123      	bne.n	17de <_malloc_r+0x92>
    1796:	230c      	movs	r3, #12
    1798:	6033      	str	r3, [r6, #0]
    179a:	4630      	mov	r0, r6
    179c:	f000 fde6 	bl	236c <__malloc_unlock>
#    17a0:	e7e3      	b.n	176a <_malloc_r+0x1e>
#    17a2:	6823      	ldr	r3, [r4, #0]
#    17a4:	1b5b      	subs	r3, r3, r5
#    17a6:	d417      	bmi.n	17d8 <_malloc_r+0x8c>
#    17a8:	2b0b      	cmp	r3, #11
#    17aa:	d903      	bls.n	17b4 <_malloc_r+0x68>
    17ac:	6023      	str	r3, [r4, #0]
#    17ae:	441c      	add	r4, r3
#    17b0:	6025      	str	r5, [r4, #0]
#    17b2:	e004      	b.n	17be <_malloc_r+0x72>
#    17b4:	6863      	ldr	r3, [r4, #4]
    17b6:	42a2      	cmp	r2, r4
    17b8:	bf0c      	ite	eq
    17ba:	600b      	streq	r3, [r1, #0]
    17bc:	6053      	strne	r3, [r2, #4]
#    17be:	4630      	mov	r0, r6
#    17c0:	f000 fdd4 	bl	236c <__malloc_unlock>
#    17c4:	f104 000b 	add.w	r0, r4, #11
#    17c8:	1d23      	adds	r3, r4, #4
#    17ca:	f020 0007 	bic.w	r0, r0, #7
#    17ce:	1ac2      	subs	r2, r0, r3
#    17d0:	d0cc      	beq.n	176c <_malloc_r+0x20>
#    17d2:	1a1b      	subs	r3, r3, r0
#    17d4:	50a3      	str	r3, [r4, r2]
#    17d6:	e7c9      	b.n	176c <_malloc_r+0x20>
    17d8:	4622      	mov	r2, r4
    17da:	6864      	ldr	r4, [r4, #4]
    17dc:	e7cc      	b.n	1778 <_malloc_r+0x2c>
#    17de:	1cc4      	adds	r4, r0, #3
#    17e0:	f024 0403 	bic.w	r4, r4, #3
#    17e4:	42a0      	cmp	r0, r4
#    17e6:	d0e3      	beq.n	17b0 <_malloc_r+0x64>
    17e8:	1a21      	subs	r1, r4, r0
#    17ea:	4630      	mov	r0, r6
#    17ec:	f000 faf4 	bl	1dd8 <_sbrk_r>
#    17f0:	3001      	adds	r0, #1
#    17f2:	d1dd      	bne.n	17b0 <_malloc_r+0x64>
#    17f4:	e7cf      	b.n	1796 <_malloc_r+0x4a>
    17f6:	bf00      	nop
#    17f8:	200002e4 	.word	0x200002e4
#    17fc:	200002e8 	.word	0x200002e8

#00001800 <__sfputc_r>:
#    1800:	6893      	ldr	r3, [r2, #8]
#    1802:	3b01      	subs	r3, #1
#    1804:	2b00      	cmp	r3, #0
#    1806:	b410      	push	{r4}
#    1808:	6093      	str	r3, [r2, #8]
#    180a:	da07      	bge.n	181c <__sfputc_r+0x1c>
#    180c:	6994      	ldr	r4, [r2, #24]
#    180e:	42a3      	cmp	r3, r4
#    1810:	db01      	blt.n	1816 <__sfputc_r+0x16>
#    1812:	290a      	cmp	r1, #10
#    1814:	d102      	bne.n	181c <__sfputc_r+0x1c>
#    1816:	bc10      	pop	{r4}
#    1818:	f000 bb32 	b.w	1e80 <__swbuf_r>
#    181c:	6813      	ldr	r3, [r2, #0]
#    181e:	1c58      	adds	r0, r3, #1
#    1820:	6010      	str	r0, [r2, #0]
#    1822:	7019      	strb	r1, [r3, #0]
#    1824:	4608      	mov	r0, r1
#    1826:	bc10      	pop	{r4}
#    1828:	4770      	bx	lr

#0000182a <__sfputs_r>:
#    182a:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
#    182c:	4606      	mov	r6, r0
#    182e:	460f      	mov	r7, r1
#    1830:	4614      	mov	r4, r2
#    1832:	18d5      	adds	r5, r2, r3
#    1834:	42ac      	cmp	r4, r5
#    1836:	d101      	bne.n	183c <__sfputs_r+0x12>
#    1838:	2000      	movs	r0, #0
#    183a:	e007      	b.n	184c <__sfputs_r+0x22>
#    183c:	f814 1b01 	ldrb.w	r1, [r4], #1
#    1840:	463a      	mov	r2, r7
#    1842:	4630      	mov	r0, r6
#    1844:	f7ff ffdc 	bl	1800 <__sfputc_r>
#    1848:	1c43      	adds	r3, r0, #1
#    184a:	d1f3      	bne.n	1834 <__sfputs_r+0xa>
#    184c:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
	...

#00001850 <_vfiprintf_r>:
#    1850:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
#    1854:	460d      	mov	r5, r1
#    1856:	b09d      	sub	sp, #116	; 0x74
#    1858:	4614      	mov	r4, r2
#    185a:	4698      	mov	r8, r3
#    185c:	4606      	mov	r6, r0
#    185e:	b118      	cbz	r0, 1868 <_vfiprintf_r+0x18>
#    1860:	6983      	ldr	r3, [r0, #24]
#    1862:	b90b      	cbnz	r3, 1868 <_vfiprintf_r+0x18>
#    1864:	f7ff fed2 	bl	160c <__sinit>
#    1868:	4b89      	ldr	r3, [pc, #548]	; (1a90 <_vfiprintf_r+0x240>)
#    186a:	429d      	cmp	r5, r3
#    186c:	d11b      	bne.n	18a6 <_vfiprintf_r+0x56>
    186e:	6875      	ldr	r5, [r6, #4]
#    1870:	6e6b      	ldr	r3, [r5, #100]	; 0x64
#    1872:	07d9      	lsls	r1, r3, #31
#    1874:	d405      	bmi.n	1882 <_vfiprintf_r+0x32>
#    1876:	89ab      	ldrh	r3, [r5, #12]
#    1878:	059a      	lsls	r2, r3, #22
#    187a:	d402      	bmi.n	1882 <_vfiprintf_r+0x32>
#    187c:	6da8      	ldr	r0, [r5, #88]	; 0x58
#    187e:	f7ff ff63 	bl	1748 <__retarget_lock_acquire_recursive>
#    1882:	89ab      	ldrh	r3, [r5, #12]
#    1884:	071b      	lsls	r3, r3, #28
#    1886:	d501      	bpl.n	188c <_vfiprintf_r+0x3c>
#    1888:	692b      	ldr	r3, [r5, #16]
#    188a:	b9eb      	cbnz	r3, 18c8 <_vfiprintf_r+0x78>
#    188c:	4629      	mov	r1, r5
#    188e:	4630      	mov	r0, r6
#    1890:	f000 fb5a 	bl	1f48 <__swsetup_r>
#    1894:	b1c0      	cbz	r0, 18c8 <_vfiprintf_r+0x78>
    1896:	6e6b      	ldr	r3, [r5, #100]	; 0x64
#    1898:	07dc      	lsls	r4, r3, #31
#    189a:	d50e      	bpl.n	18ba <_vfiprintf_r+0x6a>
    189c:	f04f 30ff 	mov.w	r0, #4294967295	; 0xffffffff
#    18a0:	b01d      	add	sp, #116	; 0x74
#    18a2:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
#    18a6:	4b7b      	ldr	r3, [pc, #492]	; (1a94 <_vfiprintf_r+0x244>)
#    18a8:	429d      	cmp	r5, r3
#    18aa:	d101      	bne.n	18b0 <_vfiprintf_r+0x60>
    18ac:	68b5      	ldr	r5, [r6, #8]
#    18ae:	e7df      	b.n	1870 <_vfiprintf_r+0x20>
#    18b0:	4b79      	ldr	r3, [pc, #484]	; (1a98 <_vfiprintf_r+0x248>)
#    18b2:	429d      	cmp	r5, r3
#    18b4:	bf08      	it	eq
#    18b6:	68f5      	ldreq	r5, [r6, #12]
#    18b8:	e7da      	b.n	1870 <_vfiprintf_r+0x20>
#    18ba:	89ab      	ldrh	r3, [r5, #12]
    18bc:	0598      	lsls	r0, r3, #22
#    18be:	d4ed      	bmi.n	189c <_vfiprintf_r+0x4c>
#    18c0:	6da8      	ldr	r0, [r5, #88]	; 0x58
    18c2:	f7ff ff42 	bl	174a <__retarget_lock_release_recursive>
    18c6:	e7e9      	b.n	189c <_vfiprintf_r+0x4c>
#    18c8:	2300      	movs	r3, #0
#    18ca:	9309      	str	r3, [sp, #36]	; 0x24
#    18cc:	2320      	movs	r3, #32
#    18ce:	f88d 3029 	strb.w	r3, [sp, #41]	; 0x29
#    18d2:	f8cd 800c 	str.w	r8, [sp, #12]
#    18d6:	2330      	movs	r3, #48	; 0x30
#    18d8:	f8df 81c0 	ldr.w	r8, [pc, #448]	; 1a9c <_vfiprintf_r+0x24c>
#    18dc:	f88d 302a 	strb.w	r3, [sp, #42]	; 0x2a
#    18e0:	f04f 0901 	mov.w	r9, #1
#    18e4:	4623      	mov	r3, r4
#    18e6:	469a      	mov	sl, r3
#    18e8:	f813 2b01 	ldrb.w	r2, [r3], #1
#    18ec:	b10a      	cbz	r2, 18f2 <_vfiprintf_r+0xa2>
#    18ee:	2a25      	cmp	r2, #37	; 0x25
#    18f0:	d1f9      	bne.n	18e6 <_vfiprintf_r+0x96>
#    18f2:	ebba 0b04 	subs.w	fp, sl, r4
#    18f6:	d00b      	beq.n	1910 <_vfiprintf_r+0xc0>
#    18f8:	465b      	mov	r3, fp
#    18fa:	4622      	mov	r2, r4
#    18fc:	4629      	mov	r1, r5
#    18fe:	4630      	mov	r0, r6
#    1900:	f7ff ff93 	bl	182a <__sfputs_r>
#    1904:	3001      	adds	r0, #1
#    1906:	f000 80aa 	beq.w	1a5e <_vfiprintf_r+0x20e>
#    190a:	9a09      	ldr	r2, [sp, #36]	; 0x24
#    190c:	445a      	add	r2, fp
#    190e:	9209      	str	r2, [sp, #36]	; 0x24
#    1910:	f89a 3000 	ldrb.w	r3, [sl]
#    1914:	2b00      	cmp	r3, #0
#    1916:	f000 80a2 	beq.w	1a5e <_vfiprintf_r+0x20e>
#    191a:	2300      	movs	r3, #0
    191c:	f04f 32ff 	mov.w	r2, #4294967295	; 0xffffffff
    1920:	e9cd 2305 	strd	r2, r3, [sp, #20]
#    1924:	f10a 0a01 	add.w	sl, sl, #1
#    1928:	9304      	str	r3, [sp, #16]
#    192a:	9307      	str	r3, [sp, #28]
    192c:	f88d 3053 	strb.w	r3, [sp, #83]	; 0x53
#    1930:	931a      	str	r3, [sp, #104]	; 0x68
#    1932:	4654      	mov	r4, sl
    1934:	2205      	movs	r2, #5
    1936:	f814 1b01 	ldrb.w	r1, [r4], #1
    193a:	4858      	ldr	r0, [pc, #352]	; (1a9c <_vfiprintf_r+0x24c>)
    193c:	f000 fcc0 	bl	22c0 <memchr>
    1940:	9a04      	ldr	r2, [sp, #16]
    1942:	b9d8      	cbnz	r0, 197c <_vfiprintf_r+0x12c>
    1944:	06d1      	lsls	r1, r2, #27
    1946:	bf44      	itt	mi
    1948:	2320      	movmi	r3, #32
    194a:	f88d 3053 	strbmi.w	r3, [sp, #83]	; 0x53
    194e:	0713      	lsls	r3, r2, #28
    1950:	bf44      	itt	mi
    1952:	232b      	movmi	r3, #43	; 0x2b
    1954:	f88d 3053 	strbmi.w	r3, [sp, #83]	; 0x53
    1958:	f89a 3000 	ldrb.w	r3, [sl]
    195c:	2b2a      	cmp	r3, #42	; 0x2a
    195e:	d015      	beq.n	198c <_vfiprintf_r+0x13c>
#    1960:	9a07      	ldr	r2, [sp, #28]
#    1962:	4654      	mov	r4, sl
#    1964:	2000      	movs	r0, #0
#    1966:	f04f 0c0a 	mov.w	ip, #10
#    196a:	4621      	mov	r1, r4
#    196c:	f811 3b01 	ldrb.w	r3, [r1], #1
    1970:	3b30      	subs	r3, #48	; 0x30
#    1972:	2b09      	cmp	r3, #9
#    1974:	d94e      	bls.n	1a14 <_vfiprintf_r+0x1c4>
#    1976:	b1b0      	cbz	r0, 19a6 <_vfiprintf_r+0x156>
#    1978:	9207      	str	r2, [sp, #28]
#    197a:	e014      	b.n	19a6 <_vfiprintf_r+0x156>
#    197c:	eba0 0308 	sub.w	r3, r0, r8
#    1980:	fa09 f303 	lsl.w	r3, r9, r3
    1984:	4313      	orrs	r3, r2
#    1986:	9304      	str	r3, [sp, #16]
    1988:	46a2      	mov	sl, r4
#    198a:	e7d2      	b.n	1932 <_vfiprintf_r+0xe2>
#    198c:	9b03      	ldr	r3, [sp, #12]
#    198e:	1d19      	adds	r1, r3, #4
    1990:	681b      	ldr	r3, [r3, #0]
#    1992:	9103      	str	r1, [sp, #12]
#    1994:	2b00      	cmp	r3, #0
#    1996:	bfbb      	ittet	lt
#    1998:	425b      	neglt	r3, r3
#    199a:	f042 0202 	orrlt.w	r2, r2, #2
#    199e:	9307      	strge	r3, [sp, #28]
#    19a0:	9307      	strlt	r3, [sp, #28]
#    19a2:	bfb8      	it	lt
    19a4:	9204      	strlt	r2, [sp, #16]
#    19a6:	7823      	ldrb	r3, [r4, #0]
#    19a8:	2b2e      	cmp	r3, #46	; 0x2e
#    19aa:	d10c      	bne.n	19c6 <_vfiprintf_r+0x176>
#    19ac:	7863      	ldrb	r3, [r4, #1]
#    19ae:	2b2a      	cmp	r3, #42	; 0x2a
#    19b0:	d135      	bne.n	1a1e <_vfiprintf_r+0x1ce>
#    19b2:	9b03      	ldr	r3, [sp, #12]
#    19b4:	1d1a      	adds	r2, r3, #4
#    19b6:	681b      	ldr	r3, [r3, #0]
    19b8:	9203      	str	r2, [sp, #12]
#    19ba:	2b00      	cmp	r3, #0
#    19bc:	bfb8      	it	lt
#    19be:	f04f 33ff 	movlt.w	r3, #4294967295	; 0xffffffff
#    19c2:	3402      	adds	r4, #2
    19c4:	9305      	str	r3, [sp, #20]
#    19c6:	f8df a0e4 	ldr.w	sl, [pc, #228]	; 1aac <_vfiprintf_r+0x25c>
#    19ca:	7821      	ldrb	r1, [r4, #0]
#    19cc:	2203      	movs	r2, #3
    19ce:	4650      	mov	r0, sl
#    19d0:	f000 fc76 	bl	22c0 <memchr>
#    19d4:	b140      	cbz	r0, 19e8 <_vfiprintf_r+0x198>
#    19d6:	2340      	movs	r3, #64	; 0x40
#    19d8:	eba0 000a 	sub.w	r0, r0, sl
#    19dc:	fa03 f000 	lsl.w	r0, r3, r0
#    19e0:	9b04      	ldr	r3, [sp, #16]
    19e2:	4303      	orrs	r3, r0
#    19e4:	3401      	adds	r4, #1
    19e6:	9304      	str	r3, [sp, #16]
#    19e8:	f814 1b01 	ldrb.w	r1, [r4], #1
    19ec:	482c      	ldr	r0, [pc, #176]	; (1aa0 <_vfiprintf_r+0x250>)
#    19ee:	f88d 1028 	strb.w	r1, [sp, #40]	; 0x28
#    19f2:	2206      	movs	r2, #6
#    19f4:	f000 fc64 	bl	22c0 <memchr>
    19f8:	2800      	cmp	r0, #0
#    19fa:	d03f      	beq.n	1a7c <_vfiprintf_r+0x22c>
    19fc:	4b29      	ldr	r3, [pc, #164]	; (1aa4 <_vfiprintf_r+0x254>)
#    19fe:	bb1b      	cbnz	r3, 1a48 <_vfiprintf_r+0x1f8>
    1a00:	9b03      	ldr	r3, [sp, #12]
#    1a02:	3307      	adds	r3, #7
#    1a04:	f023 0307 	bic.w	r3, r3, #7
#    1a08:	3308      	adds	r3, #8
#    1a0a:	9303      	str	r3, [sp, #12]
    1a0c:	9b09      	ldr	r3, [sp, #36]	; 0x24
#    1a0e:	443b      	add	r3, r7
#    1a10:	9309      	str	r3, [sp, #36]	; 0x24
#    1a12:	e767      	b.n	18e4 <_vfiprintf_r+0x94>
#    1a14:	fb0c 3202 	mla	r2, ip, r2, r3
#    1a18:	460c      	mov	r4, r1
    1a1a:	2001      	movs	r0, #1
#    1a1c:	e7a5      	b.n	196a <_vfiprintf_r+0x11a>
    1a1e:	2300      	movs	r3, #0
    1a20:	3401      	adds	r4, #1
    1a22:	9305      	str	r3, [sp, #20]
    1a24:	4619      	mov	r1, r3
    1a26:	f04f 0c0a 	mov.w	ip, #10
    1a2a:	4620      	mov	r0, r4
    1a2c:	f810 2b01 	ldrb.w	r2, [r0], #1
    1a30:	3a30      	subs	r2, #48	; 0x30
    1a32:	2a09      	cmp	r2, #9
    1a34:	d903      	bls.n	1a3e <_vfiprintf_r+0x1ee>
    1a36:	2b00      	cmp	r3, #0
    1a38:	d0c5      	beq.n	19c6 <_vfiprintf_r+0x176>
    1a3a:	9105      	str	r1, [sp, #20]
    1a3c:	e7c3      	b.n	19c6 <_vfiprintf_r+0x176>
    1a3e:	fb0c 2101 	mla	r1, ip, r1, r2
    1a42:	4604      	mov	r4, r0
    1a44:	2301      	movs	r3, #1
    1a46:	e7f0      	b.n	1a2a <_vfiprintf_r+0x1da>
    1a48:	ab03      	add	r3, sp, #12
    1a4a:	9300      	str	r3, [sp, #0]
    1a4c:	462a      	mov	r2, r5
    1a4e:	4b16      	ldr	r3, [pc, #88]	; (1aa8 <_vfiprintf_r+0x258>)
    1a50:	a904      	add	r1, sp, #16
    1a52:	4630      	mov	r0, r6
    1a54:	f3af 8000 	nop.w
    1a58:	4607      	mov	r7, r0
    1a5a:	1c78      	adds	r0, r7, #1
    1a5c:	d1d6      	bne.n	1a0c <_vfiprintf_r+0x1bc>
#    1a5e:	6e6b      	ldr	r3, [r5, #100]	; 0x64
#    1a60:	07d9      	lsls	r1, r3, #31
#    1a62:	d405      	bmi.n	1a70 <_vfiprintf_r+0x220>
#    1a64:	89ab      	ldrh	r3, [r5, #12]
#    1a66:	059a      	lsls	r2, r3, #22
#    1a68:	d402      	bmi.n	1a70 <_vfiprintf_r+0x220>
#    1a6a:	6da8      	ldr	r0, [r5, #88]	; 0x58
#    1a6c:	f7ff fe6d 	bl	174a <__retarget_lock_release_recursive>
#    1a70:	89ab      	ldrh	r3, [r5, #12]
#    1a72:	065b      	lsls	r3, r3, #25
#    1a74:	f53f af12 	bmi.w	189c <_vfiprintf_r+0x4c>
#    1a78:	9809      	ldr	r0, [sp, #36]	; 0x24
#    1a7a:	e711      	b.n	18a0 <_vfiprintf_r+0x50>
#    1a7c:	ab03      	add	r3, sp, #12
#    1a7e:	9300      	str	r3, [sp, #0]
#    1a80:	462a      	mov	r2, r5
#    1a82:	4b09      	ldr	r3, [pc, #36]	; (1aa8 <_vfiprintf_r+0x258>)
    1a84:	a904      	add	r1, sp, #16
#    1a86:	4630      	mov	r0, r6
#    1a88:	f000 f880 	bl	1b8c <_printf_i>
#    1a8c:	e7e4      	b.n	1a58 <_vfiprintf_r+0x208>
#    1a8e:	bf00      	nop
    1a90:	00002564 	.word	0x00002564
    1a94:	00002584 	.word	0x00002584
#    1a98:	00002544 	.word	0x00002544
#    1a9c:	000025a4 	.word	0x000025a4
#    1aa0:	000025ae 	.word	0x000025ae
#    1aa4:	00000000 	.word	0x00000000
#    1aa8:	0000182b 	.word	0x0000182b
#    1aac:	000025aa 	.word	0x000025aa

00001ab0 <_printf_common>:
#    1ab0:	e92d 47f0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
    1ab4:	4616      	mov	r6, r2
    1ab6:	4699      	mov	r9, r3
    1ab8:	688a      	ldr	r2, [r1, #8]
    1aba:	690b      	ldr	r3, [r1, #16]
    1abc:	f8dd 8020 	ldr.w	r8, [sp, #32]
    1ac0:	4293      	cmp	r3, r2
    1ac2:	bfb8      	it	lt
    1ac4:	4613      	movlt	r3, r2
    1ac6:	6033      	str	r3, [r6, #0]
    1ac8:	f891 2043 	ldrb.w	r2, [r1, #67]	; 0x43
    1acc:	4607      	mov	r7, r0
    1ace:	460c      	mov	r4, r1
    1ad0:	b10a      	cbz	r2, 1ad6 <_printf_common+0x26>
    1ad2:	3301      	adds	r3, #1
    1ad4:	6033      	str	r3, [r6, #0]
    1ad6:	6823      	ldr	r3, [r4, #0]
    1ad8:	0699      	lsls	r1, r3, #26
    1ada:	bf42      	ittt	mi
    1adc:	6833      	ldrmi	r3, [r6, #0]
    1ade:	3302      	addmi	r3, #2
    1ae0:	6033      	strmi	r3, [r6, #0]
    1ae2:	6825      	ldr	r5, [r4, #0]
    1ae4:	f015 0506 	ands.w	r5, r5, #6
    1ae8:	d106      	bne.n	1af8 <_printf_common+0x48>
    1aea:	f104 0a19 	add.w	sl, r4, #25
    1aee:	68e3      	ldr	r3, [r4, #12]
    1af0:	6832      	ldr	r2, [r6, #0]
    1af2:	1a9b      	subs	r3, r3, r2
#    1af4:	42ab      	cmp	r3, r5
#    1af6:	dc26      	bgt.n	1b46 <_printf_common+0x96>
#    1af8:	f894 2043 	ldrb.w	r2, [r4, #67]	; 0x43
#    1afc:	1e13      	subs	r3, r2, #0
#    1afe:	6822      	ldr	r2, [r4, #0]
    1b00:	bf18      	it	ne
#    1b02:	2301      	movne	r3, #1
    1b04:	0692      	lsls	r2, r2, #26
#    1b06:	d42b      	bmi.n	1b60 <_printf_common+0xb0>
#    1b08:	f104 0243 	add.w	r2, r4, #67	; 0x43
#    1b0c:	4649      	mov	r1, r9
    1b0e:	4638      	mov	r0, r7
#    1b10:	47c0      	blx	r8
    1b12:	3001      	adds	r0, #1
#    1b14:	d01e      	beq.n	1b54 <_printf_common+0xa4>
#    1b16:	6823      	ldr	r3, [r4, #0]
#    1b18:	68e5      	ldr	r5, [r4, #12]
#    1b1a:	6832      	ldr	r2, [r6, #0]
#    1b1c:	f003 0306 	and.w	r3, r3, #6
#    1b20:	2b04      	cmp	r3, #4
    1b22:	bf08      	it	eq
#    1b24:	1aad      	subeq	r5, r5, r2
#    1b26:	68a3      	ldr	r3, [r4, #8]
#    1b28:	6922      	ldr	r2, [r4, #16]
#    1b2a:	bf0c      	ite	eq
#    1b2c:	ea25 75e5 	biceq.w	r5, r5, r5, asr #31
    1b30:	2500      	movne	r5, #0
    1b32:	4293      	cmp	r3, r2
    1b34:	bfc4      	itt	gt
    1b36:	1a9b      	subgt	r3, r3, r2
    1b38:	18ed      	addgt	r5, r5, r3
    1b3a:	2600      	movs	r6, #0
    1b3c:	341a      	adds	r4, #26
    1b3e:	42b5      	cmp	r5, r6
    1b40:	d11a      	bne.n	1b78 <_printf_common+0xc8>
    1b42:	2000      	movs	r0, #0
    1b44:	e008      	b.n	1b58 <_printf_common+0xa8>
    1b46:	2301      	movs	r3, #1
    1b48:	4652      	mov	r2, sl
    1b4a:	4649      	mov	r1, r9
    1b4c:	4638      	mov	r0, r7
    1b4e:	47c0      	blx	r8
    1b50:	3001      	adds	r0, #1
    1b52:	d103      	bne.n	1b5c <_printf_common+0xac>
    1b54:	f04f 30ff 	mov.w	r0, #4294967295	; 0xffffffff
    1b58:	e8bd 87f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
    1b5c:	3501      	adds	r5, #1
    1b5e:	e7c6      	b.n	1aee <_printf_common+0x3e>
    1b60:	18e1      	adds	r1, r4, r3
    1b62:	1c5a      	adds	r2, r3, #1
    1b64:	2030      	movs	r0, #48	; 0x30
    1b66:	f881 0043 	strb.w	r0, [r1, #67]	; 0x43
    1b6a:	4422      	add	r2, r4
    1b6c:	f894 1045 	ldrb.w	r1, [r4, #69]	; 0x45
    1b70:	f882 1043 	strb.w	r1, [r2, #67]	; 0x43
    1b74:	3302      	adds	r3, #2
    1b76:	e7c7      	b.n	1b08 <_printf_common+0x58>
    1b78:	2301      	movs	r3, #1
    1b7a:	4622      	mov	r2, r4
    1b7c:	4649      	mov	r1, r9
    1b7e:	4638      	mov	r0, r7
    1b80:	47c0      	blx	r8
    1b82:	3001      	adds	r0, #1
    1b84:	d0e6      	beq.n	1b54 <_printf_common+0xa4>
    1b86:	3601      	adds	r6, #1
    1b88:	e7d9      	b.n	1b3e <_printf_common+0x8e>
	...

00001b8c <_printf_i>:
    1b8c:	e92d 47ff 	stmdb	sp!, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, lr}
    1b90:	460c      	mov	r4, r1
    1b92:	4691      	mov	r9, r2
    1b94:	7e27      	ldrb	r7, [r4, #24]
    1b96:	990c      	ldr	r1, [sp, #48]	; 0x30
    1b98:	2f78      	cmp	r7, #120	; 0x78
    1b9a:	4680      	mov	r8, r0
    1b9c:	469a      	mov	sl, r3
    1b9e:	f104 0243 	add.w	r2, r4, #67	; 0x43
    1ba2:	d807      	bhi.n	1bb4 <_printf_i+0x28>
    1ba4:	2f62      	cmp	r7, #98	; 0x62
    1ba6:	d80a      	bhi.n	1bbe <_printf_i+0x32>
    1ba8:	2f00      	cmp	r7, #0
    1baa:	f000 80d8 	beq.w	1d5e <_printf_i+0x1d2>
    1bae:	2f58      	cmp	r7, #88	; 0x58
    1bb0:	f000 80a3 	beq.w	1cfa <_printf_i+0x16e>
    1bb4:	f104 0642 	add.w	r6, r4, #66	; 0x42
    1bb8:	f884 7042 	strb.w	r7, [r4, #66]	; 0x42
    1bbc:	e03a      	b.n	1c34 <_printf_i+0xa8>
    1bbe:	f1a7 0363 	sub.w	r3, r7, #99	; 0x63
    1bc2:	2b15      	cmp	r3, #21
    1bc4:	d8f6      	bhi.n	1bb4 <_printf_i+0x28>
    1bc6:	a001      	add	r0, pc, #4	; (adr r0, 1bcc <_printf_i+0x40>)
    1bc8:	f850 f023 	ldr.w	pc, [r0, r3, lsl #2]
    1bcc:	00001c25 	.word	0x00001c25
    1bd0:	00001c39 	.word	0x00001c39
    1bd4:	00001bb5 	.word	0x00001bb5
#    1bd8:	00001bb5 	.word	0x00001bb5
#    1bdc:	00001bb5 	.word	0x00001bb5
#    1be0:	00001bb5 	.word	0x00001bb5
#    1be4:	00001c39 	.word	0x00001c39
#    1be8:	00001bb5 	.word	0x00001bb5
    1bec:	00001bb5 	.word	0x00001bb5
#    1bf0:	00001bb5 	.word	0x00001bb5
#    1bf4:	00001bb5 	.word	0x00001bb5
#    1bf8:	00001d45 	.word	0x00001d45
#    1bfc:	00001c69 	.word	0x00001c69
#    1c00:	00001d27 	.word	0x00001d27
#    1c04:	00001bb5 	.word	0x00001bb5
#    1c08:	00001bb5 	.word	0x00001bb5
#    1c0c:	00001d67 	.word	0x00001d67
#    1c10:	00001bb5 	.word	0x00001bb5
#    1c14:	00001c69 	.word	0x00001c69
#    1c18:	00001bb5 	.word	0x00001bb5
#    1c1c:	00001bb5 	.word	0x00001bb5
#    1c20:	00001d2f 	.word	0x00001d2f
#    1c24:	680b      	ldr	r3, [r1, #0]
    1c26:	1d1a      	adds	r2, r3, #4
    1c28:	681b      	ldr	r3, [r3, #0]
    1c2a:	600a      	str	r2, [r1, #0]
    1c2c:	f104 0642 	add.w	r6, r4, #66	; 0x42
    1c30:	f884 3042 	strb.w	r3, [r4, #66]	; 0x42
    1c34:	2301      	movs	r3, #1
    1c36:	e0a3      	b.n	1d80 <_printf_i+0x1f4>
    1c38:	6825      	ldr	r5, [r4, #0]
    1c3a:	6808      	ldr	r0, [r1, #0]
    1c3c:	062e      	lsls	r6, r5, #24
    1c3e:	f100 0304 	add.w	r3, r0, #4
    1c42:	d50a      	bpl.n	1c5a <_printf_i+0xce>
    1c44:	6805      	ldr	r5, [r0, #0]
    1c46:	600b      	str	r3, [r1, #0]
    1c48:	2d00      	cmp	r5, #0
    1c4a:	da03      	bge.n	1c54 <_printf_i+0xc8>
    1c4c:	232d      	movs	r3, #45	; 0x2d
    1c4e:	426d      	negs	r5, r5
    1c50:	f884 3043 	strb.w	r3, [r4, #67]	; 0x43
    1c54:	485e      	ldr	r0, [pc, #376]	; (1dd0 <_printf_i+0x244>)
    1c56:	230a      	movs	r3, #10
    1c58:	e019      	b.n	1c8e <_printf_i+0x102>
    1c5a:	f015 0f40 	tst.w	r5, #64	; 0x40
    1c5e:	6805      	ldr	r5, [r0, #0]
    1c60:	600b      	str	r3, [r1, #0]
    1c62:	bf18      	it	ne
    1c64:	b22d      	sxthne	r5, r5
    1c66:	e7ef      	b.n	1c48 <_printf_i+0xbc>
    1c68:	680b      	ldr	r3, [r1, #0]
    1c6a:	6825      	ldr	r5, [r4, #0]
    1c6c:	1d18      	adds	r0, r3, #4
    1c6e:	6008      	str	r0, [r1, #0]
    1c70:	0628      	lsls	r0, r5, #24
    1c72:	d501      	bpl.n	1c78 <_printf_i+0xec>
    1c74:	681d      	ldr	r5, [r3, #0]
    1c76:	e002      	b.n	1c7e <_printf_i+0xf2>
#    1c78:	0669      	lsls	r1, r5, #25
#    1c7a:	d5fb      	bpl.n	1c74 <_printf_i+0xe8>
#    1c7c:	881d      	ldrh	r5, [r3, #0]
#    1c7e:	4854      	ldr	r0, [pc, #336]	; (1dd0 <_printf_i+0x244>)
#    1c80:	2f6f      	cmp	r7, #111	; 0x6f
#    1c82:	bf0c      	ite	eq
#    1c84:	2308      	moveq	r3, #8
#    1c86:	230a      	movne	r3, #10
    1c88:	2100      	movs	r1, #0
#    1c8a:	f884 1043 	strb.w	r1, [r4, #67]	; 0x43
#    1c8e:	6866      	ldr	r6, [r4, #4]
#    1c90:	60a6      	str	r6, [r4, #8]
#    1c92:	2e00      	cmp	r6, #0
#    1c94:	bfa2      	ittt	ge
    1c96:	6821      	ldrge	r1, [r4, #0]
#    1c98:	f021 0104 	bicge.w	r1, r1, #4
#    1c9c:	6021      	strge	r1, [r4, #0]
#    1c9e:	b90d      	cbnz	r5, 1ca4 <_printf_i+0x118>
#    1ca0:	2e00      	cmp	r6, #0
#    1ca2:	d04d      	beq.n	1d40 <_printf_i+0x1b4>
    1ca4:	4616      	mov	r6, r2
#    1ca6:	fbb5 f1f3 	udiv	r1, r5, r3
#    1caa:	fb03 5711 	mls	r7, r3, r1, r5
#    1cae:	5dc7      	ldrb	r7, [r0, r7]
#    1cb0:	f806 7d01 	strb.w	r7, [r6, #-1]!
#    1cb4:	462f      	mov	r7, r5
    1cb6:	42bb      	cmp	r3, r7
#    1cb8:	460d      	mov	r5, r1
#    1cba:	d9f4      	bls.n	1ca6 <_printf_i+0x11a>
#    1cbc:	2b08      	cmp	r3, #8
#    1cbe:	d10b      	bne.n	1cd8 <_printf_i+0x14c>
#    1cc0:	6823      	ldr	r3, [r4, #0]
#    1cc2:	07df      	lsls	r7, r3, #31
    1cc4:	d508      	bpl.n	1cd8 <_printf_i+0x14c>
#    1cc6:	6923      	ldr	r3, [r4, #16]
#    1cc8:	6861      	ldr	r1, [r4, #4]
#    1cca:	4299      	cmp	r1, r3
#    1ccc:	bfde      	ittt	le
    1cce:	2330      	movle	r3, #48	; 0x30
#    1cd0:	f806 3c01 	strble.w	r3, [r6, #-1]
    1cd4:	f106 36ff 	addle.w	r6, r6, #4294967295	; 0xffffffff
#    1cd8:	1b92      	subs	r2, r2, r6
#    1cda:	6122      	str	r2, [r4, #16]
    1cdc:	f8cd a000 	str.w	sl, [sp]
    1ce0:	464b      	mov	r3, r9
    1ce2:	aa03      	add	r2, sp, #12
    1ce4:	4621      	mov	r1, r4
    1ce6:	4640      	mov	r0, r8
    1ce8:	f7ff fee2 	bl	1ab0 <_printf_common>
    1cec:	3001      	adds	r0, #1
    1cee:	d14c      	bne.n	1d8a <_printf_i+0x1fe>
    1cf0:	f04f 30ff 	mov.w	r0, #4294967295	; 0xffffffff
    1cf4:	b004      	add	sp, #16
    1cf6:	e8bd 87f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
    1cfa:	4835      	ldr	r0, [pc, #212]	; (1dd0 <_printf_i+0x244>)
    1cfc:	f884 7045 	strb.w	r7, [r4, #69]	; 0x45
    1d00:	6823      	ldr	r3, [r4, #0]
    1d02:	680e      	ldr	r6, [r1, #0]
    1d04:	061f      	lsls	r7, r3, #24
    1d06:	f856 5b04 	ldr.w	r5, [r6], #4
    1d0a:	600e      	str	r6, [r1, #0]
    1d0c:	d514      	bpl.n	1d38 <_printf_i+0x1ac>
    1d0e:	07d9      	lsls	r1, r3, #31
    1d10:	bf44      	itt	mi
    1d12:	f043 0320 	orrmi.w	r3, r3, #32
    1d16:	6023      	strmi	r3, [r4, #0]
    1d18:	b91d      	cbnz	r5, 1d22 <_printf_i+0x196>
    1d1a:	6823      	ldr	r3, [r4, #0]
    1d1c:	f023 0320 	bic.w	r3, r3, #32
    1d20:	6023      	str	r3, [r4, #0]
    1d22:	2310      	movs	r3, #16
    1d24:	e7b0      	b.n	1c88 <_printf_i+0xfc>
    1d26:	6823      	ldr	r3, [r4, #0]
    1d28:	f043 0320 	orr.w	r3, r3, #32
    1d2c:	6023      	str	r3, [r4, #0]
    1d2e:	2378      	movs	r3, #120	; 0x78
    1d30:	4828      	ldr	r0, [pc, #160]	; (1dd4 <_printf_i+0x248>)
    1d32:	f884 3045 	strb.w	r3, [r4, #69]	; 0x45
    1d36:	e7e3      	b.n	1d00 <_printf_i+0x174>
    1d38:	065e      	lsls	r6, r3, #25
    1d3a:	bf48      	it	mi
    1d3c:	b2ad      	uxthmi	r5, r5
    1d3e:	e7e6      	b.n	1d0e <_printf_i+0x182>
    1d40:	4616      	mov	r6, r2
    1d42:	e7bb      	b.n	1cbc <_printf_i+0x130>
    1d44:	680b      	ldr	r3, [r1, #0]
    1d46:	6826      	ldr	r6, [r4, #0]
    1d48:	6960      	ldr	r0, [r4, #20]
    1d4a:	1d1d      	adds	r5, r3, #4
    1d4c:	600d      	str	r5, [r1, #0]
    1d4e:	0635      	lsls	r5, r6, #24
    1d50:	681b      	ldr	r3, [r3, #0]
    1d52:	d501      	bpl.n	1d58 <_printf_i+0x1cc>
    1d54:	6018      	str	r0, [r3, #0]
    1d56:	e002      	b.n	1d5e <_printf_i+0x1d2>
    1d58:	0671      	lsls	r1, r6, #25
    1d5a:	d5fb      	bpl.n	1d54 <_printf_i+0x1c8>
    1d5c:	8018      	strh	r0, [r3, #0]
    1d5e:	2300      	movs	r3, #0
    1d60:	6123      	str	r3, [r4, #16]
    1d62:	4616      	mov	r6, r2
    1d64:	e7ba      	b.n	1cdc <_printf_i+0x150>
    1d66:	680b      	ldr	r3, [r1, #0]
    1d68:	1d1a      	adds	r2, r3, #4
    1d6a:	600a      	str	r2, [r1, #0]
    1d6c:	681e      	ldr	r6, [r3, #0]
    1d6e:	6862      	ldr	r2, [r4, #4]
    1d70:	2100      	movs	r1, #0
    1d72:	4630      	mov	r0, r6
    1d74:	f000 faa4 	bl	22c0 <memchr>
    1d78:	b108      	cbz	r0, 1d7e <_printf_i+0x1f2>
    1d7a:	1b80      	subs	r0, r0, r6
    1d7c:	6060      	str	r0, [r4, #4]
    1d7e:	6863      	ldr	r3, [r4, #4]
    1d80:	6123      	str	r3, [r4, #16]
    1d82:	2300      	movs	r3, #0
    1d84:	f884 3043 	strb.w	r3, [r4, #67]	; 0x43
    1d88:	e7a8      	b.n	1cdc <_printf_i+0x150>
    1d8a:	6923      	ldr	r3, [r4, #16]
    1d8c:	4632      	mov	r2, r6
    1d8e:	4649      	mov	r1, r9
    1d90:	4640      	mov	r0, r8
    1d92:	47d0      	blx	sl
    1d94:	3001      	adds	r0, #1
    1d96:	d0ab      	beq.n	1cf0 <_printf_i+0x164>
    1d98:	6823      	ldr	r3, [r4, #0]
    1d9a:	079b      	lsls	r3, r3, #30
    1d9c:	d413      	bmi.n	1dc6 <_printf_i+0x23a>
    1d9e:	68e0      	ldr	r0, [r4, #12]
    1da0:	9b03      	ldr	r3, [sp, #12]
    1da2:	4298      	cmp	r0, r3
    1da4:	bfb8      	it	lt
    1da6:	4618      	movlt	r0, r3
    1da8:	e7a4      	b.n	1cf4 <_printf_i+0x168>
    1daa:	2301      	movs	r3, #1
    1dac:	4632      	mov	r2, r6
    1dae:	4649      	mov	r1, r9
    1db0:	4640      	mov	r0, r8
    1db2:	47d0      	blx	sl
    1db4:	3001      	adds	r0, #1
    1db6:	d09b      	beq.n	1cf0 <_printf_i+0x164>
    1db8:	3501      	adds	r5, #1
    1dba:	68e3      	ldr	r3, [r4, #12]
    1dbc:	9903      	ldr	r1, [sp, #12]
    1dbe:	1a5b      	subs	r3, r3, r1
    1dc0:	42ab      	cmp	r3, r5
    1dc2:	dcf2      	bgt.n	1daa <_printf_i+0x21e>
    1dc4:	e7eb      	b.n	1d9e <_printf_i+0x212>
    1dc6:	2500      	movs	r5, #0
    1dc8:	f104 0619 	add.w	r6, r4, #25
    1dcc:	e7f5      	b.n	1dba <_printf_i+0x22e>
    1dce:	bf00      	nop
    1dd0:	000025b5 	.word	0x000025b5
    1dd4:	000025c6 	.word	0x000025c6

#00001dd8 <_sbrk_r>:
#    1dd8:	b538      	push	{r3, r4, r5, lr}
#    1dda:	4d06      	ldr	r5, [pc, #24]	; (1df4 <_sbrk_r+0x1c>)
#    1ddc:	2300      	movs	r3, #0
#    1dde:	4604      	mov	r4, r0
#    1de0:	4608      	mov	r0, r1
#    1de2:	602b      	str	r3, [r5, #0]
#    1de4:	f000 fb6a 	bl	24bc <_sbrk>
#    1de8:	1c43      	adds	r3, r0, #1
#    1dea:	d102      	bne.n	1df2 <_sbrk_r+0x1a>
    1dec:	682b      	ldr	r3, [r5, #0]
    1dee:	b103      	cbz	r3, 1df2 <_sbrk_r+0x1a>
    1df0:	6023      	str	r3, [r4, #0]
#    1df2:	bd38      	pop	{r3, r4, r5, pc}
    1df4:	200002fc 	.word	0x200002fc

00001df8 <__sread>:
    1df8:	b510      	push	{r4, lr}
    1dfa:	460c      	mov	r4, r1
    1dfc:	f9b1 100e 	ldrsh.w	r1, [r1, #14]
    1e00:	f000 fb08 	bl	2414 <_read_r>
    1e04:	2800      	cmp	r0, #0
    1e06:	bfab      	itete	ge
    1e08:	6d63      	ldrge	r3, [r4, #84]	; 0x54
    1e0a:	89a3      	ldrhlt	r3, [r4, #12]
    1e0c:	181b      	addge	r3, r3, r0
    1e0e:	f423 5380 	biclt.w	r3, r3, #4096	; 0x1000
    1e12:	bfac      	ite	ge
    1e14:	6563      	strge	r3, [r4, #84]	; 0x54
    1e16:	81a3      	strhlt	r3, [r4, #12]
    1e18:	bd10      	pop	{r4, pc}

#00001e1a <__swrite>:
#    1e1a:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
#    1e1e:	461f      	mov	r7, r3
#    1e20:	898b      	ldrh	r3, [r1, #12]
#    1e22:	05db      	lsls	r3, r3, #23
#    1e24:	4605      	mov	r5, r0
#    1e26:	460c      	mov	r4, r1
#    1e28:	4616      	mov	r6, r2
#    1e2a:	d505      	bpl.n	1e38 <__swrite+0x1e>
    1e2c:	f9b1 100e 	ldrsh.w	r1, [r1, #14]
    1e30:	2302      	movs	r3, #2
    1e32:	2200      	movs	r2, #0
    1e34:	f000 f9c8 	bl	21c8 <_lseek_r>
#    1e38:	89a3      	ldrh	r3, [r4, #12]
#    1e3a:	f9b4 100e 	ldrsh.w	r1, [r4, #14]
#    1e3e:	f423 5380 	bic.w	r3, r3, #4096	; 0x1000
#    1e42:	81a3      	strh	r3, [r4, #12]
#    1e44:	4632      	mov	r2, r6
#    1e46:	463b      	mov	r3, r7
#    1e48:	4628      	mov	r0, r5
#    1e4a:	e8bd 41f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, lr}
#    1e4e:	f000 b869 	b.w	1f24 <_write_r>

00001e52 <__sseek>:
    1e52:	b510      	push	{r4, lr}
    1e54:	460c      	mov	r4, r1
    1e56:	f9b1 100e 	ldrsh.w	r1, [r1, #14]
    1e5a:	f000 f9b5 	bl	21c8 <_lseek_r>
    1e5e:	1c43      	adds	r3, r0, #1
    1e60:	89a3      	ldrh	r3, [r4, #12]
    1e62:	bf15      	itete	ne
    1e64:	6560      	strne	r0, [r4, #84]	; 0x54
    1e66:	f423 5380 	biceq.w	r3, r3, #4096	; 0x1000
    1e6a:	f443 5380 	orrne.w	r3, r3, #4096	; 0x1000
    1e6e:	81a3      	strheq	r3, [r4, #12]
    1e70:	bf18      	it	ne
    1e72:	81a3      	strhne	r3, [r4, #12]
    1e74:	bd10      	pop	{r4, pc}

00001e76 <__sclose>:
    1e76:	f9b1 100e 	ldrsh.w	r1, [r1, #14]
    1e7a:	f000 b8d3 	b.w	2024 <_close_r>
	...

#00001e80 <__swbuf_r>:
#    1e80:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
#    1e82:	460e      	mov	r6, r1
#    1e84:	4614      	mov	r4, r2
#    1e86:	4605      	mov	r5, r0
#    1e88:	b118      	cbz	r0, 1e92 <__swbuf_r+0x12>
#    1e8a:	6983      	ldr	r3, [r0, #24]
#    1e8c:	b90b      	cbnz	r3, 1e92 <__swbuf_r+0x12>
    1e8e:	f7ff fbbd 	bl	160c <__sinit>
#    1e92:	4b21      	ldr	r3, [pc, #132]	; (1f18 <__swbuf_r+0x98>)
#    1e94:	429c      	cmp	r4, r3
#    1e96:	d12b      	bne.n	1ef0 <__swbuf_r+0x70>
    1e98:	686c      	ldr	r4, [r5, #4]
#    1e9a:	69a3      	ldr	r3, [r4, #24]
#    1e9c:	60a3      	str	r3, [r4, #8]
#    1e9e:	89a3      	ldrh	r3, [r4, #12]
#    1ea0:	071a      	lsls	r2, r3, #28
#    1ea2:	d52f      	bpl.n	1f04 <__swbuf_r+0x84>
#    1ea4:	6923      	ldr	r3, [r4, #16]
#    1ea6:	b36b      	cbz	r3, 1f04 <__swbuf_r+0x84>
#    1ea8:	6923      	ldr	r3, [r4, #16]
#    1eaa:	6820      	ldr	r0, [r4, #0]
#    1eac:	1ac0      	subs	r0, r0, r3
#    1eae:	6963      	ldr	r3, [r4, #20]
#    1eb0:	b2f6      	uxtb	r6, r6
#    1eb2:	4283      	cmp	r3, r0
#    1eb4:	4637      	mov	r7, r6
#    1eb6:	dc04      	bgt.n	1ec2 <__swbuf_r+0x42>
#    1eb8:	4621      	mov	r1, r4
#    1eba:	4628      	mov	r0, r5
#    1ebc:	f000 f948 	bl	2150 <_fflush_r>
#    1ec0:	bb30      	cbnz	r0, 1f10 <__swbuf_r+0x90>
#    1ec2:	68a3      	ldr	r3, [r4, #8]
#    1ec4:	3b01      	subs	r3, #1
#    1ec6:	60a3      	str	r3, [r4, #8]
#    1ec8:	6823      	ldr	r3, [r4, #0]
#    1eca:	1c5a      	adds	r2, r3, #1
#    1ecc:	6022      	str	r2, [r4, #0]
#    1ece:	701e      	strb	r6, [r3, #0]
#    1ed0:	6963      	ldr	r3, [r4, #20]
#    1ed2:	3001      	adds	r0, #1
#    1ed4:	4283      	cmp	r3, r0
#    1ed6:	d004      	beq.n	1ee2 <__swbuf_r+0x62>
#    1ed8:	89a3      	ldrh	r3, [r4, #12]
#    1eda:	07db      	lsls	r3, r3, #31
#    1edc:	d506      	bpl.n	1eec <__swbuf_r+0x6c>
#    1ede:	2e0a      	cmp	r6, #10
#    1ee0:	d104      	bne.n	1eec <__swbuf_r+0x6c>
#    1ee2:	4621      	mov	r1, r4
#    1ee4:	4628      	mov	r0, r5
#    1ee6:	f000 f933 	bl	2150 <_fflush_r>
#    1eea:	b988      	cbnz	r0, 1f10 <__swbuf_r+0x90>
#    1eec:	4638      	mov	r0, r7
#    1eee:	bdf8      	pop	{r3, r4, r5, r6, r7, pc}
#    1ef0:	4b0a      	ldr	r3, [pc, #40]	; (1f1c <__swbuf_r+0x9c>)
#    1ef2:	429c      	cmp	r4, r3
#    1ef4:	d101      	bne.n	1efa <__swbuf_r+0x7a>
#    1ef6:	68ac      	ldr	r4, [r5, #8]
#    1ef8:	e7cf      	b.n	1e9a <__swbuf_r+0x1a>
#    1efa:	4b09      	ldr	r3, [pc, #36]	; (1f20 <__swbuf_r+0xa0>)
#    1efc:	429c      	cmp	r4, r3
#    1efe:	bf08      	it	eq
#    1f00:	68ec      	ldreq	r4, [r5, #12]
#    1f02:	e7ca      	b.n	1e9a <__swbuf_r+0x1a>
#    1f04:	4621      	mov	r1, r4
#    1f06:	4628      	mov	r0, r5
#    1f08:	f000 f81e 	bl	1f48 <__swsetup_r>
    1f0c:	2800      	cmp	r0, #0
#    1f0e:	d0cb      	beq.n	1ea8 <__swbuf_r+0x28>
#    1f10:	f04f 37ff 	mov.w	r7, #4294967295	; 0xffffffff
#    1f14:	e7ea      	b.n	1eec <__swbuf_r+0x6c>
#    1f16:	bf00      	nop
#    1f18:	00002564 	.word	0x00002564
#    1f1c:	00002584 	.word	0x00002584
#    1f20:	00002544 	.word	0x00002544

#00001f24 <_write_r>:
#    1f24:	b538      	push	{r3, r4, r5, lr}
#    1f26:	4d07      	ldr	r5, [pc, #28]	; (1f44 <_write_r+0x20>)
#    1f28:	4604      	mov	r4, r0
#    1f2a:	4608      	mov	r0, r1
#    1f2c:	4611      	mov	r1, r2
#    1f2e:	2200      	movs	r2, #0
#    1f30:	602a      	str	r2, [r5, #0]
#    1f32:	461a      	mov	r2, r3
#    1f34:	f7fe fc76 	bl	824 <_write>
#    1f38:	1c43      	adds	r3, r0, #1
#    1f3a:	d102      	bne.n	1f42 <_write_r+0x1e>
#    1f3c:	682b      	ldr	r3, [r5, #0]
#    1f3e:	b103      	cbz	r3, 1f42 <_write_r+0x1e>
#    1f40:	6023      	str	r3, [r4, #0]
#    1f42:	bd38      	pop	{r3, r4, r5, pc}
#    1f44:	200002fc 	.word	0x200002fc

#00001f48 <__swsetup_r>:
#    1f48:	4b32      	ldr	r3, [pc, #200]	; (2014 <Heap_Size+0x14>)
#    1f4a:	b570      	push	{r4, r5, r6, lr}
#    1f4c:	681d      	ldr	r5, [r3, #0]
#    1f4e:	4606      	mov	r6, r0
#    1f50:	460c      	mov	r4, r1
#    1f52:	b125      	cbz	r5, 1f5e <__swsetup_r+0x16>
#    1f54:	69ab      	ldr	r3, [r5, #24]
#    1f56:	b913      	cbnz	r3, 1f5e <__swsetup_r+0x16>
#    1f58:	4628      	mov	r0, r5
#    1f5a:	f7ff fb57 	bl	160c <__sinit>
#    1f5e:	4b2e      	ldr	r3, [pc, #184]	; (2018 <Heap_Size+0x18>)
#    1f60:	429c      	cmp	r4, r3
#    1f62:	d10f      	bne.n	1f84 <__swsetup_r+0x3c>
#    1f64:	686c      	ldr	r4, [r5, #4]
#    1f66:	89a3      	ldrh	r3, [r4, #12]
#    1f68:	f9b4 200c 	ldrsh.w	r2, [r4, #12]
#    1f6c:	0719      	lsls	r1, r3, #28
#    1f6e:	d42c      	bmi.n	1fca <__swsetup_r+0x82>
    1f70:	06dd      	lsls	r5, r3, #27
    1f72:	d411      	bmi.n	1f98 <__swsetup_r+0x50>
    1f74:	2309      	movs	r3, #9
    1f76:	6033      	str	r3, [r6, #0]
    1f78:	f042 0340 	orr.w	r3, r2, #64	; 0x40
    1f7c:	81a3      	strh	r3, [r4, #12]
    1f7e:	f04f 30ff 	mov.w	r0, #4294967295	; 0xffffffff
    1f82:	e03e      	b.n	2002 <Heap_Size+0x2>
#    1f84:	4b25      	ldr	r3, [pc, #148]	; (201c <Heap_Size+0x1c>)
#    1f86:	429c      	cmp	r4, r3
#    1f88:	d101      	bne.n	1f8e <__swsetup_r+0x46>
    1f8a:	68ac      	ldr	r4, [r5, #8]
    1f8c:	e7eb      	b.n	1f66 <__swsetup_r+0x1e>
#    1f8e:	4b24      	ldr	r3, [pc, #144]	; (2020 <Heap_Size+0x20>)
#    1f90:	429c      	cmp	r4, r3
#    1f92:	bf08      	it	eq
#    1f94:	68ec      	ldreq	r4, [r5, #12]
#    1f96:	e7e6      	b.n	1f66 <__swsetup_r+0x1e>
    1f98:	0758      	lsls	r0, r3, #29
    1f9a:	d512      	bpl.n	1fc2 <__swsetup_r+0x7a>
    1f9c:	6b61      	ldr	r1, [r4, #52]	; 0x34
    1f9e:	b141      	cbz	r1, 1fb2 <__swsetup_r+0x6a>
    1fa0:	f104 0344 	add.w	r3, r4, #68	; 0x44
    1fa4:	4299      	cmp	r1, r3
    1fa6:	d002      	beq.n	1fae <__swsetup_r+0x66>
    1fa8:	4630      	mov	r0, r6
    1faa:	f000 f9e5 	bl	2378 <_free_r>
    1fae:	2300      	movs	r3, #0
    1fb0:	6363      	str	r3, [r4, #52]	; 0x34
    1fb2:	89a3      	ldrh	r3, [r4, #12]
    1fb4:	f023 0324 	bic.w	r3, r3, #36	; 0x24
    1fb8:	81a3      	strh	r3, [r4, #12]
    1fba:	2300      	movs	r3, #0
    1fbc:	6063      	str	r3, [r4, #4]
    1fbe:	6923      	ldr	r3, [r4, #16]
    1fc0:	6023      	str	r3, [r4, #0]
    1fc2:	89a3      	ldrh	r3, [r4, #12]
    1fc4:	f043 0308 	orr.w	r3, r3, #8
    1fc8:	81a3      	strh	r3, [r4, #12]
#    1fca:	6923      	ldr	r3, [r4, #16]
#    1fcc:	b94b      	cbnz	r3, 1fe2 <__swsetup_r+0x9a>
#    1fce:	89a3      	ldrh	r3, [r4, #12]
#    1fd0:	f403 7320 	and.w	r3, r3, #640	; 0x280
#    1fd4:	f5b3 7f00 	cmp.w	r3, #512	; 0x200
#    1fd8:	d003      	beq.n	1fe2 <__swsetup_r+0x9a>
#    1fda:	4621      	mov	r1, r4
#    1fdc:	4630      	mov	r0, r6
#    1fde:	f000 f929 	bl	2234 <__smakebuf_r>
#    1fe2:	89a0      	ldrh	r0, [r4, #12]
#    1fe4:	f9b4 200c 	ldrsh.w	r2, [r4, #12]
#    1fe8:	f010 0301 	ands.w	r3, r0, #1
#    1fec:	d00a      	beq.n	2004 <Heap_Size+0x4>
#    1fee:	2300      	movs	r3, #0
#    1ff0:	60a3      	str	r3, [r4, #8]
#    1ff2:	6963      	ldr	r3, [r4, #20]
#    1ff4:	425b      	negs	r3, r3
#    1ff6:	61a3      	str	r3, [r4, #24]
#    1ff8:	6923      	ldr	r3, [r4, #16]
#    1ffa:	b943      	cbnz	r3, 200e <Heap_Size+0xe>
    1ffc:	f010 0080 	ands.w	r0, r0, #128	; 0x80
    2000:	d1ba      	bne.n	1f78 <__swsetup_r+0x30>
#    2002:	bd70      	pop	{r4, r5, r6, pc}
    2004:	0781      	lsls	r1, r0, #30
    2006:	bf58      	it	pl
    2008:	6963      	ldrpl	r3, [r4, #20]
    200a:	60a3      	str	r3, [r4, #8]
    200c:	e7f4      	b.n	1ff8 <__swsetup_r+0xb0>
#    200e:	2000      	movs	r0, #0
#    2010:	e7f7      	b.n	2002 <Heap_Size+0x2>
    2012:	bf00      	nop
    2014:	20000000 	.word	0x20000000
    2018:	00002564 	.word	0x00002564
    201c:	00002584 	.word	0x00002584
    2020:	00002544 	.word	0x00002544

00002024 <_close_r>:
    2024:	b538      	push	{r3, r4, r5, lr}
    2026:	4d06      	ldr	r5, [pc, #24]	; (2040 <_close_r+0x1c>)
    2028:	2300      	movs	r3, #0
    202a:	4604      	mov	r4, r0
    202c:	4608      	mov	r0, r1
    202e:	602b      	str	r3, [r5, #0]
    2030:	f000 fa24 	bl	247c <_close>
    2034:	1c43      	adds	r3, r0, #1
    2036:	d102      	bne.n	203e <_close_r+0x1a>
    2038:	682b      	ldr	r3, [r5, #0]
    203a:	b103      	cbz	r3, 203e <_close_r+0x1a>
    203c:	6023      	str	r3, [r4, #0]
    203e:	bd38      	pop	{r3, r4, r5, pc}
    2040:	200002fc 	.word	0x200002fc

#00002044 <__sflush_r>:
#    2044:	898a      	ldrh	r2, [r1, #12]
#    2046:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
#    204a:	4605      	mov	r5, r0
#    204c:	0710      	lsls	r0, r2, #28
#    204e:	460c      	mov	r4, r1
#    2050:	d458      	bmi.n	2104 <__sflush_r+0xc0>
    2052:	684b      	ldr	r3, [r1, #4]
    2054:	2b00      	cmp	r3, #0
    2056:	dc05      	bgt.n	2064 <__sflush_r+0x20>
    2058:	6c0b      	ldr	r3, [r1, #64]	; 0x40
    205a:	2b00      	cmp	r3, #0
    205c:	dc02      	bgt.n	2064 <__sflush_r+0x20>
#    205e:	2000      	movs	r0, #0
#    2060:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
    2064:	6ae6      	ldr	r6, [r4, #44]	; 0x2c
    2066:	2e00      	cmp	r6, #0
    2068:	d0f9      	beq.n	205e <__sflush_r+0x1a>
    206a:	2300      	movs	r3, #0
    206c:	f412 5280 	ands.w	r2, r2, #4096	; 0x1000
    2070:	682f      	ldr	r7, [r5, #0]
    2072:	602b      	str	r3, [r5, #0]
    2074:	d032      	beq.n	20dc <__sflush_r+0x98>
    2076:	6d60      	ldr	r0, [r4, #84]	; 0x54
    2078:	89a3      	ldrh	r3, [r4, #12]
    207a:	075a      	lsls	r2, r3, #29
    207c:	d505      	bpl.n	208a <__sflush_r+0x46>
    207e:	6863      	ldr	r3, [r4, #4]
    2080:	1ac0      	subs	r0, r0, r3
    2082:	6b63      	ldr	r3, [r4, #52]	; 0x34
    2084:	b10b      	cbz	r3, 208a <__sflush_r+0x46>
    2086:	6c23      	ldr	r3, [r4, #64]	; 0x40
    2088:	1ac0      	subs	r0, r0, r3
    208a:	2300      	movs	r3, #0
    208c:	4602      	mov	r2, r0
    208e:	6ae6      	ldr	r6, [r4, #44]	; 0x2c
    2090:	6a21      	ldr	r1, [r4, #32]
    2092:	4628      	mov	r0, r5
    2094:	47b0      	blx	r6
    2096:	1c43      	adds	r3, r0, #1
    2098:	89a3      	ldrh	r3, [r4, #12]
    209a:	d106      	bne.n	20aa <__sflush_r+0x66>
    209c:	6829      	ldr	r1, [r5, #0]
    209e:	291d      	cmp	r1, #29
    20a0:	d82c      	bhi.n	20fc <__sflush_r+0xb8>
    20a2:	4a2a      	ldr	r2, [pc, #168]	; (214c <__sflush_r+0x108>)
    20a4:	40ca      	lsrs	r2, r1
    20a6:	07d6      	lsls	r6, r2, #31
    20a8:	d528      	bpl.n	20fc <__sflush_r+0xb8>
    20aa:	2200      	movs	r2, #0
    20ac:	6062      	str	r2, [r4, #4]
    20ae:	04d9      	lsls	r1, r3, #19
    20b0:	6922      	ldr	r2, [r4, #16]
    20b2:	6022      	str	r2, [r4, #0]
    20b4:	d504      	bpl.n	20c0 <__sflush_r+0x7c>
    20b6:	1c42      	adds	r2, r0, #1
    20b8:	d101      	bne.n	20be <__sflush_r+0x7a>
    20ba:	682b      	ldr	r3, [r5, #0]
    20bc:	b903      	cbnz	r3, 20c0 <__sflush_r+0x7c>
    20be:	6560      	str	r0, [r4, #84]	; 0x54
    20c0:	6b61      	ldr	r1, [r4, #52]	; 0x34
    20c2:	602f      	str	r7, [r5, #0]
    20c4:	2900      	cmp	r1, #0
    20c6:	d0ca      	beq.n	205e <__sflush_r+0x1a>
    20c8:	f104 0344 	add.w	r3, r4, #68	; 0x44
    20cc:	4299      	cmp	r1, r3
    20ce:	d002      	beq.n	20d6 <__sflush_r+0x92>
    20d0:	4628      	mov	r0, r5
    20d2:	f000 f951 	bl	2378 <_free_r>
    20d6:	2000      	movs	r0, #0
    20d8:	6360      	str	r0, [r4, #52]	; 0x34
    20da:	e7c1      	b.n	2060 <__sflush_r+0x1c>
    20dc:	6a21      	ldr	r1, [r4, #32]
    20de:	2301      	movs	r3, #1
    20e0:	4628      	mov	r0, r5
    20e2:	47b0      	blx	r6
    20e4:	1c41      	adds	r1, r0, #1
    20e6:	d1c7      	bne.n	2078 <__sflush_r+0x34>
    20e8:	682b      	ldr	r3, [r5, #0]
    20ea:	2b00      	cmp	r3, #0
    20ec:	d0c4      	beq.n	2078 <__sflush_r+0x34>
    20ee:	2b1d      	cmp	r3, #29
    20f0:	d001      	beq.n	20f6 <__sflush_r+0xb2>
    20f2:	2b16      	cmp	r3, #22
    20f4:	d101      	bne.n	20fa <__sflush_r+0xb6>
    20f6:	602f      	str	r7, [r5, #0]
    20f8:	e7b1      	b.n	205e <__sflush_r+0x1a>
    20fa:	89a3      	ldrh	r3, [r4, #12]
    20fc:	f043 0340 	orr.w	r3, r3, #64	; 0x40
    2100:	81a3      	strh	r3, [r4, #12]
    2102:	e7ad      	b.n	2060 <__sflush_r+0x1c>
#    2104:	690f      	ldr	r7, [r1, #16]
#    2106:	2f00      	cmp	r7, #0
#    2108:	d0a9      	beq.n	205e <__sflush_r+0x1a>
#    210a:	0793      	lsls	r3, r2, #30
#    210c:	680e      	ldr	r6, [r1, #0]
#    210e:	bf08      	it	eq
#    2110:	694b      	ldreq	r3, [r1, #20]
#    2112:	600f      	str	r7, [r1, #0]
#    2114:	bf18      	it	ne
#    2116:	2300      	movne	r3, #0
#    2118:	eba6 0807 	sub.w	r8, r6, r7
#    211c:	608b      	str	r3, [r1, #8]
#    211e:	f1b8 0f00 	cmp.w	r8, #0
#    2122:	dd9c      	ble.n	205e <__sflush_r+0x1a>
#    2124:	6a21      	ldr	r1, [r4, #32]
#    2126:	6aa6      	ldr	r6, [r4, #40]	; 0x28
#    2128:	4643      	mov	r3, r8
#    212a:	463a      	mov	r2, r7
#    212c:	4628      	mov	r0, r5
#    212e:	47b0      	blx	r6
#    2130:	2800      	cmp	r0, #0
#    2132:	dc06      	bgt.n	2142 <__sflush_r+0xfe>
    2134:	89a3      	ldrh	r3, [r4, #12]
    2136:	f043 0340 	orr.w	r3, r3, #64	; 0x40
    213a:	81a3      	strh	r3, [r4, #12]
    213c:	f04f 30ff 	mov.w	r0, #4294967295	; 0xffffffff
    2140:	e78e      	b.n	2060 <__sflush_r+0x1c>
#    2142:	4407      	add	r7, r0
#    2144:	eba8 0800 	sub.w	r8, r8, r0
#    2148:	e7e9      	b.n	211e <__sflush_r+0xda>
    214a:	bf00      	nop
    214c:	20400001 	.word	0x20400001

#00002150 <_fflush_r>:
#    2150:	b538      	push	{r3, r4, r5, lr}
#    2152:	690b      	ldr	r3, [r1, #16]
#    2154:	4605      	mov	r5, r0
#    2156:	460c      	mov	r4, r1
#    2158:	b913      	cbnz	r3, 2160 <_fflush_r+0x10>
    215a:	2500      	movs	r5, #0
#    215c:	4628      	mov	r0, r5
#    215e:	bd38      	pop	{r3, r4, r5, pc}
#    2160:	b118      	cbz	r0, 216a <_fflush_r+0x1a>
#    2162:	6983      	ldr	r3, [r0, #24]
#    2164:	b90b      	cbnz	r3, 216a <_fflush_r+0x1a>
    2166:	f7ff fa51 	bl	160c <__sinit>
#    216a:	4b14      	ldr	r3, [pc, #80]	; (21bc <_fflush_r+0x6c>)
#    216c:	429c      	cmp	r4, r3
#    216e:	d11b      	bne.n	21a8 <_fflush_r+0x58>
    2170:	686c      	ldr	r4, [r5, #4]
#    2172:	f9b4 300c 	ldrsh.w	r3, [r4, #12]
#    2176:	2b00      	cmp	r3, #0
#    2178:	d0ef      	beq.n	215a <_fflush_r+0xa>
#    217a:	6e62      	ldr	r2, [r4, #100]	; 0x64
#    217c:	07d0      	lsls	r0, r2, #31
#    217e:	d404      	bmi.n	218a <_fflush_r+0x3a>
#    2180:	0599      	lsls	r1, r3, #22
#    2182:	d402      	bmi.n	218a <_fflush_r+0x3a>
#    2184:	6da0      	ldr	r0, [r4, #88]	; 0x58
#    2186:	f7ff fadf 	bl	1748 <__retarget_lock_acquire_recursive>
#    218a:	4628      	mov	r0, r5
#    218c:	4621      	mov	r1, r4
#    218e:	f7ff ff59 	bl	2044 <__sflush_r>
#    2192:	6e63      	ldr	r3, [r4, #100]	; 0x64
#    2194:	07da      	lsls	r2, r3, #31
#    2196:	4605      	mov	r5, r0
#    2198:	d4e0      	bmi.n	215c <_fflush_r+0xc>
#    219a:	89a3      	ldrh	r3, [r4, #12]
#    219c:	059b      	lsls	r3, r3, #22
#    219e:	d4dd      	bmi.n	215c <_fflush_r+0xc>
#    21a0:	6da0      	ldr	r0, [r4, #88]	; 0x58
#    21a2:	f7ff fad2 	bl	174a <__retarget_lock_release_recursive>
#    21a6:	e7d9      	b.n	215c <_fflush_r+0xc>
#    21a8:	4b05      	ldr	r3, [pc, #20]	; (21c0 <_fflush_r+0x70>)
#    21aa:	429c      	cmp	r4, r3
#    21ac:	d101      	bne.n	21b2 <_fflush_r+0x62>
    21ae:	68ac      	ldr	r4, [r5, #8]
    21b0:	e7df      	b.n	2172 <_fflush_r+0x22>
#    21b2:	4b04      	ldr	r3, [pc, #16]	; (21c4 <_fflush_r+0x74>)
#    21b4:	429c      	cmp	r4, r3
#    21b6:	bf08      	it	eq
#    21b8:	68ec      	ldreq	r4, [r5, #12]
#    21ba:	e7da      	b.n	2172 <_fflush_r+0x22>
    21bc:	00002564 	.word	0x00002564
    21c0:	00002584 	.word	0x00002584
    21c4:	00002544 	.word	0x00002544

000021c8 <_lseek_r>:
    21c8:	b538      	push	{r3, r4, r5, lr}
    21ca:	4d07      	ldr	r5, [pc, #28]	; (21e8 <_lseek_r+0x20>)
    21cc:	4604      	mov	r4, r0
    21ce:	4608      	mov	r0, r1
    21d0:	4611      	mov	r1, r2
    21d2:	2200      	movs	r2, #0
    21d4:	602a      	str	r2, [r5, #0]
    21d6:	461a      	mov	r2, r3
    21d8:	f000 f968 	bl	24ac <_lseek>
    21dc:	1c43      	adds	r3, r0, #1
    21de:	d102      	bne.n	21e6 <_lseek_r+0x1e>
    21e0:	682b      	ldr	r3, [r5, #0]
    21e2:	b103      	cbz	r3, 21e6 <_lseek_r+0x1e>
    21e4:	6023      	str	r3, [r4, #0]
    21e6:	bd38      	pop	{r3, r4, r5, pc}
    21e8:	200002fc 	.word	0x200002fc

#000021ec <__swhatbuf_r>:
#    21ec:	b570      	push	{r4, r5, r6, lr}
#    21ee:	460e      	mov	r6, r1
#    21f0:	f9b1 100e 	ldrsh.w	r1, [r1, #14]
#    21f4:	2900      	cmp	r1, #0
#    21f6:	b096      	sub	sp, #88	; 0x58
#    21f8:	4614      	mov	r4, r2
#    21fa:	461d      	mov	r5, r3
#    21fc:	da07      	bge.n	220e <__swhatbuf_r+0x22>
#    21fe:	2300      	movs	r3, #0
#    2200:	602b      	str	r3, [r5, #0]
#    2202:	89b3      	ldrh	r3, [r6, #12]
#    2204:	061a      	lsls	r2, r3, #24
#    2206:	d410      	bmi.n	222a <__swhatbuf_r+0x3e>
#    2208:	f44f 6380 	mov.w	r3, #1024	; 0x400
#    220c:	e00e      	b.n	222c <__swhatbuf_r+0x40>
#    220e:	466a      	mov	r2, sp
#    2210:	f000 f912 	bl	2438 <_fstat_r>
#    2214:	2800      	cmp	r0, #0
#    2216:	dbf2      	blt.n	21fe <__swhatbuf_r+0x12>
    2218:	9a01      	ldr	r2, [sp, #4]
    221a:	f402 4270 	and.w	r2, r2, #61440	; 0xf000
    221e:	f5a2 5300 	sub.w	r3, r2, #8192	; 0x2000
    2222:	425a      	negs	r2, r3
    2224:	415a      	adcs	r2, r3
    2226:	602a      	str	r2, [r5, #0]
    2228:	e7ee      	b.n	2208 <__swhatbuf_r+0x1c>
    222a:	2340      	movs	r3, #64	; 0x40
#    222c:	2000      	movs	r0, #0
#    222e:	6023      	str	r3, [r4, #0]
#    2230:	b016      	add	sp, #88	; 0x58
#    2232:	bd70      	pop	{r4, r5, r6, pc}

#00002234 <__smakebuf_r>:
#    2234:	898b      	ldrh	r3, [r1, #12]
#    2236:	b573      	push	{r0, r1, r4, r5, r6, lr}
#    2238:	079d      	lsls	r5, r3, #30
#    223a:	4606      	mov	r6, r0
#    223c:	460c      	mov	r4, r1
#    223e:	d507      	bpl.n	2250 <__smakebuf_r+0x1c>
    2240:	f104 0347 	add.w	r3, r4, #71	; 0x47
    2244:	6023      	str	r3, [r4, #0]
    2246:	6123      	str	r3, [r4, #16]
    2248:	2301      	movs	r3, #1
    224a:	6163      	str	r3, [r4, #20]
#    224c:	b002      	add	sp, #8
#    224e:	bd70      	pop	{r4, r5, r6, pc}
#    2250:	ab01      	add	r3, sp, #4
#    2252:	466a      	mov	r2, sp
#    2254:	f7ff ffca 	bl	21ec <__swhatbuf_r>
#    2258:	9900      	ldr	r1, [sp, #0]
#    225a:	4605      	mov	r5, r0
#    225c:	4630      	mov	r0, r6
#    225e:	f7ff fa75 	bl	174c <_malloc_r>
#    2262:	b948      	cbnz	r0, 2278 <__smakebuf_r+0x44>
    2264:	f9b4 300c 	ldrsh.w	r3, [r4, #12]
    2268:	059a      	lsls	r2, r3, #22
    226a:	d4ef      	bmi.n	224c <__smakebuf_r+0x18>
    226c:	f023 0303 	bic.w	r3, r3, #3
    2270:	f043 0302 	orr.w	r3, r3, #2
    2274:	81a3      	strh	r3, [r4, #12]
    2276:	e7e3      	b.n	2240 <__smakebuf_r+0xc>
#    2278:	4b0d      	ldr	r3, [pc, #52]	; (22b0 <__smakebuf_r+0x7c>)
#    227a:	62b3      	str	r3, [r6, #40]	; 0x28
#    227c:	89a3      	ldrh	r3, [r4, #12]
#    227e:	6020      	str	r0, [r4, #0]
#    2280:	f043 0380 	orr.w	r3, r3, #128	; 0x80
#    2284:	81a3      	strh	r3, [r4, #12]
#    2286:	9b00      	ldr	r3, [sp, #0]
#    2288:	6163      	str	r3, [r4, #20]
#    228a:	9b01      	ldr	r3, [sp, #4]
#    228c:	6120      	str	r0, [r4, #16]
#    228e:	b15b      	cbz	r3, 22a8 <__smakebuf_r+0x74>
    2290:	f9b4 100e 	ldrsh.w	r1, [r4, #14]
    2294:	4630      	mov	r0, r6
    2296:	f000 f8e1 	bl	245c <_isatty_r>
    229a:	b128      	cbz	r0, 22a8 <__smakebuf_r+0x74>
    229c:	89a3      	ldrh	r3, [r4, #12]
    229e:	f023 0303 	bic.w	r3, r3, #3
    22a2:	f043 0301 	orr.w	r3, r3, #1
    22a6:	81a3      	strh	r3, [r4, #12]
#    22a8:	89a0      	ldrh	r0, [r4, #12]
#    22aa:	4305      	orrs	r5, r0
#    22ac:	81a5      	strh	r5, [r4, #12]
#    22ae:	e7cd      	b.n	224c <__smakebuf_r+0x18>
    22b0:	000015a5 	.word	0x000015a5
	...

000022c0 <memchr>:
    22c0:	f001 01ff 	and.w	r1, r1, #255	; 0xff
    22c4:	2a10      	cmp	r2, #16
    22c6:	db2b      	blt.n	2320 <memchr+0x60>
    22c8:	f010 0f07 	tst.w	r0, #7
    22cc:	d008      	beq.n	22e0 <memchr+0x20>
    22ce:	f810 3b01 	ldrb.w	r3, [r0], #1
    22d2:	3a01      	subs	r2, #1
    22d4:	428b      	cmp	r3, r1
    22d6:	d02d      	beq.n	2334 <memchr+0x74>
    22d8:	f010 0f07 	tst.w	r0, #7
    22dc:	b342      	cbz	r2, 2330 <memchr+0x70>
    22de:	d1f6      	bne.n	22ce <memchr+0xe>
    22e0:	b4f0      	push	{r4, r5, r6, r7}
    22e2:	ea41 2101 	orr.w	r1, r1, r1, lsl #8
    22e6:	ea41 4101 	orr.w	r1, r1, r1, lsl #16
    22ea:	f022 0407 	bic.w	r4, r2, #7
    22ee:	f07f 0700 	mvns.w	r7, #0
    22f2:	2300      	movs	r3, #0
    22f4:	e8f0 5602 	ldrd	r5, r6, [r0], #8
    22f8:	3c08      	subs	r4, #8
    22fa:	ea85 0501 	eor.w	r5, r5, r1
    22fe:	ea86 0601 	eor.w	r6, r6, r1
    2302:	fa85 f547 	uadd8	r5, r5, r7
    2306:	faa3 f587 	sel	r5, r3, r7
    230a:	fa86 f647 	uadd8	r6, r6, r7
    230e:	faa5 f687 	sel	r6, r5, r7
    2312:	b98e      	cbnz	r6, 2338 <memchr+0x78>
    2314:	d1ee      	bne.n	22f4 <memchr+0x34>
    2316:	bcf0      	pop	{r4, r5, r6, r7}
    2318:	f001 01ff 	and.w	r1, r1, #255	; 0xff
    231c:	f002 0207 	and.w	r2, r2, #7
    2320:	b132      	cbz	r2, 2330 <memchr+0x70>
    2322:	f810 3b01 	ldrb.w	r3, [r0], #1
    2326:	3a01      	subs	r2, #1
    2328:	ea83 0301 	eor.w	r3, r3, r1
    232c:	b113      	cbz	r3, 2334 <memchr+0x74>
    232e:	d1f8      	bne.n	2322 <memchr+0x62>
    2330:	2000      	movs	r0, #0
    2332:	4770      	bx	lr
    2334:	3801      	subs	r0, #1
    2336:	4770      	bx	lr
    2338:	2d00      	cmp	r5, #0
    233a:	bf06      	itte	eq
    233c:	4635      	moveq	r5, r6
    233e:	3803      	subeq	r0, #3
    2340:	3807      	subne	r0, #7
    2342:	f015 0f01 	tst.w	r5, #1
    2346:	d107      	bne.n	2358 <memchr+0x98>
    2348:	3001      	adds	r0, #1
    234a:	f415 7f80 	tst.w	r5, #256	; 0x100
    234e:	bf02      	ittt	eq
    2350:	3001      	addeq	r0, #1
    2352:	f415 3fc0 	tsteq.w	r5, #98304	; 0x18000
    2356:	3001      	addeq	r0, #1
    2358:	bcf0      	pop	{r4, r5, r6, r7}
    235a:	3801      	subs	r0, #1
    235c:	4770      	bx	lr
    235e:	bf00      	nop

#00002360 <__malloc_lock>:
#    2360:	4801      	ldr	r0, [pc, #4]	; (2368 <__malloc_lock+0x8>)
#    2362:	f7ff b9f1 	b.w	1748 <__retarget_lock_acquire_recursive>
    2366:	bf00      	nop
    2368:	200002f4 	.word	0x200002f4

#0000236c <__malloc_unlock>:
#    236c:	4801      	ldr	r0, [pc, #4]	; (2374 <__malloc_unlock+0x8>)
#    236e:	f7ff b9ec 	b.w	174a <__retarget_lock_release_recursive>
    2372:	bf00      	nop
    2374:	200002f4 	.word	0x200002f4

00002378 <_free_r>:
    2378:	b538      	push	{r3, r4, r5, lr}
    237a:	4605      	mov	r5, r0
    237c:	2900      	cmp	r1, #0
    237e:	d045      	beq.n	240c <_free_r+0x94>
    2380:	f851 3c04 	ldr.w	r3, [r1, #-4]
    2384:	1f0c      	subs	r4, r1, #4
    2386:	2b00      	cmp	r3, #0
    2388:	bfb8      	it	lt
    238a:	18e4      	addlt	r4, r4, r3
    238c:	f7ff ffe8 	bl	2360 <__malloc_lock>
    2390:	4a1f      	ldr	r2, [pc, #124]	; (2410 <_free_r+0x98>)
    2392:	6813      	ldr	r3, [r2, #0]
    2394:	4610      	mov	r0, r2
    2396:	b933      	cbnz	r3, 23a6 <_free_r+0x2e>
    2398:	6063      	str	r3, [r4, #4]
    239a:	6014      	str	r4, [r2, #0]
    239c:	4628      	mov	r0, r5
    239e:	e8bd 4038 	ldmia.w	sp!, {r3, r4, r5, lr}
    23a2:	f7ff bfe3 	b.w	236c <__malloc_unlock>
    23a6:	42a3      	cmp	r3, r4
    23a8:	d90b      	bls.n	23c2 <_free_r+0x4a>
    23aa:	6821      	ldr	r1, [r4, #0]
    23ac:	1862      	adds	r2, r4, r1
    23ae:	4293      	cmp	r3, r2
    23b0:	bf04      	itt	eq
    23b2:	681a      	ldreq	r2, [r3, #0]
    23b4:	685b      	ldreq	r3, [r3, #4]
    23b6:	6063      	str	r3, [r4, #4]
    23b8:	bf04      	itt	eq
    23ba:	1852      	addeq	r2, r2, r1
    23bc:	6022      	streq	r2, [r4, #0]
    23be:	6004      	str	r4, [r0, #0]
    23c0:	e7ec      	b.n	239c <_free_r+0x24>
    23c2:	461a      	mov	r2, r3
    23c4:	685b      	ldr	r3, [r3, #4]
    23c6:	b10b      	cbz	r3, 23cc <_free_r+0x54>
    23c8:	42a3      	cmp	r3, r4
    23ca:	d9fa      	bls.n	23c2 <_free_r+0x4a>
    23cc:	6811      	ldr	r1, [r2, #0]
    23ce:	1850      	adds	r0, r2, r1
    23d0:	42a0      	cmp	r0, r4
    23d2:	d10b      	bne.n	23ec <_free_r+0x74>
    23d4:	6820      	ldr	r0, [r4, #0]
    23d6:	4401      	add	r1, r0
    23d8:	1850      	adds	r0, r2, r1
    23da:	4283      	cmp	r3, r0
    23dc:	6011      	str	r1, [r2, #0]
    23de:	d1dd      	bne.n	239c <_free_r+0x24>
    23e0:	6818      	ldr	r0, [r3, #0]
    23e2:	685b      	ldr	r3, [r3, #4]
    23e4:	6053      	str	r3, [r2, #4]
    23e6:	4401      	add	r1, r0
    23e8:	6011      	str	r1, [r2, #0]
    23ea:	e7d7      	b.n	239c <_free_r+0x24>
    23ec:	d902      	bls.n	23f4 <_free_r+0x7c>
    23ee:	230c      	movs	r3, #12
    23f0:	602b      	str	r3, [r5, #0]
    23f2:	e7d3      	b.n	239c <_free_r+0x24>
    23f4:	6820      	ldr	r0, [r4, #0]
    23f6:	1821      	adds	r1, r4, r0
    23f8:	428b      	cmp	r3, r1
    23fa:	bf04      	itt	eq
    23fc:	6819      	ldreq	r1, [r3, #0]
    23fe:	685b      	ldreq	r3, [r3, #4]
    2400:	6063      	str	r3, [r4, #4]
    2402:	bf04      	itt	eq
    2404:	1809      	addeq	r1, r1, r0
    2406:	6021      	streq	r1, [r4, #0]
    2408:	6054      	str	r4, [r2, #4]
    240a:	e7c7      	b.n	239c <_free_r+0x24>
    240c:	bd38      	pop	{r3, r4, r5, pc}
    240e:	bf00      	nop
    2410:	200002e4 	.word	0x200002e4

00002414 <_read_r>:
    2414:	b538      	push	{r3, r4, r5, lr}
    2416:	4d07      	ldr	r5, [pc, #28]	; (2434 <_read_r+0x20>)
    2418:	4604      	mov	r4, r0
    241a:	4608      	mov	r0, r1
    241c:	4611      	mov	r1, r2
    241e:	2200      	movs	r2, #0
    2420:	602a      	str	r2, [r5, #0]
    2422:	461a      	mov	r2, r3
#    2424:	f7fe fa0c 	bl	840 <_read>
#    2428:	1c43      	adds	r3, r0, #1
    242a:	d102      	bne.n	2432 <_read_r+0x1e>
    242c:	682b      	ldr	r3, [r5, #0]
    242e:	b103      	cbz	r3, 2432 <_read_r+0x1e>
    2430:	6023      	str	r3, [r4, #0]
#    2432:	bd38      	pop	{r3, r4, r5, pc}
    2434:	200002fc 	.word	0x200002fc

#00002438 <_fstat_r>:
#    2438:	b538      	push	{r3, r4, r5, lr}
#    243a:	4d07      	ldr	r5, [pc, #28]	; (2458 <_fstat_r+0x20>)
#    243c:	2300      	movs	r3, #0
#    243e:	4604      	mov	r4, r0
#    2440:	4608      	mov	r0, r1
#    2442:	4611      	mov	r1, r2
#    2444:	602b      	str	r3, [r5, #0]
#    2446:	f000 f821 	bl	248c <_fstat>
#    244a:	1c43      	adds	r3, r0, #1
#    244c:	d102      	bne.n	2454 <_fstat_r+0x1c>
#    244e:	682b      	ldr	r3, [r5, #0]
#    2450:	b103      	cbz	r3, 2454 <_fstat_r+0x1c>
#    2452:	6023      	str	r3, [r4, #0]
#    2454:	bd38      	pop	{r3, r4, r5, pc}
#    2456:	bf00      	nop
#    2458:	200002fc 	.word	0x200002fc

0000245c <_isatty_r>:
    245c:	b538      	push	{r3, r4, r5, lr}
#    245e:	4d06      	ldr	r5, [pc, #24]	; (2478 <_isatty_r+0x1c>)
#    2460:	2300      	movs	r3, #0
#    2462:	4604      	mov	r4, r0
    2464:	4608      	mov	r0, r1
#    2466:	602b      	str	r3, [r5, #0]
#    2468:	f000 f818 	bl	249c <_isatty>
    246c:	1c43      	adds	r3, r0, #1
#    246e:	d102      	bne.n	2476 <_isatty_r+0x1a>
#    2470:	682b      	ldr	r3, [r5, #0]
#    2472:	b103      	cbz	r3, 2476 <_isatty_r+0x1a>
#    2474:	6023      	str	r3, [r4, #0]
#    2476:	bd38      	pop	{r3, r4, r5, pc}
#    2478:	200002fc 	.word	0x200002fc

0000247c <_close>:
    247c:	4b02      	ldr	r3, [pc, #8]	; (2488 <_close+0xc>)
    247e:	2258      	movs	r2, #88	; 0x58
    2480:	601a      	str	r2, [r3, #0]
#    2482:	f04f 30ff 	mov.w	r0, #4294967295	; 0xffffffff
#    2486:	4770      	bx	lr
#    2488:	200002fc 	.word	0x200002fc

#0000248c <_fstat>:
#    248c:	4b02      	ldr	r3, [pc, #8]	; (2498 <_fstat+0xc>)
#    248e:	2258      	movs	r2, #88	; 0x58
#    2490:	601a      	str	r2, [r3, #0]
#    2492:	f04f 30ff 	mov.w	r0, #4294967295	; 0xffffffff
#    2496:	4770      	bx	lr
    2498:	200002fc 	.word	0x200002fc

0000249c <_isatty>:
    249c:	4b02      	ldr	r3, [pc, #8]	; (24a8 <_isatty+0xc>)
    249e:	2258      	movs	r2, #88	; 0x58
    24a0:	601a      	str	r2, [r3, #0]
    24a2:	2000      	movs	r0, #0
    24a4:	4770      	bx	lr
    24a6:	bf00      	nop
    24a8:	200002fc 	.word	0x200002fc

000024ac <_lseek>:
    24ac:	4b02      	ldr	r3, [pc, #8]	; (24b8 <_lseek+0xc>)
    24ae:	2258      	movs	r2, #88	; 0x58
    24b0:	601a      	str	r2, [r3, #0]
    24b2:	f04f 30ff 	mov.w	r0, #4294967295	; 0xffffffff
    24b6:	4770      	bx	lr
    24b8:	200002fc 	.word	0x200002fc

#000024bc <_sbrk>:
#    24bc:	4a04      	ldr	r2, [pc, #16]	; (24d0 <_sbrk+0x14>)
#    24be:	4905      	ldr	r1, [pc, #20]	; (24d4 <_sbrk+0x18>)
#    24c0:	6813      	ldr	r3, [r2, #0]
#    24c2:	2b00      	cmp	r3, #0
#    24c4:	bf08      	it	eq
#    24c6:	460b      	moveq	r3, r1
#    24c8:	4418      	add	r0, r3
#    24ca:	6010      	str	r0, [r2, #0]
#    24cc:	4618      	mov	r0, r3
#    24ce:	4770      	bx	lr
    24d0:	200002ec 	.word	0x200002ec
    24d4:	20000300 	.word	0x20000300

#000024d8 <_init>:
#    24d8:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
#    24da:	bf00      	nop
#    24dc:	bcf8      	pop	{r3, r4, r5, r6, r7}
#    24de:	bc08      	pop	{r3}
#    24e0:	469e      	mov	lr, r3
#    24e2:	4770      	bx	lr

000024e4 <_fini>:
#    24e4:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
#    24e6:	bf00      	nop
#    24e8:	bcf8      	pop	{r3, r4, r5, r6, r7}
#    24ea:	bc08      	pop	{r3}
#    24ec:	469e      	mov	lr, r3
#    24ee:	4770      	bx	lr

000024f0 <_global_impure_ptr>:
#    24f0:	0004 2000 ffff ffff ffff ffff ffff ffff     ... ............
    2500:	ffff ffff 0000 0000 0000 0000 0000 01d6     ................
#    2510:	0107 0000 0a0d 7453 7261 3a74 0d20 000a     ......Start: ...
    2520:	0d20 450a 6978 2174 0a0d 0000 0008 0000      ..Exit!........
    2530:	0006 0000 0005 0000 0007 0000 0001 0000     ................
#    2540:	e000 01d7                                   ....

00002544 <__sf_fake_stderr>:
	...

00002564 <__sf_fake_stdin>:
	...

00002584 <__sf_fake_stdout>:
	...
#    25a4:	2d23 2b30 0020 6c68 004c 6665 4567 4746     #-0+ .hlL.efgEFG
#    25b4:	3000 3231 3433 3635 3837 4139 4342 4544     .0123456789ABCDE
#    25c4:	0046 3130 3332 3534 3736 3938 6261 6463     F.0123456789abcd
#    25d4:	6665 0000                                   ef..

000025d8 <__EH_FRAME_BEGIN__>:
#    25d8:	0000 0000                                   ....
