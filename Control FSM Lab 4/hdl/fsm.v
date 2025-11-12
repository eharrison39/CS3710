
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

module fsm(clk, rst, inop, instruction, rsMuxCtrl, rdMuxCtrl, opcode, regEn, fe, imm, ri, pcEn, ir, writeEn, lsCtrl, aluMuxCtrl);

input clk, rst;
input [15:0] inop, instruction;
output reg [3:0] rsMuxCtrl, rdMuxCtrl;
output reg [4:0] opcode;
output reg [15:0] regEn;
output reg [15:0] imm;
output reg fe, ri, pcEn, ir, writeEn, lsCtrl, aluMuxCtrl;

reg [2:0] currState, nextState;
parameter [2:0] s0 = 3'b000, s1a = 3'b110, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100, s5 = 3'b101;

// Instanciate decoder
wire [3:0] decRsMuxCtrl, decRdMuxCtrl;
wire [4:0] decOpcode;
wire [15:0] decRegEn;
wire [7:0] decImm;
wire decRi;

decoder theDecoder(instruction, decRsMuxCtrl, decRdMuxCtrl, decOpcode, decRegEn, decImm, decRi);

always @(posedge clk) begin

	if(~rst)
		nextState <= s0;
	else
		currState <= nextState;
		case(nextState)
			s0: nextState <= s1a;
			s1a: nextState <=s1;
			s1: begin
				if(inop[15:12] != 4'h4 && inop[15:12] != 4'hc) // If r-type instruction.
					nextState <= s2;
				else if(inop[15:12] == 4'h4 && inop[7:4] == 4'h4) // If store instruction.
					nextState <= s3;
				else if(inop[15:12] == 4'h4 && inop[7:4] == 4'h0) // If load instruction.
					nextState <= s4;
			end
			s2: nextState <= s0;
			s3: nextState <= s0;
			s4: nextState <= s5;
			s5: nextState <= s0;
			
			default: nextState <= s0;
		endcase
end

always @(*) begin
	// defaults
	rsMuxCtrl = 4'b0000;
	rdMuxCtrl = 4'b0000;
	opcode = 5'b00000;
	regEn = 16'h0000;
	fe = 1'b1;
	ri = 1'b0;
	ir = 1'b0;
	pcEn = 1'b0;
	imm = 16'h0000;
	lsCtrl = 1'b0;
	writeEn = 1'b0;
	aluMuxCtrl = 1'b0;
	
	case(currState)
		s0: ;
		s1a: ;
		
		s1: begin
			ir = 1'b1;
		end
		
		s2: begin // This is chillin.  It has all the right outputs for an r-type instruction.
			pcEn = 1'b1;
			rsMuxCtrl = decRsMuxCtrl;
			rdMuxCtrl = decRdMuxCtrl;
			opcode = decOpcode;
			regEn = decRegEn;
			imm = {8'h00, decImm};
			ri = decRi;
		end
		s3: begin
			writeEn = 1'b1;
			lsCtrl = 1'b1;
			pcEn = 1'b1;
			rsMuxCtrl = instruction[11:8];
			rdMuxCtrl = instruction[3:0];
		end
		s4: begin
			rdMuxCtrl = instruction[3:0];
			//rsMuxCtrl = decRsMuxCtrl;
			lsCtrl = 1'b1;
		end
		s5: begin
			pcEn = 1'b1;
			aluMuxCtrl = 1'b1;
			regEn = decRegEn;
		end
		
		default: ;
		
	endcase
end
endmodule