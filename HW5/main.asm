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
       read_int(t3)
       check_size
       la	t4 n		# Adress n in t4
       sw	t3 (t4)		# save n
       la t0 array              # init t0 on start of array
       input_array_macro        #  input array
       init_start_values
       output_array_macro       #  output array
       init_start_values
       sum_counter_macro        # find sum and print it
       exit
error: 
       print_str("incorrect n!\n")
       exit
	
	
	
	
