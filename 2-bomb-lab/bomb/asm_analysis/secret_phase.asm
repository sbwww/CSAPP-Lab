00000000004015c4 <phase_defused>:
  4015c4:	48 83 ec 78          	sub    $0x78,%rsp
  4015c8:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
  4015cf:	00 00 
  4015d1:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
  4015d6:	31 c0                	xor    %eax,%eax
  4015d8:	83 3d 81 21 20 00 06 	cmpl   $0x6,0x202181(%rip)        # 603760 <num_input_strings>
  4015df:	75 5e                	jne    40163f <phase_defused+0x7b>
  4015e1:	4c 8d 44 24 10       	lea    0x10(%rsp),%r8
  4015e6:	48 8d 4c 24 0c       	lea    0xc(%rsp),%rcx
  4015eb:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
  4015f0:	be 19 26 40 00       	mov    $0x402619,%esi
  ; (gdb) x/s 0x402619
  ; 0x402619:       "%d %d %s"
  4015f5:	bf 70 38 60 00       	mov    $0x603870,%edi                     ; answer for phase_4 !!!
  4015fa:	e8 f1 f5 ff ff       	callq  400bf0 <__isoc99_sscanf@plt>
  4015ff:	83 f8 03             	cmp    $0x3,%eax
  401602:	75 31                	jne    401635 <phase_defused+0x71>        ; if input != 3 -> normal end
  ; so, to enter the secret phase, we must input 3 items in phase 4, %d %d %s
  401604:	be 22 26 40 00       	mov    $0x402622,%esi
  ; (gdb) x 0x402622
  ; 0x402622:       "DrEvil"
  401609:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
  40160e:	e8 25 fd ff ff       	callq  401338 <strings_not_equal>
  401613:	85 c0                	test   %eax,%eax
  401615:	75 1e                	jne    401635 <phase_defused+0x71>        ; if strings_not_equal != 0 -> normal end
  ; notice that: (str1 != str2) ==> (strings_not_equal != 0)
  ; so, to enter the secret phase, we must input the same string as "DrEvil"
  401617:	bf f8 24 40 00       	mov    $0x4024f8,%edi
  ; (gdb) x/s 0x4024f8
  ; 0x4024f8:       "Curses, you've found the secret phase!"
  40161c:	e8 ef f4 ff ff       	callq  400b10 <puts@plt>
  401621:	bf 20 25 40 00       	mov    $0x402520,%edi
  ; (gdb) x/s 0x402520
  ; 0x402520:       "But finding it and solving it are quite different..."
  401626:	e8 e5 f4 ff ff       	callq  400b10 <puts@plt>
  40162b:	b8 00 00 00 00       	mov    $0x0,%eax
  401630:	e8 0d fc ff ff       	callq  401242 <secret_phase>
  401635:	bf 58 25 40 00       	mov    $0x402558,%edi
  ; (gdb) x/s 0x402558
  ; 0x402558:       "Congratulations! You've defused the bomb!"
  40163a:	e8 d1 f4 ff ff       	callq  400b10 <puts@plt>
  40163f:	48 8b 44 24 68       	mov    0x68(%rsp),%rax
  401644:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
  40164b:	00 00 
  40164d:	74 05                	je     401654 <phase_defused+0x90>
  40164f:	e8 dc f4 ff ff       	callq  400b30 <__stack_chk_fail@plt>
  401654:	48 83 c4 78          	add    $0x78,%rsp
  401658:	c3                   	retq   
  401659:	90                   	nop
  40165a:	90                   	nop
  40165b:	90                   	nop
  40165c:	90                   	nop
  40165d:	90                   	nop
  40165e:	90                   	nop
  40165f:	90                   	nop

0000000000401242 <secret_phase>:
  401242:	53                   	push   %rbx
  401243:	e8 56 02 00 00       	callq  40149e <read_line>
  401248:	ba 0a 00 00 00       	mov    $0xa,%edx                    ; %rdx = 10
  40124d:	be 00 00 00 00       	mov    $0x0,%esi                    ; %rsi = 0
  401252:	48 89 c7             	mov    %rax,%rdi                    ; %rdi = res = 0
  401255:	e8 76 f9 ff ff       	callq  400bd0 <strtol@plt>          ; string -> %d
  40125a:	48 89 c3             	mov    %rax,%rbx                    ; %rbx = input
  40125d:	8d 40 ff             	lea    -0x1(%rax),%eax              ; input -= 1
  401260:	3d e8 03 00 00       	cmp    $0x3e8,%eax
  401265:	76 05                	jbe    40126c <secret_phase+0x2a>   ; if input <= 0x3e8 (1000) skip bomb
  401267:	e8 ce 01 00 00       	callq  40143a <explode_bomb>        ; else fail
  40126c:	89 de                	mov    %ebx,%esi                    ; %rsi = %rbx = input
  40126e:	bf f0 30 60 00       	mov    $0x6030f0,%edi
  ; (gdb) x/120x 0x6030f0
  ; 0x6030f0 <n1>:  0x00000024      0x00000000      0x00603110     0x00000000
  ; 0x603100 <n1+16>:       0x00603130      0x00000000      0x00000000      0x00000000
  ; 0x603110 <n21>: 0x00000008      0x00000000      0x00603190     0x00000000
  ; 0x603120 <n21+16>:      0x00603150      0x00000000      0x00000000      0x00000000
  ; 0x603130 <n22>: 0x00000032      0x00000000      0x00603170     0x00000000
  ; 0x603140 <n22+16>:      0x006031b0      0x00000000      0x00000000      0x00000000
  ; 0x603150 <n32>: 0x00000016      0x00000000      0x00603270     0x00000000
  ; 0x603160 <n32+16>:      0x00603230      0x00000000      0x00000000      0x00000000
  ; 0x603170 <n33>: 0x0000002d      0x00000000      0x006031d0     0x00000000
  ; 0x603180 <n33+16>:      0x00603290      0x00000000      0x00000000      0x00000000
  ; 0x603190 <n31>: 0x00000006      0x00000000      0x006031f0     0x00000000
  ; 0x6031a0 <n31+16>:      0x00603250      0x00000000      0x00000000      0x00000000
  ; 0x6031b0 <n34>: 0x0000006b      0x00000000      0x00603210     0x00000000
  ; 0x6031c0 <n34+16>:      0x006032b0      0x00000000      0x00000000      0x00000000
  ; 0x6031d0 <n45>: 0x00000028      0x00000000      0x00000000     0x00000000
  ; 0x6031e0 <n45+16>:      0x00000000      0x00000000      0x00000000      0x00000000
  ; 0x6031f0 <n41>: 0x00000001      0x00000000      0x00000000     0x00000000
  ; 0x603200 <n41+16>:      0x00000000      0x00000000      0x00000000      0x00000000
  ; 0x603210 <n47>: 0x00000063      0x00000000      0x00000000     0x00000000
  ; 0x603220 <n47+16>:      0x00000000      0x00000000      0x00000000      0x00000000
  ; 0x603230 <n44>: 0x00000023      0x00000000      0x00000000     0x00000000
  ; 0x603240 <n44+16>:      0x00000000      0x00000000      0x00000000      0x00000000
  ; 0x603250 <n42>: 0x00000007      0x00000000      0x00000000     0x00000000
  ; 0x603260 <n42+16>:      0x00000000      0x00000000      0x00000000      0x00000000
  ; 0x603270 <n43>: 0x00000014      0x00000000      0x00000000     0x00000000
  ; 0x603280 <n43+16>:      0x00000000      0x00000000      0x00000000      0x00000000
  ; 0x603290 <n46>: 0x0000002f      0x00000000      0x00000000     0x00000000
  ; 0x6032a0 <n46+16>:      0x00000000      0x00000000      0x00000000      0x00000000
  ; 0x6032b0 <n48>: 0x000003e9      0x00000000      0x00000000     0x00000000
  ; 0x6032c0 <n48+16>:      0x00000000      0x00000000      0x00000000      0x00000000
  ; the binary tree is as:
  ;                     36
  ;               /           \
  ;          8                      50
  ;       /     \                /      \
  ;    6          22          45          107
  ;  /   \      /   \        /  \        /   \
  ; 1     7   20     35    40    47     99   1001
  401273:	e8 8c ff ff ff       	callq  401204 <fun7>
  401278:	83 f8 02             	cmp    $0x2,%eax
  40127b:	74 05                	je     401282 <secret_phase+0x40>   ; if res = 2 -> skip bomb
  40127d:	e8 b8 01 00 00       	callq  40143a <explode_bomb>        ; else fail
  401282:	bf 38 24 40 00       	mov    $0x402438,%edi               ; *(%edi) = "Wow! You've defused the secret stage!"
  401287:	e8 84 f8 ff ff       	callq  400b10 <puts@plt>
  40128c:	e8 33 03 00 00       	callq  4015c4 <phase_defused>
  401291:	5b                   	pop    %rbx
  401292:	c3                   	retq   
  401293:	90                   	nop
  401294:	90                   	nop
  401295:	90                   	nop
  401296:	90                   	nop
  401297:	90                   	nop
  401298:	90                   	nop
  401299:	90                   	nop
  40129a:	90                   	nop
  40129b:	90                   	nop
  40129c:	90                   	nop
  40129d:	90                   	nop
  40129e:	90                   	nop
  40129f:	90                   	nop

0000000000401204 <fun7>:
  401204:	48 83 ec 08          	sub    $0x8,%rsp
  401208:	48 85 ff             	test   %rdi,%rdi
  40120b:	74 2b                	je     401238 <fun7+0x34>           ; if %rdi == 0  goto 401238 (fail)
  ; so, %rdi can not be 0 (current node is not null)
  40120d:	8b 17                	mov    (%rdi),%edx                  ; else  %rdx = *(%rdi) (current node)
  40120f:	39 f2                	cmp    %esi,%edx
  401211:	7e 0d                	jle    401220 <fun7+0x1c>           ; if %rdx <= %rsi  goto 401220 (2nd call return 0)
  ; it should be %rdx > %rsi
  401213:	48 8b 7f 08          	mov    0x8(%rdi),%rdi               ; else  %rdi = *(%rdi + 8) (cur->left)
  401217:	e8 e8 ff ff ff       	callq  401204 <fun7>                ; fun7()
  40121c:	01 c0                	add    %eax,%eax                    ; res = 2 * res; (return 2)
  ; if we want res == 2, the result of fun7() at 401217 should be 1
  40121e:	eb 1d                	jmp    40123d <fun7+0x39>           ; return
  401220:	b8 00 00 00 00       	mov    $0x0,%eax                    ; res = 0
  401225:	39 f2                	cmp    %esi,%edx
  401227:	74 14                	je     40123d <fun7+0x39>           ; if %rdx == %rsi  return 0
  401229:	48 8b 7f 10          	mov    0x10(%rdi),%rdi              ; else  %rdi = *(%rdi + 16) (cur->right)
  40122d:	e8 d2 ff ff ff       	callq  401204 <fun7>                ; fun7()
  401232:	8d 44 00 01          	lea    0x1(%rax,%rax,1),%eax        ; res = 1 + 2 * res (1st call return 1)
  401236:	eb 05                	jmp    40123d <fun7+0x39>           ; return res
  401238:	b8 ff ff ff ff       	mov    $0xffffffff,%eax             ; res = 0xffffffff (fail)
  40123d:	48 83 c4 08          	add    $0x8,%rsp
  401241:	c3                   	retq   
  ; summary: the call order can be:
  ;         2 = 2 * 1
  ; left    1 = 2 * 0 + 1
  ; right   0 = 2 * 0 or (input == current node)
  ; left    0 (input == current node) (this call is optional)
  ; so, from the root node, we have
  ; root -> left -> right (-> left)
  ;  36  ->  8   ->  22   (->  20 )
  ; then, the answer is 22 or 20
