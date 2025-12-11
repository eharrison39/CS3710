
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		Luke Jones
// 
// Create Date:    09/13/2025
// Design Name: 
// Module Name:    flag reg
// Revision: 		
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

(* preserve, keep *)
module flagReg(in, regEn, reset, clk, out);
input [4:0] in;
input regEn, reset, clk;
output reg [4:0] out;

always @ (posedge clk)
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
