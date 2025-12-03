
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

module pcAdder(k, curAddr, nextAddr);

input [15:0] k, curAddr;
output reg [15:0] nextAddr;

always @(k, curAddr) begin
	nextAddr =  curAddr + $signed(k);
end


endmodule