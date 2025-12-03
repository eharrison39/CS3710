// Og test
ori r0, 5 // instruction
ori r1, 1
sub r0, r1
addui r2, 1
   bne -2
    jal r9, r2
        ori r1, 3  // Just ensuring tabs work
ori r2, 5
or r2, r1
add r2, r1
ori r3, 10
cmp r2, r3
bne -6
beq 2
andi r3, 9
ori r3, 9
ori r4, 23
ori r5, 24
stor r3, r4
stor r9, r5
load r6, r4
load r7, r5

// Begins at line 23
add r2, r1
addi r9, 15
addu r10, r11
addui r12, 255
addc r13, r14
addci r15, 0
sub r0, r1
subi r3, 8
cmp r4, r5
cmpi r6, 12
and r7, r8
andi r9, -55
or r3, r2
ori r1, 34
xor r5, r6
xori r7, 99
not r8
lsh r9, r5
lshi r0, 12
rsh r8, r15
arsh r14, r10
load r2, r8
stor r3, r9
beq 5
bne -10
bge 3
bcs -4
bcc -45
bhi 5
bls 0
blo 7
bhs 35
bgt 127
ble -128
bfs 12
bfc -8
blt 7
buc 5
jal r3, r8

// These should all be errors
// add r18, r1    // Invalid register
// add r20, r2    // Invalid register
// add r34, r3    // Invalid register
// add r202, r4   // Invalid register
// add r16, r1       // Invalid register
// addi r20, 5     // Invalid register
// sub r2, r-1       // Negative register
// andi r3, 300      // Immediate value too large
// beq 30000         // Branch offset too large
// stor r2, r3, r4   // Too many operands
// load r5            // Too few operands
// xor r1, r2, r3    // Too many operands
// lshi r2, -5      // Negative immediate value
// bge -200        // Branch offset too large
// jal r10, -5000   // Jump address too large
// unknown r1, r2    // Unknown instruction
// not r1, r2        // Too many operands
// addi r1            // Too few operands
// bne abc          // Invalid immediate value
// bgt 3.5         // Invalid immediate value
// addi r2, -10   // Negative immediate value
// addi add r3, r4
// add add
// sub r3, subi
// addi r3, r4