.include "macrolib.s"
.global input_array
.text   
       
.macro input_array_macro (%base_address), (%array_size)
    print_str("Input array: \n")
in: read_int_a0
    mv t2, a0               # Input the next element of the array
    sw t2, (%base_address)  # Store the element at the current address
    addi %base_address, %base_address, 4  # Move to the next address
    addi %array_size, %array_size, -1         # Decrement the loop counter
    bnez %array_size, in             # Branch if not zero, continue the loop
    print_str("\n")
.end_macro

.text
input_array:
    input_array_macro t0, t3  # Assuming array size is 10, adjust it according to your requirement
    ret




