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

// If maze == 1
cmpi r2, 1
// bne // Jump to ELSE IF 1
beq 4 // Jump to MAZE 1
    andi r8, 0
    addi r8, 162  // a28 + 162 = 190
    jal r11, r8  // Jump to ELSE IF 1
// MAZE 1 Addr29

// Maze == 1
    // if r1 >= 310 && r1 <= 620 && r0 >= 100 && r0 <= 120
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 54   // r6 = 310
    cmp r1, r6
    blt 10 // Jump to ELSE IF 1.1

    add r6, r6   // r6 = 620
    cmp r1, r6
    bgt 7 // Jump to ELSE IF 1.1

    cmpi r0, 100
    blt 5 // Jump to ELSE IF 1.1

    cmpi r0, 120
    bgt 3 // Jump to ELSE IF 1.1

    cmpi r9, 0
    beq 17 // Jump to SEND IF ELSE 1

    // ELSE IF 1.1 Addr44
    // else if r1 >= 320 && r1 <= 330 && r0 >= 120 && r0 <= 200
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 64   // r6 = 320
    cmp r1, r6
    blt 12 // Jump to ELSE IF 1.2

    addi r6, 10   // r6 = 330
    cmp r1, r6
    bgt 9 // Jump to ELSE IF 1.2

    cmpi r0, 120
    blt 7 // Jump to ELSE IF 1.2

    andi r7, 0    // r7 = 0
    addi r7, 200  // r7 = 200
    cmp r0, r7
    bgt 3 // Jump to ELSE IF 1.2

    cmpi r9, 0
    // SEND IF ELSE 1 Addr60
    beq 125 // Jump to END IF ELSE 1

    // ELSE IF 1.2 Addr61
    // else if r1 >= 310 && r1 <= 650 && r0 >= 200 && r0 <= 230
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 54   // r6 = 310
    cmp r1, r6
    blt 14 // Jump to ELSE IF 1.3

    add r6, r6   // r6 = 620
    addi r6, 30   // r6 = 650
    cmp r1, r6
    bgt 10 // Jump to ELSE IF 1.3

    andi r7, 0    // r7 = 0
    addi r7, 200  // r7 = 200
    cmp r0, r7
    blt 6 // Jump to ELSE IF 1.3

    addi r7, 30   // r7 = 230
    cmp r0, r7
    bgt 3 // Jump to ELSE IF 1.3

    cmpi r9, 0
    beq 106 // Jump to END IF ELSE 1

    // ELSE IF 1.3 Addr80
    // else if r1 >= 630 && r1 <= 650 && r0 >= 230 && r0 <= 300
    andi r6, 0    // r6 = 0
    addi r6, 2    // r6 = 2
    lshi r6, 8    // r6 = 512
    addi r6, 118  // r6 = 630
    cmp r1, r6
    blt 13 // Jump to ELSE IF 1.4

    addi r6, 20   // r6 = 650
    cmp r1, r6
    bgt 10 // Jump to ELSE IF 1.4

    andi r7, 0    // r7 = 0
    addi r7, 230  // r7 = 230
    cmp r0, r7
    blt 6 // Jump to ELSE IF 1.4

    addi r7, 70   // r7 = 300
    cmp r0, r7
    bgt 3 // Jump to ELSE IF 1.4

    cmpi r9, 0
    beq 88 // Jump to END IF ELSE 1

    // ELSE IF 1.4 Addr98
    // else if r1 >= 310 && r1 <= 650 && r0 >= 300 && r0 <= 350
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 54   // r6 = 310
    cmp r1, r6
    blt 15 // Jump to ELSE IF 1.5

    andi r7, 0    // r7 = 0
    addi r7, 2    // r7 = 2
    lshi r7, 8    // r7 = 512
    addi r7, 138  // r7 = 650
    cmp r1, r7
    bgt 9 // Jump to ELSE IF 1.5

    subi r6, 10  // r6 = 300
    cmp r0, r6
    blt 6 // Jump to ELSE IF 1.5

    addi r6, 50   // r6 = 350
    cmp r0, r6
    bgt 3 // Jump to ELSE IF 1.5

    cmpi r9, 0
    beq 68 // Jump to END IF ELSE 1

    // ELSE IF 1.5 Addr118
    // else if r1 >= 310 && r1 <= 340 && r0 >= 350 && r0 <= 400
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 54   // r6 = 310
    cmp r1, r6
    blt 12 // Jump to ELSE IF 1.6

    addi r6, 30   // r6 = 340
    cmp r1, r6
    bgt 9 // Jump to ELSE IF 1.6

    addi r6, 10   // r6 = 350
    cmp r0, r6
    blt 6 // Jump to ELSE IF 1.6

    addi r6, 50   // r6 = 400
    cmp r0, r6
    bgt 3 // Jump to ELSE IF 1.6

    cmpi r9, 0
    beq 51 // Jump to END IF ELSE 1

    // ELSE IF 1.6 Addr135
    // else if r1 >= 310 && r1 <= 650 && r0 >= 400 && r0 <= 480
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 54   // r6 = 310
    cmp r1, r6
    blt 13 // Jump to ELSE IF 1.7

    add r6, r6   // r6 = 620
    addi r6, 30   // r6 = 650
    cmp r1, r6
    bgt 9 // Jump to ELSE IF 1.7

    subi r6, 250  // r6 = 400
    cmp r0, r6
    blt 6 // Jump to ELSE IF 1.7

    addi r6, 80   // r6 = 480
    cmp r0, r6
    bgt 3 // Jump to ELSE IF 1.7

    cmpi r9, 0
    beq 33 // Jump to END IF ELSE 1

    // ELSE IF 1.7 Addr153
    // else if r1 >= 620 && r1 <= 650 && r0 >= 100 && r0 <= 120 then you WIN
    andi r6, 0    // r6 = 0
    addi r6, 2    // r6 = 2
    lshi r6, 8    // r6 = 512
    addi r6, 118  // r6 = 620
    cmp r1, r6
    blt 19 // Jump to ELSE DEAD 1

    addi r6, 30   // r6 = 650
    cmp r1, r6
    bgt 16 // Jump to ELSE DEAD 1

    cmpi r0, 100
    blt 14 // Jump to ELSE DEAD 1

    cmpi r0, 120
    bgt 12 // Jump to ELSE DEAD 1

    // Won Level 1
    addi r2, 1  // Update Level
    // Update x for level 2
    andi r1, 0   // x = 0
    addi r1, 1   // x = 1
    lshi r1, 8   // x = 256
    addi r1, 94  // x = 350

    // Update y for level 2
    andi r0, 0   // y = 0
    addi r0, 1   // y = 1
    lshi r0, 8   // y = 256
    addi r0, 204 // y = 460

    cmpi r9, 0
    beq 9 // Jump to END IF ELSE 1

    // ELSE DEAD 1 Addr177
    // else you die
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

    // END IF ELSE 1 Addr185
// End Maze == 1

andi r8, 0
subi r8, 170
jal r11, r8