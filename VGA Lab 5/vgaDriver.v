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

wire [7:0] rgbMem, rgbGen, rgb_base;
wire [9:0] x, y;
assign x = 200;
assign y = 200;

wire [7:0] r8 = { rgb_base[7:5], rgb_base[7:5], rgb_base[7:6] }; // 3 bits -> 8 bits
wire [7:0] g8 = { rgb_base[4:2], rgb_base[4:2], rgb_base[4:3] }; // 3 bits -> 8 bits
wire [7:0] b8 = { rgb_base[1:0], rgb_base[1:0], rgb_base[1:0], rgb_base[1:0] }; // 2 bits -> 8 bits (replicate)

assign rgb = { r8, g8, b8 };

//assign rgb = {rgb_base[7:5], 5'b0, rgb_base[4:2], 5'b0, rgb_base[1:0], 6'b0};

//vgaAddress addr(.clk(vgaClk), .bright(bright), .charcode(charcode), .hCount(hCount), .vCount(vCount), 
									//.bgColor(bgColor), .glyphAddr(glyphAddr), .pixEn(pixEn));
//vgaGlyphRom glyph(.clk(vgaClk), .address(glyphAddr), .q(q));

vgaClkDiv div (.clk(clk), .rst(rst), .countEn(vgaClk));

vgaController ctrl (.clk(clk), .rst(rst), .countEn(vgaClk), .hSync(hSync), .vSync(vSync), 
														.bright(bright), .hCount(hCount), .vCount(vCount));
vgaMux memMux(.rgbMem(rgbMem), .rgbGen(rgbGen), .lvl(swc[2]), .out(rgb_base));
									
vgaBitgenMem bitgenMem (.clk(clk), .pixelData(swc), .bright(bright), .hCount(hCount), .vCount(vCount), .rgb(rgbMem));
vgaBitgen bitgen (.pixelData(swc), .bright(bright), .hCount(hCount), .vCount(vCount), .rgb(rgbGen), .x(x), .y(y));



endmodule