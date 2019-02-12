// auto-generated by bsg_ascii_to_rom.py from /home/petrisko/bitbucket/POSH/pre-alpha-release/bp_top/test/rom/rv64ui_p_bgeu.bin; do not modify
//
//rv64ui_p_bgeu.elf:     file format elf64-littleriscv
//
//
//Disassembly of section .text.init:
//
//0000000080000000 <_start>:
//    80000000:	04c0006f          	jal	x0,8000004c <reset_vector>
//
//0000000080000004 <trap_vector>:
//    80000004:	34202f73          	csrrs	x30,mcause,x0
//    80000008:	00800f93          	addi	x31,x0,8
//    8000000c:	03ff0a63          	beq	x30,x31,80000040 <write_tohost>
//    80000010:	00900f93          	addi	x31,x0,9
//    80000014:	03ff0663          	beq	x30,x31,80000040 <write_tohost>
//    80000018:	00b00f93          	addi	x31,x0,11
//    8000001c:	03ff0263          	beq	x30,x31,80000040 <write_tohost>
//    80000020:	80000f17          	auipc	x30,0x80000
//    80000024:	fe0f0f13          	addi	x30,x30,-32 # 0 <_start-0x80000000>
//    80000028:	000f0463          	beq	x30,x0,80000030 <trap_vector+0x2c>
//    8000002c:	000f0067          	jalr	x0,0(x30)
//    80000030:	34202f73          	csrrs	x30,mcause,x0
//    80000034:	000f5463          	bge	x30,x0,8000003c <handle_exception>
//    80000038:	0040006f          	jal	x0,8000003c <handle_exception>
//
//000000008000003c <handle_exception>:
//    8000003c:	539e6e13          	ori	x28,x28,1337
//
//0000000080000040 <write_tohost>:
//    80000040:	00001f17          	auipc	x30,0x1
//    80000044:	fdcf2023          	sw	x28,-64(x30) # 80001000 <tohost>
//    80000048:	ff9ff06f          	jal	x0,80000040 <write_tohost>
//
//000000008000004c <reset_vector>:
//    8000004c:	f1402573          	csrrs	x10,mhartid,x0
//    80000050:	00051063          	bne	x10,x0,80000050 <reset_vector+0x4>
//    80000054:	00000297          	auipc	x5,0x0
//    80000058:	01028293          	addi	x5,x5,16 # 80000064 <reset_vector+0x18>
//    8000005c:	30529073          	csrrw	x0,mtvec,x5
//    80000060:	18005073          	csrrwi	x0,satp,0
//    80000064:	00000297          	auipc	x5,0x0
//    80000068:	01c28293          	addi	x5,x5,28 # 80000080 <reset_vector+0x34>
//    8000006c:	30529073          	csrrw	x0,mtvec,x5
//    80000070:	fff00293          	addi	x5,x0,-1
//    80000074:	3b029073          	csrrw	x0,pmpaddr0,x5
//    80000078:	01f00293          	addi	x5,x0,31
//    8000007c:	3a029073          	csrrw	x0,pmpcfg0,x5
//    80000080:	00000297          	auipc	x5,0x0
//    80000084:	01828293          	addi	x5,x5,24 # 80000098 <reset_vector+0x4c>
//    80000088:	30529073          	csrrw	x0,mtvec,x5
//    8000008c:	30205073          	csrrwi	x0,medeleg,0
//    80000090:	30305073          	csrrwi	x0,mideleg,0
//    80000094:	30405073          	csrrwi	x0,mie,0
//    80000098:	00000e13          	addi	x28,x0,0
//    8000009c:	00000297          	auipc	x5,0x0
//    800000a0:	f6828293          	addi	x5,x5,-152 # 80000004 <trap_vector>
//    800000a4:	30529073          	csrrw	x0,mtvec,x5
//    800000a8:	00100513          	addi	x10,x0,1
//    800000ac:	01f51513          	slli	x10,x10,0x1f
//    800000b0:	02055c63          	bge	x10,x0,800000e8 <reset_vector+0x9c>
//    800000b4:	0ff0000f          	fence	iorw,iorw
//    800000b8:	000c02b7          	lui	x5,0xc0
//    800000bc:	0df2829b          	addiw	x5,x5,223
//    800000c0:	00c29293          	slli	x5,x5,0xc
//    800000c4:	ad028293          	addi	x5,x5,-1328 # bfad0 <_start-0x7ff40530>
//    800000c8:	000e0513          	addi	x10,x28,0
//    800000cc:	000105b7          	lui	x11,0x10
//    800000d0:	fff5859b          	addiw	x11,x11,-1
//    800000d4:	00b57533          	and	x10,x10,x11
//    800000d8:	00a2a023          	sw	x10,0(x5)
//    800000dc:	0ff0000f          	fence	iorw,iorw
//    800000e0:	00100e13          	addi	x28,x0,1
//    800000e4:	00000073          	ecall
//    800000e8:	80000297          	auipc	x5,0x80000
//    800000ec:	f1828293          	addi	x5,x5,-232 # 0 <_start-0x80000000>
//    800000f0:	00028e63          	beq	x5,x0,8000010c <reset_vector+0xc0>
//    800000f4:	10529073          	csrrw	x0,stvec,x5
//    800000f8:	0000b2b7          	lui	x5,0xb
//    800000fc:	1092829b          	addiw	x5,x5,265
//    80000100:	30229073          	csrrw	x0,medeleg,x5
//    80000104:	30202373          	csrrs	x6,medeleg,x0
//    80000108:	f2629ae3          	bne	x5,x6,8000003c <handle_exception>
//    8000010c:	30005073          	csrrwi	x0,mstatus,0
//    80000110:	00000297          	auipc	x5,0x0
//    80000114:	01428293          	addi	x5,x5,20 # 80000124 <test_2>
//    80000118:	34129073          	csrrw	x0,mepc,x5
//    8000011c:	f1402573          	csrrs	x10,mhartid,x0
//    80000120:	30200073          	mret
//
//0000000080000124 <test_2>:
//    80000124:	00200e13          	addi	x28,x0,2
//    80000128:	00000093          	addi	x1,x0,0
//    8000012c:	00000113          	addi	x2,x0,0
//    80000130:	0020f663          	bgeu	x1,x2,8000013c <test_2+0x18>
//    80000134:	3fc01463          	bne	x0,x28,8000051c <fail>
//    80000138:	01c01663          	bne	x0,x28,80000144 <test_3>
//    8000013c:	fe20fee3          	bgeu	x1,x2,80000138 <test_2+0x14>
//    80000140:	3dc01e63          	bne	x0,x28,8000051c <fail>
//
//0000000080000144 <test_3>:
//    80000144:	00300e13          	addi	x28,x0,3
//    80000148:	00100093          	addi	x1,x0,1
//    8000014c:	00100113          	addi	x2,x0,1
//    80000150:	0020f663          	bgeu	x1,x2,8000015c <test_3+0x18>
//    80000154:	3dc01463          	bne	x0,x28,8000051c <fail>
//    80000158:	01c01663          	bne	x0,x28,80000164 <test_4>
//    8000015c:	fe20fee3          	bgeu	x1,x2,80000158 <test_3+0x14>
//    80000160:	3bc01e63          	bne	x0,x28,8000051c <fail>
//
//0000000080000164 <test_4>:
//    80000164:	00400e13          	addi	x28,x0,4
//    80000168:	0010009b          	addiw	x1,x0,1
//    8000016c:	02009093          	slli	x1,x1,0x20
//    80000170:	fff08093          	addi	x1,x1,-1
//    80000174:	0010011b          	addiw	x2,x0,1
//    80000178:	02011113          	slli	x2,x2,0x20
//    8000017c:	fff10113          	addi	x2,x2,-1
//    80000180:	0020f663          	bgeu	x1,x2,8000018c <test_4+0x28>
//    80000184:	39c01c63          	bne	x0,x28,8000051c <fail>
//    80000188:	01c01663          	bne	x0,x28,80000194 <test_5>
//    8000018c:	fe20fee3          	bgeu	x1,x2,80000188 <test_4+0x24>
//    80000190:	39c01663          	bne	x0,x28,8000051c <fail>
//
//0000000080000194 <test_5>:
//    80000194:	00500e13          	addi	x28,x0,5
//    80000198:	00100093          	addi	x1,x0,1
//    8000019c:	00000113          	addi	x2,x0,0
//    800001a0:	0020f663          	bgeu	x1,x2,800001ac <test_5+0x18>
//    800001a4:	37c01c63          	bne	x0,x28,8000051c <fail>
//    800001a8:	01c01663          	bne	x0,x28,800001b4 <test_6>
//    800001ac:	fe20fee3          	bgeu	x1,x2,800001a8 <test_5+0x14>
//    800001b0:	37c01663          	bne	x0,x28,8000051c <fail>
//
//00000000800001b4 <test_6>:
//    800001b4:	00600e13          	addi	x28,x0,6
//    800001b8:	0010009b          	addiw	x1,x0,1
//    800001bc:	02009093          	slli	x1,x1,0x20
//    800001c0:	fff08093          	addi	x1,x1,-1
//    800001c4:	0010011b          	addiw	x2,x0,1
//    800001c8:	02011113          	slli	x2,x2,0x20
//    800001cc:	ffe10113          	addi	x2,x2,-2
//    800001d0:	0020f663          	bgeu	x1,x2,800001dc <test_6+0x28>
//    800001d4:	35c01463          	bne	x0,x28,8000051c <fail>
//    800001d8:	01c01663          	bne	x0,x28,800001e4 <test_7>
//    800001dc:	fe20fee3          	bgeu	x1,x2,800001d8 <test_6+0x24>
//    800001e0:	33c01e63          	bne	x0,x28,8000051c <fail>
//
//00000000800001e4 <test_7>:
//    800001e4:	00700e13          	addi	x28,x0,7
//    800001e8:	0010009b          	addiw	x1,x0,1
//    800001ec:	02009093          	slli	x1,x1,0x20
//    800001f0:	fff08093          	addi	x1,x1,-1
//    800001f4:	00000113          	addi	x2,x0,0
//    800001f8:	0020f663          	bgeu	x1,x2,80000204 <test_7+0x20>
//    800001fc:	33c01063          	bne	x0,x28,8000051c <fail>
//    80000200:	01c01663          	bne	x0,x28,8000020c <test_8>
//    80000204:	fe20fee3          	bgeu	x1,x2,80000200 <test_7+0x1c>
//    80000208:	31c01a63          	bne	x0,x28,8000051c <fail>
//
//000000008000020c <test_8>:
//    8000020c:	00800e13          	addi	x28,x0,8
//    80000210:	00000093          	addi	x1,x0,0
//    80000214:	00100113          	addi	x2,x0,1
//    80000218:	0020f463          	bgeu	x1,x2,80000220 <test_8+0x14>
//    8000021c:	01c01463          	bne	x0,x28,80000224 <test_8+0x18>
//    80000220:	2fc01e63          	bne	x0,x28,8000051c <fail>
//    80000224:	fe20fee3          	bgeu	x1,x2,80000220 <test_8+0x14>
//
//0000000080000228 <test_9>:
//    80000228:	00900e13          	addi	x28,x0,9
//    8000022c:	0010009b          	addiw	x1,x0,1
//    80000230:	02009093          	slli	x1,x1,0x20
//    80000234:	ffe08093          	addi	x1,x1,-2
//    80000238:	0010011b          	addiw	x2,x0,1
//    8000023c:	02011113          	slli	x2,x2,0x20
//    80000240:	fff10113          	addi	x2,x2,-1
//    80000244:	0020f463          	bgeu	x1,x2,8000024c <test_9+0x24>
//    80000248:	01c01463          	bne	x0,x28,80000250 <test_9+0x28>
//    8000024c:	2dc01863          	bne	x0,x28,8000051c <fail>
//    80000250:	fe20fee3          	bgeu	x1,x2,8000024c <test_9+0x24>
//
//0000000080000254 <test_10>:
//    80000254:	00a00e13          	addi	x28,x0,10
//    80000258:	00000093          	addi	x1,x0,0
//    8000025c:	0010011b          	addiw	x2,x0,1
//    80000260:	02011113          	slli	x2,x2,0x20
//    80000264:	fff10113          	addi	x2,x2,-1
//    80000268:	0020f463          	bgeu	x1,x2,80000270 <test_10+0x1c>
//    8000026c:	01c01463          	bne	x0,x28,80000274 <test_10+0x20>
//    80000270:	2bc01663          	bne	x0,x28,8000051c <fail>
//    80000274:	fe20fee3          	bgeu	x1,x2,80000270 <test_10+0x1c>
//
//0000000080000278 <test_11>:
//    80000278:	00b00e13          	addi	x28,x0,11
//    8000027c:	800000b7          	lui	x1,0x80000
//    80000280:	fff0809b          	addiw	x1,x1,-1
//    80000284:	0010011b          	addiw	x2,x0,1
//    80000288:	01f11113          	slli	x2,x2,0x1f
//    8000028c:	0020f463          	bgeu	x1,x2,80000294 <test_11+0x1c>
//    80000290:	01c01463          	bne	x0,x28,80000298 <test_11+0x20>
//    80000294:	29c01463          	bne	x0,x28,8000051c <fail>
//    80000298:	fe20fee3          	bgeu	x1,x2,80000294 <test_11+0x1c>
//
//000000008000029c <test_12>:
//    8000029c:	00c00e13          	addi	x28,x0,12
//    800002a0:	00000213          	addi	x4,x0,0
//    800002a4:	00f0009b          	addiw	x1,x0,15
//    800002a8:	01c09093          	slli	x1,x1,0x1c
//    800002ac:	fff08093          	addi	x1,x1,-1 # ffffffff7fffffff <_end+0xfffffffeffffdfff>
//    800002b0:	00f0011b          	addiw	x2,x0,15
//    800002b4:	01c11113          	slli	x2,x2,0x1c
//    800002b8:	2620f263          	bgeu	x1,x2,8000051c <fail>
//    800002bc:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
//    800002c0:	00200293          	addi	x5,x0,2
//    800002c4:	fe5210e3          	bne	x4,x5,800002a4 <test_12+0x8>
//
//00000000800002c8 <test_13>:
//    800002c8:	00d00e13          	addi	x28,x0,13
//    800002cc:	00000213          	addi	x4,x0,0
//    800002d0:	00f0009b          	addiw	x1,x0,15
//    800002d4:	01c09093          	slli	x1,x1,0x1c
//    800002d8:	fff08093          	addi	x1,x1,-1
//    800002dc:	00f0011b          	addiw	x2,x0,15
//    800002e0:	01c11113          	slli	x2,x2,0x1c
//    800002e4:	00000013          	addi	x0,x0,0
//    800002e8:	2220fa63          	bgeu	x1,x2,8000051c <fail>
//    800002ec:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
//    800002f0:	00200293          	addi	x5,x0,2
//    800002f4:	fc521ee3          	bne	x4,x5,800002d0 <test_13+0x8>
//
//00000000800002f8 <test_14>:
//    800002f8:	00e00e13          	addi	x28,x0,14
//    800002fc:	00000213          	addi	x4,x0,0
//    80000300:	00f0009b          	addiw	x1,x0,15
//    80000304:	01c09093          	slli	x1,x1,0x1c
//    80000308:	fff08093          	addi	x1,x1,-1
//    8000030c:	00f0011b          	addiw	x2,x0,15
//    80000310:	01c11113          	slli	x2,x2,0x1c
//    80000314:	00000013          	addi	x0,x0,0
//    80000318:	00000013          	addi	x0,x0,0
//    8000031c:	2020f063          	bgeu	x1,x2,8000051c <fail>
//    80000320:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
//    80000324:	00200293          	addi	x5,x0,2
//    80000328:	fc521ce3          	bne	x4,x5,80000300 <test_14+0x8>
//
//000000008000032c <test_15>:
//    8000032c:	00f00e13          	addi	x28,x0,15
//    80000330:	00000213          	addi	x4,x0,0
//    80000334:	00f0009b          	addiw	x1,x0,15
//    80000338:	01c09093          	slli	x1,x1,0x1c
//    8000033c:	fff08093          	addi	x1,x1,-1
//    80000340:	00000013          	addi	x0,x0,0
//    80000344:	00f0011b          	addiw	x2,x0,15
//    80000348:	01c11113          	slli	x2,x2,0x1c
//    8000034c:	1c20f863          	bgeu	x1,x2,8000051c <fail>
//    80000350:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
//    80000354:	00200293          	addi	x5,x0,2
//    80000358:	fc521ee3          	bne	x4,x5,80000334 <test_15+0x8>
//
//000000008000035c <test_16>:
//    8000035c:	01000e13          	addi	x28,x0,16
//    80000360:	00000213          	addi	x4,x0,0
//    80000364:	00f0009b          	addiw	x1,x0,15
//    80000368:	01c09093          	slli	x1,x1,0x1c
//    8000036c:	fff08093          	addi	x1,x1,-1
//    80000370:	00000013          	addi	x0,x0,0
//    80000374:	00f0011b          	addiw	x2,x0,15
//    80000378:	01c11113          	slli	x2,x2,0x1c
//    8000037c:	00000013          	addi	x0,x0,0
//    80000380:	1820fe63          	bgeu	x1,x2,8000051c <fail>
//    80000384:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
//    80000388:	00200293          	addi	x5,x0,2
//    8000038c:	fc521ce3          	bne	x4,x5,80000364 <test_16+0x8>
//
//0000000080000390 <test_17>:
//    80000390:	01100e13          	addi	x28,x0,17
//    80000394:	00000213          	addi	x4,x0,0
//    80000398:	00f0009b          	addiw	x1,x0,15
//    8000039c:	01c09093          	slli	x1,x1,0x1c
//    800003a0:	fff08093          	addi	x1,x1,-1
//    800003a4:	00000013          	addi	x0,x0,0
//    800003a8:	00000013          	addi	x0,x0,0
//    800003ac:	00f0011b          	addiw	x2,x0,15
//    800003b0:	01c11113          	slli	x2,x2,0x1c
//    800003b4:	1620f463          	bgeu	x1,x2,8000051c <fail>
//    800003b8:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
//    800003bc:	00200293          	addi	x5,x0,2
//    800003c0:	fc521ce3          	bne	x4,x5,80000398 <test_17+0x8>
//
//00000000800003c4 <test_18>:
//    800003c4:	01200e13          	addi	x28,x0,18
//    800003c8:	00000213          	addi	x4,x0,0
//    800003cc:	00f0009b          	addiw	x1,x0,15
//    800003d0:	01c09093          	slli	x1,x1,0x1c
//    800003d4:	fff08093          	addi	x1,x1,-1
//    800003d8:	00f0011b          	addiw	x2,x0,15
//    800003dc:	01c11113          	slli	x2,x2,0x1c
//    800003e0:	1220fe63          	bgeu	x1,x2,8000051c <fail>
//    800003e4:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
//    800003e8:	00200293          	addi	x5,x0,2
//    800003ec:	fe5210e3          	bne	x4,x5,800003cc <test_18+0x8>
//
//00000000800003f0 <test_19>:
//    800003f0:	01300e13          	addi	x28,x0,19
//    800003f4:	00000213          	addi	x4,x0,0
//    800003f8:	00f0009b          	addiw	x1,x0,15
//    800003fc:	01c09093          	slli	x1,x1,0x1c
//    80000400:	fff08093          	addi	x1,x1,-1
//    80000404:	00f0011b          	addiw	x2,x0,15
//    80000408:	01c11113          	slli	x2,x2,0x1c
//    8000040c:	00000013          	addi	x0,x0,0
//    80000410:	1020f663          	bgeu	x1,x2,8000051c <fail>
//    80000414:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
//    80000418:	00200293          	addi	x5,x0,2
//    8000041c:	fc521ee3          	bne	x4,x5,800003f8 <test_19+0x8>
//
//0000000080000420 <test_20>:
//    80000420:	01400e13          	addi	x28,x0,20
//    80000424:	00000213          	addi	x4,x0,0
//    80000428:	00f0009b          	addiw	x1,x0,15
//    8000042c:	01c09093          	slli	x1,x1,0x1c
//    80000430:	fff08093          	addi	x1,x1,-1
//    80000434:	00f0011b          	addiw	x2,x0,15
//    80000438:	01c11113          	slli	x2,x2,0x1c
//    8000043c:	00000013          	addi	x0,x0,0
//    80000440:	00000013          	addi	x0,x0,0
//    80000444:	0c20fc63          	bgeu	x1,x2,8000051c <fail>
//    80000448:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
//    8000044c:	00200293          	addi	x5,x0,2
//    80000450:	fc521ce3          	bne	x4,x5,80000428 <test_20+0x8>
//
//0000000080000454 <test_21>:
//    80000454:	01500e13          	addi	x28,x0,21
//    80000458:	00000213          	addi	x4,x0,0
//    8000045c:	00f0009b          	addiw	x1,x0,15
//    80000460:	01c09093          	slli	x1,x1,0x1c
//    80000464:	fff08093          	addi	x1,x1,-1
//    80000468:	00000013          	addi	x0,x0,0
//    8000046c:	00f0011b          	addiw	x2,x0,15
//    80000470:	01c11113          	slli	x2,x2,0x1c
//    80000474:	0a20f463          	bgeu	x1,x2,8000051c <fail>
//    80000478:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
//    8000047c:	00200293          	addi	x5,x0,2
//    80000480:	fc521ee3          	bne	x4,x5,8000045c <test_21+0x8>
//
//0000000080000484 <test_22>:
//    80000484:	01600e13          	addi	x28,x0,22
//    80000488:	00000213          	addi	x4,x0,0
//    8000048c:	00f0009b          	addiw	x1,x0,15
//    80000490:	01c09093          	slli	x1,x1,0x1c
//    80000494:	fff08093          	addi	x1,x1,-1
//    80000498:	00000013          	addi	x0,x0,0
//    8000049c:	00f0011b          	addiw	x2,x0,15
//    800004a0:	01c11113          	slli	x2,x2,0x1c
//    800004a4:	00000013          	addi	x0,x0,0
//    800004a8:	0620fa63          	bgeu	x1,x2,8000051c <fail>
//    800004ac:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
//    800004b0:	00200293          	addi	x5,x0,2
//    800004b4:	fc521ce3          	bne	x4,x5,8000048c <test_22+0x8>
//
//00000000800004b8 <test_23>:
//    800004b8:	01700e13          	addi	x28,x0,23
//    800004bc:	00000213          	addi	x4,x0,0
//    800004c0:	00f0009b          	addiw	x1,x0,15
//    800004c4:	01c09093          	slli	x1,x1,0x1c
//    800004c8:	fff08093          	addi	x1,x1,-1
//    800004cc:	00000013          	addi	x0,x0,0
//    800004d0:	00000013          	addi	x0,x0,0
//    800004d4:	00f0011b          	addiw	x2,x0,15
//    800004d8:	01c11113          	slli	x2,x2,0x1c
//    800004dc:	0420f063          	bgeu	x1,x2,8000051c <fail>
//    800004e0:	00120213          	addi	x4,x4,1 # 1 <_start-0x7fffffff>
//    800004e4:	00200293          	addi	x5,x0,2
//    800004e8:	fc521ce3          	bne	x4,x5,800004c0 <test_23+0x8>
//
//00000000800004ec <test_24>:
//    800004ec:	00100093          	addi	x1,x0,1
//    800004f0:	0000fa63          	bgeu	x1,x0,80000504 <test_24+0x18>
//    800004f4:	00108093          	addi	x1,x1,1
//    800004f8:	00108093          	addi	x1,x1,1
//    800004fc:	00108093          	addi	x1,x1,1
//    80000500:	00108093          	addi	x1,x1,1
//    80000504:	00108093          	addi	x1,x1,1
//    80000508:	00108093          	addi	x1,x1,1
//    8000050c:	00300e93          	addi	x29,x0,3
//    80000510:	01800e13          	addi	x28,x0,24
//    80000514:	01d09463          	bne	x1,x29,8000051c <fail>
//    80000518:	05c01263          	bne	x0,x28,8000055c <pass>
//
//000000008000051c <fail>:
//    8000051c:	0ff0000f          	fence	iorw,iorw
//    80000520:	000c0337          	lui	x6,0xc0
//    80000524:	0df3031b          	addiw	x6,x6,223
//    80000528:	00c31313          	slli	x6,x6,0xc
//    8000052c:	ad030313          	addi	x6,x6,-1328 # bfad0 <_start-0x7ff40530>
//    80000530:	000e0513          	addi	x10,x28,0
//    80000534:	000105b7          	lui	x11,0x10
//    80000538:	fff5859b          	addiw	x11,x11,-1
//    8000053c:	01059593          	slli	x11,x11,0x10
//    80000540:	00b56533          	or	x10,x10,x11
//    80000544:	00a32023          	sw	x10,0(x6)
//    80000548:	0ff0000f          	fence	iorw,iorw
//    8000054c:	000e0063          	beq	x28,x0,8000054c <fail+0x30>
//    80000550:	001e1e13          	slli	x28,x28,0x1
//    80000554:	001e6e13          	ori	x28,x28,1
//    80000558:	00000073          	ecall
//
//000000008000055c <pass>:
//    8000055c:	0ff0000f          	fence	iorw,iorw
//    80000560:	000c02b7          	lui	x5,0xc0
//    80000564:	0df2829b          	addiw	x5,x5,223
//    80000568:	00c29293          	slli	x5,x5,0xc
//    8000056c:	ad028293          	addi	x5,x5,-1328 # bfad0 <_start-0x7ff40530>
//    80000570:	000e0513          	addi	x10,x28,0
//    80000574:	000105b7          	lui	x11,0x10
//    80000578:	fff5859b          	addiw	x11,x11,-1
//    8000057c:	00b57533          	and	x10,x10,x11
//    80000580:	00a2a023          	sw	x10,0(x5)
//    80000584:	0ff0000f          	fence	iorw,iorw
//    80000588:	00100e13          	addi	x28,x0,1
//    8000058c:	00000073          	ecall
//    80000590:	c0001073          	unimp
//	...
//
//Disassembly of section .tohost:
//
//0000000080001000 <tohost>:
//	...
//
//0000000080001040 <fromhost>:
//	...
module bp_be_boot_rom #(parameter width_p=-1, addr_width_p=-1)
(input  [addr_width_p-1:0] addr_i
,output logic [width_p-1:0]      data_o
);
always_comb case(addr_i)
         0: data_o = width_p ' (512'b01010011100111100110111000010011000000000100000000000000011011110000000000001111010101000110001100110100001000000010111101110011000000000000111100000000011001110000000000001111000001000110001111111110000011110000111100010011100000000000000000001111000101110000001111111111000000100110001100000000101100000000111110010011000000111111111100000110011000110000000010010000000011111001001100000011111111110000101001100011000000001000000000001111100100110011010000100000001011110111001100000100110000000000000001101111); // 0x539E6E130040006F000F546334202F73000F0067000F0463FE0F0F1380000F1703FF026300B00F9303FF066300900F9303FF0A6300800F9334202F7304C0006F
         1: data_o = width_p ' (512'b00111010000000101001000001110011000000011111000000000010100100110011101100000010100100000111001111111111111100000000001010010011001100000101001010010000011100110000000111000010100000101001001100000000000000000000001010010111000110000000000001010000011100110011000001010010100100000111001100000001000000101000001010010011000000000000000000000010100101110000000000000101000100000110001111110001010000000010010101110011111111111001111111110000011011111111110111001111001000000010001100000000000000000001111100010111); // 0x3A02907301F002933B029073FFF002933052907301C28293000002971800507330529073010282930000029700051063F1402573FF9FF06FFDCF202300001F17
         2: data_o = width_p ' (512'b00001101111100101000001010011011000000000000110000000010101101110000111111110000000000000000111100000010000001010101110001100011000000011111010100010101000100110000000000010000000001010001001100110000010100101001000001110011111101101000001010000010100100110000000000000000000000101001011100000000000000000000111000010011001100000100000001010000011100110011000000110000010100000111001100110000001000000101000001110011001100000101001010010000011100110000000110000010100000101001001100000000000000000000001010010111); // 0x0DF2829B000C02B70FF0000F02055C6301F515130010051330529073F68282930000029700000E13304050733030507330205073305290730182829300000297
         3: data_o = width_p ' (512'b00010000100100101000001010011011000000000000000010110010101101110001000001010010100100000111001100000000000000101000111001100011111100011000001010000010100100111000000000000000000000101001011100000000000000000000000001110011000000000001000000001110000100110000111111110000000000000000111100000000101000101010000000100011000000001011010101110101001100111111111111110101100001011001101100000000000000010000010110110111000000000000111000000101000100111010110100000010100000101001001100000000110000101001001010010011); // 0x1092829B0000B2B71052907300028E63F1828293800002970000007300100E130FF0000F00A2A02300B57533FFF5859B000105B7000E0513AD02829300C29293
         4: data_o = width_p ' (512'b11111110001000001111111011100011000000011100000000010110011000110011111111000000000101000110001100000000001000001111011001100011000000000000000000000001000100110000000000000000000000001001001100000000001000000000111000010011001100000010000000000000011100111111000101000000001001010111001100110100000100101001000001110011000000010100001010000010100100110000000000000000000000101001011100110000000000000101000001110011111100100110001010011010111000110011000000100000001000110111001100110000001000101001000001110011); // 0xFE20FEE301C016633FC014630020F663000001130000009300200E1330200073F140257334129073014282930000029730005073F2629AE33020237330229073
         5: data_o = width_p ' (512'b11111111111100010000000100010011000000100000000100010001000100110000000000010000000000010001101111111111111100001000000010010011000000100000000010010000100100110000000000010000000000001001101100000000010000000000111000010011001110111100000000011110011000111111111000100000111111101110001100000001110000000001011001100011001111011100000000010100011000110000000000100000111101100110001100000000000100000000000100010011000000000001000000000000100100110000000000110000000011100001001100111101110000000001111001100011); // 0xFFF10113020111130010011BFFF08093020090930010009B00400E133BC01E63FE20FEE301C016633DC014630020F663001001130010009300300E133DC01E63
         6: data_o = width_p ' (512'b00000010000000001001000010010011000000000001000000000000100110110000000001100000000011100001001100110111110000000001011001100011111111100010000011111110111000110000000111000000000101100110001100110111110000000001110001100011000000000010000011110110011000110000000000000000000000010001001100000000000100000000000010010011000000000101000000001110000100110011100111000000000101100110001111111110001000001111111011100011000000011100000000010110011000110011100111000000000111000110001100000000001000001111011001100011); // 0x020090930010009B00600E1337C01663FE20FEE301C0166337C01C630020F663000001130010009300500E1339C01663FE20FEE301C0166339C01C630020F663
         7: data_o = width_p ' (512'b00110011110000000001000001100011000000000010000011110110011000110000000000000000000000010001001111111111111100001000000010010011000000100000000010010000100100110000000000010000000000001001101100000000011100000000111000010011001100111100000000011110011000111111111000100000111111101110001100000001110000000001011001100011001101011100000000010100011000110000000000100000111101100110001111111111111000010000000100010011000000100000000100010001000100110000000000010000000000010001101111111111111100001000000010010011); // 0x33C010630020F66300000113FFF08093020090930010009B00700E1333C01E63FE20FEE301C0166335C014630020F663FFE10113020111130010011BFFF08093
         8: data_o = width_p ' (512'b00000010000000010001000100010011000000000001000000000001000110111111111111100000100000001001001100000010000000001001000010010011000000000001000000000000100110110000000010010000000011100001001111111110001000001111111011100011001011111100000000011110011000110000000111000000000101000110001100000000001000001111010001100011000000000001000000000001000100110000000000000000000000001001001100000000100000000000111000010011001100011100000000011010011000111111111000100000111111101110001100000001110000000001011001100011); // 0x020111130010011BFFE08093020090930010009B00900E13FE20FEE32FC01E6301C014630020F463001001130000009300800E1331C01A63FE20FEE301C01663
         9: data_o = width_p ' (512'b10000000000000000000000010110111000000001011000000001110000100111111111000100000111111101110001100101011110000000001011001100011000000011100000000010100011000110000000000100000111101000110001111111111111100010000000100010011000000100000000100010001000100110000000000010000000000010001101100000000000000000000000010010011000000001010000000001110000100111111111000100000111111101110001100101101110000000001100001100011000000011100000000010100011000110000000000100000111101000110001111111111111100010000000100010011); // 0x800000B700B00E13FE20FEE32BC0166301C014630020F463FFF10113020111130010011B0000009300A00E13FE20FEE32DC0186301C014630020F463FFF10113
        10: data_o = width_p ' (512'b00000000000100100000001000010011001001100010000011110010011000110000000111000001000100010001001100000000111100000000000100011011111111111111000010000000100100110000000111000000100100001001001100000000111100000000000010011011000000000000000000000010000100110000000011000000000011100001001111111110001000001111111011100011001010011100000000010100011000110000000111000000000101000110001100000000001000001111010001100011000000011111000100010001000100110000000000010000000000010001101111111111111100001000000010011011); // 0x001202132620F26301C1111300F0011BFFF0809301C0909300F0009B0000021300C00E13FE20FEE329C0146301C014630020F46301F111130010011BFFF0809B
        11: data_o = width_p ' (512'b00000000000000000000001000010011000000001110000000001110000100111111110001010010000111101110001100000000001000000000001010010011000000000001001000000010000100110010001000100000111110100110001100000000000000000000000000010011000000011100000100010001000100110000000011110000000000010001101111111111111100001000000010010011000000011100000010010000100100110000000011110000000000001001101100000000000000000000001000010011000000001101000000001110000100111111111001010010000100001110001100000000001000000000001010010011); // 0x0000021300E00E13FC521EE300200293001202132220FA630000001301C1111300F0011BFFF0809301C0909300F0009B0000021300D00E13FE5210E300200293
        12: data_o = width_p ' (512'b11111111111100001000000010010011000000011100000010010000100100110000000011110000000000001001101100000000000000000000001000010011000000001111000000001110000100111111110001010010000111001110001100000000001000000000001010010011000000000001001000000010000100110010000000100000111100000110001100000000000000000000000000010011000000000000000000000000000100110000000111000001000100010001001100000000111100000000000100011011111111111111000010000000100100110000000111000000100100001001001100000000111100000000000010011011); // 0xFFF0809301C0909300F0009B0000021300F00E13FC521CE300200293001202132020F063000000130000001301C1111300F0011BFFF0809301C0909300F0009B
        13: data_o = width_p ' (512'b00000000000000000000000000010011000000011100000100010001000100110000000011110000000000010001101100000000000000000000000000010011111111111111000010000000100100110000000111000000100100001001001100000000111100000000000010011011000000000000000000000010000100110000000100000000000011100001001111111100010100100001111011100011000000000010000000000010100100110000000000010010000000100001001100011100001000001111100001100011000000011100000100010001000100110000000011110000000000010001101100000000000000000000000000010011); // 0x0000001301C1111300F0011B00000013FFF0809301C0909300F0009B0000021301000E13FC521EE300200293001202131C20F86301C1111300F0011B00000013
        14: data_o = width_p ' (512'b00000000001000000000001010010011000000000001001000000010000100110001011000100000111101000110001100000001110000010001000100010011000000001111000000000001000110110000000000000000000000000001001100000000000000000000000000010011111111111111000010000000100100110000000111000000100100001001001100000000111100000000000010011011000000000000000000000010000100110000000100010000000011100001001111111100010100100001110011100011000000000010000000000010100100110000000000010010000000100001001100011000001000001111111001100011); // 0x00200293001202131620F46301C1111300F0011B0000001300000013FFF0809301C0909300F0009B0000021301100E13FC521CE300200293001202131820FE63
        15: data_o = width_p ' (512'b00000001110000001001000010010011000000001111000000000000100110110000000000000000000000100001001100000001001100000000111000010011111111100101001000010000111000110000000000100000000000101001001100000000000100100000001000010011000100100010000011111110011000110000000111000001000100010001001100000000111100000000000100011011111111111111000010000000100100110000000111000000100100001001001100000000111100000000000010011011000000000000000000000010000100110000000100100000000011100001001111111100010100100001110011100011); // 0x01C0909300F0009B0000021301300E13FE5210E300200293001202131220FE6301C1111300F0011BFFF0809301C0909300F0009B0000021301200E13FC521CE3
        16: data_o = width_p ' (512'b00000000000000000000000000010011000000011100000100010001000100110000000011110000000000010001101111111111111100001000000010010011000000011100000010010000100100110000000011110000000000001001101100000000000000000000001000010011000000010100000000001110000100111111110001010010000111101110001100000000001000000000001010010011000000000001001000000010000100110001000000100000111101100110001100000000000000000000000000010011000000011100000100010001000100110000000011110000000000010001101111111111111100001000000010010011); // 0x0000001301C1111300F0011BFFF0809301C0909300F0009B0000021301400E13FC521EE300200293001202131020F6630000001301C1111300F0011BFFF08093
        17: data_o = width_p ' (512'b00000000001000000000001010010011000000000001001000000010000100110000101000100000111101000110001100000001110000010001000100010011000000001111000000000001000110110000000000000000000000000001001111111111111100001000000010010011000000011100000010010000100100110000000011110000000000001001101100000000000000000000001000010011000000010101000000001110000100111111110001010010000111001110001100000000001000000000001010010011000000000001001000000010000100110000110000100000111111000110001100000000000000000000000000010011); // 0x00200293001202130A20F46301C1111300F0011B00000013FFF0809301C0909300F0009B0000021301500E13FC521CE300200293001202130C20FC6300000013
        18: data_o = width_p ' (512'b00000000000000000000001000010011000000010111000000001110000100111111110001010010000111001110001100000000001000000000001010010011000000000001001000000010000100110000011000100000111110100110001100000000000000000000000000010011000000011100000100010001000100110000000011110000000000010001101100000000000000000000000000010011111111111111000010000000100100110000000111000000100100001001001100000000111100000000000010011011000000000000000000000010000100110000000101100000000011100001001111111100010100100001111011100011); // 0x0000021301700E13FC521CE300200293001202130620FA630000001301C1111300F0011B00000013FFF0809301C0909300F0009B0000021301600E13FC521EE3
        19: data_o = width_p ' (512'b00000000000100001000000010010011000000000001000010000000100100110000000000010000100000001001001100000000000000001111101001100011000000000001000000000000100100111111110001010010000111001110001100000000001000000000001010010011000000000001001000000010000100110000010000100000111100000110001100000001110000010001000100010011000000001111000000000001000110110000000000000000000000000001001100000000000000000000000000010011111111111111000010000000100100110000000111000000100100001001001100000000111100000000000010011011); // 0x0010809300108093001080930000FA6300100093FC521CE300200293001202130420F06301C1111300F0011B0000001300000013FFF0809301C0909300F0009B
        20: data_o = width_p ' (512'b00000001000001011001010110010011111111111111010110000101100110110000000000000001000001011011011100000000000011100000010100010011101011010000001100000011000100110000000011000011000100110001001100001101111100110000001100011011000000000000110000000011001101110000111111110000000000000000111100000101110000000001001001100011000000011101000010010100011000110000000110000000000011100001001100000000001100000000111010010011000000000001000010000000100100110000000000010000100000001001001100000000000100001000000010010011); // 0x01059593FFF5859B000105B7000E0513AD03031300C313130DF3031B000C03370FF0000F05C0126301D0946301800E1300300E93001080930010809300108093
        21: data_o = width_p ' (512'b00000000101101010111010100110011111111111111010110000101100110110000000000000001000001011011011100000000000011100000010100010011101011010000001010000010100100110000000011000010100100101001001100001101111100101000001010011011000000000000110000000010101101110000111111110000000000000000111100000000000000000000000001110011000000000001111001101110000100110000000000011110000111100001001100000000000011100000000001100011000011111111000000000000000011110000000010100011001000000010001100000000101101010110010100110011); // 0x00B57533FFF5859B000105B7000E0513AD02829300C292930DF2829B000C02B70FF0000F00000073001E6E13001E1E13000E00630FF0000F00A3202300B56533
        22: data_o = width_p ' (512'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001100000000000000000100000111001100000000000000000000000001110011000000000001000000001110000100110000111111110000000000000000111100000000101000101010000000100011); // 0x0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C00010730000007300100E130FF0000F00A2A023
   default: data_o = { width_p { 1'b0 } };
endcase
endmodule
