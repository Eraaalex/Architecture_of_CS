.include "macrolib.s"
.global input_array
.text   
       
input_array:
       print_str("Input array: \n")
in:       read_int_a0
       mv t2 a0               
       sw t2 (t0)
       addi t0 t0 4
       addi t3 t3 -1
       bnez t3 in
       print_str("\n")
       ret



