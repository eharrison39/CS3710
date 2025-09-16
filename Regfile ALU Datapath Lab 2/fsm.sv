`timescale 1ns / 1ps

// @Authors Luke Jones, David Brown, Elden Harrison
// fsm module

//
module fsm(clk, rst, rs, rd, opcode, re, ri, fe, inop);
	
	input clk, rst;
	input [15:0] inop;
	output reg [3:0] rs, rd;
	output reg [4:0] opcode;
	output reg [15:0] re;
	output reg ri, fe;
	
	Reg [1:0]y;
	parameter [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
	
	always @(posedge clk or negedge rst) begin
	 if (~rst)
		state <= S0;
	 else
		case(y)
			S0: y <= S1
			S1: y <= S2
			S2: y <= S3
			S3: y <= S3
			default: y <= S0
		endcase
	end
			
	always@ (y)
		S0:
			begin
				re = 16'h0000;
				rs = rd = 4'h0;
				opcode = 5'b0_0000;
				ri = fe = 1'b0;
			end
		S1:
			begin
				re = 16'h0000;
				rd = inop[11:8];
				rs = inop[3:0];
				if(inop[15:12] == 4'h0) begin
					ri = 0;
					re[rs] = 1;
					re[rd] = 1;
				end
				else
					ri = 1;
				
				if(inop[15:12] == 4'h0)
					opcode = 0 & inop[7:4];
				else if(inop[15:12] == 4'b1000 && inop[7:4] == 4'b0100)
					opcode = 5'b11100;
				else if(inop[15:12] == 4'b1000 && inop[7:4] == 4'b0000)
					opcode = 5'b11100;
				else if(inop[15:12] == 4'b1000 && inop[7:4] == 4'b0110)
					opcode = 5'b10011;
				else if(inop[15:12] == 4'b1000 && inop[7:4] == 4'b0010)
					opcode = 5'b10111;
				else
					opcode = 0 & inop[15:12];
			
			end		
		S2:
		S3:
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
endmodule

			