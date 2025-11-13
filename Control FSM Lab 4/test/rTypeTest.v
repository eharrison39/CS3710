`timescale 1ns / 1ps


module rTypeTest;

	// inputs
	reg clk = 1;
	reg rst = 1;
	
	wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
	wire [4:0] flags;
	wire [15:0] instruction, regEn;
	
	wire [15:0] regV [0:15];
	wire [15:0] eVal [0:15]; 
	
	// values in registers
	assign regV[0]  = r0;
	assign regV[1]  = r15;
	assign regV[2]  = r15;
	assign regV[3]  = r1;
	assign regV[4]  = r15;
	assign regV[5]  = r0;
	assign regV[6]  = r2;
	assign regV[7]  = r2;
	assign regV[8]  = r8;
	assign regV[9]  = r9;
	assign regV[10] = r8;
	assign regV[11] = r8;
	assign regV[12] = r8;
	assign regV[13] = r9;
	assign regV[14] = r2;
	assign regV[15] = r7;
	
	// Expected values in Registers
	assign eVal[0]  = 16'h0005;
	assign eVal[1]  = 16'h0005;
	assign eVal[2]  = 16'h000a;
	assign eVal[3]  = 16'h0085;
	assign eVal[4]  = 16'hff85;
	assign eVal[5]  = 16'h0004;
	assign eVal[6]  = 16'h0004;
	assign eVal[7]  = 16'h0004;
	assign eVal[8]  = 16'h0002;
	assign eVal[9]  = 16'h0001;
	assign eVal[10] = 16'h0003;
	assign eVal[11] = 16'h0006;
	assign eVal[12] = 16'h0003;
	assign eVal[13] = 16'hfffe;
	assign eVal[14] = 16'h0004;
	assign eVal[15] = 16'h0007;
	
	cpuFullDatapathTB #(.INIT_FILE("r_test_memory_init.hex")) 
		cpu (clk, rst, r0, r1, r2, r3, r4, r5, r6, r7, r8, 
				r9, r10, r11, r12, r13, r14, r15, flags, instruction, regEn);
				
	always #5 clk = ~clk;
	
	integer i;
	integer nI;
	integer regN [0:15];
	integer currReg;
	
	// After setup hit reset && start running the clock
	initial begin
		nI = 16;
		regN[0]  = 0;
		regN[1]  = 15;
		regN[2]  = 15;
		regN[3]  = 1;
		regN[4]  = 15;
		regN[5]  = 0;
		regN[6]  = 2;
		regN[7]  = 2;
		regN[8]  = 8;
		regN[9]  = 9;
		regN[10] = 8;
		regN[11] = 8;
		regN[12] = 8;
		regN[13] = 9;
		regN[14] = 2;
		regN[15] = 7;
		
		rst = 0;
		#50
		rst = 1;
		
		
		for (i = 0; i < nI; i = i + 1) begin
			#30
			currReg = regEn;
			#10
			if(regV[i] == eVal[i])
				$display("PASS: Instruction: %04h	|	r%0d = %04h	|	expected = %04h	|	regEn: %04h	|	flags: %05h", 
							instruction, regN[i], regV[i], eVal[i], currReg, flags);
			else
				$display("Fail: Instruction: %04h	|	r%0d = %04h	|	expected = %04h	|	regEn: %04h	|	flags: %05h", 
							instruction, regN[i], regV[i], eVal[i], currReg, flags);
		end
		
//		if(cpu.ref.r0 == 'h0005)
//			$display("PASS: r0 == %0d", cpu.ref.r0);
//		else
//			$display("FAIL: r0 == %0d", cpu.ref.r0);
			
		//$finish;
		
	end

endmodule



