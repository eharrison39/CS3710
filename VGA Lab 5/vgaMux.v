`timescale 1ns / 1ps

// @Authors Luke Jones, David Brown, Elden Harrison
// RiMux module, the source register and an immediate as input with a 1 bit control line

module vgaMux (rgbMem, rgbGen, lvl, out);
	
	input lvl;
	input [7:0] rgbMem, rgbGen;
	output reg[7:0] out;


always @(rgbMem, rgbGen, lvl)
begin
	case (lvl)
	
	1'b0:
		begin
			out = rgbGen;
		end
		
	1'b1:
		begin
			out = rgbMem;
		end
	default: out = rgbGen;
	endcase
end

endmodule