
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: David Brown
// 
// Create Date: 11/4/2025
// Design Name: Program Counter
// Module Name: pc
// Description: Increments the PC register by k and outputs the new address
//////////////////////////////////////////////////////////////////////////////////

module pcAdder(
	 input [15:0] k,
    input pcEn,
    input rst,
    input clk,
    output [9:0] addr
);
wire [15:0] pc_in;
wire [15:0] pc_out;

// Add k to the current PC value
assign pc_in = pc_out + k;

// Instantiate the PC register
pcReg thePcReg (.in(pc_in), .pcEn(pcEn), .reset(reset), .clk(clk),.out(pc_out));

// Output the current address
assign addr = pc_out;

endmodule
	
	
	 