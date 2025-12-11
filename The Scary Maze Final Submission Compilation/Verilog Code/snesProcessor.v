module SNES_Interface (
    input  wire clk,

    // SNES button inputs
    input wire [15:0] snesData,

    // RAM interface
    output reg        ram_we,
    output reg [9:0]  ram_addr,
    output reg [15:0] ram_data
);

    // RAM address increments each write
    always @(posedge clk) begin
        // Package SNES button states into a single 16-bit value
        ram_data <= snesData;

        // Generate write enable (1 clock pulse)
        ram_we <= 1;
        ram_addr <= ram_addr + 1;
    end

endmodule