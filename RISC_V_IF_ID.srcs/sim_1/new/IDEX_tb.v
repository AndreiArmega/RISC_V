`timescale 1ns / 1ps

module ID_EX_tb;

// Inputs
reg write;
reg clk;
reg reset;
reg [31:0] PC_in;
reg [2:0] func3_in;
reg [6:0] func7_in;
reg [31:0] ALU_A_in;
reg [31:0] ALU_B_in;
reg [31:0] RS1_in;
reg [31:0] RS2_in;
reg [4:0] RD_in;
reg [31:0] IMM_in;
reg RegWrite_in;
reg MemtoReg_in;
reg MemRead_in;
reg MemWrite_in;

// Outputs
wire RegWrite_EX;
wire MemtoReg_EX;
wire MemRead_EX;
wire MemWrite_EX;
wire [31:0] PC_out;
wire [2:0] func3_out;
wire [6:0] func7_out;
wire [31:0] ALU_A_out;
wire [31:0] ALU_B_out;
wire [31:0] RS1_out;
wire [31:0] RS2_out;
wire [4:0] RD_out;
wire [31:0] IMM_out;

// Instantiate the Unit Under Test (UUT)
ID_EX uut (
    .write(write),
    .clk(clk),
    .reset(reset),
    .PC_in(PC_in),
    .func3_in(func3_in),
    .func7_in(func7_in),
    .ALU_A_in(ALU_A_in),
    .ALU_B_in(ALU_B_in),
    .RS1_in(RS1_in),
    .RS2_in(RS2_in),
    .RD_in(RD_in),
    .IMM_in(IMM_in),
    .RegWrite_in(RegWrite_in),
    .MemtoReg_in(MemtoReg_in),
    .MemRead_in(MemRead_in),
    .MemWrite_in(MemWrite_in),
    .RegWrite_EX(RegWrite_EX),
    .MemtoReg_EX(MemtoReg_EX),
    .MemRead_EX(MemRead_EX),
    .MemWrite_EX(MemWrite_EX),
    .PC_out(PC_out),
    .func3_out(func3_out),
    .func7_out(func7_out),
    .ALU_A_out(ALU_A_out),
    .ALU_B_out(ALU_B_out),
    .RS1_out(RS1_out),
    .RS2_out(RS2_out),
    .RD_out(RD_out),
    .IMM_out(IMM_out)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    // Initialize Inputs
    clk = 0;
    reset = 1;
    write = 0;
    PC_in = 32'h00000000;
    func3_in = 3'b000;
    func7_in = 7'b0000000;
    ALU_A_in = 32'h00000000;
    ALU_B_in = 32'h00000000;
    RS1_in = 32'h00000000;
    RS2_in = 32'h00000000;
    RD_in = 5'b00000;
    IMM_in = 32'h00000000;
    RegWrite_in = 1'b0;
    MemtoReg_in = 1'b0;
    MemRead_in = 1'b0;
    MemWrite_in = 1'b0;

    // Reset the module
    #10 reset = 0;
    #10;

    // Test Case 1: Write inputs to outputs
    write = 1;
    PC_in = 32'h00000010;
    func3_in = 3'b101;
    func7_in = 7'b0101010;
    ALU_A_in = 32'h00000020;
    ALU_B_in = 32'h00000030;
    RS1_in = 32'h00000040;
    RS2_in = 32'h00000050;
    RD_in = 5'b00101;
    IMM_in = 32'h00000060;
    RegWrite_in = 1'b1;
    MemtoReg_in = 1'b1;
    MemRead_in = 1'b1;
    MemWrite_in = 1'b1;
    #10;

    // Test Case 2: Disable write (outputs should hold previous values)
    write = 0;
    PC_in = 32'hFFFFFFFF;
    func3_in = 3'b111;
    func7_in = 7'b1111111;
    ALU_A_in = 32'hFFFFFFFF;
    ALU_B_in = 32'hFFFFFFFF;
    RS1_in = 32'hFFFFFFFF;
    RS2_in = 32'hFFFFFFFF;
    RD_in = 5'b11111;
    IMM_in = 32'hFFFFFFFF;
    RegWrite_in = 1'b0;
    MemtoReg_in = 1'b0;
    MemRead_in = 1'b0;
    MemWrite_in = 1'b0;
    #10;

    // Test Case 3: Reset the module
    reset = 1;
    #10 reset = 0;

    // Finish Simulation
    $stop;
end

endmodule
