# This example demonstrates an implementation of  Multiply two polynomials with integer coefficients, 
# and find the sum of all coefficients of multiplication polynomial
# We provided three strings in global for simplify.
# The ouput of test pattern 1 should be => Product polynomial is: 5 + 10x^1 + 30x^2 + 26x^3 + 52x^4 + 24x^5
# The ouput of test pattern 2 should be => Product polynomial is: 1 + 3x^1 + 9x^2 + 15x^3 + 29x^4 + 43x^5 + 20x^6
# Reference link : https://www.geeksforgeeks.org/multiply-two-polynomials-2/

.data
.align 4
# test pattern 1
# polynomialA: .word 5, 0, 10, 6
# polynomialB: .word 1, 2, 4
# ASize: .word 4
# BSize: .word 3
# test pattern 2
polynomialA: .word 1, 3, 7, 4
polynomialB: .word 1, 0, 2, 5
ASize: .word 4
BSize: .word 4
str1: .string "Product polynomial is "
str2: .string "x^"
str3: .string " + "

.text
.global _start
# Start coding in the section below, don't change the values above #
_start:
    la t0, polynomialA  # loading address
    la t1, polynomialB
    lw a0, ASize        # loading size
    lw a1, BSize
    add a2, a0, a1    
    
    mv s11, a2      # move the degree to s11

    addi a3, a3, 4
    
    sub a4, a0, a1  # len diff
    
    la a0, str1
    li a7, 4
    ecall     
    
    bne a4, zero, diff   # for checking the lenght of two polynomials
    
    jal multiply
    jal print
    
    j end
    
multiply:
    sub sp, sp, a2   # pop 7 positions to store a0 - a7 and return address
    sw ra, 0(sp)     # return address
    
    lw s1, 0(t0)     # for polynomial 1
    lw s2, 4(t0)
    lw s3, 8(t0)
    lw s4, 12(t0)
     
    lw s5, 0(t1)     # for polynomial 2
    lw s6, 4(t1)
    lw s7, 8(t1)
    lw s8, 12(t1)
    
    mul a0, s1, s5   # deg 0 
    sw  a0, 4(sp) 
    mul a1, s1, s6   # deg 1
    mul a2, s2, s5  
    add a1, a1, a2 
    sw  a1, 8(sp)
    mul a2, s1, s7   # deg 2
    mul a3, s2, s6
    add a2, a2, a3
    mul a3, s3, s5
    add a2, a2, a3
    sw  a2, 12(sp)
    mul a3, s1, s8   # deg 3
    mul a4, s2, s7
    add a3, a3, a4
    mul a4, s3, s6
    mul a5, s4, s5
    add a4, a4, a5
    add a3, a3, a4
    sw  a3, 16(sp)
    mul a4, s2, s8   # deg 4
    mul a5, s3, s7
    add a4, a4, a5
    mul a5, s4, s6
    add a4, a4, a5  
    sw  a4, 20(sp)
    mul a5, s3, s8   # deg 5
    mul a6, s4, s7  
    add a5, a5, a6 
    sw  a5, 24(sp)
    mul a6, s4, s8   # deg 6
    sw  a6, 28(sp)
    jr x1

diff:                # for checking the lenght of two polynomials
    mul a5, a3, a1   # a3 = 12
    add a3, a5, t1
    sw zero, 0(a3) 
    jal multiply    

print:
    addi sp, sp, 4    # where to start pop stack
    addi a1, zero, 1  # index
    addi s11, s11, -1   # termination index
    li a7, 1
    ecall 
    
    loop:
        addi sp, sp, 4  # next element to pop
        
        la a0, str3  # "+" 
        li a7, 4
        ecall
        
        lw a0, 0(sp) # "coefficient"
        li a7, 1
        ecall
        
        la a0, str2  # "x"
        li a7, 4
        ecall 
        
        li a7, 1     # "power of deg"
        mv a0, a1
        ecall
        
        addi a1, a1, 1  # increment the element by 1
        bne a1, s11, loop
        
end: nop


    





