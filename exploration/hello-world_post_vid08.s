PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003
ACR = $600b


E  = %10000000
RW = %01000000
RS = %00100000
BF = %10000000 ; The busy flag

  .org $8000

reset:
  ldx #$ff  ; a2 ff
  txs       ; 9a

  ; turn of data latching on Port A so that we can read current state of input
  ; http://lateblt.tripod.com/bit67.txt
  lda #%00000000 ; a9 00 Setting last two bits (2 and 1) to 0 turns off latching for PA and PB input
  sta ACR        ; 8d 0b 60

  lda #%11111111 ; a9 ff    Set all pins on port B to output
  sta DDRB       ; 8d 02 60

  lda #%11100000 ; a9 e0     Set top 3 pins on port A to output
  sta DDRA       ; 8d 03 60

  lda #%00111000 ; a9 38  Set 8-bit mode; 2-line display; 5x8 font
  jsr lcd_instruction ; 20 XX XX

  lda #%00001110 ; Display on; cursor on; blink off
  jsr lcd_instruction

  lda #%00000110 ; Increment and shift cursor; don't shift display
  jsr lcd_instruction

  lda #%00000001 ; Clear Display
  jsr lcd_instruction

  lda #"H"
  jsr print_char
  lda #"e"
  jsr print_char
  lda #"l"
  jsr print_char
  lda #"l"
  jsr print_char
  lda #"o"
  jsr print_char
  lda #","
  jsr print_char
  lda #" "
  jsr print_char
  lda #"w"
  jsr print_char
  lda #"o"
  jsr print_char
  lda #"r"
  jsr print_char
  lda #"l"
  jsr print_char
  lda #"d"
  jsr print_char
  lda #"!"
  jsr print_char

loop:
  jmp loop


check_busy:

  pha            ; Push the current value of A to the stack, need it later since it has info for display


  lda #%00000000 ; a9 00       Set all pins on port B to input
  sta DDRB       ; 8d 02 60

  lda #RW        ; a9 40       Set the RW flag. Do this before enable, since if they are put high at the same time the display can read the enable before it sees the read
  sta PORTA      ; 8d 01 60

  lda #(RW | E)  ; a9 c0       Now raise the E flag to enable output of busy flag
  sta PORTA      ; 8d 01 60

while_busy:
  lda PORTB      ; ad 00 60    Read the busy flag
  eor #%00000000 ; 49 00       Check if it is zero
  and #BF        ; 29 80       Select only the relevant bit
  bne while_busy ; d0          If result isn't zero, try again

  lda #0         ; a9 00       Clear RS/RW/E bits
  sta PORTA      ; 8d 01 60

  lda #%11111111 ; a9 ff       Set all pins on port B to output
  sta DDRB       ; 8d 02 60

  pla            ; Retrieve A from the stack
  rts            ; 60


lcd_instruction:
  jsr check_busy     ; 20 XX XX   wait until the lcd isn't busy
  sta PORTB
  lda #0         ; Clear RS/RW/E bits
  sta PORTA
  lda #E         ; Set E bit to send instruction
  sta PORTA
  lda #0         ; Clear RS/RW/E bits
  sta PORTA
  rts

print_char:
  jsr check_busy     ; wait until the lcd isn't busy
  sta PORTB
  lda #RS         ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction
  sta PORTA
  lda #RS         ; Clear E bits
  sta PORTA
  rts


  .org $fffc
  .word reset
  .word $0000
