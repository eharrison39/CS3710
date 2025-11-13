
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		Luke Jones
// 
// Create Date:    11/4/2025
// Design Name: 
// Module Name:    flag reg
// Revision: 		
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module fsm(clk, rst, inop, instruction, flags, rsMuxCtrl, rdMuxCtrl, 
					opcode, regEn, fe, imm, ri, pcEn, ir, writeEn, lsCtrl, aluMuxCtrl, pcMuxCtrl);

input clk, rst;
input [15:0] inop, instruction;
input [4:0] flags;
output reg [3:0] rsMuxCtrl, rdMuxCtrl;
output reg [4:0] opcode;
output reg [15:0] regEn;
output reg [15:0] imm;
output reg [1:0] pcMuxCtrl, aluMuxCtrl;
output reg fe, ri, pcEn, ir, writeEn, lsCtrl;

reg [3:0]  state;
parameter [3:0] s0 = 4'b0000, s1 = 4'b0001, s2 = 4'b0010, s3 = 4'b0011, 
					 s4 = 4'b0100, s5 = 4'b0101, s6 = 4'b0110, s7 = 4'b0111, s8 = 4'b1000;

// Instantiate decoder
wire [3:0] decRsMuxCtrl, decRdMuxCtrl;
wire [4:0] decOpcode;
wire [15:0] decRegEn;
wire [7:0] decImm;
wire decRi;

decoder theDecoder(instruction, decRsMuxCtrl, decRdMuxCtrl, decOpcode, decRegEn, decImm, decRi);

always @(posedge clk) begin

	if(~rst)
		state <= s0;
	else
		case(state)
			s0: state <= s1;
			s1: state <=s2;
			s2: begin
				if(inop[15:12] != 4'h4 && inop[15:12] != 4'hc) // If r-type instruction.
					state <= s3;
				else if(inop[15:12] == 4'h4 && inop[7:4] == 4'h4) // If store instruction.
					state <= s4;
				else if(inop[15:12] == 4'h4 && inop[7:4] == 4'h0) // If load instruction.
					state <= s5;
				else if(inop[15:12] == 4'hc)
					state <= s7;
				else if(inop[15:12] == 4'h4 && inop[7:4] == 4'h8)
					state <= s8;
			end
			s3: state <= s0;
			s4: state <= s0;
			s5: state <= s6;
			s6: state <= s0;
			s7: state <= s0;
			s8: state <= s0;
			
			default: state <= s0;
		endcase
end

always @(*) begin
	// defaults
	rsMuxCtrl = 4'b0000;
	rdMuxCtrl = 4'b0000;
	opcode = 5'b00000;
	regEn = 16'h0000;
	fe = 1'b0;
	ri = 1'b0;
	ir = 1'b0;
	pcEn = 1'b0;
	imm = 16'h0000;
	lsCtrl = 1'b0;
	writeEn = 1'b0;
	aluMuxCtrl = 2'b00;
	pcMuxCtrl = 2'b00;
	
	case(state)
		s0: ;
		s1: ;
		
		// Load instruction register
		s2: begin
			ir = 1'b1;
		end
		
		// R-type instruction
		s3: begin // This is chillin.  It has all the right outputs for an r-type instruction.
			pcEn = 1'b1;
			fe = 1'b1;
			rsMuxCtrl = decRsMuxCtrl;
			rdMuxCtrl = decRdMuxCtrl;
			opcode = decOpcode;
			regEn = decRegEn;
			imm = {8'h00, decImm};
			ri = decRi;
		end
		
		// Store instruction
		s4: begin
			writeEn = 1'b1;
			lsCtrl = 1'b1;
			pcEn = 1'b1;
			rsMuxCtrl = instruction[11:8];
			rdMuxCtrl = instruction[3:0];
		end
		
		// Load Instruction
		s5: begin
			rdMuxCtrl = instruction[3:0];
			lsCtrl = 1'b1;
		end
		s6: begin
			pcEn = 1'b1;
			aluMuxCtrl = 2'b01;
			regEn = decRegEn;
		end
		
		// Branch on condition
		s7: begin
			imm = {8'h00, decImm};
			case (decRdMuxCtrl)
				4'b0000: pcMuxCtrl = {1'b0, flags[1]};					// Equal, 		Z = 1
				4'b0001: pcMuxCtrl = {1'b0, ~flags[1]};				// Not Equal	Z = 0
				4'b1101: pcMuxCtrl = {1'b0, flags[1] | flags[0]};	// Great or E	N = 1 or Z = 1	
				4'b0010: pcMuxCtrl = {1'b0, flags[4]};					// Carry Set	C = 1
				4'b0011: pcMuxCtrl = {1'b0, ~flags[4]};				// Carry Clear	C = 0
				4'b0100: pcMuxCtrl = {1'b0, flags[3]};					// Higher		L = 1
				4'b0101: pcMuxCtrl = {1'b0, ~flags[3]};				// Lower or E	L = 0
				4'b1010: pcMuxCtrl = {1'b0, ~flags[3] & ~flags[1]};// Lower than	L = 0 and Z = 0
				4'b1011: pcMuxCtrl = {1'b0, flags[3] | flags[1]};	// Higher or E	L = 1 or Z = 1
				4'b0110: pcMuxCtrl = {1'b0, flags[0]};					// Greater		N = 1
				4'b0111: pcMuxCtrl = {1'b0, ~flags[0]};				// Less or E	N = 0
				4'b1000: pcMuxCtrl = {1'b0, flags[2]};					// Flag Set		F = 1
				4'b1001: pcMuxCtrl = {1'b0, ~flags[2]};				// Flag Clear	F = 0
				4'b1100: pcMuxCtrl = {1'b0, ~flags[0] & ~flags[1]};// Less Than	N = 0 and Z = 0
				4'b1110: pcMuxCtrl = 2'b01;								// Unconditional Jump	N/A
				4'b1111: pcMuxCtrl = 2'b00;								// Never Jump				N/A
			endcase
			
			pcEn = 1'b1;
		end
		
		// Jump
		s8: begin
			pcMuxCtrl = 2'b10;
			pcEn = 1'b1;
			rsMuxCtrl = decRsMuxCtrl;
			aluMuxCtrl = 2'b10;
			regEn = decRegEn;
		end
		
		default: ;
		
	endcase
end
endmodule