`timescale 1ns / 1ps

module forwarding_tb;

// Inputs
reg [4:0] rs1;
reg [4:0] rs2;
reg [4:0] ex_mem_rd;
reg [4:0] mem_wb_rd;
reg ex_mem_regwrite;
reg mem_wb_regwrite;

// Outputs
wire [1:0] forwardA;
wire [1:0] forwardB;

// Instantiate the Unit Under Test (UUT)
forwarding uut (
    .rs1(rs1),
    .rs2(rs2),
    .ex_mem_rd(ex_mem_rd),
    .mem_wb_rd(mem_wb_rd),
    .ex_mem_regwrite(ex_mem_regwrite),
    .mem_wb_regwrite(mem_wb_regwrite),
    .forwardA(forwardA),
    .forwardB(forwardB)
);

initial begin
    // Initialize inputs
    rs1 = 5'b0;
    rs2 = 5'b0;
    ex_mem_rd = 5'b0;
    mem_wb_rd = 5'b0;
    ex_mem_regwrite = 0;
    mem_wb_regwrite = 0;

    // Test Case 1: No forwarding (default values)
    #10;
    $display("TC1: forwardA=%b, forwardB=%b", forwardA, forwardB);

    // Test Case 2: Forward from EX/MEM to rs1
    ex_mem_regwrite = 1;
    ex_mem_rd = 5'b00011;
    rs1 = 5'b00011;
    #10;
    $display("TC2: forwardA=%b, forwardB=%b", forwardA, forwardB);

    // Test Case 3: Forward from MEM/WB to rs1
    ex_mem_regwrite = 0;
    mem_wb_regwrite = 1;
    mem_wb_rd = 5'b00100;
    rs1 = 5'b00100;
    #10;
    $display("TC3: forwardA=%b, forwardB=%b", forwardA, forwardB);

    // Test Case 4: Forward from EX/MEM to rs2
    mem_wb_regwrite = 0;
    ex_mem_regwrite = 1;
    ex_mem_rd = 5'b00101;
    rs2 = 5'b00101;
    #10;
    $display("TC4: forwardA=%b, forwardB=%b", forwardA, forwardB);

    // Test Case 5: Forward from MEM/WB to rs2
    ex_mem_regwrite = 0;
    mem_wb_regwrite = 1;
    mem_wb_rd = 5'b00110;
    rs2 = 5'b00110;
    #10;
    $display("TC5: forwardA=%b, forwardB=%b", forwardA, forwardB);

    // Test Case 6: Both rs1 and rs2 forwarded from EX/MEM
    ex_mem_regwrite = 1;
    mem_wb_regwrite = 0;
    ex_mem_rd = 5'b01000;
    rs1 = 5'b01000;
    rs2 = 5'b01000;
    #10;
    $display("TC6: forwardA=%b, forwardB=%b", forwardA, forwardB);

    // Test Case 7: Resetting inputs (No forwarding)
    ex_mem_regwrite = 0;
    mem_wb_regwrite = 0;
    rs1 = 5'b0;
    rs2 = 5'b0;
    #10;
    $display("TC7: forwardA=%b, forwardB=%b", forwardA, forwardB);

    // Test Case 8: Forward from both EX/MEM and MEM/WB for different registers
    ex_mem_regwrite = 1;
    mem_wb_regwrite = 1;
    ex_mem_rd = 5'b01001;
    mem_wb_rd = 5'b01010;
    rs1 = 5'b01001; // Forward from EX/MEM
    rs2 = 5'b01010; // Forward from MEM/WB
    #10;
    $display("TC8: forwardA=%b, forwardB=%b", forwardA, forwardB);

    // Finish simulation
    $stop;
end

endmodule
