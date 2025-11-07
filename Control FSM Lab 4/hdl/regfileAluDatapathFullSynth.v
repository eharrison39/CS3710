`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date:    15:24:24 09/13/2015 
//// Design Name: 
//// Module Name:    regbank 
//// Project Name: 
//// Target Devices: 
//// Tool versions: 
//// Description: 
////
//// Dependencies: 
////
//// Revision: 
//// Revision 0.01 - File Created
//// Additional Comments: 
////
////////////////////////////////////////////////////////////////////////////////////
//
//
//////////////////////////////////////////////////////////////////////////////////



/**/
(* keep_hierarchy = "yes" *)
(* noprune = 1 *)
module regfileAluDatapathFullSynth(clk, rst, regEn, destMuxControl, srcMuxControl, fe, ri, imm);

input wire clk, rst;


// Inputs from fsm
wire [15:0] regEn;
wire [3:0] destMuxControl, srcMuxControl;
wire fe, ri, ir;
wire [15:0] imm;

// FSM Output
wire [15:0] instruction;

// Regfile Alu Datapath
wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
wire [15:0] aluBus;
wire [15:0] destMuxOut, srcMuxOut, srcImmRegOut;
wire [4:0] flags;
wire [4:0] aluFlags;
wire [4:0] opc5;

// Memory
wire [15:0] memOutA, memOutB;
wire memAEn, memBEn;


// Needed from  program counter
wire [9:0] addrA, addrB;

wire pcEn;


// Regfile Alu Datapath
regfile ref(.clk(clk), .reset(rst), .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .aluBus(aluBus), .regEn(regEn));

mux destMux( .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .r(destMuxControl), .out(destMuxOut));
mux srcMux( .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .r(srcMuxControl), .out(srcMuxOut));
riMux immediateMux(.ri(ri), .rsrc(srcMuxOut), .imm(imm), .out(srcImmRegOut));

alu alu(.b(destMuxOut), .b(srcImmRegOut), .c(aluBus), .opcode(opc5), .flags(aluFlags), .cin(~opc5[4] & opc5[2] & opc5[1] & opc5[0]));
flagReg flagReg(.in(aluFlags), .regEn(fe), .reset(rst), .clk(clk), .out(flags));

// Memory
dualPortRam ram(.we_a(memAEn), .we_b(memBEn), .clk(clk), .addr_a(addrA), .addr_b(addrB), 
						  .data_a(aluBus), .data_b(aluBus), .q_a(memOutA), .q_b(memOutB));
						  
// Instruction Register
register instructionReg(.in(memOutA), .regEn(ir), .rst(rst), .clk(clk),  .out(instruction))
						  
// Program Counter
pcAdder(.k(1), .pcEn(pcEn), .rst(rst), .clk(clk), .addr(addrA))

// FSM
fsm theFsm(.clk(clk), .rst(rst), .inop(memOutA), .instruction(instruction), .rsMuxCtrl(srcMuxCtrl), .rdMuxCtrl(destMuxCtrl), 
			  .opcode(opc5), .regEn(regEn), .fe(fe), .imm(imm), .ri(ri), .pcEn(pcEn))




endmodule
/**/