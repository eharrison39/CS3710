// Variables Needed
// Maze/Screen   x and y position   
// Level 1 (600, 440)
// Level 2 (350, 460)
// Level 3 (320, 460)

// THE BEGINNING Addr0

// Set fixed memory addresses
andi r3, 0  // Set x pos address
addi r3, 200
andi r4, 0  // Set y pos address
addi r4, 201
andi r5, 0  // Set maze level address
addi r5, 202

// Set r9 to 0
andi r9, 0

// GAME RESET Addr7
// Set initial values
andi r1, 0  // x pos
addi r1, 2  // x = 2
lshi r1, 8  // x = 512
addi r1, 88 // x = 600
andi r0, 0  // y pos
addi r0, 1  // y = 1
lshi r0, 8  // y = 256
addi r0, 184 // y = 440
andi r2, 0  // maze level
addi r2, 1

// BEGINNING LOOP Addr17
// Stor initial values in memory
andi r3, 0  // Stor x pos
andi r4, 0  // Stor y pos
andi r5, 0  // Stor maze level

// If r15 == 0 then jump to BEGINNING LOOP
cmpi r15, 0
bne 3   // CHANGE
andi r12, 0  // CHANGE
beq -6  // Jump to BEGINNING LOOP

    // if r1 >= 310 && r1 <= 650 && r0 >= 400 && r0 <= 480
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 54   // r6 = 310
    cmp r1, r6
    bgt 13 // Jump to ELSE IF 1.7

    add r6, r6   // r6 = 620
    addi r6, 30   // r6 = 650
    cmp r1, r6
    blt 9 // Jump to ELSE IF 1.7

    subi r6, 250  // r6 = 400
    cmp r0, r6
    bgt 6 // Jump to ELSE IF 1.7

    addi r6, 80   // r6 = 480
    cmp r0, r6
    blt 3 // Jump to ELSE IF 1.7

    cmpi r9, 0
    beq 9 // Jump to END IF ELSE 1

    // else there is a collision
    // Update x for level 1
    andi r1, 0   // x = 0
    addi r1, 2   // x = 2
    lshi r1, 8   // x = 512
    addi r1, 88  // x = 600

    // Update y for level 1
    andi r0, 0   // y = 0
    addi r0, 1   // y = 1
    lshi r0, 8   // y = 256
    addi r0, 184 // y = 440

    // ELSE IF 1.7 Addr153
// If r15 == 8 then move up (decrease y pos)
andi r14, 0
addi r14, 8  // r14 = 8
and r14, r15
cmpi r14, 8
bne 5 // Jump to CHECK DOWN
    cmpi r12, 0  // CHANGE
    bne 3        // CHANGE
    subi r0, 5  // Move up by 5
    addi r12, 1  // Set state to 1 // CHANGE

// CHECK DOWN Addr736
// If r15 == 16 then move down (increase y pos)
andi r14, 0
addi r14, 16  // r14 = 16
and r14, r15
cmpi r14, 16
bne 5 // Jump to CHECK LEFT
    cmpi r12, 0  // CHANGE
    bne 3        // CHANGE
    addi r0, 5  // Move down by 5
    addi r12, 1  // Set state to 1 // CHANGE

// CHECK LEFT Addr745
// If r15 == 32 then move left (decrease x pos)
andi r14, 0
addi r14, 32  // r14 = 32
and r14, r15
cmpi r14, 32
bne 5 // Jump to CHECK RIGHT
    cmpi r12, 0  // CHANGE
    bne 3        // CHANGE
    subi r1, 5  // Move left by 5
    addi r12, 1  // Set state to 1 // CHANGE

// CHECK RIGHT Addr754
// If r15 == 64 then move right (increase x pos)
andi r14, 0
addi r14, 64  // r14 = 64
and r14, r15
cmpi r14, 64
bne 5 // Jump to CHECK RESET
    cmpi r12, 0  // CHANGE
    bne 3        // CHANGE
    addi r1, 5  // Move right by 5
    addi r12, 1  // Set state to 1 // CHANGE

// CHECK RESET Addr763
// If r15 == 1 then reset the game
andi r14, 0
addi r14, 1  // r14 = 1
and r14, r15
cmpi r14, 1
bne 9  // Jump to END LOOP
    cmpi r12, 0  // NEW CHANGE
    bne 7        // NEW CHANGE
    addi r12, 1  // Set state to 1 // NEW CHANGE
    andi r8, 0    // r8 = 0
    subi r8, 91  // r8 = 253
    lshi r8, 0    // r8 = -768
    addi r8, 0   // r8 = -765
    // Address = 7 a772 - 765 = 7
    jal r11, r8 // Jump to GAME RESET

// END LOOP Addr773
andi r8, 0    // r8 = 0
subi r8, 86  // r8 = 253
lshi r8, 0    // r8 = -768
addi r8, 0   // r8 = -760
// Address = 17 a777 - 760 = 17
jal r11, r8  // Jump to BEGINNING LOOP

// Addr778

// // beq address x
// bne 4  // Jump to CONTINUE
//   andi r8, 0
//   addi r8, x
//   jal r11, r8  // Jump to ADDRESS X
// // CONTINUE



// If x then y
// Check if x
// jump to else if !x
// do stuff
// jump to end of if else statement
// Start next else if