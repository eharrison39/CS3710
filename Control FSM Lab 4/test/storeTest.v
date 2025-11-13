`timescale 1ns / 1ps


module storeTest;

	// inputs
	reg clk = 1;
	reg rst = 1;
	
	wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
	wire [4:0] flags;
	wire [15:0] instruction, regEn;
	wire [9:0] address;
	
	wire [15:0] regV [0:20];
	wire [15:0] eVal [0:20]; 
	
	// values in registers
	assign regV[0]  = r8;
	assign regV[1]  = r5;
	assign regV[2]  = r0;
	assign regV[3]  = r1;
	assign regV[4]  = r0;
	assign regV[5]  = r0;
	assign regV[6]  = r8;
	assign regV[7]  = r2;
	assign regV[8]  = r3;
	assign regV[9]  = r4;
	assign regV[10] = r6;
	assign regV[11] = {6'b000000, address};
	assign regV[12] = r7;
	assign regV[13] = {6'b000000, address};
	assign regV[14] = {6'b000000, address};
	assign regV[15] = {6'b000000, address};
	assign regV[16] = r9;
	assign regV[17] = r10;
	assign regV[18] = r11;
	assign regV[19] = {6'b000000, address};
	assign regV[20] = r10;
	
	// Expected values in Registers
	assign eVal[0]  = 16'h0021;
	assign eVal[1]  = 16'h0019;
	assign eVal[2]  = 16'h0008;
	assign eVal[3]  = 16'h0001;
	assign eVal[4]  = 16'h0009;
	assign eVal[5]  = 16'h0000;
	assign eVal[6]  = 16'h0022;
	assign eVal[7]  = 16'h0021;
	assign eVal[8]  = 16'h0022;
	assign eVal[9]  = 16'h0023;
	assign eVal[10] = 16'h0024;
	assign eVal[11] = 16'h0021;
	assign eVal[12] = 16'h0022;
	assign eVal[13] = 16'h0022;
	assign eVal[14] = 16'h0023;
	assign eVal[15] = 16'h0024;
	assign eVal[16] = 16'h0019;
	assign eVal[17] = 16'h0001;
	assign eVal[18] = 16'h0021;
	assign eVal[19] = 16'h0019;
	assign eVal[20] = 16'h0022;
	
	cpuFullDatapathTB #(.INIT_FILE("store_test_memory_init.hex")) 
		cpu (clk, rst, r0, r1, r2, r3, r4, r5, r6, r7, r8, 
				r9, r10, r11, r12, r13, r14, r15, flags, instruction, regEn, address);
				
	always #5 clk = ~clk;
	
	integer i;
	integer nI;
	integer regN [0:20];
	integer currReg;
	integer currAddr;
	
	// After setup hit reset && start running the clock
	initial begin
		nI = 21;
		regN[0]  = 8;
		regN[1]  = 5;
		regN[2]  = 0;
		regN[3]  = 1;
		regN[4]  = 0;
		regN[5]  = 0;
		regN[6]  = 8;
		regN[7]  = 2;
		regN[8]  = 3;
		regN[9]  = 4;
		regN[10] = 6;
		regN[11] = 17; // R-address
		regN[12] = 7;
		regN[13] = 17; // R-address
		regN[14] = 17; // R-address
		regN[15] = 17; // R-address
		regN[16] = 9;
		regN[17] = 10;
		regN[18] = 11;
		regN[19] = 17; // R-address
		regN[20] = 10;
		
		rst = 0;
		#50;
		rst = 1;
		
		
		for (i = 0; i < nI; i = i + 1) begin
			
			#30;
			currReg = regEn;
			currAddr = address;
			#10;
			if(instruction[15:12] == 4'h4 && instruction[7:4] == 4'h0) begin
				currReg = regEn;
				#10;
			end
			//currAddr = address;
			if(instruction[15:12] == 4'h4 && instruction[7:4] == 4'h4) begin
				if(currAddr == eVal[i])
					$display("PASS: Instruction: %04h	|	address = %04h	|	expected = %04h	|	regEn: %04h	|	flags: %05h", 
								instruction, currAddr, eVal[i], currReg, flags);
				else
					$display("Fail: Instruction: %04h	|	address = %04h	|	expected = %04h	|	regEn: %04h	|	flags: %05h", 
								instruction, currAddr, eVal[i], currReg, flags);
			end
			
			else begin
				if(regV[i] == eVal[i])
					$display("PASS: Instruction: %04h	|	r%0d = %04h	|	expected = %04h	|	regEn: %04h	|	flags: %05h", 
								instruction, regN[i], regV[i], eVal[i], currReg, flags);
				else
					$display("Fail: Instruction: %04h	|	r%0d = %04h	|	expected = %04h	|	regEn: %04h	|	flags: %05h", 
								instruction, regN[i], regV[i], eVal[i], currReg, flags);
			end
							
		end
		
//		if(cpu.ref.r0 == 'h0005)
//			$display("PASS: r0 == %0d", cpu.ref.r0);
//		else
//			$display("FAIL: r0 == %0d", cpu.ref.r0);
			
		$finish;
		
	end

endmodule



