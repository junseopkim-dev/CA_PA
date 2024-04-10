.data
string: .asciiz "Computer Architecture"
input: .asciiz "input an integer: "

.text
.globl main

main:
    li        $v0, 4          # prompt input
    la        $a0, input
    syscall                   # print prompt message

    li        $v0, 5          # get input
    syscall
    move      $a1, $v0        # store input in $a1

    la        $a0, string     # $a0 points to beginning of string

    jal       func            # execute func
    move      $a0, $v0        # move v0 into a0, v0 has answer
    li        $v0, 1          # print number (stored in $a0)
    syscall

    li        $v0, 10         # exit program
    syscall

func:
    ### Write your code here, rereferring below instructions.
    ### Result of your function must be stored in $v0, before returning.
    li        $v0, 0          # set register v0 into 0

loop:
    lb        $t0, ($a0)      # (Load Byte) Load the first character of string to which $a0 points
    beq       $t0, $zero, end # if $t0 == 0, go to end
    beq       $t0, $a1, found # else if $t0 == $a1, go to found
    addi      $a0, $a0, 1     # $a0 += 1, move to next char
    j         loop            # jump back to loop

found:
    addi      $v0, $v0, 1     # $v0 += 1, add 1 when we found what we looking for.
    addi      $a0, $a0, 1     # $a0 += 1, move to next char
    j         loop            # jump back to loop

end:
    jr        $ra             # jump back to when it's called

