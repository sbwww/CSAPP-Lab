
0000000000400efc <phase_2>:
  400efc:	55                   	push   %rbp                         ; store %rbp
  400efd:	53                   	push   %rbx                         ; store %rbx
  400efe:	48 83 ec 28          	sub    $0x28,%rsp                   ; allocate stack space
  400f02:	48 89 e6             	mov    %rsp,%rsi                    ; %rsi = %rsp
  400f05:	e8 52 05 00 00       	callq  40145c <read_six_numbers>    ; read_six_numbers(string input, *p)
  ; (gdb) x/s 0x4025c3
  ; 0x4025c3:       "%d %d %d %d %d %d"
  400f0a:	83 3c 24 01          	cmpl   $0x1,(%rsp)
  400f0e:	74 20                	je     400f30 <phase_2+0x34>        ; if (%rsp) == 1
  ; number_1 is 1, jump to 400f30
  400f10:	e8 25 05 00 00       	callq  40143a <explode_bomb>        ; else fail
  400f15:	eb 19                	jmp    400f30 <phase_2+0x34>
  400f17:	8b 43 fc             	mov    -0x4(%rbx),%eax              ; res = (%rbx - 4)
  400f1a:	01 c0                	add    %eax,%eax                    ; res += res
  400f1c:	39 03                	cmp    %eax,(%rbx)
  400f1e:	74 05                	je     400f25 <phase_2+0x29>        ; if res == (%rbx) -> number_i = 2 * number_i-1
  400f20:	e8 15 05 00 00       	callq  40143a <explode_bomb>        ; else fail
  400f25:	48 83 c3 04          	add    $0x4,%rbx                    ; %rbx += 4
  400f29:	48 39 eb             	cmp    %rbp,%rbx
  400f2c:	75 e9                	jne    400f17 <phase_2+0x1b>        ; if %rbp != %rbx loop
  400f2e:	eb 0c                	jmp    400f3c <phase_2+0x40>        ; else break (meeting ending criteria)
  400f30:	48 8d 5c 24 04       	lea    0x4(%rsp),%rbx               ; %rbx = (%rsp + 4) -> next number
  400f35:	48 8d 6c 24 18       	lea    0x18(%rsp),%rbp              ; %rbp = (%rsp + 24) this is the ending criteria of loop
  400f3a:	eb db                	jmp    400f17 <phase_2+0x1b>        ; 
  400f3c:	48 83 c4 28          	add    $0x28,%rsp                   ; deallocate stack space
  400f40:	5b                   	pop    %rbx                         ; restore %rbx
  400f41:	5d                   	pop    %rbp                         ; restore %rbp
  400f42:	c3                   	retq   

000000000040145c <read_six_numbers>:
  40145c:	48 83 ec 18          	sub    $0x18,%rsp
  401460:	48 89 f2             	mov    %rsi,%rdx
  401463:	48 8d 4e 04          	lea    0x4(%rsi),%rcx
  401467:	48 8d 46 14          	lea    0x14(%rsi),%rax
  40146b:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  401470:	48 8d 46 10          	lea    0x10(%rsi),%rax
  401474:	48 89 04 24          	mov    %rax,(%rsp)
  401478:	4c 8d 4e 0c          	lea    0xc(%rsi),%r9
  40147c:	4c 8d 46 08          	lea    0x8(%rsi),%r8
  401480:	be c3 25 40 00       	mov    $0x4025c3,%esi
  401485:	b8 00 00 00 00       	mov    $0x0,%eax
  40148a:	e8 61 f7 ff ff       	callq  400bf0 <__isoc99_sscanf@plt>
  40148f:	83 f8 05             	cmp    $0x5,%eax
  401492:	7f 05                	jg     401499 <read_six_numbers+0x3d>
  401494:	e8 a1 ff ff ff       	callq  40143a <explode_bomb>
  401499:	48 83 c4 18          	add    $0x18,%rsp
  40149d:	c3                   	retq  