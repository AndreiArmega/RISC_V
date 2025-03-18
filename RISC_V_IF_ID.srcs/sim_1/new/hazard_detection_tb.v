`timescale 1ns / 1ps

module hazard_detection_tb;

// Inputs
reg [4:0] rd;
reg [4:0] rs1;
reg [4:0] rs2;
reg MemRead;

// Outputs
wire PCwrite;
wire IF_IDwrite;
wire control_sel;

// Instantiate the Unit Under Test (UUT)
hazard_detection uut (
    .rd(rd),
    .rs1(rs1),
    .rs2(rs2),
    .MemRead(MemRead),
    .PCwrite(PCwrite),
    .IF_IDwrite(IF_IDwrite),
    .control_sel(control_sel)
);

initial begin
    // Initialize Inputs
    rd = 5'b00000;
    rs1 = 5'b00000;
    rs2 = 5'b00000;
    MemRead = 0;

    // Test Case 1: No hazard (MemRead=0)
    #10;
    $display("TC1: PCwrite=%b, IF_IDwrite=%b, control_sel=%b", PCwrite, IF_IDwrite, control_sel);

    // Test Case 2: Hazard detected (rd matches rs1, MemRead=1)
    rd = 5'b00001;
    rs1 = 5'b00001;
    rs2 = 5'b00010;
    MemRead = 1;
    #10;
    $display("TC2: PCwrite=%b, IF_IDwrite=%b, control_sel=%b", PCwrite, IF_IDwrite, control_sel);

    // Test Case 3: Hazard detected (rd matches rs2, MemRead=1)
    rd = 5'b00010;
    rs1 = 5'b00011;
    rs2 = 5'b00010;
    MemRead = 1;
    #10;
    $display("TC3: PCwrite=%b, IF_IDwrite=%b, control_sel=%b", PCwrite, IF_IDwrite, control_sel);

    // Test Case 4: No hazard (rd does not match rs1 or rs2, MemRead=1)
    rd = 5'b00100;
    rs1 = 5'b00101;
    rs2 = 5'b00110;
    MemRead = 1;
    #10;
    $display("TC4: PCwrite=%b, IF_IDwrite=%b, control_sel=%b", PCwrite, IF_IDwrite, control_sel);

    // Test Case 5: No hazard (MemRead=0)
    rd = 5'b00001;
    rs1 = 5'b00001;
    rs2 = 5'b00010;
    MemRead = 0;
    #10;
    $display("TC5: PCwrite=%b, IF_IDwrite=%b, control_sel=%b", PCwrite, IF_IDwrite, control_sel);

    // Test Case 6: Reset all inputs to zero
    rd = 5'b00000;
    rs1 = 5'b00000;
    rs2 = 5'b00000;
    MemRead = 0;
    #10;
    $display("TC6: PCwrite=%b, IF_IDwrite=%b, control_sel=%b", PCwrite, IF_IDwrite, control_sel);

    // Finish simulation
    $stop;
end

endmodule
