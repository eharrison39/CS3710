`timescale 1ns / 1ps

// @Authors David Brown
// pcMux module, input a 1, an imm displacement and an rsrcDisp. Has a 2 bit control line 
module pcMux (one, immDisp, rsrcDisp, ctrl, out);
	
	input [1:0] ctrl;
	input [15:0] one, immDisp, rsrcDisp;
	output reg[15:0] out;

always @(one, immDisp, rsrcDisp, ctrl)
begin
	case (ctrl)
	
	2'b00:
		begin
			// add 1
			out = one;
		end
		
	2'b01:
		begin
			// branch
			out = immDisp;
		end
	2'b10:
		begin
			// jump
			out = rsrcDisp;
		end
	default: out = one;
	endcase
end

endmodule