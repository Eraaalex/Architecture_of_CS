.include "macrolib.s"
.global sum_counter

.text
sum_counter:
	li a4 0
sum_loop:
       lw  a0, 0(t0)
       mv t6 t5                # Save sum before add element 
       add t5 t5 a0
       addi t0 t0 4
       addi t3 t3 -1
       addi a4 a4 1
check_overflow:           
       blt t5 t6 check_overflow_1   
       blt t6 t5 check_overflow_2  
       bnez t3 sum_loop
check_overflow_1:
	bgtz a0 overflow
	bnez t3 sum_loop
	j output_sum
check_overflow_2:
	bltz a0 overflow
	bnez t3 sum_loop
	j output_sum
output_sum:       
       print_str("Sum = ")
        print_int(t5)
       print_str("\n----------------\n")
       ret
overflow:
	print_str("Overflow! Last sum = ")
        print_int(t6)
	print_str("\n")
        print_str("Number of elements in sum = ")
        addi a4 a4 -1
        print_int(a4)
        print_str("\n----------------\n")
        ret