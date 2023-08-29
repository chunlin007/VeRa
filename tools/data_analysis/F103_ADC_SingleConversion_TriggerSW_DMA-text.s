
/home/chunlin/TSIS/dir_analyze/DICE-advance/DICE-Evaluation/ARM/Unit-Test/Firmware/Binaries-DICE/F103_ADC_SingleConversion_TriggerSW_DMA.elf:     file format elf32-littlearm


Disassembly of section .text:

0800010c <__do_global_dtors_aux>:
 800010c:	b510      	push	{r4, lr}
 800010e:	4c05      	ldr	r4, [pc, #20]	; (8000124 <__do_global_dtors_aux+0x18>)
 8000110:	7823      	ldrb	r3, [r4, #0]
 8000112:	b933      	cbnz	r3, 8000122 <__do_global_dtors_aux+0x16>
 8000114:	4b04      	ldr	r3, [pc, #16]	; (8000128 <__do_global_dtors_aux+0x1c>)
 8000116:	b113      	cbz	r3, 800011e <__do_global_dtors_aux+0x12>
 8000118:	4804      	ldr	r0, [pc, #16]	; (800012c <__do_global_dtors_aux+0x20>)
 800011a:	f3af 8000 	nop.w
 800011e:	2301      	movs	r3, #1
 8000120:	7023      	strb	r3, [r4, #0]
 8000122:	bd10      	pop	{r4, pc}
 8000124:	20000008 	.word	0x20000008
 8000128:	00000000 	.word	0x00000000
 800012c:	080006fc 	.word	0x080006fc

#08000130 <frame_dummy>:
# 8000130:	b508      	push	{r3, lr}
# 8000132:	4b03      	ldr	r3, [pc, #12]	; (8000140 <frame_dummy+0x10>)
# 8000134:	b11b      	cbz	r3, 800013e <frame_dummy+0xe>
 8000136:	4903      	ldr	r1, [pc, #12]	; (8000144 <frame_dummy+0x14>)
 8000138:	4803      	ldr	r0, [pc, #12]	; (8000148 <frame_dummy+0x18>)
 800013a:	f3af 8000 	nop.w
# 800013e:	bd08      	pop	{r3, pc}
 8000140:	00000000 	.word	0x00000000
 8000144:	2000000c 	.word	0x2000000c
 8000148:	080006fc 	.word	0x080006fc

#0800014c <SystemInit>:
# 800014c:	4b0f      	ldr	r3, [pc, #60]	; (800018c <SystemInit+0x40>)
# 800014e:	681a      	ldr	r2, [r3, #0]
# 8000150:	f042 0201 	orr.w	r2, r2, #1
# 8000154:	601a      	str	r2, [r3, #0]
# 8000156:	6859      	ldr	r1, [r3, #4]
# 8000158:	4a0d      	ldr	r2, [pc, #52]	; (8000190 <SystemInit+0x44>)
# 800015a:	400a      	ands	r2, r1
# 800015c:	605a      	str	r2, [r3, #4]
# 800015e:	681a      	ldr	r2, [r3, #0]
# 8000160:	f022 7284 	bic.w	r2, r2, #17301504	; 0x1080000
# 8000164:	f422 3280 	bic.w	r2, r2, #65536	; 0x10000
# 8000168:	601a      	str	r2, [r3, #0]
# 800016a:	681a      	ldr	r2, [r3, #0]
# 800016c:	f422 2280 	bic.w	r2, r2, #262144	; 0x40000
# 8000170:	601a      	str	r2, [r3, #0]
# 8000172:	685a      	ldr	r2, [r3, #4]
# 8000174:	f422 02fe 	bic.w	r2, r2, #8323072	; 0x7f0000
# 8000178:	605a      	str	r2, [r3, #4]
# 800017a:	f44f 021f 	mov.w	r2, #10420224	; 0x9f0000
# 800017e:	609a      	str	r2, [r3, #8]
# 8000180:	f04f 6200 	mov.w	r2, #134217728	; 0x8000000
# 8000184:	4b03      	ldr	r3, [pc, #12]	; (8000194 <SystemInit+0x48>)
# 8000186:	609a      	str	r2, [r3, #8]
# 8000188:	4770      	bx	lr
 800018a:	bf00      	nop
 800018c:	40021000 	.word	0x40021000
 8000190:	f8ff0000 	.word	0xf8ff0000
 8000194:	e000ed00 	.word	0xe000ed00

#08000198 <LL_Init1msTick>:
# 8000198:	f44f 737a 	mov.w	r3, #1000	; 0x3e8
# 800019c:	fbb0 f0f3 	udiv	r0, r0, r3
# 80001a0:	2200      	movs	r2, #0
# 80001a2:	4b03      	ldr	r3, [pc, #12]	; (80001b0 <LL_Init1msTick+0x18>)
# 80001a4:	3801      	subs	r0, #1
# 80001a6:	6058      	str	r0, [r3, #4]
# 80001a8:	609a      	str	r2, [r3, #8]
# 80001aa:	2205      	movs	r2, #5
# 80001ac:	601a      	str	r2, [r3, #0]
# 80001ae:	4770      	bx	lr
 80001b0:	e000e010 	.word	0xe000e010

#080001b4 <LL_mDelay>:
# 80001b4:	4b03      	ldr	r3, [pc, #12]	; (80001c4 <LL_mDelay+0x10>)
# 80001b6:	b082      	sub	sp, #8
# 80001b8:	681b      	ldr	r3, [r3, #0]
# 80001ba:	9301      	str	r3, [sp, #4]
# 80001bc:	9b01      	ldr	r3, [sp, #4]
# 80001be:	b002      	add	sp, #8
# 80001c0:	4770      	bx	lr
 80001c2:	bf00      	nop
 80001c4:	e000e010 	.word	0xe000e010

#080001c8 <LL_SetSystemCoreClock>:
# 80001c8:	4b01      	ldr	r3, [pc, #4]	; (80001d0 <LL_SetSystemCoreClock+0x8>)
# 80001ca:	6018      	str	r0, [r3, #0]
# 80001cc:	4770      	bx	lr
 80001ce:	bf00      	nop
 80001d0:	20000000 	.word	0x20000000

#080001d4 <Reset_Handler>:
# 80001d4:	2100      	movs	r1, #0
# 80001d6:	e003      	b.n	80001e0 <LoopCopyDataInit>

#080001d8 <CopyDataInit>:
# 80001d8:	4b0b      	ldr	r3, [pc, #44]	; (8000208 <LoopFillZerobss+0x14>)
# 80001da:	585b      	ldr	r3, [r3, r1]
# 80001dc:	5043      	str	r3, [r0, r1]
# 80001de:	3104      	adds	r1, #4

#080001e0 <LoopCopyDataInit>:
# 80001e0:	480a      	ldr	r0, [pc, #40]	; (800020c <LoopFillZerobss+0x18>)
# 80001e2:	4b0b      	ldr	r3, [pc, #44]	; (8000210 <LoopFillZerobss+0x1c>)
# 80001e4:	1842      	adds	r2, r0, r1
# 80001e6:	429a      	cmp	r2, r3
# 80001e8:	d3f6      	bcc.n	80001d8 <CopyDataInit>
# 80001ea:	4a0a      	ldr	r2, [pc, #40]	; (8000214 <LoopFillZerobss+0x20>)
# 80001ec:	e002      	b.n	80001f4 <LoopFillZerobss>

#080001ee <FillZerobss>:
# 80001ee:	2300      	movs	r3, #0
# 80001f0:	f842 3b04 	str.w	r3, [r2], #4

#080001f4 <LoopFillZerobss>:
# 80001f4:	4b08      	ldr	r3, [pc, #32]	; (8000218 <LoopFillZerobss+0x24>)
# 80001f6:	429a      	cmp	r2, r3
# 80001f8:	d3f9      	bcc.n	80001ee <FillZerobss>
# 80001fa:	f7ff ffa7 	bl	800014c <SystemInit>
# 80001fe:	f000 fa59 	bl	80006b4 <__libc_init_array>
# 8000202:	f000 f9a9 	bl	8000558 <main>
 8000206:	4770      	bx	lr
 8000208:	0800071c 	.word	0x0800071c
 800020c:	20000000 	.word	0x20000000
 8000210:	20000008 	.word	0x20000008
 8000214:	20000008 	.word	0x20000008
 8000218:	20000034 	.word	0x20000034

#0800021c <ADC1_2_IRQHandler>:
# 800021c:	e7fe      	b.n	800021c <ADC1_2_IRQHandler>
	...

#08000220 <LL_APB2_GRP1_EnableClock>:
# 8000220:	4b05      	ldr	r3, [pc, #20]	; (8000238 <LL_APB2_GRP1_EnableClock+0x18>)
# 8000222:	b082      	sub	sp, #8
# 8000224:	699a      	ldr	r2, [r3, #24]
# 8000226:	4302      	orrs	r2, r0
# 8000228:	619a      	str	r2, [r3, #24]
# 800022a:	699b      	ldr	r3, [r3, #24]
# 800022c:	4018      	ands	r0, r3
# 800022e:	9001      	str	r0, [sp, #4]
# 8000230:	9b01      	ldr	r3, [sp, #4]
# 8000232:	b002      	add	sp, #8
# 8000234:	4770      	bx	lr
 8000236:	bf00      	nop
 8000238:	40021000 	.word	0x40021000

#0800023c <LL_GPIO_SetPinMode>:
# 800023c:	b530      	push	{r4, r5, lr}
# 800023e:	0e0d      	lsrs	r5, r1, #24
# 8000240:	fa91 f4a1 	rbit	r4, r1
# 8000244:	fab4 f484 	clz	r4, r4
# 8000248:	fa91 f1a1 	rbit	r1, r1
# 800024c:	230f      	movs	r3, #15
# 800024e:	fab1 f181 	clz	r1, r1
# 8000252:	00a4      	lsls	r4, r4, #2
# 8000254:	fa03 f404 	lsl.w	r4, r3, r4
# 8000258:	5943      	ldr	r3, [r0, r5]
# 800025a:	0089      	lsls	r1, r1, #2
# 800025c:	ea23 0304 	bic.w	r3, r3, r4
# 8000260:	fa02 f101 	lsl.w	r1, r2, r1
# 8000264:	4319      	orrs	r1, r3
# 8000266:	5141      	str	r1, [r0, r5]
# 8000268:	bd30      	pop	{r4, r5, pc}
	...

#0800026c <Configure_DMA>:
# 800026c:	2210      	movs	r2, #16
# 800026e:	4b1c      	ldr	r3, [pc, #112]	; (80002e0 <Configure_DMA+0x74>)
# 8000270:	b082      	sub	sp, #8
# 8000272:	f883 230b 	strb.w	r2, [r3, #779]	; 0x30b
# 8000276:	f44f 6200 	mov.w	r2, #2048	; 0x800
# 800027a:	601a      	str	r2, [r3, #0]
# 800027c:	4b19      	ldr	r3, [pc, #100]	; (80002e4 <Configure_DMA+0x78>)
# 800027e:	695a      	ldr	r2, [r3, #20]
# 8000280:	f042 0201 	orr.w	r2, r2, #1
# 8000284:	615a      	str	r2, [r3, #20]
# 8000286:	695b      	ldr	r3, [r3, #20]
# 8000288:	f003 0301 	and.w	r3, r3, #1
# 800028c:	9301      	str	r3, [sp, #4]
# 800028e:	9b01      	ldr	r3, [sp, #4]
# 8000290:	4b15      	ldr	r3, [pc, #84]	; (80002e8 <Configure_DMA+0x7c>)
# 8000292:	681a      	ldr	r2, [r3, #0]
# 8000294:	f422 42ff 	bic.w	r2, r2, #32640	; 0x7f80
# 8000298:	f022 0270 	bic.w	r2, r2, #112	; 0x70
# 800029c:	f442 5216 	orr.w	r2, r2, #9600	; 0x2580
# 80002a0:	f042 0220 	orr.w	r2, r2, #32
# 80002a4:	601a      	str	r2, [r3, #0]
# 80002a6:	4a11      	ldr	r2, [pc, #68]	; (80002ec <Configure_DMA+0x80>)
# 80002a8:	609a      	str	r2, [r3, #8]
# 80002aa:	4a11      	ldr	r2, [pc, #68]	; (80002f0 <Configure_DMA+0x84>)
# 80002ac:	60da      	str	r2, [r3, #12]
# 80002ae:	685a      	ldr	r2, [r3, #4]
# 80002b0:	0c12      	lsrs	r2, r2, #16
# 80002b2:	0412      	lsls	r2, r2, #16
# 80002b4:	f042 0204 	orr.w	r2, r2, #4
# 80002b8:	605a      	str	r2, [r3, #4]
# 80002ba:	681a      	ldr	r2, [r3, #0]
# 80002bc:	f042 0202 	orr.w	r2, r2, #2
# 80002c0:	601a      	str	r2, [r3, #0]
# 80002c2:	681a      	ldr	r2, [r3, #0]
# 80002c4:	f042 0204 	orr.w	r2, r2, #4
# 80002c8:	601a      	str	r2, [r3, #0]
# 80002ca:	681a      	ldr	r2, [r3, #0]
# 80002cc:	f042 0208 	orr.w	r2, r2, #8
# 80002d0:	601a      	str	r2, [r3, #0]
# 80002d2:	681a      	ldr	r2, [r3, #0]
# 80002d4:	f042 0201 	orr.w	r2, r2, #1
# 80002d8:	601a      	str	r2, [r3, #0]
# 80002da:	b002      	add	sp, #8
# 80002dc:	4770      	bx	lr
 80002de:	bf00      	nop
 80002e0:	e000e100 	.word	0xe000e100
 80002e4:	40021000 	.word	0x40021000
 80002e8:	40020008 	.word	0x40020008
 80002ec:	4001244c 	.word	0x4001244c
 80002f0:	2000002c 	.word	0x2000002c

#080002f4 <Configure_ADC>:
# 80002f4:	b538      	push	{r3, r4, r5, lr}
# 80002f6:	2004      	movs	r0, #4
# 80002f8:	f7ff ff92 	bl	8000220 <LL_APB2_GRP1_EnableClock>
# 80002fc:	2200      	movs	r2, #0
# 80002fe:	f241 0110 	movw	r1, #4112	; 0x1010
# 8000302:	482f      	ldr	r0, [pc, #188]	; (80003c0 <Configure_ADC+0xcc>)
# 8000304:	f7ff ff9a 	bl	800023c <LL_GPIO_SetPinMode>
# 8000308:	2200      	movs	r2, #0
# 800030a:	4b2e      	ldr	r3, [pc, #184]	; (80003c4 <Configure_ADC+0xd0>)
# 800030c:	f44f 7000 	mov.w	r0, #512	; 0x200
# 8000310:	f883 2312 	strb.w	r2, [r3, #786]	; 0x312
# 8000314:	f44f 2280 	mov.w	r2, #262144	; 0x40000
# 8000318:	601a      	str	r2, [r3, #0]
# 800031a:	f7ff ff81 	bl	8000220 <LL_APB2_GRP1_EnableClock>
# 800031e:	4b2a      	ldr	r3, [pc, #168]	; (80003c8 <Configure_ADC+0xd4>)
# 8000320:	689a      	ldr	r2, [r3, #8]
# 8000322:	07d2      	lsls	r2, r2, #31
# 8000324:	d421      	bmi.n	800036a <Configure_ADC+0x76>
# 8000326:	689a      	ldr	r2, [r3, #8]
# 8000328:	f442 2260 	orr.w	r2, r2, #917504	; 0xe0000
# 800032c:	609a      	str	r2, [r3, #8]
# 800032e:	689a      	ldr	r2, [r3, #8]
# 8000330:	f022 0202 	bic.w	r2, r2, #2
# 8000334:	609a      	str	r2, [r3, #8]
# 8000336:	689a      	ldr	r2, [r3, #8]
# 8000338:	f442 7280 	orr.w	r2, r2, #256	; 0x100
# 800033c:	609a      	str	r2, [r3, #8]
# 800033e:	6ada      	ldr	r2, [r3, #44]	; 0x2c
# 8000340:	f422 0270 	bic.w	r2, r2, #15728640	; 0xf00000
# 8000344:	62da      	str	r2, [r3, #44]	; 0x2c
# 8000346:	f44f 7340 	mov.w	r3, #768	; 0x300
# 800034a:	fa93 f3a3 	rbit	r3, r3
# 800034e:	f44f 7200 	mov.w	r2, #512	; 0x200
# 8000352:	fab3 f383 	clz	r3, r3
# 8000356:	491d      	ldr	r1, [pc, #116]	; (80003cc <Configure_ADC+0xd8>)
# 8000358:	40da      	lsrs	r2, r3
# 800035a:	f851 3022 	ldr.w	r3, [r1, r2, lsl #2]
# 800035e:	f023 031f 	bic.w	r3, r3, #31
# 8000362:	f043 0304 	orr.w	r3, r3, #4
# 8000366:	f841 3022 	str.w	r3, [r1, r2, lsl #2]
# 800036a:	4b17      	ldr	r3, [pc, #92]	; (80003c8 <Configure_ADC+0xd4>)
# 800036c:	689b      	ldr	r3, [r3, #8]
# 800036e:	07db      	lsls	r3, r3, #31
# 8000370:	d424      	bmi.n	80003bc <Configure_ADC+0xc8>
# 8000372:	f04f 7200 	mov.w	r2, #33554432	; 0x2000000
# 8000376:	fa92 f3a2 	rbit	r3, r2
# 800037a:	fab3 f383 	clz	r3, r3
# 800037e:	4d14      	ldr	r5, [pc, #80]	; (80003d0 <Configure_ADC+0xdc>)
# 8000380:	40da      	lsrs	r2, r3
# 8000382:	f04f 73f8 	mov.w	r3, #32505856	; 0x1f00000
# 8000386:	fa93 f0a3 	rbit	r0, r3
# 800038a:	fab0 f080 	clz	r0, r0
# 800038e:	fa93 f3a3 	rbit	r3, r3
# 8000392:	f44f 0440 	mov.w	r4, #12582912	; 0xc00000
# 8000396:	fab3 f383 	clz	r3, r3
# 800039a:	2107      	movs	r1, #7
# 800039c:	fa24 f000 	lsr.w	r0, r4, r0
# 80003a0:	fa24 f303 	lsr.w	r3, r4, r3
# 80003a4:	2404      	movs	r4, #4
# 80003a6:	fa01 f000 	lsl.w	r0, r1, r0
# 80003aa:	f855 1022 	ldr.w	r1, [r5, r2, lsl #2]
# 80003ae:	fa04 f303 	lsl.w	r3, r4, r3
# 80003b2:	ea21 0100 	bic.w	r1, r1, r0
# 80003b6:	4319      	orrs	r1, r3
# 80003b8:	f845 1022 	str.w	r1, [r5, r2, lsl #2]
# 80003bc:	bd38      	pop	{r3, r4, r5, pc}
 80003be:	bf00      	nop
 80003c0:	40010800 	.word	0x40010800
 80003c4:	e000e100 	.word	0xe000e100
 80003c8:	40012400 	.word	0x40012400
 80003cc:	4001242c 	.word	0x4001242c
 80003d0:	4001240c 	.word	0x4001240c

#080003d4 <Activate_ADC>:
# 80003d4:	2300      	movs	r3, #0
# 80003d6:	b082      	sub	sp, #8
# 80003d8:	9301      	str	r3, [sp, #4]
# 80003da:	4b0c      	ldr	r3, [pc, #48]	; (800040c <Activate_ADC+0x38>)
# 80003dc:	689a      	ldr	r2, [r3, #8]
# 80003de:	07d1      	lsls	r1, r2, #31
# 80003e0:	d40f      	bmi.n	8000402 <Activate_ADC+0x2e>
# 80003e2:	689a      	ldr	r2, [r3, #8]
# 80003e4:	f042 0201 	orr.w	r2, r2, #1
# 80003e8:	609a      	str	r2, [r3, #8]
# 80003ea:	2320      	movs	r3, #32
# 80003ec:	9301      	str	r3, [sp, #4]
# 80003ee:	9b01      	ldr	r3, [sp, #4]
# 80003f0:	b94b      	cbnz	r3, 8000406 <Activate_ADC+0x32>
# 80003f2:	4b06      	ldr	r3, [pc, #24]	; (800040c <Activate_ADC+0x38>)
# 80003f4:	689a      	ldr	r2, [r3, #8]
# 80003f6:	f042 0204 	orr.w	r2, r2, #4
# 80003fa:	609a      	str	r2, [r3, #8]
# 80003fc:	689a      	ldr	r2, [r3, #8]
# 80003fe:	0752      	lsls	r2, r2, #29
# 8000400:	d4fc      	bmi.n	80003fc <Activate_ADC+0x28>
# 8000402:	b002      	add	sp, #8
# 8000404:	4770      	bx	lr
# 8000406:	9b01      	ldr	r3, [sp, #4]
# 8000408:	3b01      	subs	r3, #1
# 800040a:	e7ef      	b.n	80003ec <Activate_ADC+0x18>
 800040c:	40012400 	.word	0x40012400

#08000410 <LED_Init>:
# 8000410:	b508      	push	{r3, lr}
# 8000412:	2004      	movs	r0, #4
# 8000414:	f7ff ff04 	bl	8000220 <LL_APB2_GRP1_EnableClock>
# 8000418:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
# 800041c:	2201      	movs	r2, #1
# 800041e:	f242 0120 	movw	r1, #8224	; 0x2020
# 8000422:	4801      	ldr	r0, [pc, #4]	; (8000428 <LED_Init+0x18>)
# 8000424:	f7ff bf0a 	b.w	800023c <LL_GPIO_SetPinMode>
 8000428:	40010800 	.word	0x40010800

#0800042c <LED_Blinking>:
# 800042c:	b508      	push	{r3, lr}
# 800042e:	2320      	movs	r3, #32
# 8000430:	4605      	mov	r5, r0
# 8000432:	4c05      	ldr	r4, [pc, #20]	; (8000448 <LED_Blinking+0x1c>)
# 8000434:	6123      	str	r3, [r4, #16]
# 8000436:	68e3      	ldr	r3, [r4, #12]
# 8000438:	4628      	mov	r0, r5
# 800043a:	f083 0320 	eor.w	r3, r3, #32
# 800043e:	60e3      	str	r3, [r4, #12]
# 8000440:	f7ff feb8 	bl	80001b4 <LL_mDelay>
# 8000444:	e7f7      	b.n	8000436 <LED_Blinking+0xa>
 8000446:	bf00      	nop
 8000448:	40010800 	.word	0x40010800

#0800044c <UserButton_Init>:
# 800044c:	b510      	push	{r4, lr}
# 800044e:	4c19      	ldr	r4, [pc, #100]	; (80004b4 <UserButton_Init+0x68>)
# 8000450:	2010      	movs	r0, #16
# 8000452:	f7ff fee5 	bl	8000220 <LL_APB2_GRP1_EnableClock>
# 8000456:	2208      	movs	r2, #8
# 8000458:	4917      	ldr	r1, [pc, #92]	; (80004b8 <UserButton_Init+0x6c>)
# 800045a:	4620      	mov	r0, r4
# 800045c:	f7ff feee 	bl	800023c <LL_GPIO_SetPinMode>
# 8000460:	68e3      	ldr	r3, [r4, #12]
# 8000462:	f44f 2284 	mov.w	r2, #270336	; 0x42000
# 8000466:	f423 2384 	bic.w	r3, r3, #270336	; 0x42000
# 800046a:	fa92 f2a2 	rbit	r2, r2
# 800046e:	2001      	movs	r0, #1
# 8000470:	60e3      	str	r3, [r4, #12]
# 8000472:	f7ff fed5 	bl	8000220 <LL_APB2_GRP1_EnableClock>
# 8000476:	4811      	ldr	r0, [pc, #68]	; (80004bc <UserButton_Init+0x70>)
# 8000478:	22f0      	movs	r2, #240	; 0xf0
# 800047a:	6943      	ldr	r3, [r0, #20]
# 800047c:	fa92 f2a2 	rbit	r2, r2
# 8000480:	2102      	movs	r1, #2
# 8000482:	fab2 f282 	clz	r2, r2
# 8000486:	f023 03f0 	bic.w	r3, r3, #240	; 0xf0
# 800048a:	fa01 f202 	lsl.w	r2, r1, r2
# 800048e:	4313      	orrs	r3, r2
# 8000490:	6143      	str	r3, [r0, #20]
# 8000492:	4b0b      	ldr	r3, [pc, #44]	; (80004c0 <UserButton_Init+0x74>)
# 8000494:	681a      	ldr	r2, [r3, #0]
# 8000496:	f442 5200 	orr.w	r2, r2, #8192	; 0x2000
# 800049a:	601a      	str	r2, [r3, #0]
# 800049c:	68da      	ldr	r2, [r3, #12]
# 800049e:	f442 5200 	orr.w	r2, r2, #8192	; 0x2000
# 80004a2:	60da      	str	r2, [r3, #12]
# 80004a4:	f44f 7280 	mov.w	r2, #256	; 0x100
# 80004a8:	4b06      	ldr	r3, [pc, #24]	; (80004c4 <UserButton_Init+0x78>)
# 80004aa:	605a      	str	r2, [r3, #4]
# 80004ac:	2230      	movs	r2, #48	; 0x30
# 80004ae:	f883 2328 	strb.w	r2, [r3, #808]	; 0x328
# 80004b2:	bd10      	pop	{r4, pc}
 80004b4:	40011000 	.word	0x40011000
 80004b8:	04200020 	.word	0x04200020
 80004bc:	40010000 	.word	0x40010000
 80004c0:	40010400 	.word	0x40010400
 80004c4:	e000e100 	.word	0xe000e100

#080004c8 <SystemClock_Config>:
# 80004c8:	4a20      	ldr	r2, [pc, #128]	; (800054c <SystemClock_Config+0x84>)
# 80004ca:	b508      	push	{r3, lr}
# 80004cc:	6813      	ldr	r3, [r2, #0]
# 80004ce:	f023 0307 	bic.w	r3, r3, #7
# 80004d2:	f043 0302 	orr.w	r3, r3, #2
# 80004d6:	6013      	str	r3, [r2, #0]
# 80004d8:	4b1d      	ldr	r3, [pc, #116]	; (8000550 <SystemClock_Config+0x88>)
# 80004da:	681a      	ldr	r2, [r3, #0]
# 80004dc:	f442 2280 	orr.w	r2, r2, #262144	; 0x40000
# 80004e0:	601a      	str	r2, [r3, #0]
# 80004e2:	681a      	ldr	r2, [r3, #0]
# 80004e4:	f442 3280 	orr.w	r2, r2, #65536	; 0x10000
# 80004e8:	601a      	str	r2, [r3, #0]
# 80004ea:	681a      	ldr	r2, [r3, #0]
# 80004ec:	0391      	lsls	r1, r2, #14
# 80004ee:	d5fc      	bpl.n	80004ea <SystemClock_Config+0x22>
# 80004f0:	685a      	ldr	r2, [r3, #4]
# 80004f2:	f422 127c 	bic.w	r2, r2, #4128768	; 0x3f0000
# 80004f6:	f442 12e8 	orr.w	r2, r2, #1900544	; 0x1d0000
# 80004fa:	605a      	str	r2, [r3, #4]
# 80004fc:	681a      	ldr	r2, [r3, #0]
# 80004fe:	f042 7280 	orr.w	r2, r2, #16777216	; 0x1000000
# 8000502:	601a      	str	r2, [r3, #0]
# 8000504:	681a      	ldr	r2, [r3, #0]
# 8000506:	0192      	lsls	r2, r2, #6
# 8000508:	d5fc      	bpl.n	8000504 <SystemClock_Config+0x3c>
# 800050a:	685a      	ldr	r2, [r3, #4]
# 800050c:	f022 02f0 	bic.w	r2, r2, #240	; 0xf0
# 8000510:	605a      	str	r2, [r3, #4]
# 8000512:	685a      	ldr	r2, [r3, #4]
# 8000514:	f022 0203 	bic.w	r2, r2, #3
# 8000518:	f042 0202 	orr.w	r2, r2, #2
# 800051c:	605a      	str	r2, [r3, #4]
# 800051e:	685a      	ldr	r2, [r3, #4]
# 8000520:	f002 020c 	and.w	r2, r2, #12
# 8000524:	2a08      	cmp	r2, #8
# 8000526:	d1fa      	bne.n	800051e <SystemClock_Config+0x56>
# 8000528:	685a      	ldr	r2, [r3, #4]
# 800052a:	480a      	ldr	r0, [pc, #40]	; (8000554 <SystemClock_Config+0x8c>)
# 800052c:	f422 62e0 	bic.w	r2, r2, #1792	; 0x700
# 8000530:	f442 6280 	orr.w	r2, r2, #1024	; 0x400
# 8000534:	605a      	str	r2, [r3, #4]
# 8000536:	685a      	ldr	r2, [r3, #4]
# 8000538:	f422 5260 	bic.w	r2, r2, #14336	; 0x3800
# 800053c:	605a      	str	r2, [r3, #4]
# 800053e:	f7ff fe2b 	bl	8000198 <LL_Init1msTick>
# 8000542:	e8bd 4008 	ldmia.w	sp!, {r3, lr}
# 8000546:	4803      	ldr	r0, [pc, #12]	; (8000554 <SystemClock_Config+0x8c>)
# 8000548:	f7ff be3e 	b.w	80001c8 <LL_SetSystemCoreClock>
 800054c:	40022000 	.word	0x40022000
 8000550:	40021000 	.word	0x40021000
 8000554:	044aa200 	.word	0x044aa200

#08000558 <main>:
# 8000558:	b508      	push	{r3, lr}
# 800055a:	f7ff ffb5 	bl	80004c8 <SystemClock_Config>
# 800055e:	f44f 5280 	mov.w	r2, #4096	; 0x1000
# 8000562:	4b08      	ldr	r3, [pc, #32]	; (8000584 <main+0x2c>)
# 8000564:	801a      	strh	r2, [r3, #0]
# 8000566:	805a      	strh	r2, [r3, #2]
# 8000568:	809a      	strh	r2, [r3, #4]
# 800056a:	80da      	strh	r2, [r3, #6]
# 800056c:	f7ff ff50 	bl	8000410 <LED_Init>
# 8000570:	f7ff ff6c 	bl	800044c <UserButton_Init>
# 8000574:	f7ff fe7a 	bl	800026c <Configure_DMA>
# 8000578:	f7ff febc 	bl	80002f4 <Configure_ADC>
# 800057c:	f7ff ff2a 	bl	80003d4 <Activate_ADC>
# 8000580:	e7fe      	b.n	8000580 <main+0x28>
 8000582:	bf00      	nop
 8000584:	2000002c 	.word	0x2000002c

#08000588 <UserButton_Callback>:
# 8000588:	b508      	push	{r3, lr}
# 800058a:	4b09      	ldr	r3, [pc, #36]	; (80005b0 <UserButton_Callback+0x28>)
# 800058c:	781a      	ldrb	r2, [r3, #0]
# 800058e:	2a02      	cmp	r2, #2
# 8000590:	bf04      	itt	eq
# 8000592:	2200      	moveq	r2, #0
# 8000594:	701a      	strbeq	r2, [r3, #0]
# 8000596:	4b07      	ldr	r3, [pc, #28]	; (80005b4 <UserButton_Callback+0x2c>)
# 8000598:	689a      	ldr	r2, [r3, #8]
# 800059a:	07d2      	lsls	r2, r2, #31
# 800059c:	d504      	bpl.n	80005a8 <UserButton_Callback+0x20>
# 800059e:	689a      	ldr	r2, [r3, #8]
# 80005a0:	f442 02a0 	orr.w	r2, r2, #5242880	; 0x500000
# 80005a4:	609a      	str	r2, [r3, #8]
# 80005a6:	bd08      	pop	{r3, pc}
 80005a8:	f44f 707a 	mov.w	r0, #1000	; 0x3e8
 80005ac:	f7ff ff3e 	bl	800042c <LED_Blinking>
 80005b0:	20000004 	.word	0x20000004
 80005b4:	40012400 	.word	0x40012400

#080005b8 <AdcDmaTransferComplete_Callback>:
# 80005b8:	f640 43e4 	movw	r3, #3300	; 0xce4
# 80005bc:	f640 70ff 	movw	r0, #4095	; 0xfff
# 80005c0:	b510      	push	{r4, lr}
# 80005c2:	4c0a      	ldr	r4, [pc, #40]	; (80005ec <AdcDmaTransferComplete_Callback+0x34>)
# 80005c4:	490a      	ldr	r1, [pc, #40]	; (80005f0 <AdcDmaTransferComplete_Callback+0x38>)
# 80005c6:	88a2      	ldrh	r2, [r4, #4]
# 80005c8:	435a      	muls	r2, r3
# 80005ca:	fbb2 f2f0 	udiv	r2, r2, r0
# 80005ce:	b292      	uxth	r2, r2
# 80005d0:	808a      	strh	r2, [r1, #4]
# 80005d2:	88e2      	ldrh	r2, [r4, #6]
# 80005d4:	4353      	muls	r3, r2
# 80005d6:	fbb3 f3f0 	udiv	r3, r3, r0
# 80005da:	2201      	movs	r2, #1
# 80005dc:	b29b      	uxth	r3, r3
# 80005de:	80cb      	strh	r3, [r1, #6]
# 80005e0:	4b04      	ldr	r3, [pc, #16]	; (80005f4 <AdcDmaTransferComplete_Callback+0x3c>)
# 80005e2:	701a      	strb	r2, [r3, #0]
# 80005e4:	2220      	movs	r2, #32
# 80005e6:	4b04      	ldr	r3, [pc, #16]	; (80005f8 <AdcDmaTransferComplete_Callback+0x40>)
# 80005e8:	611a      	str	r2, [r3, #16]
# 80005ea:	bd10      	pop	{r4, pc}
 80005ec:	2000002c 	.word	0x2000002c
 80005f0:	20000024 	.word	0x20000024
 80005f4:	20000004 	.word	0x20000004
 80005f8:	40010800 	.word	0x40010800

#080005fc <AdcDmaTransferHalf_Callback>:
# 80005fc:	f640 43e4 	movw	r3, #3300	; 0xce4
# 8000600:	f640 70ff 	movw	r0, #4095	; 0xfff
# 8000604:	b510      	push	{r4, lr}
# 8000606:	4c0a      	ldr	r4, [pc, #40]	; (8000630 <AdcDmaTransferHalf_Callback+0x34>)
# 8000608:	490a      	ldr	r1, [pc, #40]	; (8000634 <AdcDmaTransferHalf_Callback+0x38>)
# 800060a:	8822      	ldrh	r2, [r4, #0]
# 800060c:	435a      	muls	r2, r3
# 800060e:	fbb2 f2f0 	udiv	r2, r2, r0
# 8000612:	b292      	uxth	r2, r2
# 8000614:	800a      	strh	r2, [r1, #0]
# 8000616:	8862      	ldrh	r2, [r4, #2]
# 8000618:	4353      	muls	r3, r2
# 800061a:	fbb3 f3f0 	udiv	r3, r3, r0
# 800061e:	2200      	movs	r2, #0
# 8000620:	b29b      	uxth	r3, r3
# 8000622:	804b      	strh	r3, [r1, #2]
# 8000624:	4b04      	ldr	r3, [pc, #16]	; (8000638 <AdcDmaTransferHalf_Callback+0x3c>)
# 8000626:	701a      	strb	r2, [r3, #0]
# 8000628:	2220      	movs	r2, #32
# 800062a:	4b04      	ldr	r3, [pc, #16]	; (800063c <AdcDmaTransferHalf_Callback+0x40>)
# 800062c:	615a      	str	r2, [r3, #20]
# 800062e:	bd10      	pop	{r4, pc}
 8000630:	2000002c 	.word	0x2000002c
 8000634:	20000024 	.word	0x20000024
 8000638:	20000004 	.word	0x20000004
 800063c:	40010800 	.word	0x40010800

#08000640 <AdcDmaTransferError_Callback>:
# 8000640:	b508      	push	{r3, lr}
# 8000642:	f44f 707a 	mov.w	r0, #1000	; 0x3e8
# 8000646:	f7ff fef1 	bl	800042c <LED_Blinking>

0800064a <NMI_Handler>:
 800064a:	4770      	bx	lr

0800064c <HardFault_Handler>:
 800064c:	e7fe      	b.n	800064c <HardFault_Handler>

0800064e <MemManage_Handler>:
 800064e:	e7fe      	b.n	800064e <MemManage_Handler>

08000650 <BusFault_Handler>:
 8000650:	e7fe      	b.n	8000650 <BusFault_Handler>

08000652 <UsageFault_Handler>:
 8000652:	e7fe      	b.n	8000652 <UsageFault_Handler>

08000654 <SVC_Handler>:
 8000654:	4770      	bx	lr

08000656 <DebugMon_Handler>:
 8000656:	4770      	bx	lr

08000658 <PendSV_Handler>:
 8000658:	4770      	bx	lr

#0800065a <SysTick_Handler>:
# 800065a:	4770      	bx	lr

#0800065c <EXTI15_10_IRQHandler>:
# 800065c:	b510      	push	{r4, lr}
# 800065e:	4c05      	ldr	r4, [pc, #20]	; (8000674 <EXTI15_10_IRQHandler+0x18>)
# 8000660:	6963      	ldr	r3, [r4, #20]
# 8000662:	049b      	lsls	r3, r3, #18
# 8000664:	d504      	bpl.n	8000670 <EXTI15_10_IRQHandler+0x14>
# 8000666:	f7ff ff8f 	bl	8000588 <UserButton_Callback>
# 800066a:	f44f 5300 	mov.w	r3, #8192	; 0x2000
# 800066e:	6163      	str	r3, [r4, #20]
# 8000670:	bd10      	pop	{r4, pc}
 8000672:	bf00      	nop
 8000674:	40010400 	.word	0x40010400

#08000678 <DMA1_Channel1_IRQHandler>:
# 8000678:	b510      	push	{r4, lr}
# 800067a:	4c0d      	ldr	r4, [pc, #52]	; (80006b0 <DMA1_Channel1_IRQHandler+0x38>)
# 800067c:	6823      	ldr	r3, [r4, #0]
# 800067e:	0798      	lsls	r0, r3, #30
# 8000680:	d503      	bpl.n	800068a <DMA1_Channel1_IRQHandler+0x12>
# 8000682:	2302      	movs	r3, #2
# 8000684:	6063      	str	r3, [r4, #4]
# 8000686:	f7ff ff97 	bl	80005b8 <AdcDmaTransferComplete_Callback>
# 800068a:	6823      	ldr	r3, [r4, #0]
# 800068c:	0759      	lsls	r1, r3, #29
# 800068e:	d503      	bpl.n	8000698 <DMA1_Channel1_IRQHandler+0x20>
# 8000690:	2304      	movs	r3, #4
# 8000692:	6063      	str	r3, [r4, #4]
# 8000694:	f7ff ffb2 	bl	80005fc <AdcDmaTransferHalf_Callback>
# 8000698:	4b05      	ldr	r3, [pc, #20]	; (80006b0 <DMA1_Channel1_IRQHandler+0x38>)
# 800069a:	681a      	ldr	r2, [r3, #0]
# 800069c:	0712      	lsls	r2, r2, #28
# 800069e:	d505      	bpl.n	80006ac <DMA1_Channel1_IRQHandler+0x34>
# 80006a0:	e8bd 4010 	ldmia.w	sp!, {r4, lr}
# 80006a4:	2208      	movs	r2, #8
# 80006a6:	605a      	str	r2, [r3, #4]
# 80006a8:	f7ff bfca 	b.w	8000640 <AdcDmaTransferError_Callback>
# 80006ac:	bd10      	pop	{r4, pc}
 80006ae:	bf00      	nop
 80006b0:	40020000 	.word	0x40020000

#080006b4 <__libc_init_array>:
# 80006b4:	b570      	push	{r4, r5, r6, lr}
# 80006b6:	2500      	movs	r5, #0
# 80006b8:	4e0c      	ldr	r6, [pc, #48]	; (80006ec <__libc_init_array+0x38>)
# 80006ba:	4c0d      	ldr	r4, [pc, #52]	; (80006f0 <__libc_init_array+0x3c>)
# 80006bc:	1ba4      	subs	r4, r4, r6
# 80006be:	10a4      	asrs	r4, r4, #2
# 80006c0:	42a5      	cmp	r5, r4
# 80006c2:	d109      	bne.n	80006d8 <__libc_init_array+0x24>
# 80006c4:	f000 f81a 	bl	80006fc <_init>
# 80006c8:	2500      	movs	r5, #0
# 80006ca:	4e0a      	ldr	r6, [pc, #40]	; (80006f4 <__libc_init_array+0x40>)
# 80006cc:	4c0a      	ldr	r4, [pc, #40]	; (80006f8 <__libc_init_array+0x44>)
# 80006ce:	1ba4      	subs	r4, r4, r6
# 80006d0:	10a4      	asrs	r4, r4, #2
# 80006d2:	42a5      	cmp	r5, r4
# 80006d4:	d105      	bne.n	80006e2 <__libc_init_array+0x2e>
# 80006d6:	bd70      	pop	{r4, r5, r6, pc}
 80006d8:	f856 3025 	ldr.w	r3, [r6, r5, lsl #2]
 80006dc:	4798      	blx	r3
 80006de:	3501      	adds	r5, #1
 80006e0:	e7ee      	b.n	80006c0 <__libc_init_array+0xc>
# 80006e2:	f856 3025 	ldr.w	r3, [r6, r5, lsl #2]
# 80006e6:	4798      	blx	r3
# 80006e8:	3501      	adds	r5, #1
# 80006ea:	e7f2      	b.n	80006d2 <__libc_init_array+0x1e>
 80006ec:	08000714 	.word	0x08000714
 80006f0:	08000714 	.word	0x08000714
 80006f4:	08000714 	.word	0x08000714
 80006f8:	08000718 	.word	0x08000718

#080006fc <_init>:
# 80006fc:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
# 80006fe:	bf00      	nop
# 8000700:	bcf8      	pop	{r3, r4, r5, r6, r7}
# 8000702:	bc08      	pop	{r3}
# 8000704:	469e      	mov	lr, r3
# 8000706:	4770      	bx	lr

08000708 <_fini>:
 8000708:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 800070a:	bf00      	nop
 800070c:	bcf8      	pop	{r3, r4, r5, r6, r7}
 800070e:	bc08      	pop	{r3}
 8000710:	469e      	mov	lr, r3
 8000712:	4770      	bx	lr
