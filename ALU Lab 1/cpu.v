module cpu(
	input [3:0] a, b,
	input k0, k1, k2, k3,
	input sw0, sw1,
	output [4:0] flags,
	output [3:0] c
);

reg [5:0] opcode = 5'b00000;
reg cin = 1'b0;

always @(negedge k0 or negedge k1 or negedge k2 or negedge k3) begin

	if(~k0) begin
		if(sw0 == 0 && sw1 == 0)
			opcode = 5'b0_0101; // Add
		else if (sw0 == 1 && sw1 == 0)
			opcode = 5'b0_1001; // Subtract
		else if (sw0 == 0 && sw1 == 1)
			opcode = 5'b0_0011; // XOR
		else
			cin = 1'b1;
	end
	else if (~k1) begin
		if(sw0 == 0 && sw1 == 0)
			opcode = 5'b0_0110; // Addu
		else if (sw0 == 1 && sw1 == 0)
			opcode = 5'b0_1011; // CMP
		else if (sw0 == 0 && sw1 == 1)
			opcode = 5'b0_0100; // NOT
		else
			cin = 1'b0;
	end
	else if(~k2) begin
		if(sw0 == 0 && sw1 == 0)
			opcode = 5'b0_0111; // Addc
		else if (sw0 == 1 && sw1 == 0)
			opcode = 5'b0_0001; // AND
		else if (sw0 == 0 && sw1 == 1)
			opcode = 5'b0_1100; // LSH
		else
			cin = 1'b0;
	end
	else begin
		if(sw0 == 0 && sw1 == 0)
			opcode = 5'b0_1111; // Addcu
		else if (sw0 == 1 && sw1 == 0)
			opcode = 5'b0_0010; // OR
		else if (sw0 == 0 && sw1 == 1)
			opcode = 5'b1_0011; // RSH
		else
			cin = 1'b0;
	end
end


	alu uut (
		.A(a), 
		.B(b), 
		.C(c), 
		.Opcode(opcode), 
		.Flags(flags),
		.Cin(cin)
	);

endmodule