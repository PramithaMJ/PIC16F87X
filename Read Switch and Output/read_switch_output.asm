; ########## READ SWITCHES AND OUTPUT PROGRAM 
; TITLE: "READ SWITCHES AND OUTPUT"
; DEVICE: PIC16F877
; FUNCTION: Read switches from PORTA and output to PORTD

    LIST    P=16F877                ; Set PIC model
    INCLUDE <P16F877.INC>           ; Load register definitions

; --- Define Bank Switching Macros ---
BANK0   MACRO
        BCF STATUS, RP0
        BCF STATUS, RP1             ; BANK 0
        ENDM

BANK1   MACRO
        BSF STATUS, RP0
        BCF STATUS, RP1             ; BANK 1
        ENDM

BANK2   MACRO
        BCF STATUS, RP0
        BSF STATUS, RP1             ; BANK 2
        ENDM

BANK3   MACRO
        BSF STATUS, RP0
        BSF STATUS, RP1             ; BANK 3
        ENDM

; --- Program Start ---
    ORG 0x00
    NOP                             ; No operation
    GOTO START                      ; Jump to main program

; --- Main Program Starts ---
    ORG 0x20

START
    CALL INITP                      ; Initialize ports

REPEAT
    MOVF PORTA, W                   ; Read input from PORTA into WREG
    MOVWF PORTD                     ; Output WREG to PORTD
    GOTO REPEAT                     ; Repeat forever

; --- Subroutine: Initialize Ports ---
INITP
    BANK1                            ; Switch to Bank 1
    MOVLW 0x06                       ; Set ADCON1 to make PORTA digital
    MOVWF ADCON1
    MOVLW 0xFF                       ; WREG = 0xFF (all 1s)
    MOVWF TRISA                      ; Make PORTA all INPUT
    CLRF TRISD                       ; Make PORTD all OUTPUT (clear TRISD)
    BANK0                            ; Back to Bank 0
    RETURN                           ; Return to main program

    END                              ; End of program
