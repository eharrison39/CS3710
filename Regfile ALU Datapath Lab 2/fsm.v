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
	
	reg [1:0]state;
	parameter [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
	
	always @(posedge clk or negedge rst) begin
	 if (~rst)
		state <= S0;
	 else
		case(state)
			S0: state <= S1;
			S1: state <= S2;
			S2: state <= S3;
			S3: state <= S3;
			default: state <= S0;
		endcase
	end
			
	always@ (state) begin
		S0:
			begin
				re = 16'h0000;
				rs = 4'h0;
				rd = 4'h0;
				opcode = 5'b0_0000;
				ri = 1'b0;
				fe = 1'b0;
			end
		S1:
			begin
				re = 16'h0000;
				
				// Set rd and rs muxes
				rd = inop[11:8];
				rs = inop[3:0];
				
				// Open source and dest registers
				re[rd] = 1;
				
				if(inop[15:12] == 4'h0) begin
					re[rs] = 1;
					
					// Set rimmediate mux control in.
					ri = 0;
				end
				else
					ri = 1;
					
				// Set alu opcode
				if(inop[15:12] == 4'h0)
					opcode = {1'b0, inop[7:4]};
				else if(inop[15:12] == 4'b1000 && inop[7:4] == 4'b0100)
					opcode = 5'b11100;
				else if(inop[15:12] == 4'b1000 && inop[7:4] == 4'b0000)
					opcode = 5'b11100;
				else if(inop[15:12] == 4'b1000 && inop[7:4] == 4'b0110)
					opcode = 5'b10011;
				else if(inop[15:12] == 4'b1000 && inop[7:4] == 4'b0010)
					opcode = 5'b10111;
				else
					opcode = {1'b0, inop[15:12]};
					
				// Enable alu flags
				fe = 1;
			
			end		
		S2:
			begin
				re = 16'h0000;
				re[rd] = 1;
				rs = 4'h0;
				rd = 4'h0;
				opcode = 5'b0_0000;
				ri = 1'b0;
				fe = 1'b0;
			end
		S3:
			begin
				re = 16'h0000;
				rs = 4'h0;
				rd = 4'h0;
				opcode = 5'b0_0000;
				ri = 1'b0;
				fe = 1'b0;
			end	
	end	
			
endmodule

			