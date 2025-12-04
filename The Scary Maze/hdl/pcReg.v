
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
output reg [15:0] out;

always @ (posedge clk)
begin
	if(~reset)
		out <= 16'h0000;
	else
	begin
		if(pcEn)
			out <= in;
		else
			out <= out;
	end
end

endmodule


