`timescale 1ns/1ps

module riscsapic;

  // Inputs
  reg clk;
  reg reset;

  // Outputs
  wire [31:0] PC_EX;
  wire [31:0] ALU_OUT_EX;
  wire [31:0] PC_MEM;
  wire PCSrc;
  wire [31:0] DATA_MEMORY_MEM;
  wire [31:0] ALU_DATA_WB;
  wire [1:0] forwardA, forwardB;
  wire pipeline_stall;

  // Instantiate the DUT (Device Under Test)
  RISC_V dut (
    .clk(clk),
    .reset(reset),
    .PC_EX(PC_EX),
    .ALU_OUT_EX(ALU_OUT_EX),
    .PC_MEM(PC_MEM),
    .PCSrc(PCSrc),
    .DATA_MEMORY_MEM(DATA_MEMORY_MEM),
    .ALU_DATA_WB(ALU_DATA_WB),
    .forwardA(forwardA),
    .forwardB(forwardB),
    .pipeline_stall(pipeline_stall)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period (100 MHz)
  end

  // Testbench stimulus
  initial begin
    // Initialize inputs
    reset = 1;

    // Apply reset
    #20;
    reset = 0;

    // Test scenarios
    #100;
    // Add more scenarios here to test the behavior of the module.

    // Finish simulation after sufficient time
    #500;
    $finish;
  end

  // Monitor output signals
  initial begin
    $monitor($time, " clk=%b reset=%b PC_EX=%h ALU_OUT_EX=%h PC_MEM=%h PCSrc=%b DATA_MEMORY_MEM=%h ALU_DATA_WB=%h forwardA=%b forwardB=%b pipeline_stall=%b", 
             clk, reset, PC_EX, ALU_OUT_EX, PC_MEM, PCSrc, DATA_MEMORY_MEM, ALU_DATA_WB, forwardA, forwardB, pipeline_stall);
  end

endmodule
