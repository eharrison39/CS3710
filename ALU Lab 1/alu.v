`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 		 Luke Jones, David Brown, Elden Harrison
// 
// Create Date:    12:54:08 08/29/2025 
// Design Name: 
// Module Name:    alu 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module alu( A, B, C, Opcode, Flags
    );
input [15:0] A, B;
input [7:0] Opcode;
output reg [15:0] C;
output reg [4:0] Flags;



parameter ADDU = 8'b0000 0110;
parameter ADD = 8'b0000 0101;
parameter ADDI = 8'b0101 ;
parameter ADDUI = 8'b0110 ;
parameter ADDC = 8'b0000 0111;
parameter ADDCU = 8'b ;
parameter ADDCI = 8'b0111 ;
parameter ADDCUI = 8'b ;

parameter SUB = 8'b0000 1001;
parameter SUBI = 8'b1001 ;

parameter CMP = 8'b0000 1011;
parameter CMPI = 8'b1011 ;
parameter CMPUI = 8'b ;

parameter AND = 8'b0000 0001;
parameter OR = 8'b0000 0010;
parameter XOR = 8'b0000 0011;
parameter NOT = 8'b0000 ;

parameter LSH = 8'b1000 0100;
parameter LSHI = 8'b1000 000s;
parameter RSH = 8'b ;
parameter RSHI = 8'b ;
parameter ALSH = 8'b ;
parameter ARSH = 8'b ;
parameter WAIT = 8'b0000 0000;




always @(A, B, Opcode)
begin
	case (Opcode)
	ADDU:
		begin
			{Flags[3], C} = A + B;
			// perhaps if ({Flags[3], C} == 5'b00000) ....
			
			if (C == 16'b0000 0000 0000 0000)
				Flags[4] = 1'b1; 
			else 
				Flags[4] = 1'b0;
				
			Flags[2:0] = 3'b000;
		end
	ADD:
		begin
		C = A + B;
		if (C == 4'b0000) Flags[4] = 1'b1;
		else Flags[4] = 1'b0;
		if( (~A[3] & ~B[3] & C[3]) | (A[3] & B[3] & ~C[3]) ) Flags[2] = 1'b1;
		else Flags[2] = 1'b0;
		Flags[1:0] = 2'b00; Flags[3] = 1'b0;

		end
	ADDI:
		begin
		
		end
	ADDUI:
		begin
		
		end
	ADDC:
		begin
		
		end
	ADDCU:
		begin
		
		end
	ADDCUI:
		begin
		
		end
		
	//////////////////
	SUB:
		begin
		C = A - B;
		if (C == 4'b0000) Flags[4] = 1'b1;
		else Flags[4] = 1'b0;
		if( (~A[3] & ~B[3] & C[3]) | (A[3] & B[3] & ~C[3]) ) Flags[2] = 1'b1;
		else Flags[2] = 1'b0;
		Flags[1:0] = 2'b00; Flags[3] = 1'b0;
		end
		
	SUBI:
		begin
		
		end
		
	//////////////////
	CMP:
		begin
		if( $signed(A) < $signed(B) ) Flags[1:0] = 2'b11;
		else Flags[1:0] = 2'b00;
		C = 4'b0000;
		Flags[4:2] = 3'b000;
		// both positive or both negative
		/*if( A[3] == B[3] )
		begin
			if (A < B) Flags[1:0] = 2'b11;
			else Flags[1:0] = 2'b00;
		end
		else if (A[3] == 1'b0) Flags[1:0] = 2'b00;
		else Flags[1:0] = 2'b01;
		Flags[4:2] = 3'b000;
		
		// C = ?? if I don;t specify, then I'm in trouble.
		C = 4'b0000;
		*/
		end
	CMPI:
		begin
		
		end
	CMPUI:
		begin
		
		end
		
	//////////////////
	AND:
		begin
		
		end
	OR:
		begin
		
		end
	XOR:
		begin
		
		end
	NOT:
		begin
		
		end
		
	//////////////////
	LSH:
		begin
		
		end
	LSHI:
		begin
		
		end
	RSH:
		begin
		
		end
	RSHI:
		begin
		
		end
	ALSH:
		begin
		
		end
	ARSH:
		begin
		
		end
	WAIT:
		begin
		
		end
		
	default: 
		begin
			C = 4'b0000;
			Flags = 5'b00000;
		end
	endcase
end

endmodule
