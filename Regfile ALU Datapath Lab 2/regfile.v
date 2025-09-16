
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:24:24 09/13/2015 
// Design Name: 
// Module Name:    regbank 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////



/********/
module regfile(aluBus, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, regEn, clk, reset);
	input clk, reset;
	input [15:0] aluBus;
	input [15:0] regEn;
	output [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;

	
register reg0(aluBus, regEn[0], reset, clk, r0);
register reg1(aluBus, regEn[1], reset, clk, r1);
register reg2(aluBus, regEn[2], reset, clk, r2);
register reg3(aluBus, regEn[3], reset, clk, r3);
register reg4(aluBus, regEn[4], reset, clk, r4);
register reg5(aluBus, regEn[5], reset, clk, r5);
register reg6(aluBus, regEn[6], reset, clk, r6);
register reg7(aluBus, regEn[7], reset, clk, r7);
register reg8(aluBus, regEn[8], reset, clk, r8);
register reg9(aluBus, regEn[9], reset, clk, r9);
register reg10(aluBus, regEn[10], reset, clk, r10);
register reg11(aluBus, regEn[11], reset, clk, r11);
register reg12(aluBus, regEn[12], reset, clk, r12);
register reg13(aluBus, regEn[13], reset, clk, r13);
register reg14(aluBus, regEn[14], reset, clk, r14);
register reg15(aluBus, regEn[15], reset, clk, r15);
 

endmodule
/**************/

