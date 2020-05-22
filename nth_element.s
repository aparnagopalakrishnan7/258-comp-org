.data 
n: .word 4
len: .word 5
list: .word -4, 6, 7, -2, 1

.text 
main: 
la $t9, n 
lw $t8, 0($t9) #\240n
addi $sp, $sp, -4 
sw $t8, 0($sp) 
la $t0, len # address of len 
la $t1, list # base address of list 
lw $t2, 0($t0) # length of list 
jal get_n
add $t3, $v0, $zero #\240return value here 
add $a0, $t3, $zero # printing 
li $v0, 1 
syscall
li $v0, 10 
syscall

# returns nth word of the array 'list' which has len words 
get_n:
# EDGE CASES
lw $a0, 0($sp) # n
ble $a0, $zero, EDGE # if n <= 0, return -1
addi $t3, $t2, 1 # len + 1 (for comparison in the next step) 
bge $a0, $t3, EDGE # if n => len + 1, return -1
add $t4, $zero, $zero #i = 0 (but indexing starts at 1)

LOOP: #\240don't need exit loop condition because we have already checked for those cases 
addi $t5, $t4, 1 # i + 1 (to account for indexing)
beq $t5, $a0, RETURN # if n = i + 1

UPDATE:
addi $t4, $t4, 1 # i++ 
j LOOP 
 
EDGE: 
addi $v0, $zero, -1 # change the reg here 
jr $ra

RETURN: 
sll $t4, $t4, 2 #\2404*i
add $t1, $t1, $t4 # base address + 4*i 
lw $v0, 0($t1) # get list[n]
jr $ra # return 









