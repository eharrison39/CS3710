module vgaBitgenMem(
    input clk,
    input bright,
	 input [2:0] pixelData,
    input [9:0] hCount, vCount,
    output reg [2:0] rgb
);

localparam TILE_W = 10;
localparam TILE_H = 10;
localparam MAP_W  = 64;
localparam MAP_H  = 48;

wire [5:0] tile_x = hCount / TILE_W;
wire [5:0] tile_y = vCount / TILE_H;
wire [11:0] tile_addr = tile_y * MAP_W + tile_x;

// delay 1 cycle for sync
reg [11:0] tile_addr_d;
reg [9:0] hCount_d, vCount_d;
reg bright_d;

always @(posedge clk) begin
    tile_addr_d <= tile_addr;
    bright_d    <= bright;
	 hCount_d <= hCount;
    vCount_d <= vCount;
end

wire [7:0] tile_id;

// tilemap RAM (single read port)
dualPortRam #(
    .DATA_WIDTH(8),
    .ADDR_WIDTH(12),
    .INIT_FILE("maze.hex")
) tilemap (
    .data_a(8'd0),
    .addr_a(tile_addr_d),
    .we_a(1'b0),
    .q_a(tile_id),

    .data_b(8'd0),
    .addr_b(12'd0),
    .we_b(1'b0),
    .q_b(),
    .clk(clk)
);

always @(*) begin
    if (!bright_d) begin
        rgb = 3'b000;
    end else begin
	 case (pixelData)
		3'b001: begin
        rgb = tile_id[2:0];
		end
		default: rgb = 3'b000;
	 endcase
    end
end

endmodule
