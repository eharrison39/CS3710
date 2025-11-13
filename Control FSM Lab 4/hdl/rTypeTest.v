`timescale 1ns / 1ps


module rTypeTest;

	// inputs
	reg clk = 1;
	reg reset = 1;
	
	always #5 clk = ~clk;
	
	regfileAluDatapathFullSynth #(.INIT_FILE("jb_test_memory_init.hex")) cpu(.rst(reset), .clk(clk));

	// After setup hit reset && start running the clock
	initial begin
		

		reset = 0;
		#50
		reset = 1;
		
		#50
		
//		if(cpu.ref.r0 == 'h0005)
//			$display("PASS: r0 == %0d", cpu.ref.r0);
//		else
//			$display("FAIL: r0 == %0d", cpu.ref.r0);
			
		$finish;
		
	end

endmodule



