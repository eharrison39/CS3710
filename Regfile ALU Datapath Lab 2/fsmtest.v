`timescale 1ns / 1ps


module fsmtest;

	// inputs
	reg clk = 1;
	reg reset = 1;
	//wire [15:0] bus;
	wire [6:0] seg1, seg2, seg3;
	
	always #5 clk = ~clk;

	regfileAluDatapath uut(.clk(clk), .rst(reset), .segOutput1(seg1), .segOutput2(seg2), .segOutput3(seg3));
	
	initial begin
		reset = 0;
		
		#10
		reset = 1;
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


//`timescale 1ns / 1ps
//
//module fsmtest;
//
//    // Inputs
//    reg clk = 0;
//    reg reset = 1;
//
//    // Outputs
//    wire [6:0] seg1, seg2, seg3;
//
//    // Clock generation (100 MHz)
//    always #5 clk = ~clk;
//
//    // Instantiate UUT
//    regfileAluDatapath uut (
//        .clk(clk),
//        .rst(reset),
//        .segOutput1(seg1),
//        .segOutput2(seg2),
//        .segOutput3(seg3)
//    );
//
//    // Reset + simulation sequence
//    initial begin
//        // Apply reset for a short time
//        reset = 0;
//        #20;
//        reset = 1;
//
//        // Run long enough to observe several state cycles
//        repeat (100) @(posedge clk);
//
//        $finish;
//    end
//
//    // Watch outputs change
//    initial begin
//        $monitor("t=%0t | reset=%b | seg1=%h seg2=%h seg3=%h",
//                 $time, reset, seg1, seg2, seg3);
//    end
//
//endmodule

