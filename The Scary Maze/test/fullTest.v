`timescale 1ns / 1ps


module fullTest;

	// inputs
	reg clk = 1;
	reg rst = 1;
	reg [15:0] snesInput = 16'h0000;
	
	wire [15:0] r0, r1, r2, r14, r15;
	wire [4:0] flags;
	wire [15:0] memOutA, srcMuxOut;
	wire [15:0] address;
	wire memAEn;
	
	dualPortRam #(.INIT_FILE("output.hex")) ram (.we_a(memAEn), .we_b(), .clk(clk), .addr_a(address), .addr_b(), 
						  .data_a(srcMuxOut), .data_b(), .q_a(memOutA), .q_b());
	cpuFullDatapathTB cpu (.clk(clk), .rst(rst), .snesInput(snesInput), .memOutA(memOutA), .srcMuxOut(srcMuxOut), .address(address), 
			.memAEn(memAEn), .r0(r0), .r1(r1), .r2(r2), .r14(r14), .r15(r15), .flags(flags));
				
	always #1 clk = ~clk;
	integer i;
	integer nI;
	
		// After setup hit reset && start running the clock
	initial begin
		nI = 1000;
		rst = 0;
		#10;
		rst = 1;
		#1000;
		snesInput = 16'h0040;
		for (i = 0; i < nI; i = i + 1) begin
			#20;
			snesInput = 16'h0000;
			#20;
			snesInput = 16'h0040;
			#20;
			snesInput = 16'h0000;
		end
		#100;
		
		//#5000;
			
		$finish;
		
	end
	

endmodule



