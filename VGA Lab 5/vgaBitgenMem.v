module vgaBitgenMem(
    input clk,
    input bright,
	 input [2:0] pixelData,
    input [9:0] hCount, vCount,
    output reg [7:0] rgb
);

localparam TILE_W = 10;
localparam TILE_H = 10;
localparam MAP_W  = 64;
localparam MAP_H  = 48;

wire [5:0] tile_x = hCount / TILE_W;
wire [5:0] tile_y = vCount / TILE_H;
wire [11:0] tile_addr = tile_y * MAP_W + tile_x;


reg [11:0] tileAddr_d;  // stage 1: address presented to RAM
reg [2:0] pixel_d;      // stage 1: capture pixelData
reg bright_d;
reg [7:0] tileId_d;    // s1 captures RAM q (if RAM is synchronous it appears here)



always @(posedge clk) begin
    tileAddr_d <= tile_addr;
    bright_d <= bright;
	 pixel_d <= pixelData;
end

// tilemap RAM (single read port)
dualPortRam #(
    .DATA_WIDTH(8),
    .ADDR_WIDTH(12),
    .INIT_FILE("scary.hex")
) tilemap (
    .data_a(8'd0),
    .addr_a(tileAddr_d),
    .we_a(1'b0),
    .q_a(tile_id),

    .data_b(8'd0),
    .addr_b(12'd0),
    .we_b(1'b0),
    .q_b(),
    .clk(clk)
);

wire [7:0] tile_id;
always @(posedge clk) begin
	tileId_d <= tile_id;
end


always @(*) begin
    if (!bright_d) begin
        rgb = 8'h00;
    end else begin
	 case (pixel_d)
		3'b001: begin
         rgb = tileId_d;
		end
		default: rgb = 8'h00;
	 endcase
    end
end

endmodule
