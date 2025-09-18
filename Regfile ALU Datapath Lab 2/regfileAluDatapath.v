//
//`timescale 1ns / 1ps
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



/********/
module regfileAluDatapath(opcode, clk, rst);

input wire [15:0] opcode;
input wire clk, rst;

wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
wire [15:0] aluBus; // Make this come from alu.
wire [15:0] regEn;  // 
wire [3:0] destMuxControl, srcMuxControl;
wire [15:0] destMuxOut, srcMuxOut, srcImmRegOut;
wire [4:0] flags;
wire fe, ri;
wire [4:0] opc5;


fsm fms(.clk(clk), .rst(rst), .rs(srcMuxControl), .rd(destMuxControl), .opcode(opc5), .re(regEn), .ri(ri), .fe(fe), .inop(opcode));
regfile ref(.clk(clk), .reset(rst), .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .aluBus(aluBus), .regEn(regEn));
mux destMux( .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .r(destMuxControl), .out(destMuxOut));
mux srcMux( .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .r(srcMuxControl), .out(srcMuxOut));
riMux immediateMux(.ri(ri), .rsrc(srcMuxOut), .imm({8'h00, opcode[7:0]}), .out(srcImmRegOut));
alu alu(.A(destMuxOut), .B(srcImmRegOut), .C(), .Opcode(aluBus), .Flags(flags), .Cin(~opc5[4] & opc5[2] & opc5[1] & opc5[0]));
flagReg flagReg(.in(flags), .regEn(fe), .reset(rst), .clk(clk), .out(flags));




endmodule
/**************/
