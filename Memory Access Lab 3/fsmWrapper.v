module fsmWrapper (
	
	input clk, rst,
	
	
	output wire [7:0] seg0, seg1, seg2, seg3

);
	
	// We can read and write from 2 different addresses in the same clock cycle
	wire [15:0] ramValueA;
	wire [15:0] ramValueB;
	
	wire writeEnableA = 0;
	wire writeEnableB = 0;
	
	wire [9:0] addrA, addrB;
	wire [15:0] dataA, dataB;
	
	
	
	// Address values specified in Lab 3 Manual
	localparam ADDR0 = 10'd0;
	localparam ADDR1 = 10'd1;
	localparam ADDR2 = 10'd2;
	localparam ADDR3 = 10'd510;
	localparam ADDR4 = 10'd511;
	localparam ADDR5 = 10'd512;
	localparam ADDR6 = 10'd513;
	
	assign addrA = ADDR6;
	
	
	true_dual_port_ram_single_clock ramMod1(.clk(clk), .we_a(writeEnableA), .we_b(writeEnableB), .data_a(dataA), .data_b(dataB), 
														 .addr_a(addrA), .addr_b(addrB), .q_a(ramValueA), .q_b(ramValueB));
	
	
	
	bcd_to_sev_seg bcd3(ramValueA[15:12], seg3);
	bcd_to_sev_seg bcd2(ramValueA[11:8], seg2);
	bcd_to_sev_seg bcd1(ramValueA[7:4], seg1);
	bcd_to_sev_seg bcd0(ramValueA[3:0], seg0);


endmodule