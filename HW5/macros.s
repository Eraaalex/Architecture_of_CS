.macro input_array_macro
   jal input_array
.end_macro

.macro output_array_macro 
    jal output_array
.end_macro

.macro sum_counter_macro 
    jal sum_counter
.end_macro

.macro init_start_values
       lw t3 n                  
       la t0 array             
       lw t5 sum
.end_macro

.macro check_size
	li      a1 10           # Max array size 
        blez    t3 error           # if size < 1
        bgt     t3 a1 error      # if size > 10
.end_macro
