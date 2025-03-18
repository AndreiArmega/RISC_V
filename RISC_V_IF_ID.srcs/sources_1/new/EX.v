`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2024 07:06:18 PM
// Design Name: 
// Module Name: EX
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module EX(input [31:0] IMM_EX,         
          input [31:0] REG_DATA1_EX,
          input [31:0] REG_DATA2_EX,
          input [31:0] PC_EX,
          
          input [2:0] FUNCT3_EX,
          input [6:0] FUNCT7_EX,
          input [4:0] RD_EX,
          input [4:0] RS1_EX,
          
          input [4:0] RS2_EX,
          
          input RegWrite_EX,
          input MemtoReg_EX,
          input MemRead_EX,
          input MemWrite_EX,
          
          input [1:0] ALUop_EX,
          input ALUSrc_EX,
          input Branch_EX, //
          input [1:0] forwardA,forwardB,
          
          input [31:0] ALU_DATA_WB,
          input [31:0] ALU_OUT_MEM,
          
          output ZERO_EX,
          output [31:0] ALU_OUT_EX,
          output [31:0] PC_Branch_EX,
          output [31:0] REG_DATA2_EX_FINAL,
          output [3:0] ALU_Control,
          output [31:0] ALU_SRC1,
          output [31:0] ALU_SRC2);
    
wire [31:0] OUT_MUX_1,OUT_MUX_2,OUT_MUX_3;
wire [3:0] ALU_CTRL_OUT;    
wire ZERO = 1'b0;
mux32 PRIMUL_MUX(REG_DATA1_EX, ALU_DATA_WB, ALU_OUT_MEM, forwardA, OUT_MUX_1);

mux32 AL_DOILEA_MUX(REG_DATA2_EX,ALU_DATA_WB, ALU_OUT_MEM,forwardB,OUT_MUX_2);

mux2_1 AL_TREILA_MUXCHETAR(IMM_EX,OUT_MUX_2,~ALUSrc_EX,OUT_MUX_3);

ALUcontrol ALUctrl(ALUop_EX,FUNCT7_EX,FUNCT3_EX,ALU_CTRL_OUT);

ALU ALU_CEL_BATRAN(ALU_CTRL_OUT,OUT_MUX_1,OUT_MUX_3,ZERO,ALU_OUT_EX);       
   
copie_adder ADDER_EX(PC_EX, IMM_EX, PC_Branch_EX);   

assign REG_DATA2_EX_FINAL = OUT_MUX_2;

assign ZERO_EX = ZERO;
assign ALU_Control = ALU_CTRL_OUT;
assign ALU_SRC1 = OUT_MUX_1;
assign ALU_SRC2 = OUT_MUX_3 ;
endmodule
