   	li      a7 5        # ��������� ����� �5 � ������ ���������� �����
        ecall               # ��������� � � �������� a0
        mv      t0 a0       # ��������� ��������� � t0
        ecall               # ������� a7 �� �������, ��� �� ��������� �����
        add     a0 t0 a0    # ���������� �� ������� ����� ������
        li      a7 1        # ��������� ����� �1 � ������� ���������� �����
        ecall
        li      a7 10       # ��������� ����� �10 � ������� ���������
        ecall