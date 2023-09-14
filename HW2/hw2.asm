.data    
    arg01:  .asciz "Input 1st number (dividend): "
    arg02:  .asciz "Input 2nd number (divider): "
    result: .asciz "Result = "
    remainder: .asciz "Remainder = "
    warning: .asciz "Division by 0 !"
    ln:     .asciz "\n"

.text
main:
    la a0 arg01		
    li a7 4
    ecall

    li a7 5             
    ecall
    mv t1 a0
    
    la 	a0 arg02	
    li 	a7 4       	
    ecall

    li  a7 5		
    ecall
    mv  t2 a0
    
    mv t4 t1
    mv t5 t2

    beqz t2 error
    bltz t1 change_sign_divisible
    j check_sign_divisor
change_sign_divisible:
    neg t1 t1
check_sign_divisor:
    bltz t2 change_sign_divisor
    j set_results
change_sign_divisor:
    neg t2 t2
set_results:
    blt t2 t1 division_loop
    j check_remainder_sign
division_loop:
    sub t1 t1 t2
    addi t0 t0 1
    blt t2 t1 division_loop
check_remainder_sign:
    bltz t4 set_remainder_sign
    j check_result_sign
set_remainder_sign:
    neg t1 t1
check_result_sign:
    bltz t5 is_positive_dividend
    bgtz t5 is_negative_dividend
    j output
is_positive_dividend:
    bgtz t4 set_result_sign
    j output
is_negative_dividend:
    bltz t4 set_result_sign
    j output
set_result_sign:
    neg t0 t0
output:
    la a0 result
    li a7 4
    ecall
    li  a7, 1 		# ��������� ����� �1 � ������� ���������� �����
    mv  a0, t0
    ecall
    
    la a0 ln
    li a7 4
    ecall
    
    la a0 remainder
    li a7 4
    ecall
    li  a7, 1 		# ��������� ����� �1 � ������� ���������� �����
    mv  a0, t1
    ecall
    j finish
error:
    la a0 warning
    li a7 4
    ecall
finish:
    li a7 10
    ecall
