module regfileAluDatapathtwo(clk, rst, segOutput1, segOutput2, segOutput3);

input wire clk, rst;

wire [15:0] imm;
wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
wire [15:0] aluBus; // Make this come from alu.
wire [15:0] regEn;
wire [3:0] destMuxControl, srcMuxControl;
wire [15:0] destMuxOut, srcMuxOut, srcImmRegOut;
wire [4:0] flags;
wire fe, ri;
wire [4:0] opc5;

output wire [6:0] segOutput1, segOutput2, segOutput3;



fsmtwo fsm(.clk(clk), .rst(rst), .rs(srcMuxControl), .rd(destMuxControl), .opcode(opc5), .re(regEn), .ri(ri), .fe(fe), .imm(imm));
regfile ref(.clk(clk), .reset(rst), .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .aluBus(aluBus), .regEn(regEn));
mux destMux(.r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .r(destMuxControl), .out(destMuxOut));
mux srcMux(.r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .r(srcMuxControl), .out(srcMuxOut));
riMux immediateMux(.ri(ri), .rsrc(srcMuxOut), .imm(imm), .out(srcImmRegOut));
alu alu(.A(destMuxOut), .B(srcImmRegOut), .C(aluBus), .Opcode(opc5), .Flags(flags), .Cin(~opc5[4] & opc5[2] & opc5[1] & opc5[0]));
flagReg flagReg(.in(flags), .regEn(fe), .reset(rst), .clk(clk), .out(flags));


bcd_to_sev_seg bcd1(aluBus[3:0], segOutput1);
bcd_to_sev_seg bcd2(aluBus[7:4], segOutput2);
bcd_to_sev_seg bcd3(aluBus[11:8], segOutput3);



endmodule