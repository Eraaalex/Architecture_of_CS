.include "macrolib.asm"
   #BUF_SIZE 10
.data
buf:    .space BUF_SIZE     # Buffer for initial string
buf_: .space BUF_SIZE    # Buffer for copied string
empty_test_str:	.asciz ""		 
short_test_str:	.asciz "Hello!"		
long_test_str:	.asciz "I am long for BUF_SIZE"	
.text

.globl main     
main:

# Input test:
    la 	    a2 buf_ # new copied string
    print_str("Input string:")
    # Input string
    la		a0 buf
        li      a1 BUF_SIZE
        li      a7 8
		ecall
    strcpy(a0, a2) # macro for copy string into buf_ allocated memory
    print_saved_string(buf_)
 # Default tests
 
 # Empty:
    la 	    a2 buf_ # new copied string
    la a0  empty_test_str
    strcpy(a0, a2) # macro for copy string into buf_ adrress
    print_saved_string(buf_)
    print_str("\n---------------------------\n")
# Correct string:
    la 	    a2 buf_ # new copied string
    la a0  short_test_str
    strcpy(a0, a2) # macro for copy string into buf_ adrress
    print_saved_string(buf_)
    print_str("\n---------------------------\n")
# Incorrect string (too long):
    la 	    a2 buf_ # new copied string
    la a0  long_test_str
    strcpy(buf, buf_) # macro for copy string into buf_ adrress
    print_saved_string(buf_)
    print_str("\n---------------------------\n")
	   
exit:
    li      a7 10
    ecall

 
