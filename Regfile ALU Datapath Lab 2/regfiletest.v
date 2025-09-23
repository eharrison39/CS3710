`timescale 1ns / 1ps

module regfiletest;

	// inputs
	reg clk = 0;
	reg reset = 1;
	reg [15:0] bus = 16'h0000;
	reg [15:0] regEnable = 16'h0000;
	
	// outputs
	wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
	
	
	always #1 clk = ~clk;
	

	// Instantiate the Unit Under Test (UUT)
	regfile uut (.regEn(regEnable), .aluBus(bus), .clk(clk), .reset(reset), .r0(r0), .r1(r1), .r2(r2),
					 .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12),
					 .r13(r13), .r14(r14), .r15(r15));

	initial begin

		bus = 16'h153a;

		regEnable[0] = 1;
		
		#10
		
		if(r0 == bus) begin
			$display("Part 1 - r0: accepted");
		end
		else begin
			$display("Part 1 - r0: denied");
		end
		
		#2
		
		bus = 16'h2222;
		
		#10
		
		if(r0 == bus) begin
			$display("Part 2 - r0: accepted");
		end
		else begin
			$display("Part 2 - r0: denied");
		end
		
		#2
		
		regEnable[0] = 0;
		regEnable[8] = 1;
		

		bus = 16'h1111;
		
		#10
		
		if(r8 == bus) begin
			$display("Part 3 - r8: accepted");
		end
		else begin
			$display("Part 3 - r8: denied");
		end
		
		if(r0 == 16'h2222) begin
			$display("Part 3 - r0: accepted");
		end
		else begin
			$display("Part 3 - r0: denied");
		end
		
		#2
		
		bus = 16'h3333;
		
		#10
		
		if(r8 == bus) begin
			$display("Part 4 - r8: accepted");
		end
		else begin
			$display("Part 4 - r8: denied");
		end
		
		if(r0 == 16'h2222) begin
			$display("Part 4 - r0: accepted");
		end
		else begin
			$display("Part 4 - r0: denied");
		end
		
		#2
		regEnable[8] = 0;
		regEnable[14] = 1;
		
		bus = 16'h5555;
		
		#10
		
		if(r14 == bus) begin
			$display("Part 5 - r14: accepted");
		end
		else begin
			$display("Part 5 - r14: denied");
		end
		
		if(r8 == 16'h3333) begin
			$display("Part 5 - r8: accepted");
		end
		else begin
			$display("Part 5 - r8: denied");
		end
		
		if(r0 == 16'h2222) begin
			$display("Part 5 - r0: accepted");
		end
		else begin
			$display("Part 5 - r0: denied");
		end
		
		#2
		
		reset = ~reset;
		
		#2
		
		reset = ~reset;
		bus = 16'h0000;
		
		#10
		
		
		if(r14 == 16'h0000) begin
			$display("Part 6 - r14: accepted");
		end
		else begin
			$display("Part 6 - r14: denied");
		end
		
		if(r8 == 16'h0000) begin
			$display("Part 6 - r8: accepted");
		end
		else begin
			$display("Part 6 - r8: denied");
		end
		
		if(r0 == 16'h0000) begin
			$display("Part 6 - r0: accepted");
		end
		else begin
			$display("Part 6 - r0: denied");
		end
		
		
		$finish(2);

	end

endmodule

