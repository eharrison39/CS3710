
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
module alu(a, b, c, opcode, flags, cin);

input [15:0] a, b;
input [4:0] opcode;
input cin;
output reg [15:0] c;
output reg [4:0] flags;


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
parameter LSH = 5'b0_1100;
parameter RSH = 5'b1_0011 ;
parameter ARSH = 5'b1_0111 ;


// Begin opcodes case statement
always @(a, b, opcode, cin)
begin
	c  = 16'h0000;
	flags[4:0] = 5'b0_0000;
	case (opcode)
	
	// Regular add without setting flags
	ADDU:
		begin
			c = a + b;
			//Flags[4:0] = 5'b0_0000;
		end
	
	// Regular add. Sets the Carry bit, Overflow bit, Negative bit, and the Zero bit
	ADD:
		begin
			// Set C and Carry bit
			{flags[4], c} = a + b;
			
			// Set Zero bit
			if (c == 16'b0000_0000_0000_0000)
				flags[1] = 1'b1;
			else
				flags[1] = 1'b0;
			
			// Set Overflow bit
			if( (~a[15] & ~b[15] & c[15]) | (a[15] & b[15] & ~c[15]) )
				flags[2] = 1'b1;
			else
				flags[2] = 1'b0;
				
			flags[3] = 1'b0; flags[0] = c[15]; // Set Negative bit
		end
	
	// Functions and sets flags the same way as "ADD" but just adding a carry bit.
	ADDC:
		begin
			{flags[4], c} = a + b + cin;
			
			if (c == 16'b0000_0000_0000_0000)
				flags[1] = 1'b1;
			else
				flags[1] = 1'b0;
				
			if( (~a[15] & ~b[15] & c[15]) | (a[15] & b[15] & ~c[15]) )
				flags[2] = 1'b1;
			else
				flags[2] = 1'b0;
				
			flags[3] = 1'b0; flags[0] = c[15];
		end
	
	// Regular ADD carry but doesn't set the flag bits.
	ADDCU:
		begin
			c = a + b + cin;
			//flags[4:0] = 5'b0_0000;
		end
	
	// Regular subtract. Sets the Overflow bit, Negative bit, and the Zero bit
	SUB:
		begin
			c = a - b;
			
			// Set Zero bit
			if (c == 16'b0000_0000_0000_0000)
				flags[1] = 1'b1;
			else
				flags[1] = 1'b0;
			
			// Set Overflow bit
			if( (a[15] ^ b[15]) & (a[15] ^ c[15]) )
				flags[2] = 1'b1;
			else
				flags[2] = 1'b0;
			
			flags[4:3] = 2'b00; flags[0] = c[15]; // Set Negative bit
		end
	
	// Comparison instruction only sets flags. CMP sets the zero bit, low bit, and negative bit
	CMP:
		begin
			// Set zero bit if a == b (a - b = 0)
			if(a == b)
				flags[1] = 1'b1;
			else
				flags[1] = 1'b0;
			
			// Set negative bit if signed a is less than signed b
			if( $signed(a) < $signed(b) ) 
				flags[0] = 1'b1;
			else 
				flags[0] = 1'b0;
			
			// Set low bit if unsigned a is less than unsigned b
			flags[3] = (a < b);
				
			flags[2] = 1'b0;
			flags[4] = 1'b0;
			
			c = 16'b0000_0000_0000_0000;	
		end

// Bit Logic gates. They don't set any flag bits
	AND:
		begin
			c = a & b;
			//flags = 5'b0_0000;
		end
	OR:
		begin
			c = a | b;
			//flags = 5'b0_0000;
		end
	XOR:
		begin
			c = a ^ b;
			flags = 5'b0_0000;
		end
	NOT:
		begin
			c = ~a;
			//flags = 5'b0_0000;
		end
		
	// Shifting arithmetic. No flag bits set (Arithmetic and Logic Left Shift) - (They do the same thing)
	LSH:
		begin
			c = a << b;
			//flags = 5'b0_0000;
		end

	// Logical right shift
	RSH:
		begin
			c = a >> b;
			//flags = 5'b0_0000;
		end
	
	// Arithmetic right shift
	ARSH:
		begin
			c = $signed(a) >>> b;
			//flags = 5'b0_0000;
		end

	default: 
		begin
			c = 16'b0000_0000_0000_0000;
			flags = 5'b0_0000;
		end
	endcase
end

endmodule
