
module SNES(clk, snes_data, snes_latch, snes_clock, outputData);

input wire clk;           // 50 MHz
input wire snes_data;
output reg snes_latch;
output reg snes_clock;

output reg [15:0] outputData;

reg [15:0] buttons;
reg [4:0] bitpos;
reg [15:0] timer;

// SNES timing: ~12 us per half-cycle
localparam SNES_DIV = 600; // 50MHz/600 = ~83kHz toggle = ~41kHz clock

always @(posedge clk) begin
    
    // free running timer
    timer <= timer + 1;

    if (timer == 1)
        snes_latch <= 1;

    else if (timer == 12)
        snes_latch <= 0;


    if (timer >= 12 && (timer % SNES_DIV) == 0) begin
        snes_clock <= ~snes_clock;

        // Sample on falling edge
        if (snes_clock == 1) begin
            buttons[bitpos] <= ~snes_data;
            bitpos <= bitpos + 1;
        end
    end


    if (bitpos == 16) begin
        bitpos <= 0;
        timer  <= 0;
        outputData <= buttons;
    end
	
    /*  
	b      <= buttons[0];
        y      <= buttons[1];
        start  <= buttons[2];
        select <= buttons[3];
        up     <= buttons[4];
        down   <= buttons[5];
        left   <= buttons[6];
        right  <= buttons[7];
        a      <= buttons[8];
        x      <= buttons[9];
        l      <= buttons[10];
        r      <= buttons[11];
*/
end
endmodule