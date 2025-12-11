`timescale 1ns / 1ps


module fullTest;

	// inputs
	reg clk = 1;
	reg rst = 1;
	
	wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
	wire [4:0] flags;
	wire [15:0] instruction, regEn;
	wire [9:0] address;
	
	wire [15:0] regV [0:35];
	wire [15:0] eVal [0:35]; 
	
	// values in registers
	assign regV[0]  = r0;
	assign regV[1]  = r1;
	assign regV[2]  = r0;
	assign regV[3]  = r2;
	assign regV[4]  = {6'b000000, address};
	assign regV[5]  = r0;
	assign regV[6]  = r2;
	assign regV[7]  = {6'b000000, address};
	assign regV[8]  = r0;
	assign regV[9]  = r2;
	assign regV[10] = {6'b000000, address};
	assign regV[11] = r0;
	assign regV[12] = r2;
	assign regV[13] = {6'b000000, address};
	assign regV[14] = r0;
	assign regV[15] = r2;
	assign regV[16] = {6'b000000, address}; // stopped here continue on jump instruction
	assign regV[17] = r9;
	assign regV[18] = r3;
	assign regV[19] = flags;
	assign regV[20] = {6'b000000, address};
	assign regV[21] = r1;
	assign regV[22] = r2;
	assign regV[23] = r2;
	assign regV[24] = r2;
	assign regV[25] = r3;
	assign regV[26] = flags;
	assign regV[27] = {6'b000000, address};
	assign regV[28] = {6'b000000, address};
	assign regV[29] = r3;
	assign regV[30] = r4;
	assign regV[31] = r5;
	assign regV[32] = {6'b000000, address};
	assign regV[33] = {6'b000000, address};
	assign regV[34] = r6;
	assign regV[35] = r7;
	
	
	// Expected values in Registers
	assign eVal[0]  = 16'h0005;
	assign eVal[1]  = 16'h0001;
	assign eVal[2]  = 16'h0004;
	assign eVal[3]  = 16'h0001;
	assign eVal[4]  = 16'h0004;
	assign eVal[5]  = 16'h0003;
	assign eVal[6]  = 16'h0002;
	assign eVal[7]  = 16'h0004;
	assign eVal[8]  = 16'h0002;
	assign eVal[9]  = 16'h0003;
	assign eVal[10] = 16'h0004;
	assign eVal[11] = 16'h0001;
	assign eVal[12] = 16'h0004;
	assign eVal[13] = 16'h0004;
	assign eVal[14] = 16'h0000;
	assign eVal[15] = 16'h0005;
	assign eVal[16] = 16'h0004;
	assign eVal[17] = 16'h0006;
	assign eVal[18] = 16'h000a; 
	assign eVal[19] = 16'h0009;	// (010010)
	assign eVal[20] = 16'h000c;
	assign eVal[21] = 16'h0003;
	assign eVal[22] = 16'h0005;
	assign eVal[23] = 16'h0007;
	assign eVal[24] = 16'h000a;
	assign eVal[25] = 16'h000a; // (00010)
	assign eVal[26] = 16'h0002;
	assign eVal[27] = 16'h000c;
	assign eVal[28] = 16'h000d;
	assign eVal[29] = 16'h000b;
	assign eVal[30] = 16'h0017;
	assign eVal[31] = 16'h0018;
	assign eVal[32] = 16'h0017;
	assign eVal[33] = 16'h0018;
	assign eVal[34] = 16'h000b;
	assign eVal[35] = 16'h0006;
	
	cpuFullDatapathTB #(.INIT_FILE("full_test_memory_init.hex")) 
		cpu (clk, rst, r0, r1, r2, r3, r4, r5, r6, r7, r8, 
				r9, r10, r11, r12, r13, r14, r15, flags, instruction, regEn, address);
				
	always #5 clk = ~clk;
	
	integer i;
	integer nI;
	integer regN [0:35];
	integer currReg;
	integer currAddr;
	
	// After setup hit reset && start running the clock
	initial begin
		nI = 36;
		regN[0]  = 0;
		regN[1]  = 1;
		regN[2]  = 0;
		regN[3]  = 2;
		regN[4]  = 17; // address
		regN[5]  = 0;
		regN[6]  = 2;
		regN[7]  = 17; // address
		regN[8]  = 0;
		regN[9]  = 2;
		regN[10] = 17; // address
		regN[11] = 0;
		regN[12] = 2;
		regN[13] = 17; // address
		regN[14] = 0;
		regN[15] = 2;
		regN[16] = 17; // stopped here continue on jump instruction
		regN[17] = 9;
		regN[18] = 3; 
		regN[19] = 18; // flags
		regN[20] = 17; // address
		regN[21] = 1;
		regN[22] = 2;
		regN[23] = 2;
		regN[24] = 2;
		regN[25] = 3; 
		regN[26] = 18; // flags
		regN[27] = 17; // address
		regN[28] = 17;  // address
		regN[29] = 3;
		regN[30] = 4;
		regN[31] = 5;
		regN[32] = 17;	// address
		regN[33] = 17;	// address
		regN[34] = 6;
		regN[35] = 7;
		
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
			if	((instruction[15:12] == 4'h4 && instruction[7:4] == 4'h4) || (instruction[15:12] == 4'hc)) begin
				if(currAddr == eVal[i])
					$display("PASS: Instruction: %04h	|	address = %04h	|	expected = %04h	|	regEn: %04h	|	flags: %05b", 
								instruction, currAddr, eVal[i], currReg, flags);
				else
					$display("FAIL: Instruction: %04h	|	address = %04h	|	expected = %04h	|	regEn: %04h	|	flags: %05b", 
								instruction, currAddr, eVal[i], currReg, flags);
			end
			
			else begin
				if(regV[i] == eVal[i])
					$display("PASS: Instruction: %04h	|	r%0d = %04h	|	expected = %04h	|	regEn: %04h	|	flags: %05b", 
								instruction, regN[i], regV[i], eVal[i], currReg, flags);
				else
					$display("FAIL: Instruction: %04h	|	r%0d = %04h	|	expected = %04h	|	regEn: %04h	|	flags: %05b", 
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



