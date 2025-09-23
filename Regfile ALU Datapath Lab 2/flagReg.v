
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

module flagReg(in, regEn, reset, clk, out);
input [4:0] in;
input regEn, reset, clk;
output reg [4:0] out;

always @ (posedge clk or negedge reset)
begin
	if(~reset)
		out <= 5'b00000;
	else
	begin
		if(regEn)
			out <= in;
		else
			out <= out;
	end
end

endmodule
