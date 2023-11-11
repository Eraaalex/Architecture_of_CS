.include "macrolib.asm"
.globl strcpy
.data
error_message: .asciz "!Error: line is too long, but part of string was copied in buffer\n"

.text
strcpy:
str_copy:
    li t0 0        
loop:
    lb      t1 (a0)         # Load the initial string symbol 
    sb      t1, 0(a2)       # Store the symbol in the destination string
    beqz    t1 end
    addi    t0 t0 1		# Limit counter
    addi    a0 a0 1		# Next symbol for initial string
    addi    a2 a2 1		# Next sybol for copied string
    bge     t0 a1 overflow      # error when buffer size is exceeded
    b       loop
end:
    ret
overflow:
    print_saved_string(error_message)
    addi    a2 a2 -1		# Previous symbol
    sb      zero, 0(a2)       # Store the last symbol in the destination string
    ret
