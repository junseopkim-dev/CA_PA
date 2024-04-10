.data
input: .asciiz "input an integer: "

.text
.globl main

main:
	li        $v0, 4          # prompt input
	la        $a0, input
	syscall                   # print prompt message
	
	li        $v0, 5          # get input
	syscall
	move      $t0, $v0        # store input in $t0
	
	li        $v0, 4          # prompt input
	la        $a0, input
	syscall
	
	li        $v0, 5          # get input
	syscall
	move      $t1, $v0        # store input in $t1
	
	move      $a0, $t0
	move      $a1, $t1
	jal       func
	move      $a0, $v0
	li        $v0, 1          # print number (stored in $a0)
	syscall
	
	li        $v0, 10         # exit program	
	syscall

func:
	### Write your code here, rereferring below instructions.
	### Result of your function must be stored in $v0, before returning.
