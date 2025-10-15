`timescale 1ns / 1ps


module fsmtest;

	// inputs
	reg clk = 1;
	reg reset = 1;
	wire [6:0] seg0, seg1, seg2, seg3;
	
	always #1 clk = ~clk;

	// Instantiate the fsm wrapper
	fsmWrapper uut(.clk(clk), .rst(reset), .seg0(seg0), .seg1(seg1), .seg2(seg2), .seg3(seg3));

	// After setup hit reset and start running the clock
	initial begin
		
		
		#5
		
	
		$finish(2);

	end

endmodule



