`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 		David Brown
//// 
//// Create Date:    12/3/2025 
//// Module Name:    vgaAddressGen
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


module vgaAddress(clk, bright, hCount, vCount, charcode, bgColor, glyphAddr, pixEn);

input clk, bright;
input [9:0] hCount, vCount;
input wire [7:0] charcode;
output reg [7:0] bgColor;
output reg [13:0] glyphAddr;
output reg pixEn;

localparam TILE_W = 8;
localparam TILE_H = 8;
localparam MAP_W  = 80;

wire [6:0] tile_x = hCount / TILE_W;
wire [5:0] tile_y = vCount / TILE_H;

wire [6:0] glyph_x = hCount % TILE_W;
wire [5:0] glyph_y = vCount % TILE_H;
wire [11:0] tile_addr = tile_y * MAP_W + tile_x;


always @(posedge clk) begin
	pixEn <= bright;
	bgColor <= 8'h18;
	glyphAddr <= {charcode, 3'b000} + glyph_y;
end

endmodule

