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

module vgaBitgen(bright, pixelData, hCount, vCount, rgb);

input bright;
input [2:0] pixelData;
input [9:0] hCount, vCount;
output reg [2:0] rgb;

parameter black = 3'b000;
parameter blue = 3'b001, green = 3'b010, cyan = 3'b011, red = 3'b100, magenta = 3'b101, yellow = 3'b110;
parameter white = 3'b111;

always @(*) begin
	if(~bright)
		rgb = black;
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
				
			default rgb = black;
		endcase
	end
end

endmodule
