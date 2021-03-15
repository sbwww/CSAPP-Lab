00000000004010f4 <phase_6>:
  4010f4:	41 56                	push   %r14
  4010f6:	41 55                	push   %r13
  4010f8:	41 54                	push   %r12
  4010fa:	55                   	push   %rbp
  4010fb:	53                   	push   %rbx
  4010fc:	48 83 ec 50          	sub    $0x50,%rsp
  401100:	49 89 e5             	mov    %rsp,%r13
  401103:	48 89 e6             	mov    %rsp,%rsi
  401106:	e8 51 03 00 00       	callq  40145c <read_six_numbers>        ; read_six_numbers(string input, *p)
  ; (gdb) x/s 0x4025c3
  ; 0x4025c3:       "%d %d %d %d %d %d"
  40110b:	49 89 e6             	mov    %rsp,%r14                        ; %r14 = %rsp
  40110e:	41 bc 00 00 00 00    	mov    $0x0,%r12d                       ; %r12d = 0
  401114:	4c 89 ed             	mov    %r13,%rbp                        ; %rbp = %r13 (while loop)
  401117:	41 8b 45 00          	mov    0x0(%r13),%eax                   ; res = *(%r13)
  40111b:	83 e8 01             	sub    $0x1,%eax                        ; res -= 1
  40111e:	83 f8 05             	cmp    $0x5,%eax
  401121:	76 05                	jbe    401128 <phase_6+0x34>            ; if res <= 5 skip bomb
  401123:	e8 12 03 00 00       	callq  40143a <explode_bomb>            ; else fail !!! input must <= 6
  401128:	41 83 c4 01          	add    $0x1,%r12d                       ; %r12d += 1 (iteration indicator 0~6)
  40112c:	41 83 fc 06          	cmp    $0x6,%r12d
  401130:	74 21                	je     401153 <phase_6+0x5f>            ; if %r12d == 6 goto 401153 (break)
  401132:	44 89 e3             	mov    %r12d,%ebx                       ; %rbx = %r12d
  401135:	48 63 c3             	movslq %ebx,%rax                        ; res = %rbx (for loop)
  ; for i = 1; i <= 5; ++i
  401138:	8b 04 84             	mov    (%rsp,%rax,4),%eax               ; res = *(%rsp + 4 * res) (the %r12d-th number)
  40113b:	39 45 00             	cmp    %eax,0x0(%rbp)
  40113e:	75 05                	jne    401145 <phase_6+0x51>            ; if *(%rbp) != res goto 401145
  401140:	e8 f5 02 00 00       	callq  40143a <explode_bomb>            ; else fail !!! input must be different numbers
  401145:	83 c3 01             	add    $0x1,%ebx                        ; %rbx++
  401148:	83 fb 05             	cmp    $0x5,%ebx
  40114b:	7e e8                	jle    401135 <phase_6+0x41>            ; if %rbx <= 5 goto 401135 (for loop)
  40114d:	49 83 c5 04          	add    $0x4,%r13                        ; %r13 += 4
  401151:	eb c1                	jmp    401114 <phase_6+0x20>            ; goto 401114 (while loop)
  401153:	48 8d 74 24 18       	lea    0x18(%rsp),%rsi                  ; %rsi = *(%rsp+18)
  401158:	4c 89 f0             	mov    %r14,%rax                        ; res = %r14
  40115b:	b9 07 00 00 00       	mov    $0x7,%ecx                        ; %rcx = 7
  401160:	89 ca                	mov    %ecx,%edx                        ; %rdx = 7 (while loop)
  ; while res != %rsi
  401162:	2b 10                	sub    (%rax),%edx                      ; %rdx -= *res
  401164:	89 10                	mov    %edx,(%rax)                      ; *res = %rdx
  401166:	48 83 c0 04          	add    $0x4,%rax                        ; res += 4 (summary: each input x becomes 7 - x)
  40116a:	48 39 f0             	cmp    %rsi,%rax
  40116d:	75 f1                	jne    401160 <phase_6+0x6c>            ; if res != %rsi goto 401160 (while loop)
  40116f:	be 00 00 00 00       	mov    $0x0,%esi                        ; else %rsi = 0
  401174:	eb 21                	jmp    401197 <phase_6+0xa3>            ; goto 401197
  401176:	48 8b 52 08          	mov    0x8(%rdx),%rdx                   ; %rdx = *(%rdx + 8) (pointer++) (loop)
  40117a:	83 c0 01             	add    $0x1,%eax                        ; res += 1
  40117d:	39 c8                	cmp    %ecx,%eax
  40117f:	75 f5                	jne    401176 <phase_6+0x82>            ; if res != %rcx goto 401176 (loop)
  401181:	eb 05                	jmp    401188 <phase_6+0x94>            ; else goto 401188
  401183:	ba d0 32 60 00       	mov    $0x6032d0,%edx                   ; (loop)
  401188:	48 89 54 74 20       	mov    %rdx,0x20(%rsp,%rsi,2)           ; *(%rsp + 2 * %rsi + 20) = %rdx
  40118d:	48 83 c6 04          	add    $0x4,%rsi                        ; %rsi += 4
  401191:	48 83 fe 18          	cmp    $0x18,%rsi
  401195:	74 14                	je     4011ab <phase_6+0xb7>            ; if %rsi == 18 break
  401197:	8b 0c 34             	mov    (%rsp,%rsi,1),%ecx               ; %rcx = *(%rsp + %rsi)
  40119a:	83 f9 01             	cmp    $0x1,%ecx
  40119d:	7e e4                	jle    401183 <phase_6+0x8f>            ; if %rcx <= 1 goto 401183 (loop)
  40119f:	b8 01 00 00 00       	mov    $0x1,%eax                        ; res = 1
  4011a4:	ba d0 32 60 00       	mov    $0x6032d0,%edx                   ; %rdx = 0x6032d0
  ; (gdb) x/12xg 0x6032d0
  ; 0x6032d0 <node1>:       0x000000010000014c      0x00000000006032e0
  ; 0x6032e0 <node2>:       0x00000002000000a8      0x00000000006032f0
  ; 0x6032f0 <node3>:       0x000000030000039c      0x0000000000603300
  ; 0x603300 <node4>:       0x00000004000002b3      0x0000000000603310
  ; 0x603310 <node5>:       0x00000005000001dd      0x0000000000603320
  ; 0x603320 <node6>:       0x00000006000001bb      0x0000000000000000
  ; node+8 is a pointer to the next node
  ; so it's likely a linked list
  ; 0x14c -> 0x0a8 -> 0x1dd -> 0x1bb
  4011a9:	eb cb                	jmp    401176 <phase_6+0x82>            ; goto 401176 (loop)
  4011ab:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx                  ; %rbx = *(%rsp + 20)
  4011b0:	48 8d 44 24 28       	lea    0x28(%rsp),%rax                  ; %rax = %rsp + 28
  4011b5:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi                  ; %rsi = %rsi + 50
  4011ba:	48 89 d9             	mov    %rbx,%rcx                        ; %rcx = %rbx
  4011bd:	48 8b 10             	mov    (%rax),%rdx                      ; %rdx = *(%rax) (loop)
  4011c0:	48 89 51 08          	mov    %rdx,0x8(%rcx)                   ; *(%rcx + 8) = %rdx
  4011c4:	48 83 c0 08          	add    $0x8,%rax                        ; res = 8
  4011c8:	48 39 f0             	cmp    %rsi,%rax
  4011cb:	74 05                	je     4011d2 <phase_6+0xde>            ; if res == %rsi break
  4011cd:	48 89 d1             	mov    %rdx,%rcx                        ; %rcx = %rdx
  4011d0:	eb eb                	jmp    4011bd <phase_6+0xc9>            ; goto 4011bd (loop)
  4011d2:	48 c7 42 08 00 00 00 	movq   $0x0,0x8(%rdx)                   ; *(%rdx + 8) = 0
  4011d9:	00 
  4011da:	bd 05 00 00 00       	mov    $0x5,%ebp                        ; %rbp = 5
  4011df:	48 8b 43 08          	mov    0x8(%rbx),%rax                   ; res = *(%rbx + 8) (loop)
  4011e3:	8b 00                	mov    (%rax),%eax                      ; res = *res
  4011e5:	39 03                	cmp    %eax,(%rbx)
  4011e7:	7d 05                	jge    4011ee <phase_6+0xfa>            ; if (%rbx) >= res skip bomb
  ; node[i].val >= node[i+1].val (val is the lower 4 bits)
  ; 0x6032f0 <node3>:       0x000000030000039c      0x0000000000603300
  ; 0x603300 <node4>:       0x00000004000002b3      0x0000000000603310
  ; 0x603310 <node5>:       0x00000005000001dd      0x0000000000603320
  ; 0x603320 <node6>:       0x00000006000001bb      0x0000000000000000
  ; 0x6032d0 <node1>:       0x000000010000014c      0x00000000006032e0
  ; 0x6032e0 <node2>:       0x00000002000000a8      0x00000000006032f0
  ; notice that the order is 7 - x, refer to 401166
  ; so the answer is 7 - [3 4 5 6 1 2] = [4 3 2 1 6 5]
  4011e9:	e8 4c 02 00 00       	callq  40143a <explode_bomb>            ; else fail
  4011ee:	48 8b 5b 08          	mov    0x8(%rbx),%rbx                   ; %rbx = *(%rbx + 8)
  4011f2:	83 ed 01             	sub    $0x1,%ebp                        ; %rbp -= 1
  4011f5:	75 e8                	jne    4011df <phase_6+0xeb>            ; if %rbp != 0 goto 4011df (loop)
  4011f7:	48 83 c4 50          	add    $0x50,%rsp                       ; else okay
  4011fb:	5b                   	pop    %rbx
  4011fc:	5d                   	pop    %rbp
  4011fd:	41 5c                	pop    %r12
  4011ff:	41 5d                	pop    %r13
  401201:	41 5e                	pop    %r14
  401203:	c3                   	retq 