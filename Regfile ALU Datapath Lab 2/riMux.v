`timescale 1ns / 1ps

// @Authors Luke Jones, David Brown, Elden Harrison
// Mux module, 16 registers as input with a 4 bit opcode as the control line
// look into an actual verilog mux
module mux (rsrc, imm, ri, out);
	
	input [1:0] ri;
	input [15:0] rsrc, imm;
	output reg[15:0] out;
	
always @(r, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15)
begin
	case (r)
	
	4'b0000:
		begin
			out = r0;
		end
		
	4'b0001:
		begin
			out = r1;
		end
		
	4'b0010:
		begin
			out = r2;
		end
	
	4'b0011:
		begin
			out = r3;
		end
	
	4'b0100:
		begin
			out = r4;
		end
		
	4'b0101:
		begin
			out = r5;
		end
		
	4'b0110:
		begin
			out = r6;
		end
		
	4'b0111:
		begin
			out = r7;
		end
		
	4'b1000:
		begin
			out = r8;
		end
		
	4'b1001:
		begin
			out = r9;
		end
		
	4'b1010:
		begin
			out = r10;
		end
	
	4'b1011:
		begin
			out = r11;
		end
	
	4'b1100:
		begin
			out = r12;
		end
		
	4'b1101:
		begin
			out = r13;
		end
		
	4'b1110:
		begin
			out = r14;
		end
		
	4'b1111:
		begin
			out = r15;
		end
	endcase
end

endmodule