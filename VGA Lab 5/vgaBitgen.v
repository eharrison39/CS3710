`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 		David Brown
//// 
//// Create Date:    11/24/2025 
//// Module Name:    vgaBitgen
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

module vgaBitgen(bright, pixelData, bgColor, pixEn, glyphX, pixelRow, hCount, vCount, rgb);

input bright, pixEn;
input [7:0] bgColor, pixelRow;
input [2:0] glyphX, pixelData;
input [9:0] hCount, vCount;
//input [15:0] x, y;

output reg [7:0] rgb;

wire pixel = pixelRow[7 - glyphX];

parameter black = 8'b0000_0000;
parameter blue = 8'b0000_0011, green = 8'b0001_1100, cyan = 8'b0001_1111, red = 8'b1110_0000, magenta = 8'b1110_0011, yellow = 8'b1111_1100;
parameter white = 8'b1111_1111;

always @(*) begin
	if(~bright || ~pixEn)
		rgb = black;
	else begin
	
			  // default to black
	  rgb = black;

		// draw the red square centered at (x,y) with +/-5 pixel radius
	   if ((hCount >= 300 - 2) && (hCount <= 300 + 2) &&
			  (vCount >= 300 - 2) && (vCount <= 300 + 2)) begin
			 rgb = cyan;
	   end
		else begin
			case (pixelData)
			
				3'b001: begin
					if (((hCount >= 310) && (hCount <= 620)) &&
								((vCount >= 100) && (vCount <= 120))) begin
						rgb = magenta;
					end
					else if (((hCount >= 620) && (hCount <= 650)) &&
								((vCount >= 100) && (vCount <= 120))) begin
						rgb = blue;
					end
					else if (((hCount >= 320) && (hCount <= 330)) &&
								((vCount >= 120) && (vCount <= 200))) begin
						rgb = magenta;
					end
					else if (((hCount >= 310) && (hCount <= 650)) &&
								((vCount >= 200) && (vCount <= 230))) begin
						rgb = magenta;
					end
					else if (((hCount >= 630) && (hCount <= 650)) &&
								((vCount >= 230) && (vCount <= 300))) begin
						rgb = magenta;
					end
					else if (((hCount >= 310) && (hCount <= 650)) &&
								((vCount >= 300) && (vCount <= 350))) begin
						rgb = magenta;
					end
					else if (((hCount >= 310) && (hCount <= 340)) &&
								((vCount >= 350) && (vCount <= 400))) begin
						rgb = magenta;
					end
					else if (((hCount >= 310) && (hCount <= 650)) &&
								((vCount >= 400) && (vCount <= 480))) begin
						rgb = magenta;
					end
					else
						rgb = black;
				end
				
				3'b010: begin
					if (((hCount >= 310) && (hCount <= 380)) &&
								((vCount >= 150) && (vCount <= 480))) begin
						rgb = green;
					end
					else if (((hCount >= 310) && (hCount <= 350)) &&
								((vCount >= 120) && (vCount <= 150))) begin
						rgb = green;
					end
					else if (((hCount >= 310) && (hCount <= 410)) &&
								((vCount >= 100) && (vCount <= 120))) begin
						rgb = green;
					end
					else if (((hCount >= 410) && (hCount <= 460)) &&
								((vCount >= 100) && (vCount <= 150))) begin
						rgb = green;
					end
					else if (((hCount >= 430) && (hCount <= 480)) &&
								((vCount >= 150) && (vCount <= 200))) begin
						rgb = green;
					end
					else if (((hCount >= 450) && (hCount <= 510)) &&
								((vCount >= 200) && (vCount <= 480))) begin
						rgb = green;
					end
					else if (((hCount >= 510) && (hCount <= 640)) &&
								((vCount >= 450) && (vCount <= 480))) begin
						rgb = green;
					end
					else if (((hCount >= 620) && (hCount <= 640)) &&
								((vCount >= 140) && (vCount <= 480))) begin
						rgb = green;
					end
					else if (((hCount >= 510) && (hCount <= 640)) &&
								((vCount >= 120) && (vCount <= 140))) begin
						rgb = green;
					end
					else if (((hCount >= 510) && (hCount <= 520)) &&
								((vCount >= 100) && (vCount <= 120))) begin
						rgb = green;
					end
					else if (((hCount >= 520) && (hCount <= 640)) &&
								((vCount >= 100) && (vCount <= 110))) begin
						rgb = green;
					end
					else if (((hCount >= 640) && (hCount <= 650)) &&
								((vCount >= 100) && (vCount <= 110))) begin
						rgb = magenta;
					end
					else
						rgb = black;
					
				end
				
				3'b011: begin
					if (((hCount >= 310) && (hCount <= 650)) &&
								((vCount >= 440) && (vCount <= 480))) begin
						rgb = cyan;
					end
					else if (((hCount >= 620) && (hCount <= 650)) &&
								((vCount >= 380) && (vCount <= 440))) begin
						rgb = cyan;
					end
					else if (((hCount >= 310) && (hCount <= 620)) &&
								((vCount >= 380) && (vCount <= 410))) begin
						rgb = cyan;
					end
					else if (((hCount >= 310) && (hCount <= 330)) &&
								((vCount >= 100) && (vCount <= 380))) begin
						rgb = cyan;
					end
					else if (((hCount >= 330) && (hCount <= 650)) &&
								((vCount >= 100) && (vCount <= 150))) begin
						rgb = cyan;
					end
					else if (((hCount >= 620) && (hCount <= 650)) &&
								((vCount >= 150) && (vCount <= 350))) begin
						rgb = cyan;
					end
					else if (((hCount >= 360) && (hCount <= 620)) &&
								((vCount >= 320) && (vCount <= 350))) begin
						rgb = cyan;
					end
					else if (((hCount >= 360) && (hCount <= 380)) &&
								((vCount >= 170) && (vCount <= 320))) begin
						rgb = cyan;
					end
					else if (((hCount >= 380) && (hCount <= 600)) &&
								((vCount >= 170) && (vCount <= 180))) begin
						rgb = cyan;
					end
					else if (((hCount >= 585) && (hCount <= 600)) &&
								((vCount >= 180) && (vCount <= 300))) begin
						rgb = cyan;
					end
					else if (((hCount >= 390) && (hCount <= 585)) &&
								((vCount >= 290) && (vCount <= 300))) begin
						rgb = cyan;
					end
					else if (((hCount >= 390) && (hCount <= 395)) &&
								((vCount >= 200) && (vCount <= 290))) begin
						rgb = cyan;
					end
					else if (((hCount >= 395) && (hCount <= 500)) &&
								((vCount >= 200) && (vCount <= 205))) begin
						rgb = cyan;
					end
					else if (((hCount >= 495) && (hCount <= 500)) &&
								((vCount >= 205) && (vCount <= 270))) begin
						rgb = cyan;
					end
					else if (((hCount >= 500) && (hCount <= 540)) &&
								((vCount >= 267) && (vCount <= 270))) begin
						rgb = cyan;
					end
					else if (((hCount >= 540) && (hCount <= 560)) &&
								((vCount >= 267) && (vCount <= 270))) begin
						rgb = magenta;
					end
					else
						rgb = black;
				end
				
				3'b100: begin
					rgb = pixel ? 8'hFF : bg_color;
				end
					
				default rgb = black;
			endcase
		end
	end
end

endmodule
