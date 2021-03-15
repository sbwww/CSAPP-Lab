0000000000400ee0 <phase_1>:
  400ee0:	48 83 ec 08          	sub    $0x8,%rsp                    ; allocate stack space
  400ee4:	be 00 24 40 00       	mov    $0x402400,%esi               ; string *p = 0x402400
  ; gdb bomb
  ; (gdb) x/s 0x402400
  ; 0x402400:       "Border relations with Canada have never been better."
  400ee9:	e8 4a 04 00 00       	callq  401338 <strings_not_equal>   ; res = strings_not_equal(input ,*p)
  400eee:	85 c0                	test   %eax,%eax
  400ef0:	74 05                	je     400ef7 <phase_1+0x17>        ; if (res == 0)  success
  ; not equal -> res == 1
  ; equal -> res == 0
  400ef2:	e8 43 05 00 00       	callq  40143a <explode_bomb>        ; else  fail
  400ef7:	48 83 c4 08          	add    $0x8,%rsp                    ; deallocate stak space
  400efb:	c3                   	retq   