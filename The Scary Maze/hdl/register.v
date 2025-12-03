
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: 		Luke Jones
// 
// Create Date:    	09/09/2025
// Design Name: 
// Module Name:    	register

// Additional Comments: A simple register that when enabled sets data to incoming
//						data. 
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

 