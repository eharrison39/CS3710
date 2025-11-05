
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

module fsm(clk, rst, inop, rsMuxCtrl, rdMuxCtrl, opcode, regEn, fe, imm, ri, pcEn);

input clk, rst;
input [15:0] inop;
output reg [3:0] rsMuxCtrl, rdMuxCtrl;
output reg [4:0] opcode;
output reg [15:0] regEn;
output reg [7:0] imm;
output reg fe, ri, pcEn;

reg [15:0] instruction;

reg [2:0] state;
parameter [2:0] s0 = 3'b000, s1 = 3'b001, s2 = 3'b010;

// Instanciate decoder
wire [3:0] decRsMuxCtrl, decRdMuxCtrl;
wire [4:0] decOpcode;
wire [15:0] decRegEn;
wire [7:0] decImm;
wire decRi;

decoder theDecoder(inop, decRsMuxCtrl, decRdMuxCtrl, decOpcode, decRegEn, decImm, decRi);

always @(posedge clk) begin

	if(~rst)
		state <= s0;
	else
		case(state)
			s0: state <= s1;
			s1: state <= s2;
			s2: state <= s0;
			
			default: state <= s0;
		endcase
end

always @(state) begin
	// defaults
	rsMuxCtrl = 0;
	rdMuxCtrl = 0;
	opcode = 0;
	regEn = 0;
	fe = 1;
	ri = 0;
	pcEn = 0;
	instruction = instruction;
	
	case(state)
		s0: begin
			instruction = inop;
		end
		
		s1: begin
			if(instruction[15:12] != 4'b0100)
				;// We're chillin
		end
		
		s2: begin
			pcEn = 1;
			rsMuxCtrl = decRsMuxCtrl;
			rdMuxCtrl = decRdMuxCtrl;
			opcode = decOpcode;
			imm = decImm;
			ri = decRi;
		end
	endcase
end
endmodule