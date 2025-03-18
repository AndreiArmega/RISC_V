`timescale 1ns / 1ps

module expart_tb;

// Inputs
reg VDD;
reg clk;
reg reset;
reg [31:0] PC_ID;
reg [2:0] FUNCT3_ID_IN_IDEX;
reg [6:0] FUNCT7_ID_IN_IDEX;
reg [31:0] REG_DATA1_ID_IN_IDEX;
reg [31:0] REG_DATA2_ID_IN_IDEX;
reg [4:0] RS1_ID_IN_IDEX;
reg [4:0] RS2_ID_IN_IDEX;
reg [4:0] RD_ID_IN_IDEX;
reg [31:0] IMM_ID_IN_IDEX;
reg RegWrite_ID;
reg MemtoReg_ID;
reg MemRead_ID;
reg MemWrite_ID;
reg [1:0] ALUop_ID;
reg ALUsrc_ID;
reg [1:0] ForwardA;
reg [1:0] ForwardB;
reg [31:0] ALU_DATA_wb;
//reg [31:0] EXMEM_ALU_OUT;

// Outputs
wire RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX;
wire [31:0] OUT_IDEX_PC, OUT_IDEX_ALU_A_OUT, OUT_IDEX_ALU_B_OUT, OUT_IDEX_IMM_OUT;
wire [4:0] OUT_IDEX_RD_OUT;
wire [2:0] OUT_IDEX_FUNCT3_ID;
wire [6:0] OUT_IDEX_FUNCT7_ID;
wire [4:0] OUT_IDEX_RS1, OUT_IDEX_RS2;
wire ZERO_EX;
wire [31:0] ALU_out_EX, PC_Branch_EX, REG_DATA2_EX_FINAL;
wire RegWrite_MEM, MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM;
wire [31:0] EXMEM_PC_OUT, EXMEM_ALU_OUT, EXMEM_REG2_DATA_OUT;
wire [4:0] EXMEM_RD_OUT;
wire [2:0] EXMEM_F3;
wire [6:0] EXMEM_F7;
wire EXMEM_ZERO_OUT;

// Instantiate ID_EX Module
ID_EX id_ex (
    VDD, clk, reset,
    PC_ID, FUNCT3_ID_IN_IDEX, FUNCT7_ID_IN_IDEX,
    REG_DATA1_ID_IN_IDEX, REG_DATA2_ID_IN_IDEX,
    RS1_ID_IN_IDEX, RS2_ID_IN_IDEX,
    RD_ID_IN_IDEX, IMM_ID_IN_IDEX,
    RegWrite_ID, MemtoReg_ID, MemRead_ID, MemWrite_ID,
    RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX,
    OUT_IDEX_PC,
    OUT_IDEX_FUNCT3_ID, OUT_IDEX_FUNCT7_ID,
    OUT_IDEX_ALU_A_OUT, OUT_IDEX_ALU_B_OUT,
    OUT_IDEX_RS1, OUT_IDEX_RS2,
    OUT_IDEX_RD_OUT, OUT_IDEX_IMM_OUT
);

// Instantiate EX Module
EX ex (
    OUT_IDEX_IMM_OUT, OUT_IDEX_ALU_A_OUT, OUT_IDEX_ALU_B_OUT,
    OUT_IDEX_PC, OUT_IDEX_FUNCT3_ID, OUT_IDEX_FUNCT7_ID,
    OUT_IDEX_RD_OUT, OUT_IDEX_RS1, OUT_IDEX_RS2,
    RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX,
    ALUop_ID, ALUsrc_ID,
    ForwardA, ForwardB, 
    Branch_MEM, // Assuming Branch signal propagates
    ALU_DATA_wb, EXMEM_ALU_OUT,
    ZERO_EX, ALU_out_EX, PC_Branch_EX, REG_DATA2_EX_FINAL
);

// Instantiate EX_MEM Module
EX_MEM ex_mem (
    VDD, clk, reset,
    PC_Branch_EX,
    OUT_IDEX_FUNCT3_ID, OUT_IDEX_FUNCT7_ID,
    ZERO_EX, ALU_out_EX, REG_DATA2_EX_FINAL,
    OUT_IDEX_RD_OUT,
    RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, Branch_MEM,
    RegWrite_MEM, MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, Branch_MEM,
    EXMEM_PC_OUT,
    EXMEM_F3, EXMEM_F7,
    EXMEM_ZERO_OUT, EXMEM_ALU_OUT,
    EXMEM_REG2_DATA_OUT, EXMEM_RD_OUT
);

// Clock generation
always #5 clk = ~clk;

// Testbench logic
initial begin
    // Initialize Inputs
    VDD = 1;
    clk = 0;
    reset = 1;
    PC_ID = 32'h00000000;
    FUNCT3_ID_IN_IDEX = 3'b000;
    FUNCT7_ID_IN_IDEX = 7'b0000000;
    REG_DATA1_ID_IN_IDEX = 32'h00000000;
    REG_DATA2_ID_IN_IDEX = 32'h00000000;
    RS1_ID_IN_IDEX = 5'b00000;
    RS2_ID_IN_IDEX = 5'b00000;
    RD_ID_IN_IDEX = 5'b00000;
    IMM_ID_IN_IDEX = 32'h00000000;
    RegWrite_ID = 0;
    MemtoReg_ID = 0;
    MemRead_ID = 0;
    MemWrite_ID = 0;
    ALUop_ID = 2'b00;
    ALUsrc_ID = 0;
    ForwardA = 2'b00;
    ForwardB = 2'b00;
    ALU_DATA_wb = 32'h00000000;
    EXMEM_ALU_OUT = 32'h00000000;

    // Reset the pipeline
    #10 reset = 0;

    // Test Case 1: Forward valid inputs
    PC_ID = 32'h00000010;
    FUNCT3_ID_IN_IDEX = 3'b101;
    FUNCT7_ID_IN_IDEX = 7'b0101010;
    REG_DATA1_ID_IN_IDEX = 32'h00000020;
    REG_DATA2_ID_IN_IDEX = 32'h00000030;
    RS1_ID_IN_IDEX = 5'b00010;
    RS2_ID_IN_IDEX = 5'b00011;
    RD_ID_IN_IDEX = 5'b00100;
    IMM_ID_IN_IDEX = 32'h00000040;
    RegWrite_ID = 1;
    MemtoReg_ID = 1;
    MemRead_ID = 1;
    MemWrite_ID = 1;
    ALUop_ID = 2'b10;
    ALUsrc_ID = 1;
    ForwardA = 2'b01;
    ForwardB = 2'b10;
    ALU_DATA_wb = 32'h00000050;
    EXMEM_ALU_OUT = 32'h00000060;
    #20;

    // Test Case 2: Reset and test again
    reset = 1;
    #10 reset = 0;

    // Finish Simulation
    #50 $stop;
end

endmodule