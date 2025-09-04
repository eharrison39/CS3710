`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:25:01 08/30/2011
// Design Name:   alu
// Module Name:   C:/Documents and Settings/Administrator/ALU/alutest.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alutest;

	// Inputs
	reg [15:0] a;
	reg [15:0] b;
	reg [4:0] opcode;

	// Outputs
	wire [15:0] c;
	wire [4:0] flags;

	integer i;
	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.A(a), 
		.B(b), 
		.C(c), 
		.Opcode(opcode), 
		.Flags(flags)
	);

	initial begin
//			$monitor("A: %0d, B: %0d, C: %0d, Flags[1:0]:%b, time:%0d", A, B, C, Flags[1:0], $time );
//Instead of the $display stmt in the loop, you could use just this
//monitor statement which is executed everytime there is an event on any
//signal in the argument list.

		// Add

		opcode = 5'b00101;
		a = 16'h0000;
		b = 16'h0000;
		
		#10
		
		if(c == 16'h0000)
		begin
			$display("Add 1 of 2 is chillin. End result which should be 0 is %h.", c);
		end
		else
		begin
			$display("Add 1 of 2 is not chillin.");
		end
		
		
		a = 16'h0402;
		b = 16'h1325;
		
		#10
		
		if(c == 16'h1727)
		begin
			$display("Add 2 of 2 is chillin.");
		end
		else
		begin
			$display("Add 2 of 2 is not chillin.");
		end
		
		// Sub
		
		opcode = 5'b01010;
		a = 16'h9999;
		b = 16'h5555;
		
		#10
		
		if(c == 16'h4444)
		begin
			$display("Sub 1 of 1 is chillin.");
		end
		else
		begin
			$display("Sub 1 of 1 is not chillin.");
		end
		
		// Cmp
		
		opcode = 5'b01011;
		a = 16'h0001;
		b = 16'h0000;
		
		#10
		
		if(1) // Fill this in. /////////////////////////////////////////////////////////////////////////////////////////
		begin
			$display("Cmp 1 of 1 is chilin.");
		end
		else
		begin
			$display("Cmp 1 of 1 is not chilin.");
		end
		
		// And
		
		opcode = 5'b00001;
		a = 16'h0007;
		b = 16'h007f;
		
		#10 // Try without this wait.  //////////////////////////////////////////////////////////////////
		
		if(c == 16'h0007)
		begin
			$display("And 1 of 2 is chilin.");
		end
		else
		begin
			$display("And 1 of 2 is not chilin.");
		end
		
		
		a = 16'hf00f;
		b = 16'h0ff0;
		
		#10
		
		if(c == 16'h0000)
		begin
			$display("And 2 of 2 is chilin.");
		end
		else
		begin
			$display("And 2 of 2 is not chilin.");
		end
		
		// Or
		
		opcode = 5'b00010;
		a = 16'h0007;
		b = 16'h0070;
		
		#10 // Try without this wait.  //////////////////////////////////////////////////////////////////
		
		if(c == 16'h0077)
		begin
			$display("Or 1 of 2 is chilin.");
		end
		else
		begin
			$display("Or 1 of 2 is not chilin.");
		end
		
		
		a = 16'hf00f;
		b = 16'h0000;
		
		#10
		
		if(c == 16'hf00f)
		begin
			$display("Or 2 of 2 is chilin.");
		end
		else
		begin
			$display("Or 2 of 2 is not chilin.");
		end
		
		// Xor
		
		opcode = 5'b00011;
		a = 16'h0007;
		b = 16'h0071;
		
		#10
		
		if(c == 16'h0076)
		begin
			$display("Xor 1 of 2 is chilin.");
		end
		else
		begin
			$display("Xor 1 of 2 is not chilin.");
		end
		
		
		a = 16'hf00f;
		b = 16'h0000;
		
		#10
		
		if(c == 16'hf00f)
		begin
			$display("Xor 2 of 2 is chilin.");
		end
		else
		begin
			$display("Xor 2 of 2 is not chilin.");
		end
		
		// Not
		
		opcode = 5'b00000;  // undefined right now;
		
		// Lsh
		
		opcode = 5'b00000;
		
		
		// Rsh
		
		opcode = 5'b00000;
		
		// Arsh
		
		opcode = 5'b00000;
		
		// Nop/Wait
		
		opcode = 5'b00000;
		

		// Initialize Inputs
		a = 0;
		b = 0;
		opcode = 2'b11;

		// Wait 100 ns for global reset to finish

		// One vector-by-vector case simulation
		#10;
	        opcode = 2'b11;
		a = 4'b0010; b = 4'b0011;
		#10
		a = 4'b1111; b = 4'b 1110;
		$display("A: %b, B: %b, C:%b, Flags[1:0]: %b, time:%d", a, b, c, flags[1:0], $time);

		//Random simulation
		//for( i = 0; i< 10; i = i+ 1)
		//begin
			//#10
			//A = $random % 16;
			//B = $random %16;
			//$display("A: %0d, B: %0d, C: %0d, Flags[1:0]: %b, time:%0d", A, B, C, Flags[1:0], $time );
		//end
		$finish(2);

	end

endmodule

