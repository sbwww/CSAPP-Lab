0000000000401062 <phase_5>:
  401062:	53                   	push   %rbx
  401063:	48 83 ec 20          	sub    $0x20,%rsp
  401067:	48 89 fb             	mov    %rdi,%rbx                ; store &input in %rbx
  40106a:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax            ; retrieve canary (equal to %fs:40) res = 40
  401071:	00 00                                                 ; padding?
  401073:	48 89 44 24 18       	mov    %rax,0x18(%rsp)          ; stack[4] = res
  401078:	31 c0                	xor    %eax,%eax                ; res = 0
  40107a:	e8 9c 02 00 00       	callq  40131b <string_length>   ; len = string_length(input)
  40107f:	83 f8 06             	cmp    $0x6,%eax
  401082:	74 4e                	je     4010d2 <phase_5+0x70>    ; if len == 6 jump to 4010d2
  401084:	e8 b1 03 00 00       	callq  40143a <explode_bomb>    ; else fail
  401089:	eb 47                	jmp    4010d2 <phase_5+0x70> 
  40108b:	0f b6 0c 03          	movzbl (%rbx,%rax,1),%ecx       ; p = &input + res
  40108f:	88 0c 24             	mov    %cl,(%rsp)               ; input[0] = (lower 8 bits of) arg4
  401092:	48 8b 14 24          	mov    (%rsp),%rdx              ; arg3 = input[0]
  401096:	83 e2 0f             	and    $0xf,%edx                ; arg3 &= 0...01111 (save lower 4 bits)
  401099:	0f b6 92 b0 24 40 00 	movzbl 0x4024b0(%rdx),%edx      ; arg3 += 0x4024b0
  ; at 0x4024b0 is "maduiersnfotvbylSo you think you can stop the bomb with ctrl-c, do you?"
  4010a0:	88 54 04 10          	mov    %dl,0x10(%rsp,%rax,1)    ; *(input+2+res) = arg3
  4010a4:	48 83 c0 01          	add    $0x1,%rax                ; res++
  4010a8:	48 83 f8 06          	cmp    $0x6,%rax
  4010ac:	75 dd                	jne    40108b <phase_5+0x29>    ; if res != 6 jump to 40108b
  4010ae:	c6 44 24 16 00       	movb   $0x0,0x16(%rsp)          ; else input[2] = 0
  4010b3:	be 5e 24 40 00       	mov    $0x40245e,%esi           ; arg2 = "flyers" !!!
  ; lower 4 bits    total_bits    ascii
  ;     f 9         69 79         i y
  ;     l 15        6f            o
  ;     y 14        6e            n
  ;     e 5         65 75         e u
  ;     r 6         66 76         f v
  ;     s 7         67 77         g w
  4010b8:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi          ; arg1 = stack + 16
  4010bd:	e8 76 02 00 00       	callq  401338 <strings_not_equal> ; arg1 == arg2 ?
  4010c2:	85 c0                	test   %eax,%eax
  4010c4:	74 13                	je     4010d9 <phase_5+0x77>    ; if res != 0 jump to 4010d9
  4010c6:	e8 6f 03 00 00       	callq  40143a <explode_bomb>    ; else fail
  4010cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  4010d0:	eb 07                	jmp    4010d9 <phase_5+0x77>
  4010d2:	b8 00 00 00 00       	mov    $0x0,%eax                ; res = 0
  4010d7:	eb b2                	jmp    40108b <phase_5+0x29>    ; jump to 40108b
  4010d9:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  4010de:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax            ; check canary
  4010e5:	00 00 
  4010e7:	74 05                	je     4010ee <phase_5+0x8c>
  4010e9:	e8 42 fa ff ff       	callq  400b30 <__stack_chk_fail@plt>
  4010ee:	48 83 c4 20          	add    $0x20,%rsp
  4010f2:	5b                   	pop    %rbx
  4010f3:	c3                   	retq   

000000000040131b <string_length>:
  40131b:	80 3f 00             	cmpb   $0x0,(%rdi)
  40131e:	74 12                	je     401332 <string_length+0x17>  ; if *str == 0 return 0
  401320:	48 89 fa             	mov    %rdi,%rdx                    ; p = str (address)
  401323:	48 83 c2 01          	add    $0x1,%rdx                    ; p++
  401327:	89 d0                	mov    %edx,%eax                    ; res = p
  401329:	29 f8                	sub    %edi,%eax                    ; res -= str (length of str)
  40132b:	80 3a 00             	cmpb   $0x0,(%rdx)
  40132e:	75 f3                	jne    401323 <string_length+0x8>   ; *(str+p) != 0
  401330:	f3 c3                	repz retq 
  401332:	b8 00 00 00 00       	mov    $0x0,%eax
  401337:	c3                   	retq   

0000000000401338 <strings_not_equal>:
  401338:	41 54                	push   %r12
  40133a:	55                   	push   %rbp
  40133b:	53                   	push   %rbx
  40133c:	48 89 fb             	mov    %rdi,%rbx
  40133f:	48 89 f5             	mov    %rsi,%rbp
  401342:	e8 d4 ff ff ff       	callq  40131b <string_length>
  401347:	41 89 c4             	mov    %eax,%r12d
  40134a:	48 89 ef             	mov    %rbp,%rdi
  40134d:	e8 c9 ff ff ff       	callq  40131b <string_length>
  401352:	ba 01 00 00 00       	mov    $0x1,%edx
  401357:	41 39 c4             	cmp    %eax,%r12d
  40135a:	75 3f                	jne    40139b <strings_not_equal+0x63>
  40135c:	0f b6 03             	movzbl (%rbx),%eax
  40135f:	84 c0                	test   %al,%al
  401361:	74 25                	je     401388 <strings_not_equal+0x50>
  401363:	3a 45 00             	cmp    0x0(%rbp),%al
  401366:	74 0a                	je     401372 <strings_not_equal+0x3a>
  401368:	eb 25                	jmp    40138f <strings_not_equal+0x57>
  40136a:	3a 45 00             	cmp    0x0(%rbp),%al
  40136d:	0f 1f 00             	nopl   (%rax)
  401370:	75 24                	jne    401396 <strings_not_equal+0x5e>
  401372:	48 83 c3 01          	add    $0x1,%rbx
  401376:	48 83 c5 01          	add    $0x1,%rbp
  40137a:	0f b6 03             	movzbl (%rbx),%eax
  40137d:	84 c0                	test   %al,%al
  40137f:	75 e9                	jne    40136a <strings_not_equal+0x32>
  401381:	ba 00 00 00 00       	mov    $0x0,%edx
  401386:	eb 13                	jmp    40139b <strings_not_equal+0x63>
  401388:	ba 00 00 00 00       	mov    $0x0,%edx
  40138d:	eb 0c                	jmp    40139b <strings_not_equal+0x63>
  40138f:	ba 01 00 00 00       	mov    $0x1,%edx
  401394:	eb 05                	jmp    40139b <strings_not_equal+0x63>
  401396:	ba 01 00 00 00       	mov    $0x1,%edx
  40139b:	89 d0                	mov    %edx,%eax
  40139d:	5b                   	pop    %rbx
  40139e:	5d                   	pop    %rbp
  40139f:	41 5c                	pop    %r12
  4013a1:	c3                   	retq   