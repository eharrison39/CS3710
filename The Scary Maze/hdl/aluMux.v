`timescale 1ns / 1ps

// @Authors Luke Jones, David Brown, Elden Harrison
// RiMux module, the source register and an immediate as input with a 1 bit control line

module aluMux (aluOut, memData, address, ctrl, out);
	
	input [1:0] ctrl;
	input [15:0] aluOut, memData, address;
	output reg[15:0] out;

always @(ctrl, aluOut, memData)
begin
	case (ctrl)
	
	2'b00:
		begin
			out = aluOut;
		end
		
	2'b01:
		begin
			out = memData;
		end
		
	2'b10:
		begin
			out = address;
		end
	default: out = aluOut;
	endcase
end

endmodule