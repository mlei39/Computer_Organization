;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - modulus
;;=============================================================
;; Name: Minkun Lei
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;

.orig x3000
    ;; YOUR CODE HERE

    ;while (x >= mod) 
    LD R1, X
    LD R2, MOD
    NOT R2, R2
    ADD R2, R2, #1
W1  ADD R3, R1, R2
    BRn ha

    ;do: x -= mod
    ADD R1, R1, R2
    BR W1
ha  NOP

    ;mem[ANSWER] = x
    ST R1, ANSWER

    HALT

    ;; Feel free to change the below values for debugging. We will vary these values when testing your code.
    X      .fill 17 ;int x = 17
    MOD    .fill 5  ;int mod = 5   
    ANSWER .blkw 1

.end