   # ���������� ����� ��� ������ ������
    la      a0 empty_test_str
    li      a1 BUF_SIZE
    jal     strcpy
    # ����� ��������
    li      a7 1
    ecall
    # ������� ������
    li      a0 '\n'
    li      a7 11
    ecall

    # ���������� ����� ��� ��������	������
    la      a0 short_test_str
    li      a1 BUF_SIZE
    jal     strcpy
    # ����� ��������
    li      a7 1
    ecall
    # ������� ������
    li      a0 '\n'
    li      a7 11
    ecall

    # ���������� ����� ��� �������	������
    la      a0 long_test_str
    li      a1 BUF_SIZE
    jal     strcpy
    # ����� ��������
    li      a7 1
    ecall
    # ������� ������
    li      a0 '\n'
    li      a7 11
    ecall

    # ���������� ���������
    li      a7 10
    ecall
