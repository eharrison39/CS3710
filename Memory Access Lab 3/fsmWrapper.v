module fsmWrapper (
	
	input clk, rst,
	
	
	output wire [6:0] seg0, seg1, seg2, seg3

);
	
	// We can read and write from 2 different addresses in the same clock cycle
	wire [15:0] ramValueA;
	wire [15:0] ramValueB;
	reg [15:0] segOutput;
	
	reg writeEnableA = 0;
	reg writeEnableB = 0;
	
	reg [9:0] addrA, addrB;
	reg [15:0] dataA, dataB;
	
	
	// Address values specified in Lab 3 Manual
	localparam ADDR0 = 10'd0;
	localparam ADDR1 = 10'd1;
	localparam ADDR2 = 10'd2;
	localparam ADDR3 = 10'd510;
	localparam ADDR4 = 10'd511;
	localparam ADDR5 = 10'd512;
	localparam ADDR6 = 10'd513;
	
	//addrA = ADDR6;
	
	
	true_dual_port_ram_single_clock ramMod1(.clk(clk), .we_a(writeEnableA), .we_b(writeEnableB), .data_a(dataA), .data_b(dataB), 
														 .addr_a(addrA), .addr_b(addrB), .q_a(ramValueA), .q_b(ramValueB));
	reg [3:0]state;
	parameter [3:0] S_READA0 = 4'b0000, S_MODA0 = 4'b0001, S_WRITEA0 = 4'b0010, S_REREADA0 = 4'b0011,
						 S_READA1 = 4'b0100, S_MODA1 = 4'b0101, S_WRITEA1 = 4'b0110, S_REREADA1 = 4'b0111,
						 S_READB0 = 4'b1000, S_MODB0 = 4'b1001, S_WRITEB0 = 4'b1010, S_REREADB0 = 4'b1011,
						 S_READB1 = 4'b1100, S_MODB1 = 4'b1101, S_WRITEB1 = 4'b1110, S_REREADB1 = 4'b1111;
						
	// Iterate to next state on the posedge of the clock
	always @(posedge clk) begin
	 if (~rst)
		state <= S_READA0;
	 else
		case(state)
			S_READA0: 	state <= S_MODA0;
			S_MODA0:  	state <= S_WRITEA0;
			S_WRITEA0: 	state <= S_REREADA0;
			S_REREADA0: state <= S_READA1;
			
			S_READA1: 	state <= S_MODA1;
			S_MODA1: 	state <= S_WRITEA1;
			S_WRITEA1: 	state <= S_REREADA1;
			S_REREADA1: state <= S_READB0;
			
			S_READB0: 	state <= S_MODB0;
			S_MODB0: 	state <= S_WRITEB0;
			S_WRITEB0: 	state <= S_REREADB0;
			S_REREADB0: state <= S_READB1;
			
			S_READB1:	state <= S_MODB1;
			S_MODB1: 	state <= S_WRITEB1;
			S_WRITEB1: 	state <= S_REREADB1;
			S_REREADB1: state <= S_REREADB1;


			default: state <= S_READA0;
		endcase
	end
	
	//Define Each state case
	always @(state) begin
		// defaults
		writeEnableA = 0; 
		writeEnableB = 0;

		case (state)
		  // A0
		  S_READA0: begin
				addrA = ADDR0;
				addrB = 0;
		  end

		  S_MODA0: begin
				addrA = ADDR0;
				dataA = ramValueA + 16'h0001;
		  end

		  S_WRITEA0: begin
				addrA = ADDR0;
				writeEnableA = 1'b1; // perform write
		  end
		  
		  S_REREADA0: begin
				addrA = ADDR0;
		  end

		  // A1
		  S_READA1: begin
				addrA = ADDR1;
		  end

		  S_MODA1: begin
				addrA = ADDR1;
				dataA = ramValueA + 16'h0002;
		  end

		  S_WRITEA1: begin
				addrA = ADDR1;
				writeEnableA = 1'b1;
		  end
		  
		  S_REREADA1: begin
				addrA = ADDR1;
		  end

		  // B0
		  S_READB0: begin
				addrB = ADDR3;
				addrA = 0;
		  end

		  S_MODB0: begin
				addrB = ADDR3;
				dataB = ramValueB + 16'h0003;
		  end

		  S_WRITEB0: begin
				addrB = ADDR3;
				writeEnableB = 1'b1;
		  end
		  
		  S_REREADB0: begin
				addrB = ADDR3;
		  end

		  // B1
		  S_READB1: begin
				addrB = ADDR4;
		  end

		  S_MODB1: begin
				addrB = ADDR4;
				dataB = ramValueB + 16'h0004;
		  end

		  S_WRITEB1: begin
				addrB = ADDR4;
				writeEnableB = 1'b1;
		  end
		  
		  S_REREADB1: begin
				addrB = ADDR4;
		  end
		endcase
	end
	
	always @(state) begin
		case (state)
			S_READA0, S_MODA0, S_WRITEA0, S_REREADA0: segOutput = ramValueA;
			S_READA1, S_MODA1, S_WRITEA1, S_REREADA1: segOutput = ramValueA;
			S_READB0, S_MODB0, S_WRITEB0, S_REREADB0: segOutput = ramValueB;
			S_READB1, S_MODB1, S_WRITEB1, S_REREADB1: segOutput = ramValueB;
			default: segOutput = 16'h0000;
		endcase
	end
		
	bcd_to_sev_seg bcd3(segOutput[15:12], seg3);
	bcd_to_sev_seg bcd2(segOutput[11:8], seg2);
	bcd_to_sev_seg bcd1(segOutput[7:4], seg1);
	bcd_to_sev_seg bcd0(segOutput[3:0], seg0);


endmodule