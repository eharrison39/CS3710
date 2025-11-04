
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		Luke Jones
// 
// Create Date:    10/30/2025
// Design Name: 
// Module Name:    flag reg
// Revision: 		
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module pcReg(in, pcEn, reset, clk, out);
input [15:0] in;
input pcEn, reset, clk;
output [15:0] out;


(* preserve, keep *)register thePcReg(.in(in), .regEn(pcEn), .reset(reset), .clk(clk), .out(out));

endmodule


