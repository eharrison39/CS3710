`timescale 1ns / 1ps


module fsmtest;

	// inputs
	reg clk = 1;
	reg reset = 1;
	wire [6:0] seg1, seg2, seg3;
	
	always #5 clk = ~clk;

	// Instantiate the regfile alu datapath
	regfileAluDatapath uut(.clk(clk), .rst(reset), .segOutput1(seg1), .segOutput2(seg2), .segOutput3(seg3));

	// After setup hit reset and start running the clock
	initial begin
		reset = 0;
		
		#10
		reset = 1;
		
		// S0
		
		if(seg1 == ~7'b0110000 && seg2 == ~7'b1111110 && seg3 == ~7'b1111110) begin
			$display("S0: accepted");
		end
		else begin
			$display("S0: denied");
		end

		
		#10
		// S1
		if(seg1 == ~7'b0110000 && seg2 == ~7'b1111110 && seg3 == ~7'b1111110) begin
			$display("S1: accepted");
		end
		else begin
			$display("S1: denied");
		end
		
		
		#10
		// S2
		
		if(seg1 == ~7'b1101101 && seg2 == ~7'b1111110 && seg3 == ~7'b1111110) begin
			$display("S2: accepted");
		end
		else begin
			$display("S2: denied");
		end
		
		#10
		// S3
		
		if(seg1 == ~7'b1111001 && seg2 == ~7'b1111110 && seg3 == ~7'b1111110) begin
			$display("S3: accepted");
		end
		else begin
			$display("S3: denied");
		end
		
		#10
		// S4
		
		if(seg1 == ~7'b1011011 && seg2 == ~7'b1111110 && seg3 == ~7'b1111110) begin
			$display("S4: accepted");
		end
		else begin
			$display("S4: denied");
		end
		
		
		#10
		// S5
		
		if(seg1 == ~7'b1111111 && seg2 == ~7'b1111110 && seg3 == ~7'b1111110) begin
			$display("S5: accepted");
		end
		else begin
			$display("S5: denied");
		end
		
		#10
		// S6
		
		if(seg1 == ~7'b0111101 && seg2 == ~7'b1111110 && seg3 == ~7'b1111110) begin
			$display("S6: accepted");
		end
		else begin
			$display("S6: denied");
		end
		
		#10
		// S7
		
		if(seg1 == ~7'b1011011 && seg2 == ~7'b0110000 && seg3 == ~7'b1111110) begin
			$display("S7: accepted");
		end
		else begin
			$display("S7: denied");
		end
		
		#10
		// S8
		
		if(seg1 == ~7'b1101101 && seg2 == ~7'b1101101 && seg3 == ~7'b1111110) begin
			$display("S8: accepted");
		end
		else begin
			$display("S8: denied");
		end
		
		#10
		// S9
		
		if(seg1 == ~7'b1110000 && seg2 == ~7'b1111001 && seg3 == ~7'b1111110) begin
			$display("S9: accepted");
		end
		else begin
			$display("S9: denied");
		end
		
		#10
		// S10
		
		if(seg1 == ~7'b1110011 && seg2 == ~7'b1011011 && seg3 == ~7'b1111110) begin
			$display("S10: accepted");
		end
		else begin
			$display("S10: denied");
		end
		
		#10
		// S11
		
		if(seg1 == ~7'b1111110 && seg2 == ~7'b1110011 && seg3 == ~7'b1111110) begin
			$display("S11: accepted");
		end
		else begin
			$display("S11: denied");
		end
		
		#10
		// S12
		
		if(seg1 == ~7'b1110011 && seg2 == ~7'b1001111 && seg3 == ~7'b1111110) begin
			$display("S12: accepted");
		end
		else begin
			$display("S12: denied");
		end
		
		#10
		// S13
		
		if(seg1 == ~7'b1110011 && seg2 == ~7'b1110000 && seg3 == ~7'b0110000) begin
			$display("S13: accepted");
		end
		else begin
			$display("S13: denied");
		end
		
		#10
		// S14
		
		if(seg1 == ~7'b1101101 && seg2 == ~7'b1011111 && seg3 == ~7'b1101101) begin
			$display("S14: accepted");
		end
		else begin
			$display("S14: denied");
		end
		
	
		$finish(2);

	end

endmodule

