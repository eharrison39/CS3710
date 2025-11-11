`timescale 1ns / 1ps


module rTypeTest;

	// inputs
	reg clk = 1;
	reg reset = 1;
	//wire [6:0] seg0, seg1, seg2, seg3;
	
	always #5 clk = ~clk;

	// Instantiate the fsm wrapper
	//fsmWrapper uut(.clk(clk), .rst(reset), .seg0(seg0), .seg1(seg1), .seg2(seg2), .seg3(seg3));
	
	regfileAluDatapathFullSynth cpu(.rst(reset), .clk(clk));

	// After setup hit reset && start running the clock
	initial begin
		reset = 0;
		#50
		reset = 1;	
		
		$finish;
		
	end

endmodule



