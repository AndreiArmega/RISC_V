`timescale 1ns / 1ps

module EX_MEM_tb;

// Inputs
reg write;
reg clk;
reg res;
reg [31:0] pc_in;
reg [2:0] func3_in;
reg [6:0] func7_in;
reg zero_in;
reg [31:0] ALU_in;
reg [31:0] reg2_data_in;
reg [4:0] rd_in;
reg RegWrite_EX;
reg MemtoReg_EX;
reg MemRead_EX;
reg MemWrite_EX;
reg Branch_EX;

// Outputs
wire RegWrite_MEM;
wire MemtoReg_MEM;
wire MemRead_MEM;
wire MemWrite_MEM;
wire Branch_MEM;
wire [31:0] pc_out;
wire [2:0] func3_out;
wire [6:0] func7_out;
wire zero_out;
wire [31:0] alu_out;
wire [31:0] reg2_data_out;
wire [4:0] rd_out;

// Instantiate the Unit Under Test (UUT)
EX_MEM uut (
    .write(write),
    .clk(clk),
    .res(res),
    .pc_in(pc_in),
    .func3_in(func3_in),
    .func7_in(func7_in),
    .zero_in(zero_in),
    .ALU_in(ALU_in),
    .reg2_data_in(reg2_data_in),
    .rd_in(rd_in),
    .RegWrite_EX(RegWrite_EX),
    .MemtoReg_EX(MemtoReg_EX),
    .MemRead_EX(MemRead_EX),
    .MemWrite_EX(MemWrite_EX),
    .Branch_EX(Branch_EX),
    .RegWrite_MEM(RegWrite_MEM),
    .MemtoReg_MEM(MemtoReg_MEM),
    .MemRead_MEM(MemRead_MEM),
    .MemWrite_MEM(MemWrite_MEM),
    .Branch_MEM(Branch_MEM),
    .pc_out(pc_out),
    .func3_out(func3_out),
    .func7_out(func7_out),
    .zero_out(zero_out),
    .alu_out(alu_out),
    .reg2_data_out(reg2_data_out),
    .rd_out(rd_out)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    // Initialize inputs
    clk = 0;
    res = 1; // Apply reset
    write = 0;
    pc_in = 32'b0;
    func3_in = 3'b0;
    func7_in = 7'b0;
    zero_in = 1'b0;
    ALU_in = 32'b0;
    reg2_data_in = 32'b0;
    rd_in = 5'b0;
    RegWrite_EX = 0;
    MemtoReg_EX = 0;
    MemRead_EX = 0;
    MemWrite_EX = 0;
    Branch_EX = 0;

    // Reset the system
    #10 res = 0; // Release reset

    // Test Case 1: Write new values
    write = 1;
    pc_in = 32'h00000010;
    func3_in = 3'b101;
    func7_in = 7'b0101010;
    zero_in = 1'b1;
    ALU_in = 32'hDEADBEEF;
    reg2_data_in = 32'hCAFEBABE;
    rd_in = 5'b10101;
    RegWrite_EX = 1;
    MemtoReg_EX = 1;
    MemRead_EX = 1;
    MemWrite_EX = 0;
    Branch_EX = 1;
    #10;

    // Test Case 2: Disable write, change inputs (outputs should hold previous values)
    write = 0;
    pc_in = 32'hFFFFFFFF;
    func3_in = 3'b111;
    func7_in = 7'b1111111;
    zero_in = 1'b0;
    ALU_in = 32'h12345678;
    reg2_data_in = 32'h87654321;
    rd_in = 5'b11111;
    RegWrite_EX = 0;
    MemtoReg_EX = 0;
    MemRead_EX = 0;
    MemWrite_EX = 1;
    Branch_EX = 0;
    #10;

    // Test Case 3: Apply reset (outputs should go to zero)
    res = 1;
    #10 res = 0;

    // Finish simulation
    $stop;
end

endmodule
