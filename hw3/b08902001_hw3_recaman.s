.globl __start

recaman:
    addi  sp, sp, -8                         # sp -= 8
    sw    s0, 0(sp)                          # store s0 to stack
    sw    ra, 4(sp)                          # store ra to stack
    beq   a0, x0, add_to_seq                 # if n == 0, goto add_to_seq
    mv    s0, a0                             # s0 = n
    addi  a0, a0, -1                         # n -= 1
    jal   ra, recaman                        # recaman(n - 1, seq, seq_len)
    mv    t0, a0                             # t0(now n) = recaman(n - 1, seq, seq_len)
    sub   t1, t0, s0                         # t1(now a) = t0 - n
    add   t2, t0, s0                         # t2(now b) = t0 + n
    mv    a0, t2                             # a0(now res) = b
    ble   t1, x0, add_to_seq                 # if a <= 0, then goto add_to_seq
    mv    s0, x0                             # s0(now i) = 0
recaman_loop:
    slli  t3, s0, 2                          # t3 = i * 4
    add   t3, t3, a1                         # t3 = seq + t3
    lw    t0, 0(t3)                          # t0 = seq[i]
    beq   t0, t1, add_to_seq                 # if seq[i] == a, then goto add_to_seq
    lw    t0, 0(a2)                          # t0 = *seq_len
    mv    t3, s0                             # t3 = i
    addi  s0, s0, 1                          # ++i
    blt   t3, t0, recaman_loop               # if t3 > *seq_len, goto recaman_loop
    mv    a0, t1                             # res = a
add_to_seq:
    lw    t0, 0(a2)                          # t0 = *seq_len
    slli  t0, t0, 2                          # t0 *= 4
    add   t1, t0, a1                         # t1 = t0 + seq
    sw    a0, 0(t1)                          # seq[*seq_len] = res
    lw    t0, 0(a2)                          # t0 = *seq_len
    addi  t0, t0, 1                          # t0 += 1
    sw    t0, 0(a2)                          # *seq_len = t0
    lw    ra, 4(sp)                          # restore ra from stack
    lw    s0, 0(sp)                          # restore s0 from stack
    addi  sp, sp, 8                          # sp += 8
    jalr  x0, 0(ra)							 # return
    
    
.text
__start:
    # read input to a0
    li    a0, 5                              # a0 = 5
    ecall                                    # syscall 5 (readInt()) (a0 = n)
    li    a1, 205                            # a1 = 205
    slli  a1, a1, 2                          # a1 *= 4
    sub   sp, sp, a1                         # sp -= a1 (int seq[205])
    addi  sp, sp, -4                         # sp -= 4 (int seq_len)
    addi  a1, sp, 4                          # a1 = seq
    mv    a2, sp                             # a2 = &seq_len

    # call function
    jal   ra, recaman                        # recaman(s0)
    # print result
    mv    a1, a0                             # a1 = a0
    li    a0, 1                              # a0 = 1
    ecall                                    # syscall 1 (printInt(a1))
    # exit program
    li    a0, 10                             # a0 = 10
    ecall                                    # syscall 10 (exit())
