
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

module register(in, regEn, reset, clk, out);
input [15:0] in;
input regEn, reset, clk;
output reg [15:0] out;

always @ (posedge clk)
begin
	if(~reset)
		out <= 16'h0000;
	else
	begin
		if(regEn)
			out <= in;
		else
			out <= out;
	end
end

endmodule
