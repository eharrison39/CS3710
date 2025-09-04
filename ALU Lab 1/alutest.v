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
	reg cin;

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
		.Flags(flags),
		.Cin(cin)
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
		
		if(c == 16'h0000 && flags == 5'b00010)
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
		
		if(c == 16'h1727 && flags == 5'b00000)
		begin
			$display("Add 2 of 2 is chillin.");
		end
		else
		begin
			$display("Add 2 of 2 is not chillin.");
		end
		
		
		a = 16'h0402;
		b = 16'hf325;
		
		#10
		
		if(c == 16'hf727 && flags == 5'b00001)
		begin
			$display("Add 3 of 2 is chillin.");
		end
		else
		begin
			$display("Add 3 of 2 is not chillin.");
		end
		
		
		a = 16'h0402;
		b = 16'hffff;
		
		#10
		
		if(c == 16'h0401 && flags == 5'b10100)  // Verify these flags. ////////////////////////////////////////////////////////////////////////
		begin
			$display("Add 4 of 2 is chillin.");
		end
		else
		begin
			$display("Add 4 of 2 is not chillin.");
		end
		
		// Should polly do a test that sets the carry and overflow flags.  //////////////////////////////////////////////////////////////////////////
		// Should also test addc and addcu
		
		// Sub
		
		opcode = 5'b01001;
		a = 16'h7999;
		b = 16'h5555;
		
		#10
		
		if(c == 16'h2444 && flags == 5'b00000)
		begin
			$display("Sub 1 of 1 is chillin.  Should be 2444 and it is %h.", c);
		end
		else
		begin
			$display("Sub 1 of 1 is not chillin.  Should be 2444 and it is %h.", c);
		end
		
		
		a = 16'h0002;
		b = 16'h0001;
		
		#10
		
		if(c == 16'h0001 && flags == 5'b00000)
		begin
			$display("Sub 2 of 2 is chillin.  Should be 0001 and it is %h.", c);
		end
		else
		begin
			$display("Sub 2 of 2 is not chillin.  Should be 0001 and it is %h.", c);
		end
		
		
		a = 16'h9999;
		b = 16'h5555;
		
		#10
		
		if(c == 16'h4444 && flags == 5'b00000)
		begin
			$display("Sub 3 of 3 is chillin.  Maybe should be 4444 and it is %h.", c);
		end
		else
		begin
			$display("Sub 3 of 3 is not chillin.  Maybe should be 4444 and it is %h.", c);
		end
		
		$display("TEZZZZZZZZZZZZ: %b", 4'b1001 - 4'b0101);
		
		
		a = 16'h7335;
		b = 16'h7335;
		
		#10
		
		if(c == 16'h0000 && flags == 5'b00010)
		begin
			$display("Sub 4 of 3 is chillin.  Maybe should be 4444 and it is %h.", c);
		end
		else
		begin
			$display("Sub 4 of 3 is not chillin.  Maybe should be 4444 and it is %h.", c);
		end
		
		
		a = 16'h0005;
		b = 16'h0006;
		
		#10
		
		if(c == 16'hffff && flags == 5'b00001)
		begin
			$display("Sub 5 of 3 is chillin.  Maybe should be 4444 and it is %h.", c);
		end
		else
		begin
			$display("Sub 5 of 3 is not chillin.  Maybe should be 4444 and it is %h.", c);
		end
		
		
		a = 16'h7fff;
		b = 16'hfffe;
		
		#10
		
		if(c == 16'h4444 && flags == 5'b00100)
		begin
			$display("Sub 6 of 3 is chillin.  Maybe should be 4444 and it is %h.", c);
		end
		else
		begin
			$display("Sub 6 of 3 is not chillin.  Maybe should be 4444 and it is %h.", c);
		end
		
		// Should also test overflow flag.  ////////////////////////////////////////////////////////
		
		// Cmp
		
		opcode = 5'b01011;
		a = 16'h0001;
		b = 16'h0000;
		
		#10
		
		if(c == 16'h0000 && flags == 5'b00000)
		begin
			$display("Cmp 1 of 1 is chilin.");
		end
		else
		begin
			$display("Cmp 1 of 1 is not chilin.");
		end
		
		
		a = 16'h0011;
		b = 16'h0011;
		
		#10
		
		if(c == 16'h0000 && flags == 5'b00010)
		begin
			$display("Cmp 2 of 1 is chilin.");
		end
		else
		begin
			$display("Cmp 2 of 1 is not chilin.");
		end
		
		
		a = 16'h8001;
		b = 16'h0002;
		
		#10
		
		if(c == 16'h0000 && flags == 5'b00001)
		begin
			$display("Cmp 3 of 1 is chilin.");
		end
		else
		begin
			$display("Cmp 3 of 1 is not chilin.");
		end
		
		
		a = 16'h0301;
		b = 16'h8000;
		
		#10
		
		if(c == 16'h0000 && flags == 5'b01000)
		begin
			$display("Cmp 4 of 1 is chilin.");
		end
		else
		begin
			$display("Cmp 4 of 1 is not chilin.");
		end
		
		
		a = 16'h0001;
		b = 16'h0300;
		
		#10
		
		if(c == 16'h0000 && flags == 5'b01001)
		begin
			$display("Cmp 5 of 1 is chilin.");
		end
		else
		begin
			$display("Cmp 5 of 1 is not chilin.");
		end
		
		// Zero flag is set if they are the same
		// L is set if unsigned a less than b
		// N is set if a is less than b
		
		// And
		
		opcode = 5'b00001;
		a = 16'h0007;
		b = 16'h007f;
		
		#10 // Try without this wait.  //////////////////////////////////////////////////////////////////
		
		if(c == 16'h0007 && flags == 5'b00000)
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
		
		if(c == 16'h0000 && flags == 5'b00000)
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
		
		if(c == 16'h0077 && flags == 5'b00000)
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
		
		if(c == 16'hf00f && flags == 5'b00000)
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
		
		if(c == 16'h0076 && flags == 5'b00000)
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
		
		if(c == 16'hf00f && flags == 5'b00000)
		begin
			$display("Xor 2 of 2 is chilin.");
		end
		else
		begin
			$display("Xor 2 of 2 is not chilin.");
		end
		
		// Not
		
		opcode = 5'b00100;
		a = 16'hffff;
		
		#10
		
		if(c == 16'h0000 && flags == 5'b00000)
		begin
			$display("Not 1 of 2 is chillin.");
		end
		else
		begin
			$display("Not 1 of 2 is not chillin.");
		end
		
		
		a = 16'h0f0f;
		
		#10
		
		if(c == 16'hf0f0 && flags == 5'b00000)
		begin
			$display("Not 1 of 2 is chillin.");
		end
		else
		begin
			$display("Not 1 of 2 is not chillin.");
		end
		
		// Lsh
		
		opcode = 5'b01100;
		a = 16'hffff;
		b = 16'h0004;
		
		#10
		
		if(c == 16'hfff0 && flags == 5'b00000)
		begin
			$display("Lsh 1 of 1 is chillin.");
		end
		else
		begin
			$display("Lsh 1 of 1 is not chillin.");
		end
		
		
		// Rsh
		
		opcode = 5'b10011;
		a = 16'hffff;
		b = 16'h0004;
		
		#10
		
		if(c == 16'h0fff && flags == 5'b00000)
		begin
			$display("Rsh 1 of 1 is chillin.");
		end
		else
		begin
			$display("Rsh 1 of 1 is not chillin.");
		end
		
		// Arsh
		
		opcode = 5'b10111;
		a = 16'hffff;
		b = 16'h0004;
		
		#10
		
		if(c == 16'hffff && flags == 5'b00000)
		begin
			$display("Arsh 1 of 3 is chillin.");
		end
		else
		begin
			$display("Arsh 1 of 3 is not chillin.");
		end
		
		
		a = 16'h7fff;
		b = 16'h0004;
		
		#10
		
		if(c == 16'h07ff && flags == 5'b00000)
		begin
			$display("Arsh 2 of 3 is chillin.");
		end
		else
		begin
			$display("Arsh 2 of 3 is not chillin.");
		end
		
		
		a = 16'h80ff;
		b = 16'h0004;
		
		#10
		
		if(c == 16'hf80f && flags == 5'b00000)
		begin
			$display("Arsh 3 of 3 is chillin.");
		end
		else
		begin
			$display("Arsh 3 of 3 is not chillin.");
		end
		
		$finish(2);

	end

endmodule

