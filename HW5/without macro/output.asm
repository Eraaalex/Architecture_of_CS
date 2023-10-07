.include "macrolib.s"
.global output_array

.text
output_array:
        print_str("Output array: \n")
out:       lw      a0 (t0)         # 
        print_int (a0)
        print_str("\n")
        addi    t0 t0 4
        addi    t3 t3 -1    
        bnez    t3 out          
       print_str("\n")
    ret





