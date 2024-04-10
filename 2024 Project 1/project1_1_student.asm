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

    jal       func
    move      $a0, $v0
    li        $v0, 1          # print number (stored in $a0)
    syscall

    li        $v0, 10         # exit program
    syscall

func:
    ### Write your code here, rereferring below instructions.
    ### Result of your function must be stored in $v0, before returning.

    lb        $t0, ($a0)      # (Load Byte) Load the first character of string to which $a0 points

    jr        $ra

