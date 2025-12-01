`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 		David Brown
//// 
//// Create Date:    11/25/2025 
//// Module Name:    vgaTest
//// Project Name: 	vga
//// Description: 	
////
//// Dependencies: 	
////
//// Revision 0.01 - File Created
////
////////////////////////////////////////////////////////////////////////////////////
//
//
//////////////////////////////////////////////////////////////////////////////////


module vgaTest;

reg clk = 1;
reg rst = 1;

reg [2:0] swc;

wire hSync, vSync;
wire [2:0] rgb;
wire countEn, bright;
wire [9:0] hCount, vCount;


vgaDriverTb drvTest(.clk(clk), .rst(rst), .swc(swc), .hSync(hSync), .vSync(vSync), .rgb(rgb), 
							.countEn(countEn), .bright(bright), .hCount(hCount), .vCount(vCount));

always #1 clk = ~clk;
integer i;
	
initial begin
	rst = 0;
	#10;
	rst = 1;
	
	swc = 3'b101;
	
	for (i = 0; i <= 120; i = i + 1) begin
		if (((hCount >= 100) && (hCount <= 300)) &&
				((vCount >= 150) && (vCount <= 350))) begin
			$display("swc: %03b	|	rgb: %03b", swc, rgb);
		end
	
		#20000;
	end
	
	
	$finish;
end

endmodule