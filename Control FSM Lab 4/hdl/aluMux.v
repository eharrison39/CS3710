`timescale 1ns / 1ps

// @Authors Luke Jones, David Brown, Elden Harrison
// RiMux module, the source register and an immediate as input with a 1 bit control line

module aluMux (aluOut, memData, ctrl, out);
	
	input ctrl;
	input [15:0] aluOut, memData;
	output reg[15:0] out;

always @(ctrl, aluOut, memData)
begin
	case (ctrl)
	
	1'b0:
		begin
			out = aluOut;
		end
		
	1'b1:
		begin
			out = memData;
		end
	default: out = aluOut;
	endcase
end

endmodule