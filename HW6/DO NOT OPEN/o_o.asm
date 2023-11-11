   # Вычисление длины для пустой строки
    la      a0 empty_test_str
    li      a1 BUF_SIZE
    jal     strcpy
    # Вывод счетчика
    li      a7 1
    ecall
    # Перевод строки
    li      a0 '\n'
    li      a7 11
    ecall

    # Вычисление длины для короткой	строки
    la      a0 short_test_str
    li      a1 BUF_SIZE
    jal     strcpy
    # Вывод счетчика
    li      a7 1
    ecall
    # Перевод строки
    li      a0 '\n'
    li      a7 11
    ecall

    # Вычисление длины для длинной	строки
    la      a0 long_test_str
    li      a1 BUF_SIZE
    jal     strcpy
    # Вывод счетчика
    li      a7 1
    ecall
    # Перевод строки
    li      a0 '\n'
    li      a7 11
    ecall

    # Завершение программы
    li      a7 10
    ecall
