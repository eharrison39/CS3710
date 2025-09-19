`timescale 1ns / 1ps

// @Authors Luke Jones, David Brown, Elden Harrison
// fsm module

//
module ffsm(clk, rst, rs, rd, opcode, re, ri, fe, imm);
	
	input clk, rst;
	output reg [3:0] rs, rd;
	output reg [4:0] opcode;
	output reg [15:0] re;
	output reg [15:0] imm;
	output reg ri, fe;
	
	reg [1:0]state;
	parameter [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
	
	always @(posedge clk) begin
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
		re = 16'h0000;
		imm = 0;
		ri = 0;
		fe = 1;
		case (state) begin // add the corresponding 'end'
		S0:
			begin // R1 <- R0 + 1
				rs = 4'h0;
				rd = 4'h0;
				opcode = 5'b0_0101;
				re[4'b0001] = 1;
				ri = 1'b1;
				imm = 1;
				fe = 1'b0;
			end
		S1:
			begin // R2 <- R0 + R1
				
				// Set rd and rs muxes
				rd = 4'b0001; // r1 = 4'b0001
				rs = 4'b0000; // r0 4'b0000
				
				// Open only the  dest registers
				re[4'b0010] = 1;
				ri = 1'b0;
				fe = 1'b1;
			end		
		S2:
			begin // R3 <- R1 + R2
				rs = 4'h1;
				rd = 4'h2;
				re[4'h3] = 1;
			end		
		S3:
			begin // R4 <- R2 + R3
				rs = 4'h2;
				rd = 4'h3;
				re[4'h4] = 1;
			end		
		S4:
			begin // R5 <- R3 + R4
				rs = 4'h3;
				rd = 4'h4;
				re[4'h5] = 1;
			end		
		S5:
			begin // R6 <- R4 + R5
				rs = 4'h4;
				rd = 4'h5;
				re[4'h6] = 1;
			end		
		S6:
			begin // R7 <- R5 + R6
				rs = 4'h5;
				rd = 4'h6;
				re[4'h7] = 1;
			end		
		S7:
			begin // R8 <- R6 + R7
				rs = 4'h6;
				rd = 4'h7;
				re[4'h8] = 1;
			end		
		S8:
			begin // R9 <- R7 + R8
				rs = 4'h7;
				rd = 4'h8;
				re[4'h9] = 1;
			end		
		S9:
			begin // R10 <- R8 + R9
				rs = 4'h8;
				rd = 4'h9;
				re[4'ha] = 1;
			end		
		S10:
			begin // R11 <- R9 + R10
				rs = 4'h9;
				rd = 4'ha;
				re[4'hb] = 1;
			end		
		S11:
			begin // R12 <- R10 + R11
				rs = 4'ha;
				rd = 4'hb;
				re[4'hc] = 1;
			end		
		S12:
			begin // R13 <- R11 + R12
				rs = 4'hb;
				rd = 4'hc;
				re[4'hd] = 1;
			end		
		S13:
			begin // R14 <- R12 + R13
				rs = 4'hc;
				rd = 4'hd;
				re[4'he] = 1;
			end		
		S14:
			begin // R15 <- R13 + R14
				rs = 4'hd;
				rd = 4'he;
				re[4'hf] = 1;
			end
		
	end	
			
endmodule

			