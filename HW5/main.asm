
.include "macrolib.s"

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
       mv      t3 a0           # Сохраняем результат в t3 (это n)
       li      t4 10           # Размер массива
       blez t3 error           # Ошибка, если меньше 1
       bgt     t3 t4 error      # Ошибка, если больше 10
       la	t4 n		# Адрес n в t4
       sw	t3 (t4)		# Загрузка n в память на хранение
       la t0 array
       jal input_array
       lw t3 n                  # Число элементов массива
       la t0 array             # указатель на начало массива
	jal output_array
        lw t3 n                  # Число элементов массива
       la t0 array             # указатель на начало массива
       lw t5 sum
       jal sum_counter
       lw t6 n
       exit
error: 
       print_str("incorrect n!\n")
       exit
	
	
	
	
