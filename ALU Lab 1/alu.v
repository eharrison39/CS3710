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
module alu( A, B, C, Opcode, Flags, Cin
    );
input [15:0] A, B;
input [4:0] Opcode;
input Cin;
output reg [15:0] C;
output reg [4:0] Flags;



parameter ADD = 5'b0_0101;
// parameter ADDI = 8'b0101 0000;
parameter ADDU = 5'b0_0110;
// parameter ADDUI = 8'b0110 0000;
parameter ADDC = 5'b0_0111;
// parameter ADDCI = 8'b0111 0000;
parameter ADDCU = 5'b0_1111; ////
// parameter ADDCUI = 8'1111 0000; ////

parameter SUB = 5'b0_1001;
// parameter SUBI = 8'b1001 0000;

parameter CMP = 5'b0_1011;
// parameter CMPI = 8'b1011 0000;
// parameter CMPU = 8'b0100 0000; ////

parameter AND = 5'b0_0001;
parameter OR = 5'b0_0010;
parameter XOR = 5'b0_0011;
parameter NOT = 5'b0_0100; ////

parameter LSH = 8'b0_1100;
// parameter LSHI = 8'b1000 000s;
parameter RSH = 8'b1_0011 ; ////
// parameter RSHI = 8'b ; ////
// parameter ALSH = 8'b0 1110 ; ////
parameter ARSH = 8'b1_0111 ; ////
//parameter WAIT = 8'b0 0000;


always @(A, B, Opcode, Cin)
begin
	case (Opcode)
	ADDU:
		begin
			C = A + B;
			
//			if (C == 16'b0000 0000 0000 0000)
//				Flags[1] = 1'b1; 
//			else 
//				Flags[1] = 1'b0;
//			
//			Flags[0] = 1'b0;
			Flags[4:0] = 5'b0_0000;
		end
//	ADDUI:
//		begin
//			{Flags[4], C} = A + B;
			
//			if (C == 16'b0000 0000 0000 0000)
//				Flags[1] = 1'b1; 
//			else 
//				Flags[1] = 1'b0;
			
//			Flags[0] = 1'b0;
//			Flags[3:2] = 2'b00;
//		end
	ADD:
		begin
			{Flags[4], C} = A + B;
			//C = A + B;
			if (C == 16'b0000_0000_0000_0000)
				Flags[1] = 1'b1;
			else
				Flags[1] = 1'b0;
//			if(A == B)
//				Flags[1] = 1'b1;
//			else
//				Flags[1] = 1'b0;
				
			if( (~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15]) )
				Flags[2] = 1'b1;
			else
				Flags[2] = 1'b0;
				
			Flags[3] = 1'b0; Flags[0] = C[15];
		end
//	ADDI:
//		begin
//			C = A + B;
//			if (C == 16'b0000 0000 0000 0000)
//				Flags[1] = 1'b1;
//			else
//				Flags[1] = 1'b0;
//				
//			if( (~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15]) )
//				Flags[2] = 1'b1;
//			else
//				Flags[2] = 1'b0;
//				
//			Flags[4:3] = 2'b00; Flags[0] = 1'b0;
//		end
	ADDC:
		begin
			//C = A + B + 1'b1;
			{Flags[4], C} = A + B + Cin;
			
			if (C == 16'b0000_0000_0000_0000)
				Flags[1] = 1'b1;
			else
				Flags[1] = 1'b0;
				
			if( (~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15]) )
				Flags[2] = 1'b1;
			else
				Flags[2] = 1'b0;
				
			Flags[3] = 1'b0; Flags[0] = C[15];
		end
	ADDCU:
		begin
			C = A + B + Cin;
//			{Flags[4], C} = A + B + 1'b1;
//			
//			if (C == 16'b0000 0000 0000 0000)
//				Flags[1] = 1'b1; 
//			else 
//				Flags[1] = 1'b0;
//			
//			Flags[0] = 1'b0;
			Flags[4:0] = 5'b0_0000;
		end
//	ADDCUI:
//		begin
//			{Flags[4], C} = A + B + 1'b1;
//			
//			if (C == 16'b0000 0000 0000 0000)
//				Flags[1] = 1'b1; 
//			else 
//				Flags[1] = 1'b0;
//			
//			Flags[0] = 1'b0;
//			Flags[3:2] = 2'b00;
//		end
		
	//////////////////
	SUB:
		begin
<<<<<<< HEAD
			//{Flags[4], C} = A - B;
			C = A - B;
=======
			{Flags[4], C} = A - B;
>>>>>>> 7df1e42 (Fixed syntax errors)
			if (C == 16'b0000_0000_0000_0000)
				Flags[1] = 1'b1;
			else
				Flags[1] = 1'b0;
				
			if( (A[15] ^ B[15]) & (A[15] ^ C[15]) )
				Flags[2] = 1'b1;
			else
				Flags[2] = 1'b0;
			
			Flags[4:3] = 2'b00; Flags[0] = C[15];
		end
		
//	SUBI:
//		begin
//			C = A - B;
//			if (C == 16'b0000 0000 0000 0000)
//				Flags[3] = 1'b1;
//			else
//				Flags[3] = 1'b0;
//				
//			if( (~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15]) )
//				Flags[2] = 1'b1;
//			else
//				Flags[2] = 1'b0;
//			Flags[1:0] = 2'b00; Flags[4] = 1'b0;
//		end
		
	//////////////////
	CMP:
		begin
<<<<<<< HEAD
			//Flags = 5'b00000;
=======
			Flags = 5'b00000;
>>>>>>> 7df1e42 (Fixed syntax errors)
			if(A == B)
				Flags[1] = 1'b1;
			else
				Flags[1] = 1'b0;
<<<<<<< HEAD
				
			if( $signed(A) < $signed(B) ) 
				Flags[0] = 1'b1;
			else 
				Flags[0] = 1'b0;
		
			Flags[3] = (A < B);
=======
>>>>>>> 7df1e42 (Fixed syntax errors)
			//C = 16'b0000 0000 0000 0000;
			//Flags[4:2] = 3'b000;
			
			
			
			// both positive or both negative 
//			if( A[15] == B[15] ) begin
//				if (A < B) begin
//					Flags[0] = 1'b1;
//					Flags[3] = 1'b1;
//				end
//				else begin
//					Flags[0] = 1'b0;
//					Flags[3] = 1'b0;
//				end
//			end
//			else if (A[15] == 1'b0)
//				if (A < B) begin
//					Flags[0] = 1'b1;
//					Flags[3] = 1'b1;
//				end
//				
//		// N is set if signed a is less than b
//				else begin
//					Flags[0] = 1'b0;
//					Flags[3] = 1'b0;
//				end
				
			Flags[2] = 1'b0;
			Flags[4] = 1'b0;
			
			// C = ?? if I don;t specify, then I'm in trouble.
			C = 16'b0000_0000_0000_0000;
			
		end
//	CMPI:
//		begin
//		
//		end
//	CMPU:
//		begin
//		
//		end
		
	//////////////////
	AND:
		begin
			C = A & B;
			Flags = 5'b0_0000;
		end
	OR:
		begin
			C = A | B;
			Flags = 5'b0_0000;
		end
	XOR:
		begin
			C = A ^ B;
			Flags = 5'b0_0000;
		end
	NOT:
		begin
			C = ~A;
			Flags = 5'b0_0000;
		end
		
	//////////////////
	LSH:
		begin
			C = A << B;
			Flags = 5'b0_0000;
		end
//	LSHI:
//		begin
//		
//		end
	RSH:
		begin
			C = A >> B;
			Flags = 5'b0_0000;
		end
//	RSHI:
//		begin
//		
//		end
//	ALSH:
//		begin
//		
//		end
	ARSH:
		begin
			C = $signed(A) >>> B;
			Flags = 5'b0_0000;
		end
//	WAIT:
//		begin
//			
//		end
		
	default: 
		begin
			C = 16'b0000_0000_0000_0000;
			Flags = 5'b0_0000;
		end
	endcase
end

endmodule