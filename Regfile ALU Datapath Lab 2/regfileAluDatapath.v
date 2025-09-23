module regfileAluDatapath(clk, rst, segOutput1, segOutput2, segOutput3);

input wire clk, rst;

wire [15:0] imm;

wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
//wire [15:0] r0a, r1a, r2a, r3a, r4a, r5a, r6a, r7a, r8a, r9a, r10a, r11a, r12a, r13a, r14a, r15a;
//wire [15:0] r0b, r1b, r2b, r3b, r4b, r5b, r6b, r7b, r8b, r9b, r10b, r11b, r12b, r13b, r14b, r15b;
wire [15:0] aluBus; // Make this come from alu.
wire [15:0] regEn;  // 
wire [3:0] destMuxControl, srcMuxControl;
wire [15:0] destMuxOut, srcMuxOut, srcImmRegOut;
wire [4:0] flags;
wire fe, ri;
wire [4:0] opc5;

output wire [6:0] segOutput1, segOutput2, segOutput3;

//assign r0a = r0;
//assign r1a = r1;
//assign r2a = r2;
//assign r3a = r3;
//assign r4a = r4;
//assign r5a = r5;
//assign r6a = r6;
//assign r7a = r7;
//assign r8a = r8;
//assign r9a = r9;
//assign r10a = r10;
//assign r11a = r11;
//assign r12a = r12;
//assign r13a = r13;
//assign r14a = r14;
//assign r15a = r15;
//
//assign r0b = r0;
//assign r1b = r1;
//assign r2b = r2;
//assign r3b = r3;
//assign r4b = r4;
//assign r5b = r5;
//assign r6b = r6;
//assign r7b = r7;
//assign r8b = r8;
//assign r9b = r9;
//assign r10b = r10;
//assign r11b = r11;
//assign r12b = r12;
//assign r13b = r13;
//assign r14b = r14;
//assign r15b = r15;



ffsm fms(.clk(clk), .rst(rst), .rs(srcMuxControl), .rd(destMuxControl), .opcode(opc5), .re(regEn), .ri(ri), .fe(fe), .imm(imm));
regfile ref(.clk(clk), .reset(rst), .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .aluBus(aluBus), .regEn(regEn));
//mux destMux( .r0(r0a), .r1(r1a), .r2(r2a), .r3(r3a), .r4(r4a), .r5(r5a), .r6(r6a), .r7(r7a), .r8(r8a), .r9(r9a), .r10(r10a), .r11(r11a), .r12(r12a), .r13(r13a), .r14(r14a), .r15(r15a), .r(destMuxControl), .out(destMuxOut));
//mux srcMux( .r0(r0b), .r1(r1b), .r2(r2b), .r3(r3b), .r4(r4b), .r5(r5b), .r6(r6b), .r7(r7b), .r8(r8b), .r9(r9b), .r10(r10b), .r11(r11b), .r12(r12b), .r13(r13b), .r14(r14b), .r15(r15b), .r(srcMuxControl), .out(srcMuxOut));
mux destMux(.r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .r(destMuxControl), .out(destMuxOut));
mux srcMux(.r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .r(srcMuxControl), .out(srcMuxOut));
riMux immediateMux(.ri(ri), .rsrc(srcMuxOut), .imm(imm), .out(srcImmRegOut));
alu alu(.A(destMuxOut), .B(srcImmRegOut), .C(aluBus), .Opcode(opc5), .Flags(flags), .Cin(~opc5[4] & opc5[2] & opc5[1] & opc5[0]));
flagReg flagReg(.in(flags), .regEn(fe), .reset(rst), .clk(clk), .out(flags));


bcd_to_sev_seg bcd1(aluBus[3:0], segOutput1);
bcd_to_sev_seg bcd2(aluBus[7:4], segOutput2);
bcd_to_sev_seg bcd3(aluBus[11:8], segOutput3);



endmodule