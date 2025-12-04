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

// BEGINNING LOOP Addr17
// Stor initial values in memory
andi r3, 0  // Stor x pos
andi r4, 0  // Stor y pos
andi r5, 0  // Stor maze level

// If r15 == 0 then jump to BEGINNING LOOP
cmpi r15, 0
bne 3   // CHANGE
andi r12, 0  // CHANGE
beq -4  // Jump to BEGINNING LOOP

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
    andi r0, 0   // x = 0
    addi r0, 1   // x = 1
    lshi r0, 8   // x = 256
    addi r0, 94  // x = 350

    // Update y for level 2
    andi r1, 0   // y = 0
    addi r1, 1   // y = 1
    lshi r1, 8   // y = 256
    addi r1, 204 // y = 460

    cmpi r9, 0
    beq 9 // Jump to END IF ELSE 1

    // ELSE DEAD 1 Addr177
    // else you die
    // Update x for level 1
    andi r0, 0   // x = 0
    addi r0, 2   // x = 2
    lshi r0, 8   // x = 512
    addi r0, 88  // x = 600

    // Update y for level 1
    andi r1, 0   // y = 0
    addi r1, 1   // y = 1
    lshi r1, 8   // y = 256
    addi r1, 184 // y = 440

    // END IF ELSE 1 Addr185
// End Maze == 1
// Jump to end of if else statement
andi r8, 0   // r8 = 0
addi r8, 2   // r8 = 2
lshi r8, 8   // r8 = 512
addi r8, 26   // Address = 727  a189 + 538 = 727
jal r11, r8  // Jump to END IF ELSE

// If maze == 2
// ELSE IF 1 Addr190
cmpi r2, 2
// bne  // Jump to ELSE IF 2
beq 6 // Jump to MAZE 2
    andi r8, 0   // r8 = 0
    addi r8, 0   // r8 = 0
    lshi r8, 8   // r8 = 256
    addi r8, 223   // Address = 419  a196 + 223 = 419
    jal r11, r8  // Jump to ELSE IF 2
// MAZE 2 Addr197
// Maze == 2
    // if r1 >= 310 && r1 <= 380 && r0 >= 150 && r0 <= 480
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 54   // r6 = 310
    cmp r1, r6
    blt 13 // Jump to ELSE IF 2.1

    addi r6, 70   // r6 = 380
    cmp r1, r6
    bgt 10 // Jump to ELSE IF 2.1

    andi r7, 0    // r7 = 0
    addi r7, 150  // r7 = 150
    cmp r0, r7
    blt 6 // Jump to ELSE IF 2.1

    addi r6, 100  // r6 = 480
    cmp r0, r6
    bgt 3 // Jump to ELSE IF 2.1

    cmpi r9, 0
    beq 85 // Jump to SEND IF ELSE 2

    // ELSE IF 2.1 Addr215
    // else if r1 >= 310 && r1 <= 350 && r0 >= 120 && r0 <= 150
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 54   // r6 = 310
    cmp r1, r6
    blt 12 // Jump to ELSE IF 2.2

    addi r6, 40   // r6 = 350
    cmp r1, r6
    bgt 9 // Jump to ELSE IF 2.2

    cmpi r0, 120
    blt 7 // Jump to ELSE IF 2.2

    andi r7, 0    // r7 = 0
    addi r7, 150  // r7 = 150
    cmp r0, r7
    bgt 3 // Jump to ELSE IF 2.2

    cmpi r9, 0
    beq 68 // Jump to SEND IF ELSE 2

    // ELSE IF 2.2 Addr232
    // else if r1 >= 310 && r1 <= 410 && r0 >= 100 && r0 <= 120
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 54   // r6 = 310
    cmp r1, r6
    blt 10 // Jump to ELSE IF 2.3

    addi r6, 100  // r6 = 410
    cmp r1, r6
    bgt 7 // Jump to ELSE IF 2.3

    cmpi r0, 100
    blt 5 // Jump to ELSE IF 2.3

    cmpi r0, 120
    bgt 3 // Jump to ELSE IF 2.3

    cmpi r9, 0
    beq 53 // Jump to SEND IF ELSE 2

    // ELSE IF 2.3 Addr247
    // else if r1 >= 410 && r1 <= 460 && r0 >= 100 && r0 <= 150
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 154  // r6 = 410
    cmp r1, r6
    blt 12 // Jump to ELSE IF 2.4

    addi r6, 50   // r6 = 460
    cmp r1, r6
    bgt 9 // Jump to ELSE IF 2.4

    cmpi r0, 100
    blt 7 // Jump to ELSE IF 2.4

    andi r7, 0    // r7 = 0
    addi r7, 150  // r7 = 150
    cmp r0, r7
    bgt 3 // Jump to ELSE IF 2.4

    cmpi r9, 0
    beq 36 // Jump to SEND IF ELSE 2

    // ELSE IF 2.4 Addr264
    // else if r1 >= 430 && r1 <= 480 && r0 >= 150 && r0 <= 200
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 174  // r6 = 430
    cmp r1, r6
    blt 13 // Jump to ELSE IF 2.5

    addi r6, 50   // r6 = 480
    cmp r1, r6
    bgt 10 // Jump to ELSE IF 2.5

    andi r7, 0    // r7 = 0
    addi r7, 150  // r7 = 150
    cmp r0, r7
    blt 6 // Jump to ELSE IF 2.5

    addi r6, 50   // r6 = 200
    cmp r0, r6
    bgt 3 // Jump to ELSE IF 2.5

    cmpi r9, 0
    beq 18 // Jump to SEND IF ELSE 2

    // ELSE IF 2.5 Addr282
    // else if r1 >= 450 && r1 <= 510 && r0 >= 200 && r0 <= 480
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 194  // r6 = 450
    cmp r1, r6
    blt 13 // Jump to ELSE IF 2.6

    addi r6, 60   // r6 = 510
    cmp r1, r6
    bgt 10 // Jump to ELSE IF 2.6

    andi r7, 0    // r7 = 0
    addi r7, 200  // r7 = 200
    cmp r0, r7
    blt 6 // Jump to ELSE IF 2.6

    subi r6, 30   // r6 = 480
    cmp r0, r6
    bgt 3 // Jump to ELSE IF 2.6

    cmpi r9, 0
    // SEND IF ELSE 2 Addr299
    beq 115 // Jump to END IF ELSE 2

    // ELSE IF 2.6 Addr300
    // else if r1 >= 510 && r1 <= 640 && r0 >= 450 && r0 <= 480
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 254  // r6 = 510
    cmp r1, r6
    blt 12 // Jump to ELSE IF 2.7

    addi r6, 130  // r6 = 640
    cmp r1, r6
    bgt 9 // Jump to ELSE IF 2.7

    subi r6, 190  // r6 = 450
    cmp r0, r6
    blt 6 // Jump to ELSE IF 2.7

    addi r6, 30   // r6 = 480
    cmp r0, r6
    bgt 3 // Jump to ELSE IF 2.7

    cmpi r9, 0
    beq 98 // Jump to END IF ELSE 2

    // ELSE IF 2.7 Addr317
    // else if r1 >= 620 && r1 <= 640 && r0 >= 140 && r0 <= 480
    andi r6, 0    // r6 = 0
    addi r6, 2    // r6 = 2
    lshi r6, 8    // r6 = 512
    addi r6, 118  // r6 = 620
    cmp r1, r6
    blt 13 // Jump to ELSE IF 2.8

    addi r6, 20   // r6 = 640
    cmp r1, r6
    bgt 10 // Jump to ELSE IF 2.8

    andi r7, 0    // r7 = 0
    addi r7, 140  // r7 = 140
    cmp r0, r7
    blt 6 // Jump to ELSE IF 2.8

    subi r6, 160  // r6 = 480
    cmp r0, r6
    bgt 3 // Jump to ELSE IF 2.8

    cmpi r9, 0
    beq 80 // Jump to END IF ELSE 2

    // ELSE IF 2.8 Addr335
    // else if r1 >= 510 && r1 <= 640 && r0 >= 120 && r0 <= 140
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 254  // r6 = 510
    cmp r1, r6
    blt 12 // Jump to ELSE IF 2.9

    addi r6, 130  // r6 = 640
    cmp r1, r6
    bgt 9 // Jump to ELSE IF 2.9

    cmpi r0, 120
    blt 7 // Jump to ELSE IF 2.9

    andi r7, 0    // r7 = 0
    addi r7, 140  // r7 = 140
    cmp r0, r7
    bgt 3 // Jump to ELSE IF 2.9

    cmpi r9, 0
    beq 63 // Jump to END IF ELSE 2

    // ELSE IF 2.9 Addr352
    // else if r1 >= 510 && r1 <= 520 && r0 >= 100 && r0 <= 120
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 254  // r6 = 510
    cmp r1, r6
    blt 10 // Jump to ELSE IF 2.10

    addi r6, 10   // r6 = 520
    cmp r1, r6
    bgt 7 // Jump to ELSE IF 2.10

    cmpi r0, 100
    blt 5 // Jump to ELSE IF 2.10

    cmpi r0, 120
    bgt 3 // Jump to ELSE IF 2.10

    cmpi r9, 0
    beq 48 // Jump to END IF ELSE 2

    // ELSE IF 2.10 Addr367
    // else if r1 >= 520 && r1 <= 640 && r0 >= 100 && r0 <= 110
    
    andi r6, 0    // r6 = 0
    addi r6, 2    // r6 = 2
    lshi r6, 8    // r6 = 512
    addi r6, 8    // r6 = 520
    cmp r1, r6
    blt 10 // Jump to ELSE IF 2.11

    addi r6, 120  // r6 = 640
    cmp r1, r6
    bgt 7 // Jump to ELSE IF 2.11

    cmpi r0, 100
    blt 5 // Jump to ELSE IF 2.11

    cmpi r0, 110
    bgt 3 // Jump to ELSE IF 2.11

    cmpi r9, 0
    beq 33 // Jump to END IF ELSE 2

    // ELSE IF 2.11 Addr382
    // else if r1 >= 640 && r1 <= 650 && r0 >= 100 && r0 <= 110 then You Win
    andi r6, 0    // r6 = 0
    addi r6, 2    // r6 = 2
    lshi r6, 8    // r6 = 512
    addi r6, 128  // r6 = 640
    cmp r1, r6
    blt 19 // Jump to ELSE DEAD 2

    addi r6, 10   // r6 = 650
    cmp r1, r6
    bgt 16 // Jump to ELSE DEAD 2

    cmpi r0, 100
    blt 14 // Jump to ELSE DEAD 2

    cmpi r0, 110
    bgt 12 // Jump to ELSE DEAD 2

    // Won Level 2
    addi r2, 1  // Update Level
    // Update x for level 3
    andi r0, 0   // x = 0
    addi r0, 1   // x = 1
    lshi r0, 8   // x = 256
    addi r0, 64  // x = 320

    // Update y for level 3
    andi r1, 0   // y = 0
    addi r1, 1   // y = 1
    lshi r1, 8   // y = 256
    addi r1, 204 // y = 460

    cmpi r9, 0
    beq 9 // Jump to END IF ELSE 2

    // ELSE DEAD 2 Addr406
    // else you die reset x and y positions
    // Update x for level 2
    andi r0, 0   // x = 0
    addi r0, 1   // x = 1
    lshi r0, 8   // x = 256
    addi r0, 94  // x = 350

    // Update y for level 2
    andi r1, 0   // y = 0
    addi r1, 1   // y = 1
    lshi r1, 8   // y = 256
    addi r1, 204 // y = 460
    // END IF ELSE 2 Addr414
// End Maze == 2
// Jump to end of if else statement
andi r8, 0   // r8 = 0
addi r8, 1   // r8 = 1
lshi r8, 8   // r8 = 256
addi r8, 53   // Address = 727 a418 + 309 = 727
jal r11, r8 // Jump to END IF ELSE
// If maze == 3
// ELSE IF 2 Addr419
cmpi r2, 3
// bne // Jump to ELSE IF 3
beq 6 // Jump to MAZE 3
    andi r8, 0   // r8 = 0
    addi r8, 1   // r8 = 1
    lshi r8, 8   // r8 = 256
    addi r8, 44   // Address = 725 a425 + 300 = 725
    jal r11, r8 // Jump to ELSE IF 3
// MAZE 3 Addr426
// Maze == 3
    // if r1 >= 310 && r1 <= 650 && r0 >= 440 && r0 <= 480
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 54   // r6 = 310
    cmp r1, r6
    blt 13 // Jump to ELSE IF 3.1

    add r6, r6   // r6 = 620
    addi r6, 30   // r6 = 650
    cmp r1, r6
    bgt 9 // Jump to ELSE IF 3.1

    subi r6, 210  // r6 = 440
    cmp r0, r6
    blt 6 // Jump to ELSE IF 3.1

    addi r6, 40   // r6 = 480
    cmp r0, r6
    bgt 3 // Jump to ELSE IF 3.1

    cmpi r9, 0
    beq 35 // Jump to 2SEND IF ELSE 3

    // ELSE IF 3.1 Addr444
    // else if r1 >= 620 && r1 <= 650 && r0 >= 380 && r0 <= 440
    
    andi r6, 0    // r6 = 0
    addi r6, 2    // r6 = 2
    lshi r6, 8    // r6 = 512
    addi r6, 108  // r6 = 620
    cmp r1, r6
    blt 13 // Jump to ELSE IF 3.2

    addi r6, 30   // r6 = 650
    cmp r1, r6
    bgt 10 // Jump to ELSE IF 3.2

    subi r6, 250  // r6 = 400
    subi r6, 20   // r6 = 380
    cmp r0, r6
    blt 6 // Jump to ELSE IF 3.2

    addi r6, 60   // r6 = 440
    cmp r0, r6
    bgt 3 // Jump to ELSE IF 3.2

    cmpi r9, 0
    beq 17 // Jump to 2SEND IF ELSE 3

    // ELSE IF 3.2 Addr462
    // else if r1 >= 310 && r1 <= 620 && r0 >= 380 && r0 <= 410
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 54   // r6 = 310
    cmp r1, r6
    blt 12 // Jump to ELSE IF 3.3

    add r6, r6   // r6 = 620
    cmp r1, r6
    bgt 9 // Jump to ELSE IF 3.3

    subi r6, 240  // r6 = 380
    cmp r0, r6
    blt 6 // Jump to ELSE IF 3.3

    addi r6, 30   // r6 = 410
    cmp r0, r6
    bgt 3 // Jump to ELSE IF 3.3

    cmpi r9, 0
    // 2SEND IF ELSE 3 Addr478
    beq 125 // Jump to SEND IF ELSE 3

    // ELSE IF 3.3 Addr479
    // else if r1 >= 310 && r1 <= 330 && r0 >= 100 && r0 <= 380
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 54   // r6 = 310
    cmp r1, r6
    blt 11 // Jump to ELSE IF 3.4

    addi r6, 20   // r6 = 330
    cmp r1, r6
    bgt 8 // Jump to ELSE IF 3.4

    cmpi r0, 100
    blt 6 // Jump to ELSE IF 3.4

    addi r6, 50   // r6 = 380
    cmp r0, r6
    bgt 3 // Jump to ELSE IF 3.4

    cmpi r9, 0
    beq 109 // Jump to SEND IF ELSE 3

    // ELSE IF 3.4 Addr495
    // else if r1 >= 330 && r1 <= 650 && r0 >= 100 && r0 <= 150
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 74   // r6 = 330
    cmp r1, r6
    blt 13 // Jump to ELSE IF 3.5

    add r6, r6   // r6 = 660
    subi r6, 10  // r6 = 650
    cmp r1, r6
    bgt 9 // Jump to ELSE IF 3.5

    cmpi r0, 100
    blt 7 // Jump to ELSE IF 3.5

    andi r7, 0    // r7 = 0
    addi r7, 150  // r7 = 150
    cmp r0, r7
    bgt 3 // Jump to ELSE IF 3.5

    cmpi r9, 0
    beq 91 // Jump to SEND IF ELSE 3

    // ELSE IF 3.5 Addr513
    // else if r1 >= 620 && r1 <= 650 && r0 >= 150 && r0 <= 350
    andi r6, 0    // r6 = 0
    addi r6, 2    // r6 = 2
    lshi r6, 8    // r6 = 512
    addi r6, 118  // r6 = 620
    cmp r1, r6
    blt 13 // Jump to ELSE IF 3.6

    addi r6, 30   // r6 = 650
    cmp r1, r6
    bgt 10 // Jump to ELSE IF 3.6

    andi r7, 0    // r7 = 0
    addi r7, 150  // r7 = 150
    cmp r0, r7
    blt 6 // Jump to ELSE IF 3.6

    addi r7, 200  // r7 = 350
    cmp r0, r7
    bgt 3 // Jump to ELSE IF 3.6

    cmpi r9, 0
    beq 73 // Jump to SEND IF ELSE 3

    // ELSE IF 3.6 Addr531
    // else if r1 >= 360 && r1 <= 620 && r0 >= 320 && r0 <= 350
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 104   // r6 = 360
    cmp r1, r6
    blt 14 // Jump to ELSE IF 3.7

    addi r6, 240  // r6 = 600
    addi r6, 20   // r6 = 620
    cmp r1, r6
    bgt 10 // Jump to ELSE IF 3.7

    subi r6, 200  // r6 = 420
    subi r6, 100  // r6 = 320
    cmp r0, r6
    blt 6 // Jump to ELSE IF 3.7

    addi r6, 30   // r6 = 350
    cmp r0, r6
    bgt 3 // Jump to ELSE IF 3.7

    cmpi r9, 0
    beq 54 // Jump to SEND IF ELSE 3

    // ELSE IF 3.7 Addr550
    // else if r1 >= 360 && r1 <= 380 && r0 >= 170 && r0 <= 320
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 104   // r6 = 360
    cmp r1, r6
    blt 13 // Jump to ELSE IF 3.8

    addi r6, 20   // r6 = 380
    cmp r1, r6
    bgt 10 // Jump to ELSE IF 3.8

    andi r7, 0    // r7 = 0
    addi r7, 170  // r7 = 170
    cmp r0, r7
    blt 6 // Jump to ELSE IF 3.8

    subi r6, 60   // r6 = 320
    cmp r0, r6
    bgt 3 // Jump to ELSE IF 3.8

    cmpi r9, 0
    beq 36 // Jump to SEND IF ELSE 3

    // ELSE IF 3.8 Addr568
    // else if r1 >= 380 && r1 <= 600 && r0 >= 170 && r0 <= 180
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 124  // r6 = 380
    cmp r1, r6
    blt 13 // Jump to ELSE IF 3.9

    addi r6, 220  // r6 = 600
    cmp r1, r6
    bgt 10 // Jump to ELSE IF 3.9

    andi r7, 0    // r7 = 0
    addi r7, 170  // r7 = 170
    cmp r0, r7
    blt 6 // Jump to ELSE IF 3.9

    addi r7, 10   // r7 = 180
    cmp r0, r7
    bgt 3 // Jump to ELSE IF 3.9

    cmpi r9, 0
    beq 18 // Jump to SEND IF ELSE 3

    // ELSE IF 3.9 Addr586
    // else if r1 >= 585 && r1 <= 600 && r0 >= 180 && r0 <= 300
    andi r6, 0    // r6 = 0
    addi r6, 2    // r6 = 2
    lshi r6, 8    // r6 = 512
    addi r6, 73   // r6 = 585
    cmp r1, r6
    blt 13 // Jump to ELSE IF 3.10

    addi r6, 15   // r6 = 600
    cmp r1, r6
    bgt 10 // Jump to ELSE IF 3.10

    andi r7, 0    // r7 = 0
    addi r7, 180  // r7 = 180
    cmp r0, r7
    blt 6 // Jump to ELSE IF 3.10

    addi r7, 120  // r7 = 300
    cmp r0, r7
    bgt 3 // Jump to ELSE IF 3.10

    cmpi r9, 0
    // SEND IF ELSE 3 Addr603
    beq 120 // Jump to END IF ELSE 3

    // ELSE IF 3.10 Addr604
    // else if r1 >= 390 && r1 <= 585 && r0 >= 290 && r0 <= 300
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 134  // r6 = 390
    cmp r1, r6
    blt 14 // Jump to ELSE IF 3.11

    andi r7, 0    // r7 = 0
    add r7, r6    // r7 = 390
    addi r7, 195  // r7 = 585
    cmp r1, r7
    bgt 9 // Jump to ELSE IF 3.11

    subi r6, 100  // r6 = 290
    cmp r0, r6
    blt 6 // Jump to ELSE IF 3.11

    addi r6, 10   // r6 = 300
    cmp r0, r6
    bgt 3 // Jump to ELSE IF 3.11

    cmpi r9, 0
    beq 101 // Jump to END IF ELSE 3

    // ELSE IF 3.11 Addr623
    // else if r1 >= 390 && r1 <= 395 && r0 >= 200 && r0 <= 290
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 134  // r6 = 390
    cmp r1, r6
    blt 12 // Jump to ELSE IF 3.12

    addi r6, 5    // r6 = 395
    cmp r1, r6
    bgt 9 // Jump to ELSE IF 3.12

    subi r6, 195  // r6 = 200
    cmp r0, r6
    blt 6 // Jump to ELSE IF 3.12

    addi r6, 90   // r6 = 290
    cmp r0, r6
    bgt 3 // Jump to ELSE IF 3.12

    cmpi r9, 0
    beq 84 // Jump to END IF ELSE 3

    // ELSE IF 3.12 Addr640
    // else if r1 >= 395 && r1 <= 500 && r0 >= 200 && r0 <= 205
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 139  // r6 = 395
    cmp r1, r6
    blt 13 // Jump to ELSE IF 3.13

    addi r6, 105  // r6 = 500
    cmp r1, r6
    bgt 10 // Jump to ELSE IF 3.13

    andi r7, 0    // r7 = 0
    addi r7, 200  // r7 = 200
    cmp r0, r7
    blt 6 // Jump to ELSE IF 3.13

    addi r7, 5    // r7 = 205
    cmp r0, r7
    bgt 3 // Jump to ELSE IF 3.13

    cmpi r9, 0
    beq 66 // Jump to END IF ELSE 3

    // ELSE IF 3.13 Addr658
    // else if r1 >= 495 && r1 <= 500 && r0 >= 205 && r0 <= 270
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 239  // r6 = 495
    cmp r1, r6
    blt 13 // Jump to ELSE IF 3.14

    addi r6, 5    // r6 = 500
    cmp r1, r6
    bgt 10 // Jump to ELSE IF 3.14

    andi r7, 0    // r7 = 0
    addi r7, 205  // r7 = 205
    cmp r0, r7
    blt 6 // Jump to ELSE IF 3.14

    addi r7, 65   // r7 = 270
    cmp r0, r7
    bgt 3 // Jump to ELSE IF 3.14

    cmpi r9, 0
    beq 48 // Jump to END IF ELSE 3

    // ELSE IF 3.14 Addr676
    // else if r1 >= 500 && r1 <= 540 && r0 >= 267 && r0 <= 270
    andi r6, 0    // r6 = 0
    addi r6, 1    // r6 = 1
    lshi r6, 8    // r6 = 256
    addi r6, 244  // r6 = 500
    cmp r1, r6
    blt 14 // Jump to ELSE IF 3.15

    addi r6, 40   // r6 = 540
    cmp r1, r6
    bgt 11 // Jump to ELSE IF 3.15

    andi r7, 0    // r7 = 0
    addi r7, 200  // r7 = 200
    addi r7, 67   // r7 = 267
    cmp r0, r7
    blt 6 // Jump to ELSE IF 3.15

    addi r7, 3    // r7 = 270
    cmp r0, r7
    bgt 3 // Jump to ELSE IF 3.15

    cmpi r9, 0
    beq 29 // Jump to END IF ELSE 3

    // ELSE IF 3.15 Addr695
    // else if r1 >= 540 && r1 <= 560 && r0 >= 267 && r0 <= 270 then You Win
    andi r6, 0    // r6 = 0
    addi r6, 2    // r6 = 2
    lshi r6, 8    // r6 = 512
    addi r6, 28   // r6 = 540
    cmp r1, r6
    blt 15 // Jump to ELSE DEAD 3

    addi r6, 20   // r6 = 560
    cmp r1, r6
    bgt 12 // Jump to ELSE DEAD 3

    andi r7, 0    // r7 = 0
    addi r7, 200  // r7 = 200
    addi r7, 67   // r7 = 267
    cmp r0, r7
    blt 7 // Jump to ELSE DEAD 3

    addi r7, 3    // r7 = 270
    cmp r0, r7
    bgt 4 // Jump to ELSE DEAD 3

    // Won Level 3
    addi r2, 1  // Update Level

    cmpi r9, 0
    beq 9 // Jump to END IF ELSE 3

    // ELSE DEAD 3 Addr715
    // else you die reset x and y positions
    // Update x for level 3
    andi r0, 0   // x = 0
    addi r0, 1   // x = 1
    lshi r0, 8   // x = 256
    addi r0, 64  // x = 320

    // Update y for level 3
    andi r1, 0   // y = 0
    addi r1, 1   // y = 1
    lshi r1, 8   // y = 256
    addi r1, 204 // y = 460
    // END IF ELSE 3 Addr723
// End Maze == 3
// Jump to end of if else statement
cmpi r9, 0
beq 3 // Jump to END IF ELSE
// If maze == 4
// ELSE IF 3 Addr725
// Jump to end of if else
cmpi r2, 4
bne 1 // Jump to END IF ELSE
// Maze == 4
    // Do nothing.  Showing scarry girl.
// End Maze == 4

// END IF ELSE Addr727
// Now we need to update the x and y positions based on input

// If r15 == 8 then move up (decrease y pos)
andi r14, 0
addi r14, 8  // r14 = 8
and r14, r15
cmpi r14, 8
bne 5 // Jump to CHECK DOWN
    cmpi r12, 0  // CHANGE
    bne 3        // CHANGE
    subi r1, 1  // Move up by 1
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
    addi r1, 1  // Move down by 1
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
    subi r0, 1  // Move left by 1
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
    addi r0, 1  // Move right by 1
    addi r12, 1  // Set state to 1 // CHANGE

// CHECK RESET Addr763
// If r15 == 1 then reset the game
andi r14, 0
addi r14, 1  // r14 = 1
and r14, r15
cmpi r14, 1
bne 6  // Jump to END LOOP
    andi r8, 0    // r8 = 0
    addi r8, 253  // r8 = 253
    lshi r8, 8    // r8 = -768
    addi r8, 3   // r8 = -765
    // Address = 7 a772 - 765 = 7
    jal r11, r8 // Jump to GAME RESET

// END LOOP Addr773
andi r8, 0    // r8 = 0
addi r8, 253  // r8 = 253
lshi r8, 8    // r8 = -768
addi r8, 8   // r8 = -760
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