
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
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
// Revision: 	9/4/2025
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


// Add Opcodes
parameter ADD = 5'b0_0101;
parameter ADDU = 5'b0_0110;
parameter ADDC = 5'b0_0111;
parameter ADDCU = 5'b0_1111;

// Subtraction Opcode
parameter SUB = 5'b0_1001;

// Comparison Opcode
parameter CMP = 5'b0_1011;

// Bit Logic Opcodes
parameter AND = 5'b0_0001;
parameter OR = 5'b0_0010;
parameter XOR = 5'b0_0011;
parameter NOT = 5'b0_0100;

// Shifting Opcodes
parameter LSH = 8'b0_1100;
parameter RSH = 8'b1_0011 ;
parameter ARSH = 8'b1_0111 ;


// Begin opcodes case statement
always @(A, B, Opcode, Cin)
begin
	case (Opcode)
	
	// Regular add without setting flags
	ADDU:
		begin
			C = A + B;
			Flags[4:0] = 5'b0_0000;
		end
	
	// Regular add. Sets the Carry bit, Overflow bit, Negative bit, and the Zero bit
	ADD:
		begin
			// Set C and Carry bit
			{Flags[4], C} = A + B;
			
			// Set Zero bit
			if (C == 16'b0000_0000_0000_0000)
				Flags[1] = 1'b1;
			else
				Flags[1] = 1'b0;
			
			// Set Overflow bit
			if( (~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15]) )
				Flags[2] = 1'b1;
			else
				Flags[2] = 1'b0;
				
			Flags[3] = 1'b0; Flags[0] = C[15]; // Set Negative bit
		end
	
	// Functions and sets flags the same way as "ADD" but just adding a carry bit.
	ADDC:
		begin
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
	
	// Regular ADD carry but doesn't set the flag bits.
	ADDCU:
		begin
			C = A + B + Cin;
			Flags[4:0] = 5'b0_0000;
		end
	
	// Regular subtract. Sets the Overflow bit, Negative bit, and the Zero bit
	SUB:
		begin
			C = A - B;
			
			// Set Zero bit
			if (C == 16'b0000_0000_0000_0000)
				Flags[1] = 1'b1;
			else
				Flags[1] = 1'b0;
			
			// Set Overflow bit
			if( (A[15] ^ B[15]) & (A[15] ^ C[15]) )
				Flags[2] = 1'b1;
			else
				Flags[2] = 1'b0;
			
			Flags[4:3] = 2'b00; Flags[0] = C[15]; // Set Negative bit
		end
	
	// Comparison instruction only sets flags. CMP sets the zero bit, low bit, and negative bit
	CMP:
		begin
			// Set zero bit if A == B (A - B = 0)
			if(A == B)
				Flags[1] = 1'b1;
			else
				Flags[1] = 1'b0;
			
			// Set negative bit if signed a is less than signed b
			if( $signed(A) < $signed(B) ) 
				Flags[0] = 1'b1;
			else 
				Flags[0] = 1'b0;
			
			// Set low bit if unsigned a is less than unsigned b
			Flags[3] = (A < B);
				
			Flags[2] = 1'b0;
			Flags[4] = 1'b0;
			
			C = 16'b0000_0000_0000_0000;	
		end

// Bit Logic gates. They don't set any flag bits
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
		
	// Shifting arithmetic. No flag bits set (Arithmetic and Logic Left Shift) - (They do the same thing)
	LSH:
		begin
			C = A << B;
			Flags = 5'b0_0000;
		end

	// Logical right shift
	RSH:
		begin
			C = A >> B;
			Flags = 5'b0_0000;
		end
	
	// Arithmetic right shift
	ARSH:
		begin
			C = $signed(A) >>> B;
			Flags = 5'b0_0000;
		end

	default: 
		begin
			C = 16'b0000_0000_0000_0000;
			Flags = 5'b0_0000;
		end
	endcase
end

endmodule
