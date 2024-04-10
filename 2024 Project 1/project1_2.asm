.data
input: .asciiz "input an integer: "

.text
.globl main

main:
	li        $v0, 4          # prompt input
	la        $a0, input	  # load input into $a0
	syscall                   # print prompt message
	
	li        $v0, 5          # get input
	syscall
	move      $t0, $v0        # store input in $t0, this is m
	
	li        $v0, 4          # prompt input
	la        $a0, input	  # load input into $a0
	syscall
	
	li        $v0, 5          # get input
	syscall
	move      $t1, $v0        # store input in $t1, this is n
	
	move      $a0, $t0		  #move $t0(=m) to $a0 
	move      $a1, $t1		  #move $t1(=n) to $a1
	jal       func			  # jump to func
	move      $a0, $v0		  # move $v0(answer) to $a0

	li        $v0, 1          # print number (stored in $a0)
	syscall
	
	li        $v0, 10         # exit program	
	syscall

func:
	### Write your code here, rereferring below instructions.
	### Result of your function must be stored in $v0, before returning.
	addi 	  $sp, $sp, -12   # add 3 rooms(4*3) for ackerman function
	sw		  $ra, 0($sp)	  # store $ra into 0($sp), $ra = return address
	sw		  $a0, 4($sp)	  # store $a0 into 4($sp), $a0 = m
	sw		  $a1, 8($sp)     # store $a1 into 8($sp), $a1 = n

	beq		  $a0, $zero, case_one	# if $a0(m) == 0, go to case_one
	beq 	  $a1, $zero, case_two	# if $a1(n) == 0, go to case_two

	addi 	  $a1, $a1, -1	  # case_three, n -= 1
	jal		  func			  # A(m,n-1), recursion
	move	  $a1, $v0	  	  # move $v0 into $a1(n)

	lw		  $a0, 4($sp)	  # load 4($sp)(m at prev step) into $a0
	addi      $a0, $a0, -1    # m -= 1
	jal		  func			  # A(m-1, A(m,n-1)), recursion
	j		  end

case_one:
	lw		  $a1, 8($sp)	  # load 8($sp)(n at prev step) into $a1
	addi	  $v0, $a1, 1	  # $v0 = $a1 + 1
	j		  end

case_two:
	lw		 $a0, 4($sp)	  # load 4($sp)(m at prev step) into $a0
	addi	 $a0, $a0, -1	  # m -= 1
	li		 $a1, 1			  # n = 1
	jal		 func			  # A(m-1, 1), recursion

end:
	lw		  $ra, 0($sp)	  # load 0($sp) into $ra
	lw		  $a0, 4($sp)	  # reload m
	lw		  $a1, 8($sp)	  # reload n
	addi	  $sp, $sp, 12	  # $sp -=12, delete 3 stack rooms
	jr		  $ra			  # return to $ra