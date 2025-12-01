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

module vgaDriver(clk, rst, swc, hSync, vSync, rgb, bright, countEn);

input wire clk, rst;
input  wire [2:0] swc;
output wire [23:0] rgb;
output wire hSync, vSync, bright, countEn;

wire [9:0] hCount, vCount;
wire [2:0] rgb_base;

assign rgb = {rgb_base[2], 7'b0, rgb_base[1], 7'b0, rgb_base[0], 7'b0};

vgaClkDiv div (.clk(clk), .rst(rst), .countEn(countEn));

vgaController ctrl (.clk(clk), .rst(rst), .countEn(countEn), .hSync(hSync), .vSync(vSync), 
														.bright(bright), .hCount(hCount), .vCount(vCount));
									
//vgaBitgenMem bitgen (.clk(clk), .pixelData(swc), .bright(bright), .hCount(hCount), .vCount(vCount), .rgb(rgb_base));
vgaBitgen bitgen (.pixelData(swc), .bright(bright), .hCount(hCount), .vCount(vCount), .rgb(rgb_base));

endmodule