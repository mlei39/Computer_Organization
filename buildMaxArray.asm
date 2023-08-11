;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - buildMaxArray
;;=============================================================
;; Name: Minkun Lei
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;

.orig x3000
	
	;int i = 0;
	AND R1, R1, #0

	;while (i < length) {
W1	LD R2, LENGTH
	NOT R2, R2
	ADD R2, R2, #1
	ADD R2, R1, R2
	BRzp ha
	
	;if (A[i] >= B[length - i - 1])
	LD R3, A
	ADD R3, R3, R1
	LDR R3, R3, #0

	NOT R4, R1
	LD R2, LENGTH
	ADD R2, R4, R2
	LD R4, B
	ADD R4, R4, R2
	LDR R4, R4, #0

	NOT R4, R4
	ADD R4, R4, #1
	ADD R4, R3, R4
	BRn el

	;{C[i] = 1};
	LD R3, C
	ADD R3, R3, R1
	AND R4, R4, #0
	ADD R4, R4, #1
	STR R4, R3, #0
	BR inc

	;else {C[i] = 0}
el	LD R3, C
	ADD R3, R3, R1
	AND R4, R4, #0
	STR R4, R3, #0

	;i++
inc	ADD R1, R1, #1

	;}
	BR W1
ha  NOP

	HALT


;; Do not change these addresses! 
;; We populate A and B and reserve space for C at these specific addresses in the orig statements below.
A 		.fill x3200		
B 		.fill x3300		
C 		.fill x3400		
LENGTH 	.fill 3			;; Change this value if you decide to increase the size of the arrays below.
.end

;; Do not change any of the .orig lines!
;; If you decide to add more values for debugging, make sure to adjust LENGTH and .blkw 3 accordingly.
.orig x3200				;; Array A : Feel free to change or add values for debugging.
	.fill -2
	.fill 2
	.fill 1
.end

.orig x3300				;; Array B : Feel free change or add values for debugging.
	.fill 1
	.fill 0
	.fill 3
.end

.orig x3400
	.blkw 3				;; Array C: Make sure to increase block size if you've added more values to Arrays A and B!
.end