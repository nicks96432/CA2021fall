.globl __start

fib:
    beq   a0, x0, fib_return                 # if n == 0, goto fib_return
    li    t0, 1                              # t0 = 1
    beq   a0, t0, fib_return                 # if n == 1, goto fib_return
    addi  sp, sp, -12                        # sp -= 12
    sw    s0, 0(sp)                          # store s0 to stack
    sw    s1, 4(sp)                          # store s1 to stack
    sw    ra, 8(sp)                          # store ra to stack
    mv    s0, a0                             # s0 = n
    addi  a0, a0, -1                         # a0 -= 1
    jal   ra, fib                            # fib(n - 1)
    mv    s1, a0                             # s1 = fib(n - 1)
    addi  a0, s0, -2                         # a0 = n - 2
    jal   ra, fib                            # fib(n - 2)
    add   a0, a0, s1                         # a0 = fib(n - 2) + fib(n - 1)
    lw    ra, 8(sp)                          # restore ra from stack
    lw    s1, 4(sp)                          # restore s1 from stack
    lw    s0, 0(sp)                          # restore s0 from stack
    addi  sp, sp, 12                         # sp += 12
fib_return:
    jalr  x0, 0(ra)                          # return

.text
__start:
    # read input to a0
    li    a0, 5                              # a0 = 5
    ecall                                    # syscall 5 (readInt())
    # call function
    jal   ra, fib                            # fib(s0)
    # print result
    mv    a1, a0                             # a1 = a0
    li    a0, 1                              # a0 = 1
    ecall                                    # syscall 1 (printInt(a1))
    # exit program
    li    a0, 10                             # a0 = 10
    ecall                                    # syscall 10 (exit())
