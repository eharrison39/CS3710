`timescale 1ns / 1ps

// @Authors Luke Jones, David Brown, Elden Harrison
// twoBitMux module, the destination register with the address and the program counter as input with a 1 bit control line

module addrMux (rdest, pc, ctrl, out);
	
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