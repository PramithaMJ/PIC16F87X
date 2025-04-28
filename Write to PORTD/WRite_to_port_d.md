# 📜 First, Here is the Program Again:

```assembly
; ########## EXP1.ASM 
; WRITTEN BY: PramithaMJ
; DATE: 2024-04-29
; DEVICE: PIC16F877
; 40 PIN DEVICE, 10 MHz
; WATCHDOG: DISABLED
; CODE PROTECTION: OFF
; TITLE: "Write to Port D"

    LIST    P=16F877            ; Set PIC model
    INCLUDE <P16F877.INC>       ; Include register names

    ORG     0x00                ; Reset vector (program start address)
    GOTO    START               ; Jump to main program

    ORG     0x20                ; Main program starts at address 0x20

START
    CALL    INITP               ; Call port initialization subroutine

REPEAT
    MOVLW   0x55                ; Load WREG with 55h = 01010101b
    MOVWF   PORTD               ; Write WREG value to PORTD
    GOTO    REPEAT              ; Repeat forever

; --- Subroutine to Initialize PORTD ---
INITP
    MOVLW   0x00                ; WREG = 0
    MOVWF   TRISD               ; Make PORTD pins output (TRIS = 0 → output)
    RETURN

    END                         ; End of program
```

---

# 🧠 **line-by-line Detailed Explanation**:

---

## 🔵 **1. Program Header (Comments)**

```assembly
; ########## EXP1.ASM 
; Written by: (Your Name)
; Date: (Today's Date)
; 40 pin device (PIC16F877)
; 10 MHz Resonator (Clock)
; Watchdog Timer: Disabled
; Code Protection: Off
; Purpose: Write to PORTD
```
✅ These are **comments** (`;`) for explaining **what this file is doing**.
✅ They help humans understand, **machine ignores comments**.

---

## 🔵 **2. Setup Instructions**

```assembly
LIST    P=16F877
```
- Tells the assembler which PIC microcontroller we are using (PIC16F877).
  
```assembly
INCLUDE <P16F877.INC>
```
- Includes important **definitions** (PORTD, TRISD, STATUS, etc.).
- Without this file, assembler doesn’t know memory addresses.

✅ **INCLUDE** is like loading a "dictionary" for the PIC.

---

## 🔵 **3. Program Start Point (ORG 0x00)**

```assembly
ORG 0x00
GOTO START
```
- `ORG 0x00`: Start program from address 0 (Reset Vector).
- `GOTO START`: Jump to label called `START`.
  
✅ Always the PIC starts at 0x00 when powered up or reset.

---

## 🔵 **4. Main Program (ORG 0x20)**

```assembly
ORG 0x20
```
- Place real program code from address **0x20** (after reserved interrupt vectors).

✅ Good practice to start code at 0x20.

---

## 🔵 **5. START Label**

```assembly
START
    CALL INITP
```
- `START`: Label for start of program.
- `CALL INITP`: Jump to initialization subroutine to setup PORTs.

✅ `CALL` jumps to another block, does the work, then returns back.

---

## 🔵 **6. REPEAT Label**

```assembly
REPEAT
    MOVLW 0x55
    MOVWF PORTD
    GOTO REPEAT
```
- `MOVLW 0x55`: Load `WREG` with hex `55h` → binary `0101 0101`.
- `MOVWF PORTD`: Move WREG into PORTD → output pattern to pins.
- `GOTO REPEAT`: Go back to REPEAT label and do again forever.

✅ This sends the pattern `0101 0101` **again and again** to PORTD.
✅ LEDs connected to PORTD will blink in a pattern.

---

## 🔵 **7. INITP Subroutine**

```assembly
INITP
    MOVLW 0x00
    MOVWF TRISD
    RETURN
```
- `MOVLW 0x00`: WREG = 0.
- `MOVWF TRISD`: Move WREG into TRISD register.
  - In PIC, **TRIS register** controls **input/output**:
    - `0` = Output
    - `1` = Input
- `RETURN`: Go back to where `CALL INITP` was called.

✅ Now, **PORTD becomes OUTPUT**.

✅ Important because if you don't set TRISD correctly, you **cannot output**.

---

## 🔵 **8. END Instruction**

```assembly
END
```
- Tell assembler: "Program finishes here."
- No code after `END`.

✅ Necessary to properly close the program.

---

# 📚 Summary Table

| Keyword | Meaning |
|:-------:|:-------:|
| `ORG 0x00` | Start program at 0 address |
| `GOTO START` | Jump to main code |
| `CALL INITP` | Call initialization routine |
| `MOVLW 0x55` | Load WREG with 55h |
| `MOVWF PORTD` | Move WREG to PORTD |
| `MOVWF TRISD` | Set PORTD as OUTPUT |
| `RETURN` | Return from subroutine |
| `END` | End of program |

---

# 🔥 Visualization (PORTD output):

If you connect LEDs to PORTD:

| Bit | State | Result |
|:---:|:-----:|:------:|
| RD7 | ON | 1 |
| RD6 | OFF | 0 |
| RD5 | ON | 1 |
| RD4 | OFF | 0 |
| RD3 | ON | 1 |
| RD2 | OFF | 0 |
| RD1 | ON | 1 |
| RD0 | OFF | 0 |

✅ LEDs will light up in ON-OFF-ON-OFF pattern.

---

# 📢 Why is everything important?

| Code | Importance |
|:----:|:----------:|
| `CALL INITP` | Make sure PORTD can output |
| `MOVWF PORTD` | Actually send signal to pins |
| `REPEAT forever` | Keeps LEDs blinking without stopping |
| `0x55` | Alternate LEDs ON and OFF |

---
