//////////////////////////////////////////////////////////////////////////////////
// Engineer: 		Luke Jones, David Brown, Elden Harrison
// 
// Create Date:    09/12/2025
// Module Name:    regfileAluDatapath
// Dependencies:   ALU, fsm, regfile, mux, riMux, flagreg, bcd to seven seg
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: The full regFileALUDatapath implementation. Connects
//                      all the modules with wires sets output to the 7seg bcd.
//
//////////////////////////////////////////////////////////////////////////////////

(* keep_hierarchy = "yes" *)
(* noprune = 1 *)
module regfileAluDatapath(clk, rst, segOutput1, segOutput2, segOutput3);

input wire clk, rst;

wire [15:0] imm;

// Create wires to hold values passed into each module
wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;  // Registers
wire [15:0] aluBus; // Output from the alu, fed into the regfile
wire [15:0] regEn;  // Register Enables
wire [3:0] destMuxControl, srcMuxControl;  // Mux Control Lines
wire [15:0] destMuxOut, srcMuxOut, srcImmRegOut;  // Mux Output Wires
wire [4:0] flags;  // flags wire
wire [4:0] aluFlags;
wire fe, ri;  // Flag enable control wire and register immediate control line
wire [4:0] opc5;    // Opcode from the fsm fed into the alu

output wire [6:0] segOutput1, segOutput2, segOutput3;

// Create the fsm with the clock and have it feed the control lines.
ffsm fms(.clk(clk), .rst(rst), .rs(srcMuxControl), .rd(destMuxControl), .opcode(opc5), .re(regEn), .ri(ri), .fe(fe), .imm(imm));

// Instantiate the regfile with 16 registers
regfile ref(.clk(clk), .reset(rst), .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .aluBus(aluBus), .regEn(regEn));

// Create the destination mux, the source mux and the register/immediate mux
mux destMux(.r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .r(destMuxControl), .out(destMuxOut));
mux srcMux(.r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .r(srcMuxControl), .out(srcMuxOut));
riMux immediateMux(.ri(ri), .rsrc(srcMuxOut), .imm(imm), .out(srcImmRegOut));

// Instantiate the alu with the 
alu alu(.A(destMuxOut), .B(srcImmRegOut), .C(aluBus), .Opcode(opc5), .Flags(aluFlags), .Cin(~opc5[4] & opc5[2] & opc5[1] & opc5[0]));
flagReg flagReg(.in(aluFlags), .regEn(fe), .reset(rst), .clk(clk), .out(flags));

// Have bcd to seven seg display what the alu outputs
bcd_to_sev_seg bcd1(aluBus[3:0], segOutput1);
bcd_to_sev_seg bcd2(aluBus[7:4], segOutput2);
bcd_to_sev_seg bcd3(aluBus[11:8], segOutput3);

endmodule