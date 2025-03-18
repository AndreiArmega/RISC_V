`timescale 1ns / 1ps

module MEM_WB_tb;

// Inputs
reg clk;
reg res;
reg [31:0] data_in;
reg [31:0] alu_in;
reg [4:0] rd_in;
reg write;
reg RegWrite_MEM;
reg MemtoReg_MEM;
reg MemRead_MEM;
reg MemWrite_MEM;

// Outputs
wire RegWrite_WB;
wire MemtoReg_WB;
wire MemRead_WB;
wire MemWrite_WB;
wire [31:0] data_out;
wire [31:0] alu_out;
wire [4:0] rd_out;

// Instantiate the Unit Under Test (UUT)
MEM_WB uut (
    .clk(clk),
    .res(res),
    .data_in(data_in),
    .alu_in(alu_in),
    .rd_in(rd_in),
    .write(write),
    .RegWrite_MEM(RegWrite_MEM),
    .MemtoReg_MEM(MemtoReg_MEM),
    .MemRead_MEM(MemRead_MEM),
    .MemWrite_MEM(MemWrite_MEM),
    .RegWrite_WB(RegWrite_WB),
    .MemtoReg_WB(MemtoReg_WB),
    .MemRead_WB(MemRead_WB),
    .MemWrite_WB(MemWrite_WB),
    .data_out(data_out),
    .alu_out(alu_out),
    .rd_out(rd_out)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    // Initialize inputs
    clk = 0;
    res = 1; // Apply reset
    write = 0;
    data_in = 32'b0;
    alu_in = 32'b0;
    rd_in = 5'b0;
    RegWrite_MEM = 0;
    MemtoReg_MEM = 0;
    MemRead_MEM = 0;
    MemWrite_MEM = 0;

    // Apply reset
    #10 res = 0; // Release reset

    // Test Case 1: Write new values
    write = 1;
    data_in = 32'h12345678;
    alu_in = 32'h87654321;
    rd_in = 5'b10101;
    RegWrite_MEM = 1;
    MemtoReg_MEM = 1;
    MemRead_MEM = 1;
    MemWrite_MEM = 0;
    #10;

    // Test Case 2: Disable write, change inputs (outputs should hold previous values)
    write = 0;
    data_in = 32'hDEADBEEF;
    alu_in = 32'hCAFEBABE;
    rd_in = 5'b11111;
    RegWrite_MEM = 0;
    MemtoReg_MEM = 0;
    MemRead_MEM = 0;
    MemWrite_MEM = 1;
    #10;

    // Test Case 3: Apply reset (outputs should go to zero)
    res = 1;
    #10 res = 0;

    // Finish simulation
    $stop;
end

endmodule
