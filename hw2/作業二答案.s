.globl __start

.rodata
    division_by_zero: .string "division by zero"
    remainder_by_zero: .string "remainder by zero"
    operators: .word addition, substraction, multiplication, division, remainder, power, factorial

.text
__start:
    # read input to s0, s1, s2
    li a0, 5                              # a0 = 5
    ecall                                 # syscall 5 (readInt())
    mv s0, a0                             # s0 = a0

    li a0, 5                              # a0 = 5
    ecall                                 # syscall 5 (readInt())
    mv s1, a0                             # s1 = a0

    li a0, 5                              # a0 = 5
    ecall                                 # syscall 5 (readInt())
    mv s2, a0                             # s2 = a0

    # from Lecture_3-RISCV p.49
    # invalid input
    slt t0, s1, x0                        # t0 = s1 < 0
    bne t0, x0, exit                      # if (s1 < 0) then go to exit
    slti t0, s1, 7                        # t0 = s1 < 7
    beq t0, x0, exit                      # if (s1 >= 7) then go to exit

    # switch(s1)
    la t0, operators                      # load address of operator table to t0
    slli t1, s1, 2                        # t1 = s1 * 4 (1 word = 4 bytes)
    add t1, t1, t0                        # t1 += t0
    lw t2, 0(t1)                          # t2 = operators[s1]
    jalr x0, 0(t2)                        # jump to t2

addition:
    add s3, s0, s2                        # s3 = s0 + s2
    jal x0, output                        # jump to output

substraction:
    sub s3, s0, s2                        # s3 = s0 - s2
    jal x0, output                        # jump to output

multiplication:
    mul s3, s0, s2                        # s3 = s0 * s2
    jal x0, output                        # jump to output

division:
    beq s2, x0, division_by_zero_except   # if (s2 == 0) then go to division_by_zero_except
    div s3, s0, s2                        # s3 = s0 / s2
    jal x0, output                        # jump to output

remainder:
    beq s2, x0, remainder_by_zero_except  # if (s2 == 0) then go to remainder_by_zero_except
    rem s3, s0, s2                        # s3 = s0 % s2
    jal x0, output                        # jump to output

power:
    li s3, 1                              # s3 = 1
    blt s2, x0, exit                      # if (s2 < 0) then go to exit
    beq s2, x0, output                    # if (s2 == 0) then go to output
    mv t0, s2                             # t0 = s2
power_loop:
    mul s3, s3, s0                        # s3 *= s0
    addi t0, t0, -1                       # --t0
    bgt t0, x0, power_loop                # if (t0 > 0) then go to power_loop
    jal x0, output                        # jump to output
    

factorial:
    mv a0, s0                             # a0 = s0
    jal ra, _factorial                    # _factorial(s0)
    mv s3, a0                             # s3 = a0
    jal x0, output                        # jump to output

# from Lecture_3-RISCV p.61
_factorial:
    addi sp, sp, -8                       # sp -= 8
    sw ra, 4(sp)                          # store ra to stack
    sw a0, 0(sp)                          # store a0 to stack
    addi t0, a0, -1                       # t0 = a0 + -1
    bgt t0, x0, _factorial_cont           # if (a0 > 1) then go to _factorial_cont
    li a0, 1                              # a0 = 1
    addi sp, sp, 8                        # sp += 8
    jalr x0, 0(ra)                        # return
_factorial_cont:
    addi a0, a0, -1                       # --a0
    jal ra, _factorial                    # _factorial(a0 - 1)
    mv t1, a0                             # t1 = a0
    lw a0, 0(sp)                          # load a0 from stack
    lw ra, 4(sp)                          # load ra from stack
    addi sp, sp, 8                        # sp += 8
    mul a0, a0, t1                        # a0 *= t1
    jalr x0, 0(ra)                        # return

# output the result
output:
    li a0, 1                              # a0 = 1
    mv a1, s3                             # a1 = s3
    ecall                                 # syscall 1 (printInt(s3))

# exit program
exit:
    li a0, 10                             # a0 = 10
    ecall                                 # syscall 10 (exit())

division_by_zero_except:
    li a0, 4                              # a0 = 4
    la a1, division_by_zero               # load address of division_by_zero to a1
    ecall                                 # syscall 4 (printString(a1))
    jal x0, exit                          # jump to exit

remainder_by_zero_except:
    li a0, 4                              # a0 = 4 
    la a1, remainder_by_zero              # load address of remainder_by_zero to a1
    ecall                                 # syscall 4 (printString(a1))
    jal x0, exit                          # jump to exit
