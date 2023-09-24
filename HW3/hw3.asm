.data
sep:    .asciz  "--------\n"    # Строка-разделитель (с \n и нулём в конце)
prompt: .asciz  "Input n (0 < n < 11):  "  
warning:  .asciz  "incorrect n!\n"
sum_overflow:  .asciz  "Overflow! Last sum = "
ln: .asciz "\n"
number_emements_prompt: .asciz "Number of elements in sum = "
first_element_prompt: .asciz "Input first element: "
sum_prompt: .asciz "Sum = "
even_number: .asciz "Number of even = "
odd_number: .asciz "Number of odd = "
n: .word 0
sum: .word 0
array: .space 40

.text
in:
       la a0, prompt      # Подсказка для ввода числа элементов массива
       li a7, 4           
       ecall
       li      a7 5            # Системный вызов №5 — ввести десятичное число
       ecall
       mv      t3 a0           # Сохраняем результат в t3 (это n)
       blez t3 error           # Ошибка, если меньше 1
       li      t4 10           # Размер массива
       bgt     t3 t4 error      # Ошибка, если больше 10
       la	t4 n		# Адрес n в t4
       sw	t3 (t4)		# Загрузка n в память на хранение
            
       li t6, 0x7FFFFFFF
            
       la t0 array
fill:
       li a7, 5
       ecall
       mv t2 a0                # Ввод первого числа массива
       sw t2 (t0)
       addi t0 t0 4
       addi t3 t3 -1
       bnez t3 fill
       
       la      a0 sep          # Выведем строку-разделитель
       li      a7 4
       ecall
       
       lw t3 n                  # Число элементов массива
       la t0 array             # указатель на начало массива
       lw t5 sum
sum_loop:
        lw  a0, 0(t0)
       mv t6 t5                # сохраняем сумму до прибавления элемента
       add t5 t5 a0
       addi t0 t0 4
       addi t3 t3 -1
check_overflow:           
       blt t5 t6 check_overflow_1    # Проверка переполнения в пложительную сторону
       blt t6 t5 check_overflow_2    # Проверка переполнения в отрицательную сторону
       bnez t3 sum_loop
check_overflow_1:
	bgtz a0 overflow
	bnez t3 sum_loop
	j output_sum
check_overflow_2:
	bltz a0 overflow
	bnez t3 sum_loop
	j output_sum
output_sum:       
       la a0 sum_prompt      # Вывод подсказки для суммы
       li a7 4
       ecall
        mv  a0, t5           # Вывод  суммы
        li  a7, 1              
        ecall
       la a0 ln
       li      a7 4
       ecall
        j even_odd
overflow:
	la a0 sum_overflow   # Вывод суммы в случае переполнения
	li a7 4
	ecall

        mv  a0, t6            
        li  a7, 1              
        ecall
        
	la  a0, ln          
        li  a7, 4             
        ecall
        
        la a0 number_emements_prompt    # Вывод подсказки количества элементов суммы в случае переполнения
        li a7 4
        ecall
       
        lw t6 n                         # Подсчет и вывод количества элементов суммы в случае переполнения
        neg t3 t3
        add t3 t3 t6
        addi t3 t3 -1
        mv  a0, t3            
        li  a7, 1              
        ecall
        
        la  a0, ln          
        li  a7, 4             
        ecall
        

even_odd:
       lw t3 n              # Число элементов массива
       la t0 array          # указатель на начало массива
       
       li t5 0              # Количество нечетных
       li t6 0              # Количество четных 
       li t2 2
parity_loop:
        lw  a0, 0(t0)        # Считывание элемента массива
        rem t1 a0 t2
        addi t0 t0 4
        addi t3 t3 -1
        beqz t1 is_even      # Увеличение числа четных
        bnez t1 is_odd       # Увеличение числа нечетных
        bnez t3 parity_loop 
is_even:
	addi t6 t6 1
	bnez t3 parity_loop
	j output_parity
is_odd:	
	addi t5 t5 1
	bnez t3 parity_loop
	j output_parity
output_parity:
	la      a0 even_number          # Четные
       li      a7 4
       ecall
       
       mv  a0, t6            
        li  a7, 1              
        ecall
      
       
       la a0 ln
       li      a7 4
       ecall
       
       la a0 odd_number  # Нечетные
       li      a7 4
       ecall
       
       mv  a0, t5           
       li  a7, 1              
       ecall
       
       li a7 10
       ecall
error: 
       la a0 warning
       li a7 4
       ecall
       li a7 10
       ecall
	
	
	
	
