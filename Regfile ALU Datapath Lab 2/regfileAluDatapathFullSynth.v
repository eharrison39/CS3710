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
input [15:0] regEn;
input [3:0] destMuxControl, srcMuxControl;
input fe, ri;
input [15:0] imm;

wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
wire [15:0] aluBus;
wire [15:0] destMuxOut, srcMuxOut, srcImmRegOut;
wire [4:0] flags;
wire [4:0] aluFlags;
wire [4:0] opc5;

regfile ref(.clk(clk), .reset(rst), .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .aluBus(aluBus), .regEn(regEn));
mux destMux( .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .r(destMuxControl), .out(destMuxOut));
mux srcMux( .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .r(srcMuxControl), .out(srcMuxOut));
riMux immediateMux(.ri(ri), .rsrc(srcMuxOut), .imm(imm), .out(srcImmRegOut));
alu alu(.A(destMuxOut), .B(srcImmRegOut), .C(), .Opcode(aluBus), .Flags(aluFlags), .Cin(~opc5[4] & opc5[2] & opc5[1] & opc5[0]));
flagReg flagReg(.in(aluFlags), .regEn(fe), .reset(rst), .clk(clk), .out(flags));

endmodule
/**/