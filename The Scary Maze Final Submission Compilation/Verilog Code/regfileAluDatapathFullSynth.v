`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 		Elden Harrison, David Brown, Luke Jones
//// 
//// Create Date:    10/31/2025 
//// Module Name:    cpuFullDatapath
//// Project Name: 	Lab 4
//// Description: 	CPU datapath without I/O that fetches instructions from memory
////						and executes register based operations, as well as memory
////						access instructions (load and store) and control flow instructions
////						(jumps and conditional branches).
////
//// Dependencies: 	alu, register, riMux, addrMux, regMux, flagReg, dualPortRam,
////						controlFSM, theDecoder, pcAdder, pcReg, regFile.
////
//// Revision 0.01 - File Created
////
////////////////////////////////////////////////////////////////////////////////////
//
//
//////////////////////////////////////////////////////////////////////////////////

/* These next two lines are there so the compiler gives an acurrate register count. Instead of optimizing.*/ 
//(* keep_hierarchy = "yes" *)
//(* noprune = 1 *)
module cpuFullDatapath (clk, rst, snesInput, memOutA, srcMuxOut, address, memAEn, r0, r1, r2, r15);

input wire clk, rst;
input wire [15:0] snesInput, memOutA;

output wire [15:0] srcMuxOut, r0, r1, r2, r15;
output wire [15:0] address;  // Address after mux
output wire memAEn;

// Control outputs from fsm
wire [15:0] regEn;
wire [3:0] destMuxCtrl, srcMuxCtrl;
wire lsCtrl; 
wire [1:0] pcMuxCtrl, aluMuxCtrl;
wire fe, ri, ir;
wire [15:0] imm;

// Regfile Alu Datapath wire connections
wire [15:0] r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14;
wire [15:0] aluOut;
wire [15:0] aluBus;
wire [15:0] destMuxOut, srcImmRegOut;
wire [4:0] flags;
wire [4:0] aluFlags;
wire [4:0] opc5;


// FSM input
wire [15:0] instruction;

// Memory output and enables (fsm input)
//wire [15:0] memOutA,
//wire memAEn

// Needed from  program counter
wire [15:0] addrA;
wire pcEn;
wire [15:0] k;
wire [15:0] one = 16'h0001;
wire [15:0] pcAddr;
//wire [9:0] address;  // Address after mux


// Program counter jump and branch control
pcMux pcMux (.one(one), .immDisp({imm[7], imm[7], imm[7], imm[7], imm[7], imm[7], imm[7], imm[7], imm[7:0]}), 
															.rsrcDisp(srcMuxOut), .ctrl(pcMuxCtrl), .out(k));					  
// Program Counter
pcAdder pcInc (.k(k), .curAddr(pcAddr), .nextAddr(addrA));
(* preserve, keep *)pcReg pcReg (.in(addrA), .pcEn(pcEn), .reset(rst), .clk(clk),.out(pcAddr));

// Load Store ctrl
addrMux addrMux(.rdest(destMuxOut), .pc(pcAddr), .ctrl(lsCtrl), .out(address));

// Memory
//dualPortRam #(.INIT_FILE(INIT_FILE)) ram(.we_a(memAEn), .we_b(memBEn), .clk(clk), .addr_a(address), .addr_b(addrB), 
//						  .data_a(srcMuxOut), .data_b(aluBus), .q_a(memOutA), .q_b(memOutB));
						  
// Instruction Register
(* preserve, keep *)register instructionReg(.in(memOutA), .regEn(ir), .reset(rst), .clk(clk), .out(instruction));

// FSM
fsm controlFsm(.clk(clk), .rst(rst), .inop(memOutA), .instruction(instruction), .flags(flags), .rsMuxCtrl(srcMuxCtrl), .rdMuxCtrl(destMuxCtrl), 
			  .opcode(opc5), .regEn(regEn), .fe(fe), .imm(imm), .ri(ri), .pcEn(pcEn), .ir(ir),
			  .writeEn(memAEn), .lsCtrl(lsCtrl), .aluMuxCtrl(aluMuxCtrl), .pcMuxCtrl(pcMuxCtrl));

// Regfile Alu Datapath
regfile regFile(.clk(clk), .reset(rst), .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .snesInput(snesInput), .aluBus(aluBus), .regEn(regEn));

regMux destMux( .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .r(destMuxCtrl), .out(destMuxOut));
regMux srcMux( .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .r(srcMuxCtrl), .out(srcMuxOut));
riMux immediateMux(.ri(ri), .rsrc(srcMuxOut), .imm(imm), .out(srcImmRegOut));

alu alu(.a(destMuxOut), .b(srcImmRegOut), .c(aluOut), .opcode(opc5), .flags(aluFlags), .cin(~opc5[4] & opc5[2] & opc5[1] & opc5[0]));
flagReg flagReg(.in(aluFlags), .regEn(fe), .reset(rst), .clk(clk), .out(flags));

// ALU Mux
aluMux aluMux(.aluOut(aluOut), .memData(memOutA), .address(address + 1'b1), .ctrl(aluMuxCtrl), .out(aluBus));


endmodule
/**/