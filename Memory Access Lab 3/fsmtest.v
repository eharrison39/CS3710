`timescale 1ns / 1ps


module fsmtest;

	// inputs
	reg clk = 1;
	reg reset = 1;
	wire [6:0] seg0, seg1, seg2, seg3;
	
	always #5 clk = ~clk;

	// Instantiate the fsm wrapper
	fsmWrapper uut(.clk(clk), .rst(reset), .seg0(seg0), .seg1(seg1), .seg2(seg2), .seg3(seg3));

	// After setup hit reset && start running the clock
	initial begin
		reset = 0;
		#10
		
		
		reset = 1;
		
		
		#10
		
		if(seg0 == ~7'b1111001 && seg1 == ~7'b1111110 && seg2 == ~7'b1111110 && seg3 == ~7'b1111110)
			$display("S0: Passed");
		else
			$display("S0: Passed");
			
		
		#10
		
		if(seg0 == ~7'b1111001 && seg1 == ~7'b1111110 && seg2 == ~7'b1111110 && seg3 == ~7'b1111110)
			$display("S1: Passed");
		else
			$display("S1: Passed");
			
		
		#10
		
		if(seg0 == ~7'b0110011 && seg1 == ~7'b1111110 && seg2 == ~7'b1111110 && seg3 == ~7'b1111110)
			$display("S2: Passed");
		else
			$display("S2: Passed");
		
		#10
		
		if(seg0 == ~7'b0110011 && seg1 == ~7'b1111110 && seg2 == ~7'b1111110 && seg3 == ~7'b1111110)
			$display("S3: Passed");
		else
			$display("S3: Passed");
			
		#10
		
		if(seg0 == ~7'b1111001 && seg1 == ~7'b1111110 && seg2 == ~7'b1111110 && seg3 == ~7'b1111110)
			$display("S4: Passed");
		else
			$display("S4: Passed");
			
		#10
		
		if(seg0 == ~7'b1111001 && seg1 == ~7'b1111001 && seg2 == ~7'b1111110 && seg3 == ~7'b1111110)
			$display("S5: Passed");
		else
			$display("S5: Passed");
			
		#10
		
		if(seg0 == ~7'b1111001 && seg1 == ~7'b1111001 && seg2 == ~7'b1111110 && seg3 == ~7'b1111110)
			$display("S6: Passed");
		else
			$display("S6: Passed");
			
		#10
		
		if(seg0 == ~7'b1011011 && seg1 == ~7'b1111001 && seg2 == ~7'b1111110 && seg3 == ~7'b1111110)
			$display("S7: Passed");
		else
			$display("S7: Passed");

			
			
		
		#10
		
		if(seg3 == ~7'b1111001 && seg2 == ~7'b1111001 && seg1 == ~7'b1111001 && seg0 == ~7'b1111001)
			$display("S8: Passed");
		else
			$display("S8: Passed");
			
		#10
		
		if(seg3 == ~7'b1111001 && seg2 == ~7'b1111001 && seg1 == ~7'b1111001 && seg0 == ~7'b1111001)
			$display("S9: Passed");
		else
			$display("S9: Passed");
			
		#10
		
		if(seg3 == ~7'b1111001 && seg2 == ~7'b1111001 && seg1 == ~7'b1111001 && seg0 == ~7'b1111001)
			$display("S10: Passed");
		else
			$display("S10: Passed");
			
		#10
		
		if(seg3 == ~7'b1111001 && seg2 == ~7'b1111001 && seg1 == ~7'b1111001 && seg0 == ~7'b1111001)
			$display("S11: Passed");
		else
			$display("S11: Passed");
			
		#10
		
		if(seg3 == ~7'b1111001 && seg2 == ~7'b1111001 && seg1 == ~7'b1111001 && seg0 == ~7'b1011111)
			$display("S12: Passed");
		else
			$display("S12: Passed");
			
		#10
		
		if(seg3 == ~7'b0110000 && seg2 == ~7'b0110000 && seg1 == ~7'b1111001 && seg0 == ~7'b1111001)
			$display("S13: Passed");
		else
			$display("S13: Passed");
			
		#10
		
		if(seg3 == ~7'b0110000 && seg2 == ~7'b0110000 && seg1 == ~7'b1111001 && seg0 == ~7'b1111001)
			$display("S14: Passed");
		else
			$display("S14: Passed");
			
		#10
		
		if(seg3 == ~7'b1111001 && seg2 == ~7'b1111001 && seg1 == ~7'b1111001 && seg0 == ~7'b1110000)
			$display("S15: Passed");
		else
			$display("S15: Passed");
				
				
		$finish(2);

	end

endmodule



