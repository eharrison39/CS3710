`timescale 1ns / 1ps

// @Authors Luke Jones, David Brown, Elden Harrison
// Mux module, 16 registers as input with a 4 bit opcode as the control line
// look into an actual verilog mux
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
	endcase
end

endmodule