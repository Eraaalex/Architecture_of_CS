.include "macrolib.s"
.include "macros.s"
.global main

.data
n: .word 0
sum: .word 0
array: .space 40

.text
main: 
in:
       print_str ("Input n (0 < n < 11): ")
       read_int_a0
       mv      t3 a0           # Save n in t3 
       li      t4 10           # Max array size 
       blez t3 error           # if size < 1
       bgt     t3 t4 error      # if size > 10
       la	t4 n		# Adress n in t4
       sw	t3 (t4)		
       la t0 array
       input_array_macro t0 t3
       init_start_values
       output_array_macro t0 t3
       init_start_values
       sum_counter_macro t0 t3 t5
       exit
error: 
       print_str("incorrect n!\n")
       exit
	
	
	
	
