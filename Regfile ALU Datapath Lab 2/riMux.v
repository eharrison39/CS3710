`timescale 1ns / 1ps

// @Authors Luke Jones, David Brown, Elden Harrison
// RiMux module, the source register and an immediate as input with a 1 bit control line

module riMux (rsrc, imm, ri, out);
	
	input ri;
	input [15:0] rsrc, imm;
	output reg[15:0] out;

always @(ri, rsrc, imm)
begin
	case (ri)
	
	1'b0:
		begin
			out = rsrc;
		end
		
	1'b1:
		begin
			out = imm;
		end
	default: out = rsrc;
	endcase
end

endmodule