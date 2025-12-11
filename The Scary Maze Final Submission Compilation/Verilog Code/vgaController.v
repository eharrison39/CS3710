`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 		David Brown
//// 
//// Create Date:    11/24/2025 
//// Module Name:    vgaController
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


module vgaController (clk, rst, countEn, hSync, vSync, bright, hCount, vCount);

input clk, rst, countEn;
output reg hSync, vSync, bright;
output reg [9:0] hCount, vCount;

// HSync Params
parameter hDisp = 10'b1010000000;		// 640
parameter hpw 	 = 10'b0001100000;		// 96		// hsync
parameter hfp	 = 10'b0000010000;		// 16
parameter hbp	 = 10'b0000110000;		// 48
parameter hTot  = hDisp + hpw + hfp + hbp; // 800 

// VSync Params
parameter vDisp = 10'b0111100000;		// 480
parameter vpw 	 = 10'b0000000010;		// 2		// vsync
parameter vfp	 = 10'b0000001010;		// 10
parameter vbp	 = 10'b0000011101;		// 29
parameter vTot  = vDisp + vpw + vfp + vbp; // 521

// hSync Counter
always @(posedge clk or negedge rst) begin
	
	if(~rst) begin
		hCount <= 10'b0000000000;
	end
	else if (countEn) begin
		if (hCount == hTot - 1)
			hCount <= 10'b0000000000;
		else
			hCount <= hCount + 1;	
	end

end

// vSync Counter
always @(posedge clk or negedge rst) begin
	
	if(~rst) begin
		vCount <= 10'b0000000000;
	end
	else if (countEn && hCount == hTot - 1) begin
		if (vCount == vTot - 1)
			vCount <= 10'b0000000000;
		else
			vCount <= vCount + 1;	
	end
	
end

// Sync Signals
always @(*) begin
	hSync = ~((hCount >= hfp) & (hCount < hfp + hpw));
	vSync = ~((vCount >= vfp) & (vCount < vfp + vpw));
	
	bright = (hCount >= hbp + hpw + hfp) && (vCount >= vbp + vpw + vfp);
end

endmodule
		
