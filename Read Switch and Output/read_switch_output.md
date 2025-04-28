# 📜 Full Code :

```assembly
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
```

---

# 🧠 Now, Full **Line-by-Line Detailed Explanation**:

---

## 🔵 1. Title and Device Selection:

```assembly
LIST P=16F877
INCLUDE <P16F877.INC>
```
- **Tell assembler** which microcontroller you are using.
- **Load all register names** (PORTA, TRISA, STATUS, etc.).

✅ Without `INCLUDE`, the assembler won't recognize PIC registers.

---

## 🔵 2. Bank Switching Macros:

```assembly
BANK0, BANK1, BANK2, BANK3
```
- Banks are **memory areas** where registers are grouped.
- Bank switching is required to **access** TRIS and ADCON1.

✅ RP1 and RP0 bits in STATUS register select banks.

---

## 🔵 3. ORG 0x00 — Start Program:

```assembly
ORG 0x00
NOP
GOTO START
```
- When PIC resets, it starts from 0x00.
- `NOP`: No operation — safe first instruction.
- `GOTO START`: Jump to program starting at 0x20.

---

## 🔵 4. ORG 0x20 — Program Code Area:

```assembly
ORG 0x20
```
- Start real program at memory location 0x20 (standard practice).

---

## 🔵 5. START Label:

```assembly
START
CALL INITP
```
- Call subroutine `INITP` to initialize PORTA and PORTD properly.

✅ Always configure TRIS registers before reading/writing ports!

---

## 🔵 6. REPEAT Loop:

```assembly
REPEAT
MOVF PORTA, W
MOVWF PORTD
GOTO REPEAT
```
- `MOVF PORTA, W`:  
  - Read input from **PORTA** into **WREG**.
- `MOVWF PORTD`:  
  - Write WREG value into **PORTD**.
  - So, whatever switches you press, you see same pattern output on LEDs connected to PORTD.
- `GOTO REPEAT`:  
  - **Infinite loop** — keeps doing this forever.

✅ This program **directly mirrors** input (PORTA) to output (PORTD).

---

## 🔵 7. INITP Subroutine (Initialize Ports):

```assembly
INITP
BANK1
MOVLW 0x06
MOVWF ADCON1
MOVLW 0xFF
MOVWF TRISA
CLRF TRISD
BANK0
RETURN
```

🔹 **BANK1**: 
- Because `TRISA` and `ADCON1` are in Bank 1.

🔹 **MOVLW 0x06**:
- WREG = 00000110.
- Configure `ADCON1` so that **PORTA becomes digital I/O** (not ADC inputs).

🔹 **MOVWF ADCON1**:
- Write WREG to ADCON1.

🔹 **MOVLW 0xFF**:
- WREG = 11111111 (All bits 1).

🔹 **MOVWF TRISA**:
- All PORTA pins as **INPUT** (TRIS bits = 1 = input).

🔹 **CLRF TRISD**:
- Clear TRISD (set all bits 0).
- All PORTD pins as **OUTPUT** (TRIS bits = 0 = output).

🔹 **BANK0**:
- Return back to Bank 0 for normal operation.

🔹 **RETURN**:
- Finish INITP and go back to START.

---

## 🔵 8. End Program:

```assembly
END
```
- Mark the end of the program.
- Assembler needs this to finalize compilation.

---

# 📚 Summary of Working:

| Step | Action |
|:----:|:------:|
| Initialize PORTA as INPUT, PORTD as OUTPUT |
| Read the switches on PORTA |
| Send the switch states directly to PORTD |
| Loop forever |

---

# 📢 Why is this important?

✅ Learn how **input switches** can **control outputs**.  
✅ Essential for **real-world projects** like:
- Switch-controlled LEDs
- Remote buttons
- Machine control panels

---

# 🔥 Bonus Visualization:

| Switches (PORTA) | LEDs (PORTD) |
|:----------------:|:------------:|
| 1 0 1 0 0 0 1 0  | 1 0 1 0 0 0 1 0 |
| 0 0 0 0 1 0 1 0  | 0 0 0 0 1 0 1 0 |
| etc.             | mirrors input exactly |

---