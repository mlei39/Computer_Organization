;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - palindrome
;;=============================================================
;; Name: Minkun Lei
;;=============================================================

;;  NOTE: Let's decide to represent "true" as a 1 in memory and "false" as a 0 in memory.
;;
;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.

.orig x3000
	
;   String str = "aibohphobia";
	LD R1, STRING

;   boolean isPalindrome = true
	AND R2, R2, #0
	ADD R2, R2, #1

;   int length = 0;
	AND R3, R3, #0

;   while (str[length] != '\0')
W1	LD R1, STRING
	ADD R1, R1, R3
	LDR R1, R1, #0
	BRz e1

;		length++;
	ADD R3, R3, #1
	BR W1

;	int left = 0
e1	AND R4, R4, #0

;   int right = length - 1
	ADD R5, R3, #-1

;   while(left < right)
W2  NOT R3, R5
	ADD R3, R3, #1
	ADD R3, R3, R4
	BRzp e2

;		if (str[left] != str[right])
	LD R1, STRING
	ADD R3, R4, R1
	LDR R3, R3, #0
	ADD R1, R5, R1
	LDR R1, R1, #0
	NOT R1, R1
	ADD R1, R1, #1
	ADD R3, R1, R3
	BRz el

;			isPalindrome = false;
	AND R2, R2, #0

;			break;
	BR e2

;		left++;
el	ADD R4, R4, #1

;		right--;
	ADD R5, R5, #-1
	BR W2

;	mem[mem[ANSWERADDR]] = isPalindrome;
e2  STI R2, ANSWERADDR

	HALT

;; Do not change these values!
STRING	.fill x4004
ANSWERADDR 	.fill x5005
.end

;; Do not change any of the .orig lines!
.orig x4004				   
	.stringz "aibohphobia" ;; Feel free to change this string for debugging.
.end

.orig x5005
	ANSWER  .blkw 1
.end