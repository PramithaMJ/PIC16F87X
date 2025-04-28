# 📜 First, Here is Code

```assembly
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
```

---

# 🧠 Now, Detailed Line-by-Line Explanation:

---

## 🔵 1. Title, Device, Include Files:

```assembly
LIST P=16F877
INCLUDE <P16F877.INC>
```
- Tell assembler the PIC type (PIC16F877).
- Include register names (PORTA, TRISA, STATUS, etc.).

---

## 🔵 2. Bank Switching Macros:

```assembly
BANK0 MACRO ... ENDM
BANK1 MACRO ... ENDM
BANK2 MACRO ... ENDM
BANK3 MACRO ... ENDM
```
- Microcontrollers have **different banks** to access all registers.
- Bank macros allow easy switching between banks.
  
| Macro | Which Bank | RP1 RP0 Status |
|:-----:|:----------:|:--------------:|
| BANK0 | Bank 0     | 0 0 |
| BANK1 | Bank 1     | 0 1 |
| BANK2 | Bank 2     | 1 0 |
| BANK3 | Bank 3     | 1 1 |

✅ **STATUS register** bits RP0 and RP1 control which bank is active.

---

## 🔵 3. Define STOREDATA:

```assembly
STOREDATA EQU 0x20
```
- Create a **label** for memory address **0x20** (in RAM).
- Will be used to **store** switch status later.

---

## 🔵 4. ORG 0x00 — Start of Program

```assembly
ORG 0x00
NOP
GOTO START
```
- PIC always begins at address 0 after reset.
- `NOP`: No operation (safe).
- `GOTO START`: Jump to actual program at 0x20.

---

## 🔵 5. ORG 0x20 — Main Program Location

```assembly
ORG 0x20
```
- Real code starts from 0x20 memory address.

✅ Keep code organized and clear.

---

## 🔵 6. START Label:

```assembly
START
CALL INITP
```
- First **initialize** PORTA as INPUT using INITP subroutine.

✅ Always set direction first (input/output) before using a port!

---

## 🔵 7. REPEAT Loop:

```assembly
REPEAT
MOVF PORTA, W
MOVWF STOREDATA
GOTO REPEAT
```
- `MOVF PORTA, W`: Read the PORTA (switch status) into WREG.
- `MOVWF STOREDATA`: Store WREG value in 0x20 memory.
- `GOTO REPEAT`: Keep reading and storing forever.

✅ As long as switches change, their state is updated in memory.

---

## 🔵 8. INITP (Initialization Subroutine):

```assembly
INITP
BANK1
MOVLW 0x06
MOVWF ADCON1
MOVLW 0xFF
MOVWF TRISA
BANK0
RETURN
```
- Switch to **Bank 1** because TRISA and ADCON1 are located in Bank1.
- `MOVLW 0x06` → Make PORTA pins digital (not analog ADC inputs).
- `MOVWF ADCON1` → Write 0x06 to ADCON1.
- `MOVLW 0xFF` → WREG = 1111 1111.
- `MOVWF TRISA` → Set all PORTA pins as **input** (TRIS bit 1 = input).
- `BANK0` → Return to Bank 0 for normal program execution.
- `RETURN` → Back to caller.

---

## 🔵 9. END of Program:

```assembly
END
```
- Close the program.
- Without `END`, assembler will throw error.

---

# 📚 Summary of Program Working:

1. PIC resets and jumps to `START`.
2. It **initializes** PORTA for **digital input**.
3. Forever:
   - Read PORTA (switches) into WREG.
   - Save the value into memory (`STOREDATA`).
   - Repeat.

---

# 📢 Why Important:

| Step | Importance |
|:----:|:----------:|
| INITP | Proper port direction (input) |
| MOVF PORTA | Read switches |
| MOVWF STOREDATA | Save the data |
| GOTO REPEAT | Continuously monitor switches |

---

# 🚀 Bonus Tip:

If you want to **check which switch** is ON or OFF, you can later read from `STOREDATA` memory and do operations like:

- Check if a bit is HIGH (switch pressed).
- Turn ON LEDs or motors based on input!

---

# 🧠 Final note:
✅ Always **set TRIS register** properly before using ports!  
✅ **BANK switching** is important for PIC microcontrollers.  
✅ **MOVF** is used for reading input ports.

---