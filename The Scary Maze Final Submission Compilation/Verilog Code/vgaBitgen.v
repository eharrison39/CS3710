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

module vgaBitgen(bright, pixelData, hCount, vCount, rgb, x, y);

input bright;
input [2:0] pixelData;
input [9:0] hCount, vCount;
input wire[15:0] x, y;

output reg [7:0] rgb;


parameter black = 8'b0000_0000;
parameter blue = 8'b0000_0011, green = 8'b0001_1100, cyan = 8'b0001_1111, red = 8'b1110_0000, magenta = 8'b1110_0011, yellow = 8'b1111_1100;
parameter white = 8'b1111_1111;

always @(*) begin
	if(~bright)
		rgb = black;
	else begin
	
			  // default to black
	  rgb = black;

		// draw the red square centered at (x,y) with +/-5 pixel radius
	   if ((hCount >= x - 4) && (hCount <= x + 4) &&
			  (vCount >= y - 4) && (vCount <= y + 4)) begin
			 rgb = white;
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
								((vCount >= 170) && (vCount <= 300))) begin
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
					else if (((hCount >= 395) && (hCount <= 505)) &&
								((vCount >= 200) && (vCount <= 205))) begin
						rgb = cyan;
					end
					else if (((hCount >= 495) && (hCount <= 505)) &&
								((vCount >= 205) && (vCount <= 275))) begin
						rgb = cyan;
					end
					else if (((hCount >= 505) && (hCount <= 540)) &&
								((vCount >= 272) && (vCount <= 275))) begin
						rgb = cyan;
					end
					else if (((hCount >= 540) && (hCount <= 560)) &&
								((vCount >= 272) && (vCount <= 275))) begin
						rgb = magenta;
					end
					else
						rgb = black;
				end
				
				3'b100: begin
				
					// GHOST FACE
					if((hCount >= 430) && (hCount <= 530) &&
						((vCount >= 100) && (vCount <= 130))) begin
							rgb = black;
					end
					
					else if((hCount >= 410) && (hCount <= 430) &&
						((vCount >= 100) && (vCount <= 140))) begin
							rgb = black;
					end
					
					else if((hCount >= 390) && (hCount <= 410) &&
						((vCount >= 110) && (vCount <= 140))) begin
							rgb = black;
					end
					
					else if((hCount >= 370) && (hCount <= 390) &&
						((vCount >= 120) && (vCount <= 160))) begin
							rgb = black;
					end
					
					// Very LEft block
					else if((hCount >= 350) && (hCount <= 370) &&
						((vCount >= 140) && (vCount <= 340))) begin
							rgb = black;
					end
					
					else if((hCount >= 370) && (hCount <= 390) &&
						((vCount >= 300) && (vCount <= 380))) begin
							rgb = black;
					end
					
					else if((hCount >= 390) && (hCount <= 410) &&
						((vCount >= 320) && (vCount <= 400))) begin
							rgb = black;
					end
					
					else if((hCount >= 410) && (hCount <= 430) &&
						((vCount >= 360) && (vCount <= 460))) begin
							rgb = black;
					end
					
					else if((hCount >= 430) && (hCount <= 450) &&
						((vCount >= 440) && (vCount <= 480))) begin
							rgb = black;
					end
					
					else if((hCount >= 450) && (hCount <= 470) &&
						((vCount >= 460) && (vCount <= 500))) begin
							rgb = black;
					end
					
					//VERY Bottom
					else if((hCount >= 470) && (hCount <= 490) &&
						((vCount >= 480) && (vCount <= 500))) begin
							rgb = black;
					end
					
					
					else if((hCount >= 490) && (hCount <= 510) &&
						((vCount >= 460) && (vCount <= 500))) begin
							rgb = black;
					end
					
					else if((hCount >= 510) && (hCount <= 530) &&
						((vCount >= 440) && (vCount <= 480))) begin
							rgb = black;
					end
					
					else if((hCount >= 530) && (hCount <= 550) &&
						((vCount >= 360) && (vCount <= 460))) begin
							rgb = black;
					end
					
					else if((hCount >= 550) && (hCount <= 570) &&
						((vCount >= 320) && (vCount <= 400))) begin
							rgb = black;
					end
					
					else if((hCount >= 570) && (hCount <= 590) &&
						((vCount >= 300) && (vCount <= 380))) begin
							rgb = black;
					end
					
					// Very RIGHT Side
					else if((hCount >= 590) && (hCount <= 610) &&
						((vCount >= 140) && (vCount <= 340))) begin
							rgb = black;
					end
					
					else if((hCount >= 570) && (hCount <= 590) &&
						((vCount >= 120) && (vCount <= 160))) begin
							rgb = black;
					end
					
					else if((hCount >= 550) && (hCount <= 570) &&
						((vCount >= 110) && (vCount <= 140))) begin
							rgb = black;
					end
					
					else if((hCount >= 530) && (hCount <= 550) &&
						((vCount >= 100) && (vCount <= 140))) begin
							rgb = black;
					end
					
					// Full LONG FACE BOUNDARY IS COMPLETE
					
					
					// LEFT EYE
					else if (((hCount >= 390) && (hCount <= 410)) &&
								((vCount >= 260) && (vCount <= 280))) begin
						rgb = black;
					end
					
					else if (((hCount >= 410) && (hCount <= 430)) &&
								((vCount >= 240) && (vCount <= 280))) begin
						rgb = black;
					end
					
					else if (((hCount >= 430) && (hCount <= 450)) &&
								((vCount >= 220) && (vCount <= 280))) begin
						rgb = black;
					end
					
					else if (((hCount >= 450) && (hCount <= 470)) &&
								((vCount >= 200) && (vCount <= 260))) begin
						rgb = black;
					end
					
					// RIGHT EYE
					else if (((hCount >= 490) && (hCount <= 510)) &&
								((vCount >= 200) && (vCount <= 260))) begin
						rgb = black;
					end
					
					else if (((hCount >= 510) && (hCount <= 530)) &&
								((vCount >= 220) && (vCount <= 280))) begin
						rgb = black;
					end
					
					else if (((hCount >= 530) && (hCount <= 550)) &&
								((vCount >= 240) && (vCount <= 280))) begin
						rgb = black;
					end
					
					else if (((hCount >= 550) && (hCount <= 570)) &&
								((vCount >= 260) && (vCount <= 280))) begin
						rgb = black;
					end
					
					else if (((hCount >= 470) && (hCount <= 490)) &&
								((vCount >= 280) && (vCount <= 300))) begin
						rgb = black;
					end
					
					else if (((hCount >= 450) && (hCount <= 510)) &&
								((vCount >= 320) && (vCount <= 420))) begin
						rgb = black;
					end
					
					else if (((hCount >= 470) && (hCount <= 490)) &&
								((vCount >= 420) && (vCount <= 440))) begin
						rgb = black;
					end
				
					
					
					// 
					else begin
						  rgb = 8'hFF;   // BLACK
					end
				end
				default : rgb = black;
			endcase
		end
	end
end

endmodule
