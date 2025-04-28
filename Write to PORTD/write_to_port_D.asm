; ########## WRITE_TO_PORTD.ASM 
; WRITTEN BY: PramithaMJ
; DATE: 2025-04-29
; DEVICE: PIC16F877 (40 PIN)
; RESONATOR: 10MHz
; WATCHDOG TIMER: DISABLED
; CODE PROTECTION: OFF

    TITLE: "Write to Port D"
    LIST    P=16F877        ; Tell assembler the PIC model
    INCLUDE <P16F877.INC>   ; Include definitions for this PIC

    ORG     0x00            ; Start at program memory address 0
    GOTO    START           ; Jump to START label

    ORG     0x20            ; Place program from address 0x20 (general purpose memory)

START
    CALL    INITP           ; Initialize ports first

REPEAT
    MOVLW   0x55            ; Load WREG with 55h (binary 01010101)
    MOVWF   PORTD           ; Write 55h to PORTD (alternate LEDs ON/OFF)
    GOTO    REPEAT          ; Infinite loop (repeat forever)

;--- Subroutine to Initialize Ports ---
INITP
    MOVLW   0x00            ; WREG = 00h
    MOVWF   TRISD           ; Make PORTD all outputs (TRISD = 0 means all output)
    RETURN                  ; Return from subroutine

END                         ; End of program
