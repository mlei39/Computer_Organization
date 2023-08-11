;;=============================================================
;;  CS 2110 - Spring 2023
;;  Homework 6 - Insertion Sort
;;=============================================================
;;  Name: Minkun Lei
;;============================================================

;;  In this file, you must implement the 'INSERTION_SORT' subroutine.

;;  Little reminder from your friendly neighborhood 2110 TA staff: don't run
;;  this directly by pressing 'Run' in complx, since there is nothing put at
;;  address x3000. Instead, call the subroutine by doing the following steps:
;;      * 'Debug' -> 'Simulate Subroutine Call'
;;      * Call the subroutine at the 'INSERTION_SORT' label
;;      * Add the [arr (addr), length] params separated by a comma (,) 
;;        (e.g. x4000, 5)
;;      * Proceed to run, step, add breakpoints, etc.
;;      * INSERTION_SORT is an in-place algorithm, so if you go to the address
;;        of the array by going to 'View' -> 'Goto Address' -> 'Address of
;;        the Array', you should see the array (at x4000) successfully 
;;        sorted after running the program (e.g [2,3,1,1,6] -> [1,1,2,3,6])

;;  If you would like to setup a replay string (trace an autograder error),
;;  go to 'Test' -> 'Setup Replay String' -> paste the string (everything
;;  between the apostrophes (')) excluding the initial " b' ". If you are 
;;  using the Docker container, you may need to use the clipboard (found
;;  on the left panel) first to transfer your local copied string over.

.orig x3000
    ;; You do not need to write anything here
    HALT


INSERTION_SORT ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the INSERTION_SORT subroutine here!

;;  Build
    ADD R6, R6, #-4     ;; Make space for RV, RA, old FP, LV1
    STR R7, R6, #2      ;; Save RA
    STR R5, R6, #1      ;; Save old FP
    ADD R5, R6, #0      ;; Assign new FP to location of LV1
    ADD R6, R6, #-5     ;; Make space for 1 local variables
    STR R0, R6, #0      ;; Save R0
    STR R1, R6, #1      ;; Save R1
    STR R2, R6, #2      ;; Save R2
    STR R3, R6, #3      ;; Save R3
    STR R4, R6, #4      ;; Save R4

;;  INSERTION_SORT(int[] arr (addr), int length)
    LDR R0, R5, #4          ; R0 = arr
    LDR R1, R5, #5          ; R1 = length

;;      if (length <= 1)
    ADD R4, R1, #-1
    BRp ELSE1

;;        return;
    ;;  TEAR
    LDR R0, R6, #0      ;; Restore R0
    LDR R1, R6, #1      ;; Restore R1
    LDR R2, R6, #2      ;; Restore R2
    LDR R3, R6, #3      ;; Restore R3
    LDR R4, R6, #4      ;; Restore R4
    ADD R6, R5, #0      ;; Pop off all registers R0-R4, and LVs except the first LV
    LDR R5, R6, #1      ;; Restore old FP
    LDR R7, R6, #2      ;; Restore RA
    ADD R6, R6, #3      ;; Pop off LV1, old FP, RA 
    ;; R6 now conveniently points at RV, ready for caller to retrieve ;;

    RET
    
    ELSE1 NOP
;;  
;;      INSERTION_SORT(arr, length - 1);
    ADD R6, R6, #-1
    ADD R4, R1, #-1
    STR R4, R6, #0
    ADD R6, R6, #-1
    STR R0, R6, #0
    JSR INSERTION_SORT
    ADD R6, R6, 3

;;  
;;      int last_element = arr[length - 1];
    ADD R4, R1, #-1
    ADD R4, R4, R0
    LDR R2, R4, #0          ; R2 = last_element

;;      int n = length - 2;
    ADD R3, R1, #-2         ; R3 = n = length - 2

;;  
;;      while (n >= 0 && arr[n] > last_element)
    WHILE
    ADD R3, R3, #0
    BRn END1
    ADD R4, R0, R3
    LDR R4, R4, #0
    NOT R1, R2              ; R1 = temp
    ADD R1, R1, #1
    ADD R4, R4, R1
    BRnz END1

;;          arr[n + 1] = arr[n];
    ADD R4, R0, R3          ; R4 = arr[n] add
    ADD R1, R4, #1          ; R1 = arr[n+1] add
    LDR R4, R4, #0          ; R4 = arr[n] val
    STR R4, R1, #0

;;          n--;
    ADD R3, R3, #-1
    BR WHILE

;;  
;;      arr[n + 1] = last_element;
    END1
    ADD R1, R0, R3          ; R1 = arr[n] add
    ADD R1, R1, #1          ; R1 = arr[n+1] add
    STR R2, R1, #0

;;  TEAR
    LDR R0, R6, #0      ;; Restore R0
    LDR R1, R6, #1      ;; Restore R1
    LDR R2, R6, #2      ;; Restore R2
    LDR R3, R6, #3      ;; Restore R3
    LDR R4, R6, #4      ;; Restore R4
    ADD R6, R5, #0      ;; Pop off all registers R0-R4, and LVs except the first LV
    LDR R5, R6, #1      ;; Restore old FP
    LDR R7, R6, #2      ;; Restore RA
    ADD R6, R6, #3      ;; Pop off LV1, old FP, RA 
    ;; R6 now conveniently points at RV, ready for caller to retrieve ;;

    RET

;; Needed to Simulate Subroutine Call in Complx
STACK .fill xF000
.end

.orig x4000	;; Array : You can change these values for debugging!
    .fill 2
    .fill 3
    .fill 1
    .fill 1
    .fill 6
.end