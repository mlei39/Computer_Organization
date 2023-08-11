;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - octalStringToInt
;;=============================================================
;; Name: Minkun Lei
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.

.orig x3000


;   int value = 0
    AND R3, R3, #0

;   int i = 0
    AND R4, R4, #0

;   while (i < length)
W1  LD R1, OCTALSTRING
    LD R2, LENGTH
    NOT R2, R2
    ADD R2, R2, #1
    ADD R2, R2, R4
    BRzp e1

;      int leftShifts = 3
    AND R5, R5, #0
    ADD R5, R5, #3

;      while (leftShifts > 0)
W2  ADD R5, R5, #0
    BRnz e2

;          value += value
    ADD R3, R3, R3

;          leftShifts--
    ADD R5, R5, #-1
    BR W2

;      int digit = octalString[i] - 48;
e2  ADD R1, R1, R4
    LDR R1, R1, #0
    LD R6, ASCII
    ADD R6, R1, R6

;      value += digit
    ADD R3, R3, R6

;      i++
    ADD R4, R4, #1
    BR W1

;   mem[mem[RESULTADDR]] = value
e1  STI R3, RESULTADDR

    HALT
    
;; Do not change these values! 
;; Notice we wrote some values in hex this time. Maybe those values should be treated as addresses?
ASCII           .fill -48
OCTALSTRING     .fill x5000
LENGTH          .fill 4
RESULTADDR      .fill x4000
.end

.orig x5000                    ;;  Don't change the .orig statement
    .stringz "2110"            ;;  You can change this string for debugging!
.end
