`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 		David Brown
//// 
//// Create Date:    11/24/2025 
//// Module Name:    vgaClkDiv
//// Project Name: 	vga
//// Description: 	
////
//// Dependencies: 	
////
//// Revision 0.01 - File Created
////
////////////////////////////////////////////////////////////////////////////////////
//
//
//////////////////////////////////////////////////////////////////////////////////

module vgaClkDiv(clk, rst, countEn);

input clk, rst;
output reg countEn;

reg div;

always @(posedge clk or negedge rst) begin
	
	if (~rst) begin
		countEn <= 1'b0;
		div <= 1'b0;
	end
	else begin
		div <= ~div;
		countEn <= (div == 1);  
	end	
end

endmodule 

