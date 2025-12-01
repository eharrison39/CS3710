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
module cpuFullDatapathFPGA #(parameter INIT_FILE = "full_test_memory_init.hex") 
(clk, rst, showReg, segIn1, segIn2, segIn3, segIn4, regEnOut, segAlu1, segAlu2);

input wire clk, rst;
input wire [9:0] showReg;
output wire [6:0] segIn1, segIn2, segIn3, segIn4, segAlu1, segAlu2;
output wire [9:0] regEnOut;
reg[7:0] display;


// Control outputs from fsm
 wire [15:0] regEn;
wire [3:0] destMuxCtrl, srcMuxCtrl;
wire lsCtrl; 
wire [1:0] pcMuxCtrl, aluMuxCtrl;
wire fe, ri, ir;
wire [15:0] imm;

// Regfile Alu Datapath wire connections
wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
wire [15:0] aluOut;
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
wire [9:0] k;
wire [9:0] one = 10'h001;
wire [9:0] pcAddr;
wire [9:0] address;  // Address after mux


// Regfile Alu Datapath
regfile regFile(.clk(clk), .reset(rst), .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .aluBus(aluBus), .regEn(regEn));

regMux destMux( .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .r(destMuxCtrl), .out(destMuxOut));
regMux srcMux( .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15), .r(srcMuxCtrl), .out(srcMuxOut));
riMux immediateMux(.ri(ri), .rsrc(srcMuxOut), .imm(imm), .out(srcImmRegOut));

alu alu(.a(destMuxOut), .b(srcImmRegOut), .c(aluOut), .opcode(opc5), .flags(aluFlags), .cin(~opc5[4] & opc5[2] & opc5[1] & opc5[0]));
flagReg flagReg(.in(aluFlags), .regEn(fe), .reset(rst), .clk(clk), .out(flags));

// Memory
dualPortRam #(.INIT_FILE(INIT_FILE)) ram(.we_a(memAEn), .we_b(memBEn), .clk(clk), .addr_a(address), .addr_b(addrB), 
						  .data_a(srcMuxOut), .data_b(aluBus), .q_a(memOutA), .q_b(memOutB));
						  
// Instruction Register
(* preserve, keep *)register instructionReg(.in(memOutA), .regEn(ir), .reset(rst), .clk(clk), .out(instruction));

// Program counter jump and branch control
pcMux pcMux (.one(one), .immDisp({imm[7], imm[7], imm[7:0]}), .rsrcDisp(srcMuxOut[9:0]), .ctrl(pcMuxCtrl), .out(k));					  
// Program Counter
pcAdder pcInc (.k(k), .curAddr(pcAddr), .nextAddr(addrA));
(* preserve, keep *)pcReg pcReg (.in(addrA), .pcEn(pcEn), .reset(rst), .clk(clk),.out(pcAddr));


// Load Store ctrl
addrMux addrMux(.rdest(destMuxOut[9:0]), .pc(pcAddr), .ctrl(lsCtrl), .out(address));

// ALU Mux
aluMux aluMux(.aluOut(aluOut), .memData(memOutA), .address({6'b000000, address + 1'b1}), .ctrl(aluMuxCtrl), .out(aluBus));


// FSM
fsm controlFsm(.clk(clk), .rst(rst), .inop(memOutA), .instruction(instruction), .flags(flags), .rsMuxCtrl(srcMuxCtrl), .rdMuxCtrl(destMuxCtrl), 
			  .opcode(opc5), .regEn(regEn), .fe(fe), .imm(imm), .ri(ri), .pcEn(pcEn), .ir(ir),
			  .writeEn(memAEn), .lsCtrl(lsCtrl), .aluMuxCtrl(aluMuxCtrl), .pcMuxCtrl(pcMuxCtrl));

assign regEnOut = regEn[9:0];

always @(showReg) begin

	case(showReg)
		10'b00000_00000: begin
			display = aluBus[7:0];
		end
		10'b00000_00001: begin
			display = r0[7:0];
		end
		10'b00000_00010: begin
			display = r1[7:0];
		end
		10'b00000_00100: begin
			display = r2[7:0];
		end
		10'b00000_01000: begin
			display = r3[7:0];
		end
		10'b00000_10000: begin
			display = r4[7:0];
		end
		10'b00001_00000: begin
			display = r5[7:0];
		end
		10'b00010_00000: begin
			display = r6[7:0];
		end
		10'b00100_00000: begin
			display = r7[7:0];
		end
		10'b01000_00000: begin
			display = r8[7:0];
		end
		10'b10000_00000: begin
			display = r9[7:0];
		end
		
		default: begin
			display = aluBus[7:0];
		end
	endcase;
end

bcd_to_sev_seg bcdIn1(instruction[3:0], segIn1);
bcd_to_sev_seg bcdIn2(instruction[7:4], segIn2);
bcd_to_sev_seg bcdIn3(instruction[11:8], segIn3);
bcd_to_sev_seg bcdIn4(instruction[15:12], segIn4);
bcd_to_sev_seg bcdAlu1(display[3:0], segAlu1);
bcd_to_sev_seg bcdAlu2(display[7:4], segAlu2);

endmodule
/**/