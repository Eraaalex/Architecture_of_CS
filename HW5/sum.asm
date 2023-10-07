.include "macrolib.s"
.global sum_counter

.macro sum_counter_macro (%base_address), (%array_size) %sum_value
    li a4 0
    sum_loop:
        lw a0, 0(%base_address)  # Load the next element from the array
        mv t6, %sum_value                # Save the sum before adding the element
        add %sum_value, %sum_value, a0           # Add the element to the sum
        addi %base_address,%base_address, 4  # Move to the next address
        addi %array_size, %array_size, -1          # Decrement the loop counter
	addi a4 a4 1
        check_overflow:
            blt %sum_value, t6, check_overflow_1  # Check overflow in the positive direction
            blt t6, %sum_value, check_overflow_2  # Check overflow in the negative direction
            bnez %array_size, sum_loop

        check_overflow_1:
            bgtz a0, overflow
            bnez %array_size, sum_loop
            j output_sum

        check_overflow_2:
            bltz a0, overflow
            bnez %array_size, sum_loop
            j output_sum
    output_sum:
        print_str("Sum = ")
        print_int(%sum_value)
        print_str("\n----------------\n")
        ret

    overflow:
        print_str("Overflow! Last sum = ")
        print_int(t6)
        print_str("\n")
        print_str("Number of elements in sum = ")
        addi a4, a4, -1
        print_int(a4)
        print_str("\n----------------\n")
        ret
.end_macro

.text
sum_counter:
    sum_counter_macro t0, t3 t5
    ret
