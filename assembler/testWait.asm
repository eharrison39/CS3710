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

cmpi r15, 32
bne 3
    subi r0, 1
    wait

andi r9, 0
cmpi r9, 0
beq -6