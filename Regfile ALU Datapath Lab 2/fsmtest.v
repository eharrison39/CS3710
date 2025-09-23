`timescale 1ns / 1ps


module fsmtest;

	// inputs
	reg clk = 1;
	reg reset = 1;
	wire [15:0] bus;
	wire [6:0] seg1, seg2, seg3;


	
	
	regfileAluDatapath uut(.clk(clk), .rst(reset), .segOutput1(seg1), .segOutput2(seg2), .segOutput3(seg3));
	
	initial begin
		
		always #5 clk = ~clk;
		
		#10
		#10
		#10
		#10
		#10
		#10
		#10
		#10
		#10
		#10
		#10
		#10
		#10
		#10
		#10
		#10
		
		$finish(2);

	end

endmodule

