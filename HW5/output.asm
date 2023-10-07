.include "macrolib.s"
.global output_array

.text
.macro output_array_macro (%base_address), (%array_size)
    print_str("Output array: \n")
out: lw a0, (%base_address)   # Load the next element from the array
     print_int(a0)             # Print the element
     print_str("\n")
     addi %base_address, %base_address, 4  # Move to the next address
     addi %array_size, %array_size, -1           # Decrement the loop counter
     bnez %array_size, out              # If more elements are left, continue the loop
     print_str("\n")
.end_macro

.text
output_array:
    output_array_macro t0, t3  # Assuming array size is 10, adjust it according to your requirement
    ret





