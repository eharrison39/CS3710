
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

module decoder(inop, rsMuxCtrl, rdMuxCtrl, opcode, regEn, imm, ri);

	input [15:0] inop;
	output reg [3:0] rsMuxCtrl, rdMuxCtrl;
	output reg [4:0] opcode;
	output reg [15:0] regEn;
	output reg [7:0] imm;
	output reg ri;

	always @(*) begin
//		rsMuxCtrl = inop[11:8];
//		rdMuxCtrl = inop[3:0];
		rsMuxCtrl = inop[3:0];
		rdMuxCtrl = inop[11:8];

		// Set alu opcode
		if(inop[15:12] == 4'h0)
			opcode = {1'b0, inop[7:4]};
		else if(inop[15:12] == 4'b1000 && inop[7:4] == 4'b0100)	// Left Shift
			opcode = 5'b11100;	
		else if(inop[15:12] == 4'b1000 && inop[7:4] == 4'b0000)	// Arithmetic Left Shift
			opcode = 5'b11100;	
		else if(inop[15:12] == 4'b1000 && inop[7:4] == 4'b0110)	// Right Shift
			opcode = 5'b10011;
		else if(inop[15:12] == 4'b1000 && inop[7:4] == 4'b0010)	// Arithmetic Right Shift
			opcode = 5'b10111;
		else
			opcode = {1'b0, inop[15:12]};
			
		// Open source and dest registers
		regEn = 0;
		regEn[rdMuxCtrl] = 1;

//		if(inop[15:12] == 4'h0)
//			regEn[rsMuxCtrl] = 1;
			
		// Set the immediate value
		if(inop[15:12] == 4'h8)
			imm = {4'h0, inop[3:0]};
		else
			imm = inop[7:0];
			
		// Determine if we are using an immediate or not.
		if(inop[15:12] == 4'h0)
			ri = 0;
		else if(inop[15:12] == 4'h8 && (inop[7:4] == 4'h4 || inop[7:4] == 4'h6))
			ri = 0;
		else
			ri = 1;
	end

endmodule