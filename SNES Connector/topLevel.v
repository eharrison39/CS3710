module topLevel #(parameter INIT_FILE = "memory_init.hex") 
(
    input  wire clk,
    input  wire SNES_DATA_IN,
    output wire SNES_CLOCK_OUT,
    output wire SNES_LATCH_OUT,

    output wire [15:0] LEDR
);

	 wire [15:0] snesData;
	 
	 wire memAEn, memBEn;
	 wire [9:0] addrA, addrB;
	 wire [15:0] memOutA, memOutB;
	 

    SNES controller(
        .clk(clk),
        .snes_data(SNES_DATA_IN),
        .snes_clock(SNES_CLOCK_OUT),
        .snes_latch(SNES_LATCH_OUT),
        .outputData(snesData)
    );
	 
	 SNES_Interface snesInterface(.snesData(snesData), .clk(clk), .ram_we(memAEn), .ram_addr(addrA), .ram_data());
	 
	 
	 
	dualPortRam #(.INIT_FILE(INIT_FILE)) ram(.we_a(memAEn), .we_b(memBEn), .clk(clk), .addr_a(addrA), .addr_b(addrB), 
						  .data_a(snesData), .data_b(snesData), .q_a(memOutA), .q_b(memOutB));

    // Example: show some buttons on LEDs
    assign LEDR[15:0] = memOutA;

endmodule