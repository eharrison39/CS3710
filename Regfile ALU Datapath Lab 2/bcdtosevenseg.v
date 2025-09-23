module bcd_to_sev_seg(bcd,seven_seg);

input [3:0] bcd;
output reg [0:6] seven_seg;

always @*
 begin
  case (bcd)
   4'b0000 : begin seven_seg = ~7'b1111110; end // 0
   4'b0001 : begin seven_seg = ~7'b0110000; end // 1
   4'b0010 : begin seven_seg = ~7'b1101101; end // 2
   4'b0011 : begin seven_seg = ~7'b1111001; end // 3
   4'b0100 : begin seven_seg = ~7'b0110011; end // 4
   4'b0101 : begin seven_seg = ~7'b1011011; end // 5
   4'b0110 : begin seven_seg = ~7'b1011111; end // 6
   4'b0111 : begin seven_seg = ~7'b1110000; end // 7
   4'b1000 : begin seven_seg = ~7'b1111111; end // 8
   4'b1001 : begin seven_seg = ~7'b1110011; end // 9
    4'b1010 : begin seven_seg = ~7'b1110111; end // A
   4'b1011 : begin seven_seg = ~7'b0011111; end // b
   4'b1100 : begin seven_seg = ~7'b1001110; end // C
   4'b1101 : begin seven_seg = ~7'b0111101; end // d
   4'b1110 : begin seven_seg = ~7'b1001111; end // E
   4'b1111 : begin seven_seg = ~7'b1000111; end // F
   default : begin seven_seg = ~7'b0000000; end // blank
  endcase
 end
endmodule