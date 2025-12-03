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

module vgaDriver(clk, rst, swc, hSync, vSync, rgb, bright, vgaClk);

input wire clk, rst;
input  wire [2:0] swc;
output wire [23:0] rgb;
output wire hSync, vSync, bright, vgaClk;

wire [9:0] hCount, vCount;
wire [7:0] bgColor, q;
wire [7:0] rgb_base;
wire [13:0] glyphAddr;
wire pixEn;

wire [2:0] glyphX = hCount[2:0];
wire [7:0] pixelRow = q;   // from glyph ROM


assign rgb = {rgb_base[7:5], 5'b0, rgb_base[4:2], 5'b0, rgb_base[1:0], 6'b0};

vgaAddress addr(.clk(clk), .bright(bright), .hCount(hCount), .vCount(vCount), 
									.bgColor(bgColor), .glyphAddr(glyphAddr), .pixEn(pixEn));
vgaGlyphRom glyph(.clk(clk), .address(glyphAddr), .q(q))

vgaClkDiv div (.clk(clk), .rst(rst), .countEn(vgaClk));

vgaController ctrl (.clk(clk), .rst(rst), .countEn(vgaClk), .hSync(hSync), .vSync(vSync), 
														.bright(bright), .hCount(hCount), .vCount(vCount));
									
//vgaBitgenMem bitgen (.clk(clk), .pixelData(swc), .bright(bright), .hCount(hCount), .vCount(vCount), .rgb(rgb_base));
vgaBitgen bitgen (.bgColor(bgColor), .pixelData(swc), .pixEn(pixEn), .glyphX(glyphX), .pixelRow(pixelRow),
						.bright(bright), .hCount(hCount), .vCount(vCount), .rgb(rgb_base));

endmodule