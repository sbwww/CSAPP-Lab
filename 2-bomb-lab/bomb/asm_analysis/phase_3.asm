0000000000400f43 <phase_3>:
  400f43:	48 83 ec 18          	sub    $0x18,%rsp
  400f47:	48 8d 4c 24 0c       	lea    0xc(%rsp),%rcx
  400f4c:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
  400f51:	be cf 25 40 00       	mov    $0x4025cf,%esi
  ; (gdb) x/s 0x4025cf
  ; 0x4025cf:       "%d %d"
  400f56:	b8 00 00 00 00       	mov    $0x0,%eax
  400f5b:	e8 90 fc ff ff       	callq  400bf0 <__isoc99_sscanf@plt>
  400f60:	83 f8 01             	cmp    $0x1,%eax
  400f63:	7f 05                	jg     400f6a <phase_3+0x27>        ; if input more than 1 numbers jump to 400f6a
  400f65:	e8 d0 04 00 00       	callq  40143a <explode_bomb>        ; else fail
  400f6a:	83 7c 24 08 07       	cmpl   $0x7,0x8(%rsp)
  400f6f:	77 3c                	ja     400fad <phase_3+0x6a>        ; if stack[3] > 7 fail
  400f71:	8b 44 24 08          	mov    0x8(%rsp),%eax               ; %eax = stack[3]
  400f75:	ff 24 c5 70 24 40 00 	jmpq   *0x402470(,%rax,8)           ; jumping table
  ; (gdb) x/s *0x402470
  ; 0x400f7c <phase_3+57>:  "\270", <incomplete sequence \317>
  ; (gdb) x/s *0x402478
  ; 0x400fb9 <phase_3+118>: "\270\067\001"
  ; (gdb) x/s *0x402480
  ; 0x400f83 <phase_3+64>:  "\270\303\002"
  ; (gdb) x/s *0x402488
  ; 0x400f8a <phase_3+71>:  "\270"
  ; (gdb) x/s *0x402490
  ; 0x400f91 <phase_3+78>:  "\270\205\001"
  ; (gdb) x/s *0x402498
  ; 0x400f98 <phase_3+85>:  "\270", <incomplete sequence \316>
  ; (gdb) x/s *0x4024a0
  ; 0x400f9f <phase_3+92>:  "\270\252\002"
  ; (gdb) x/s *0x4024a8
  ; 0x400fa6 <phase_3+99>:  "\270G\001"
  400f7c:	b8 cf 00 00 00       	mov    $0xcf,%eax
  ; 0 207
  400f81:	eb 3b                	jmp    400fbe <phase_3+0x7b>
  400f83:	b8 c3 02 00 00       	mov    $0x2c3,%eax
  ; 2 707
  400f88:	eb 34                	jmp    400fbe <phase_3+0x7b>
  400f8a:	b8 00 01 00 00       	mov    $0x100,%eax
  ; 3 256
  400f8f:	eb 2d                	jmp    400fbe <phase_3+0x7b>
  400f91:	b8 85 01 00 00       	mov    $0x185,%eax
  ; 4 389
  400f96:	eb 26                	jmp    400fbe <phase_3+0x7b>
  400f98:	b8 ce 00 00 00       	mov    $0xce,%eax
  ; 5 206
  400f9d:	eb 1f                	jmp    400fbe <phase_3+0x7b>
  400f9f:	b8 aa 02 00 00       	mov    $0x2aa,%eax
  ; 6 682
  400fa4:	eb 18                	jmp    400fbe <phase_3+0x7b>
  400fa6:	b8 47 01 00 00       	mov    $0x147,%eax
  ; 7 327
  400fab:	eb 11                	jmp    400fbe <phase_3+0x7b>
  400fad:	e8 88 04 00 00       	callq  40143a <explode_bomb>
  400fb2:	b8 00 00 00 00       	mov    $0x0,%eax
  400fb7:	eb 05                	jmp    400fbe <phase_3+0x7b>
  400fb9:	b8 37 01 00 00       	mov    $0x137,%eax
  ; 1 311
  400fbe:	3b 44 24 0c          	cmp    0xc(%rsp),%eax
  400fc2:	74 05                	je     400fc9 <phase_3+0x86>        ; if %eax == stack[4] success
  400fc4:	e8 71 04 00 00       	callq  40143a <explode_bomb>        ; else fail
  400fc9:	48 83 c4 18          	add    $0x18,%rsp
  400fcd:	c3                   	retq   