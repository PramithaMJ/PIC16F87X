; ########## READ SWITCHES PROGRAM 
; TITLE: "READ SWITCHES"
; DEVICE: PIC16F877 (40-pin, 10MHz)
; FUNCTION: Read switches connected to PORTA and store in memory

    LIST    P=16F877                ; Set PIC model
    INCLUDE <P16F877.INC>           ; Load register definitions

; --- Define Bank Switching Macros ---
BANK0   MACRO
        BCF STATUS, RP0             ; RP0 = 0
        BCF STATUS, RP1             ; RP1 = 0 --> BANK 0
        ENDM

BANK1   MACRO
        BSF STATUS, RP0             ; RP0 = 1
        BCF STATUS, RP1             ; RP1 = 0 --> BANK 1
        ENDM

BANK2   MACRO
        BCF STATUS, RP0             ; RP0 = 0
        BSF STATUS, RP1             ; RP1 = 1 --> BANK 2
        ENDM

BANK3   MACRO
        BSF STATUS, RP0             ; RP0 = 1
        BSF STATUS, RP1             ; RP1 = 1 --> BANK 3
        ENDM

; --- Memory Location to Store Switch Data ---
STOREDATA EQU 0x20                  ; 0x20 is a general-purpose RAM location

; --- Program Start ---
    ORG 0x00
    NOP                             ; No operation (safe first instruction)
    GOTO START                      ; Jump to main program

; --- Main Program Starts ---
    ORG 0x20

START
    CALL INITP                      ; Initialize PORTA for input

REPEAT
    MOVF PORTA, W                   ; Move contents of PORTA into WREG
    MOVWF STOREDATA                 ; Save WREG value into STOREDATA memory
    GOTO REPEAT                     ; Repeat forever

; --- Subroutine: Initialize PORTA ---
INITP
    BANK1                            ; Switch to Bank 1
    MOVLW 0x06                       ; Make PORTA pins as Digital I/O (disable analog)
    MOVWF ADCON1                     ; Configure ADCON1 register
    MOVLW 0xFF                       ; WREG = 0xFF (all 1s)
    MOVWF TRISA                      ; Make all PORTA pins as input (TRISA=1 means input)
    BANK0                            ; Back to Bank 0
    RETURN                           ; Return to main program

    END                              ; End of program
