`timescale 1ns / 1ps

module EX_TB;

// Inputs
reg [31:0] IMM_EX;
reg [31:0] REG_DATA1_EX;
reg [31:0] REG_DATA2_EX;
reg [31:0] PC_EX;
reg [2:0] FUNCT3_EX;
reg [6:0] FUNCT7_EX;
reg [4:0] RD_EX;
reg [4:0] RS1_EX;
reg [4:0] RS2_EX;
reg RegWrite_EX;
reg MemtoReg_EX;
reg MemRead_EX;
reg MemWrite_EX;
reg [1:0] ALUop_EX;
reg ALUSrc_EX;
reg Branch_EX;
reg [1:0] forwardA, forwardB;
reg [31:0] ALU_DATA_WB;
reg [31:0] ALU_OUT_MEM;

// Outputs
wire ZERO_EX;
wire [31:0] ALU_OUT_EX;
wire [31:0] PC_Branch_EX;
wire [31:0] REG_DATA2_EX_FINAL;

// Instantiate the Unit Under Test (UUT)
EX uut (
    .IMM_EX(IMM_EX),
    .REG_DATA1_EX(REG_DATA1_EX),
    .REG_DATA2_EX(REG_DATA2_EX),
    .PC_EX(PC_EX),
    .FUNCT3_EX(FUNCT3_EX),
    .FUNCT7_EX(FUNCT7_EX),
    .RD_EX(RD_EX),
    .RS1_EX(RS1_EX),
    .RS2_EX(RS2_EX),
    .RegWrite_EX(RegWrite_EX),
    .MemtoReg_EX(MemtoReg_EX),
    .MemRead_EX(MemRead_EX),
    .MemWrite_EX(MemWrite_EX),
    .ALUop_EX(ALUop_EX),
    .ALUSrc_EX(ALUSrc_EX),
    .Branch_EX(Branch_EX),
    .forwardA(forwardA),
    .forwardB(forwardB),
    .ALU_DATA_WB(ALU_DATA_WB),
    .ALU_OUT_MEM(ALU_OUT_MEM),
    .ZERO_EX(ZERO_EX),
    .ALU_OUT_EX(ALU_OUT_EX),
    .PC_Branch_EX(PC_Branch_EX),
    .REG_DATA2_EX_FINAL(REG_DATA2_EX_FINAL)
);

initial begin
    // Initialize Inputs
    IMM_EX = 32'h00000010;
    REG_DATA1_EX = 32'h00000005;
    REG_DATA2_EX = 32'h00000007;
    PC_EX = 32'h00000008;
    FUNCT3_EX = 3'b000;
    FUNCT7_EX = 7'b0000000;
    RD_EX = 5'b00010;
    RS1_EX = 5'b00001;
    RS2_EX = 5'b00011;
    RegWrite_EX = 1'b0;
    MemtoReg_EX = 1'b0;
    MemRead_EX = 1'b0;
    MemWrite_EX = 1'b0;
    ALUop_EX = 2'b10;  // Example ALUop
    ALUSrc_EX = 1'b1;  // Select immediate
    Branch_EX = 1'b0;
    forwardA = 2'b00;
    forwardB = 2'b00;
    ALU_DATA_WB = 32'h00000000;
    ALU_OUT_MEM = 32'h00000000;

    // Wait for global reset
    #10;
    
    // Test Case 1: Immediate addition
    IMM_EX = 32'h00000004;
    REG_DATA1_EX = 32'h00000010;
    ALUSrc_EX = 1'b1;  // Select immediate
    ALUop_EX = 2'b00;  // Addition
    #10;

    // Test Case 2: Register addition
    IMM_EX = 32'h00000000;
    REG_DATA1_EX = 32'h00000010;
    REG_DATA2_EX = 32'h00000020;
    ALUSrc_EX = 1'b0;  // Select register
    ALUop_EX = 2'b00;  // Addition
    #10;

    // Test Case 3: Subtraction
    ALUop_EX = 2'b01;  // Subtraction
    #10;

    // Test Case 4: Forwarding
    forwardA = 2'b01;  // Forward ALU_OUT_MEM
    forwardB = 2'b10;  // Forward ALU_DATA_WB
    ALU_DATA_WB = 32'h00000015;
    ALU_OUT_MEM = 32'h00000025;
    #10;

    // Test Case 5: Branch
    Branch_EX = 1'b1;
    IMM_EX = 32'h00000008;
    PC_EX = 32'h00000010;
    #10;

    // Finish Simulation
    $stop;
end

endmodule
