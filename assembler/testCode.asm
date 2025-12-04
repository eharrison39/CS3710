// Set initial values
andi r0, 0  // x pos
addi r0, 2  // x = 2
lshi r0, 8  // x = 512
addi r0, 88 // x = 600
andi r1, 0  // y pos
addi r1, 1  // y = 1
lshi r1, 8  // y = 256
addi r1, 184 // y = 440
andi r2, 0  // maze level
addi r2, 1

andi r3, 0  // r3 = 0

// BEGINNING LOOP
// if r15 == 32 == 0x20 && r3 == 0
cmpi r15, 32
bne 13 // Jump to END ELSE IF 1
cmpi r3, 0
bne 11 // Jump to END ELSE IF 1

// then r3 = 1 && r0 -= 5
addi r3, 1
subi r0, 5

// Wait 50 times
andi r4, 0
andi r5, 0
addi r5, 5

// BEG LOOP
addi r4, 1
// WAIT
cmp r4, r5
blt -3  // Jump to BEG LOOP

subi r0, 5

// END ELSE IF 1

// if r15 == 0
cmpi r15, 0
bne 2 // Jump to END ELSE IF 2
// then r3 = 0
andi r3, 0

// END ELSE IF 2

andi r8, 0
subi r8, 19
jal r11, r8  // Jump to BEGINNING LOOP

// andi r9, 0
// cmpi r9, 0
// beq -11 // Jump to BEGINNING LOOP

