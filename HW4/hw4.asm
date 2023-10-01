.data
max_value_promt:    .asciz  "Max value which the result of calculating the factorial is placed in a 32-bit word: "
ln:     .asciz  "\n"
.text
promt:
    la a0 max_value_promt
    li a7 4
    ecall
    li a0 1  # result
    li a1 1  # previous number
    li t1 1  # result of calculating the factorial (a0!)
    li t2 1  # number to determine upper bits
    jal fact
    li a7 1
    ecall
    la a0 ln
    li a7 4
    ecall
    li a7 10
    ecall
fact: 
    mv a0 a1
    addi a1 a1 1
    mulh t2 t1 a1
    mul t1 t1 a1
    beqz t2 fact
    ret 
      
    
    
    
