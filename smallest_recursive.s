.data 
list: .word 10, -4, -3, -2, 1, 0, 6
len: 7

.text 

main:
la $t0, list # base address of list 
la $t1, len # address of length 
lw $t2, 0($t1) # length of list \240
addi $sp, $sp, -4  #\240push base address of list 
sw $t0, 0($sp) 
addi $sp, $sp, -4 # push length 
sw $t2, 0($sp) 
jal get_min
lw $t3, 0($sp) # pop return value min(list)
addi $sp, $sp, 4 
add $a0, $t3, $zero #\240printing value 
li $v0, 1
syscall
li $v0, 10 # exit 
syscall

get_min: 
lw $t9, 0($sp) # pop length 
addi $sp, $sp, 4 
lw $t8, 0($sp) # pop base address of list 
addi $sp, $sp, 4
ble $t9, $zero, EDGE # if length <= 0, return -1
addi $t4, $zero, 1 # comparison with 1 
beq $t9, $t4, BASE #\240if length = 1, return list[0]

# else:
addi $t7, $t8, 4 # address(list[1:])
addi $t6, $t9, -1 # length - 1
addi $sp, $sp, -4 
sw $ra, 0($sp) # push return address
addi $sp, $sp, -4 
sw $t8, 0($sp) #\240push address(list[0])
addi $sp, $sp, -4 
sw $t7, 0($sp) # push address(list[1])
addi $sp, $sp, -4
sw $t6, 0($sp) # push length - 1
jal get_min   
lw $s0, 0($sp) # get_min(list[1:])
addi $sp, $sp, 4
lw $s1, 0($sp) # address(list[0])
addi $sp, $sp, 4 
lw $s2, 0($s1) # list[0]

lw $ra, 0($sp) # return address
addi $sp, $sp, 4
ble $s2, $s0, FIRST # list[0] <= get_min(list[1:])
# return get_min(list[1:])
addi $sp, $sp, -4 
sw $s0, 0($sp) 
jr $ra

FIRST: # return list[0]
addi $sp, $sp, -4 
sw $s2, 0($sp) 
jr $ra

EDGE:
addi $v0, $zero, -1 # return -1 
addi $sp, $sp, -4 # push return value -1 
sw $v0, 0($sp) 
jr $ra 

BASE: 
lw $v0, 0($t8) #\240list[0]
addi $sp, $sp, -4 # push return value list[0]
sw $v0, 0($sp) 
jr $ra 


