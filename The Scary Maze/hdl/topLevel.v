


module topLevel #(parameter INIT_FILE = "output.hex") 
(clk, SNES_DATA_IN, SNES_CLOCK_OUT, SNES_LATCH_OUT, hSync, vSync, rgb, bright, vga_clk, segr15a, segr15b, segr15c, segr15d);

input wire clk;

input wire SNES_DATA_IN;
output wire SNES_CLOCK_OUT;
output wire SNES_LATCH_OUT;

output wire [23:0] rgb;
output wire hSync, vSync, bright, vga_clk;

output wire [6:0] segr15a, segr15b, segr15c, segr15d;

wire [15:0] snesData;
wire rst;
wire memAEn, memBEn;
wire [15:0] addrB;
wire [15:0] memOutA, memOutB;

wire [15:0] srcMuxOut, r0, r1, r2, r15;
wire [15:0] address;


SNES controller( .clk(clk), .snes_data(SNES_DATA_IN), .snes_clock(SNES_CLOCK_OUT),
					  .snes_latch(SNES_LATCH_OUT), .outputData(snesData));

//SNES_Interface snesInterface(.snesData(snesData), .clk(clk), .ram_we(memAEn), .ram_addr(addrb), .ram_data());


dualPortRam #(.INIT_FILE(INIT_FILE)) ram(.we_a(memAEn), .we_b(memBEn), .clk(clk), .addr_a(address), .addr_b(addrB), 
						  .data_a(srcMuxOut), .data_b(snesData), .q_a(memOutA), .q_b(memOutB));
						  
cpuFullDatapath cpu(.clk(clk), .rst(rst), .snesInput(snesData), .memOutA(memOutA), .srcMuxOut(srcMuxOut), 
										 .address(address), .memAEn(memAEn), .r0(r0), .r1(r1), .r2(r2), .r15(r15));

wire [9:0] hCount, vCount;
wire [7:0] rgb_base;

assign rgb = {rgb_base[7:5], 5'b0, rgb_base[4:2], 5'b0, rgb_base[1:0], 6'b0};

assign rst = ~(r15 == 16'h0004);

vgaClkDiv div (.clk(clk), .rst(rst), .countEn(vga_clk));

vgaController ctrl (.clk(clk), .rst(rst), .countEn(vga_clk), .hSync(hSync), .vSync(vSync), 
														.bright(bright), .hCount(hCount), .vCount(vCount));
									
//vgaBitgenMem bitgen (.clk(clk), .pixelData(swc), .bright(bright), .hCount(hCount), .vCount(vCount), .rgb(rgb_base));
vgaBitgen bitgen (.pixelData(r2[2:0]), .bright(bright), .hCount(hCount), .vCount(vCount), .rgb(rgb_base), .x(r1), .y(r0));

bcd_to_sev_seg bcdAlu1(r15[3:0], segr15a);
bcd_to_sev_seg bcdAlu2(r15[7:4], segr15b);
bcd_to_sev_seg bcdAlu3(r15[11:8], segr15c);
bcd_to_sev_seg bcdAlu4(r15[15:12], segr15d);

// Example: show some buttons on LEDs
//assign LEDR[15:0] = memOutA;

endmodule

