.data 
len: .word 5
list: .word -4, 6, 7, -2, 1

.text 
main: 
la $t9, list # base address of list 
la $t8, len # address of length of list 
lw $t6, 0($t8) # length of list 
ble $t6, $zero, EDGE # if length of list is <= 0, return -1
lw $t5, 0($t9) # value of max = A[0]
add $t7, $zero, $zero # for loop counter i = 0 

LOOP: bge $t7, $t6, END # exit if i >= len of the list 
	sll $t0, $t7, 2  # offset = i*4
	add $t3, $t0, $t9 # address of A[i] = base address + i*4
	lw $t4, 0($t3) # A[i] = element at address of A[i]
	ble $t4, $t5, UPDATE #\240if A[i] > current max 
	move $t5, $t4 # reset current max = A[i]
	
UPDATE: addi $t7, $t7, 1 # i+=1
	j LOOP 
END: # return the max value 
move $v1, $t5 # return value 
add $a0, $v1, $zero  
li $v0, 1 #\240printing value
syscall 
li $v0, 10 
syscall 

EDGE: 
addi $v1, $zero, -1 # return value 
add $a0, $v1, $zero 
li $v0, 1 #\240printing value 
syscall 
li $v0, 10
syscall

