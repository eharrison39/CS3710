`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 		David Brown
//// 
//// Create Date:    11/24/2025 
//// Module Name:    vgaDriver
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

module vgaDriverTb(clk, rst, swc, hSync, vSync, rgb, countEn, bright, hCount, vCount);

input wire clk, rst;
input  wire [2:0] swc;
output wire [2:0] rgb;
output wire hSync, vSync;

output wire countEn, bright;
output wire [9:0] hCount, vCount;

vgaClkDiv div (.clk(clk), .rst(rst), .countEn(countEn));

vgaController ctrl (.clk(clk), .rst(rst), .countEn(countEn), .hSync(hSync), .vSync(vSync), 
														.bright(bright), .hCount(hCount), .vCount(vCount));
									
vgaBitgen bitgen (.bright(bright), .pixelData(swc), .hCount(hCount), .vCount(vCount), .rgb(rgb));

endmodule