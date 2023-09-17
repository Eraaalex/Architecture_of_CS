.data    
    arg01:  .asciz "Input 1st number (dividend): "
    arg02:  .asciz "Input 2nd number (divider): "
    result: .asciz "Quitient = "
    remainder: .asciz "Remainder = "
    warning: .asciz "Division by 0 !"
    ln:     .asciz "\n"

.text
main:
    la a0 arg01		 # Подсказка ввода числа (делителя)
    li a7 4
    ecall

    li a7 5          # Ввод числа и сохранение в регистр t1
    ecall
    mv t1 a0
    
    la 	a0 arg02	 # Подсказка ввода числа (делимого)   
    li 	a7 4       	
    ecall

    li  a7 5		 # Ввод числа и сохранение в регистр t2
    ecall
    mv  t2 a0
    
    mv t4 t1         # Копии чисел, для учета знака ответа
    mv t5 t2

    beqz t2 error    # Проверка деления на 0
    bltz t1 change_sign_divisible     # Проверка делимого на отрицательность
    j check_sign_divisor        # Переход на проверку делителя на отрицательность
change_sign_divisible:
    neg t1 t1
check_sign_divisor:
    bltz t2 change_sign_divisor
    j set_results
change_sign_divisor:
    neg t2 t2
set_results:  
    ble t2 t1 division_loop   # Если t2 < t1 переход к цикличному "делению"
    j check_remainder_sign
division_loop:
    sub t1 t1 t2
    addi t0 t0 1
    ble t2 t1 division_loop
check_remainder_sign:         # Определение знаков результатов
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
set_result_sign:  # Изменение знакак частного, если t1, t2 разных знаков
    neg t0 t0
output:            # Вывод результата
    la a0 result
    li a7 4
    ecall
    li  a7, 1 		
    mv  a0, t0
    ecall
    
    la a0 ln
    li a7 4
    ecall
    
    la a0 remainder
    li a7 4
    ecall
    li  a7, 1 		
    mv  a0, t1
    ecall
    j finish
error:            # Обработка ошибки
    la a0 warning
    li a7 4
    ecall
finish:   
    li a7 10
    ecall