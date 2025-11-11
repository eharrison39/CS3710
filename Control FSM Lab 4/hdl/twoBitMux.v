`timescale 1ns / 1ps

// @Authors Luke Jones, David Brown, Elden Harrison
// RiMux module, the source register and an immediate as input with a 1 bit control line

module twoBitMux (rdest, pc, ctrl, out);
	
	input ctrl;
	input [9:0] rdest, pc;
	output reg[9:0] out;

always @(ctrl, rdest, pc)
begin
	case (ctrl)
	
	1'b0:
		begin
			out = pc;
		end
		
	1'b1:
		begin
			out = rdest;
		end
	default: out = rdest;
	endcase
end

endmodule