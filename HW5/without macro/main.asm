.include "macrolib.s"
.global main

.data
n: .word 0
sum: .word 0
array: .space 40

.macro init_start_values
       lw t3 n                  # Число элементов массива
       la t0 array             # указатель на начало массива
       lw t5 sum
.end_macro

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
       jal input_array
       init_start_values
	jal output_array
       init_start_values
       jal sum_counter
       lw t6 n
       exit
error: 
       print_str("incorrect n!\n")
       exit
	
	
	
	
