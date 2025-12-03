
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: 		Luke Jones
// 
// Create Date:    09/12/2025
// Module Name:    regfile
// Dependencies: 	 ALU, fsm
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: A simple reg file that holds 16 registers.
//
//////////////////////////////////////////////////////////////////////////////////



/********/
module regfile(aluBus, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, regEn, clk, reset, snesInput);
	input clk, reset;
	input [15:0] aluBus;
	input [15:0] regEn;
	input [15:0] snesInput;
	output [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;

// Instantiate all registers, connecting the aluBus, reg enables, clk, reset and output registers.
(* preserve, keep *)register reg0(aluBus, regEn[0], reset, clk, r0);
(* preserve, keep *)register reg1(aluBus, regEn[1], reset, clk, r1);
(* preserve, keep *)register reg2(aluBus, regEn[2], reset, clk, r2);
(* preserve, keep *)register reg3(aluBus, regEn[3], reset, clk, r3);
(* preserve, keep *)register reg4(aluBus, regEn[4], reset, clk, r4);
(* preserve, keep *)register reg5(aluBus, regEn[5], reset, clk, r5);
(* preserve, keep *)register reg6(aluBus, regEn[6], reset, clk, r6);
(* preserve, keep *)register reg7(aluBus, regEn[7], reset, clk, r7);
(* preserve, keep *)register reg8(aluBus, regEn[8], reset, clk, r8);
(* preserve, keep *)register reg9(aluBus, regEn[9], reset, clk, r9);
(* preserve, keep *)register reg10(aluBus, regEn[10], reset, clk, r10);
(* preserve, keep *)register reg11(aluBus, regEn[11], reset, clk, r11);
(* preserve, keep *)register reg12(aluBus, regEn[12], reset, clk, r12);
(* preserve, keep *)register reg13(aluBus, regEn[13], reset, clk, r13);
(* preserve, keep *)register reg14(aluBus, regEn[14], reset, clk, r14);
(* preserve, keep *)register reg15({1'b0, snesInput[14:0]}, 1'b1, reset, clk, r15);
 

endmodule
/**************/

