`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date:    15:24:24 09/13/2015 
//// Design Name: 
//// Module Name:    regbank 
//// Project Name: 
//// Target Devices: 
//// Tool versions: 
//// Description: 
////
//// Dependencies: 
////
//// Revision: 
//// Revision 0.01 - File Created
//// Additional Comments: 
////
////////////////////////////////////////////////////////////////////////////////////
//
//
//////////////////////////////////////////////////////////////////////////////////



/**/
(* keep_hierarchy = "yes" *)
(* noprune = 1 *)
module regfileAluDatapathFullSynth(clk, rst);

input wire clk, rst;

// Control outputs from fsm
wire [15:0] regEn;
wire [3:0] destMuxCtrl, srcMuxCtrl;
wire fe, ri, ir;
wire [15:0] imm;

// Regfile Alu Datapath wire connections
wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
wire [15:0] aluBus;
wire [15:0] destMuxOut, srcMuxOut, srcImmRegOut;
wire [4:0] flags;
wire [4:0] aluFlags;
wire [4:0] opc5;


// FSM input
wire [15:0] instruction;


// Memory output and enables (fsm input)
wire [15:0] memOutA, memOutB;
wire memAEn, memBEn;


// Needed from  program counter
wire [9:0] addrA, addrB;
wire pcEn;
wire [9:0] k = 10'h001;
wire [9:0] pcAddr;
wire [9:0] address;  // Address after mux
wire lsCtrl;

//Test
//reg [9:0] testReg;



//output wire [6:0] segOutput1, segOutput2, segOutput3;


// Regfile Alu Datapath
regfile ref(.clk(clk), .reset(rst), .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .aluBus(aluBus), .regEn(regEn));

mux destMux( .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .r(destMuxCtrl), .out(destMuxOut));
mux srcMux( .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .r(srcMuxCtrl), .out(srcMuxOut));
riMux immediateMux(.ri(ri), .rsrc(srcMuxOut), .imm(imm), .out(srcImmRegOut));

alu alu(.a(destMuxOut), .b(srcImmRegOut), .c(aluBus), .opcode(opc5), .flags(aluFlags), .cin(~opc5[4] & opc5[2] & opc5[1] & opc5[0]));
flagReg flagReg(.in(aluFlags), .regEn(fe), .reset(rst), .clk(clk), .out(flags));

// Memory
dualPortRam ram(.we_a(memAEn), .we_b(memBEn), .clk(clk), .addr_a(address), .addr_b(addrB), 
						  .data_a(srcMuxOut), .data_b(aluBus), .q_a(memOutA), .q_b(memOutB));
						  
// Instruction Register
register instructionReg(.in(memOutA), .regEn(ir), .reset(rst), .clk(clk), .out(instruction));
						  
// Program Counter
//testPCAdder pc(.k(10'b00000_00001), .pcEn(pcEn), .rst(rst), .clk(clk), .addr(addrA));
pcReg pcReg (.in(addrA), .pcEn(pcEn), .reset(rst), .clk(clk),.out(pcAddr));
pcAdder pc (.k(k), .curAddr(pcAddr), .nextAddr(addrA));

// Load Store ctrl
twoBitMux addrMux(.rdest(destMuxOut), .pc(pcAddr), .ctrl(lsCtrl), .out(address));


// FSM
fsm theFsm(.clk(clk), .rst(rst), .inop(instruction), .rsMuxCtrl(srcMuxCtrl), .rdMuxCtrl(destMuxCtrl), 
			  .opcode(opc5), .regEn(regEn), .fe(fe), .imm(imm), .ri(ri), .pcEn(pcEn), .ir(ir),
			  .writeEn(memAEn), .lsCtrl(lsCtrl));

//always @(posedge clk) begin
//	if(~rst)
//		testReg <= 10'b00000_00000;
//	else
//		testReg <= addrA;
//end

endmodule
/**/