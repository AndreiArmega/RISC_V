`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2024 06:39:18 PM
// Design Name: 
// Module Name: EX_MEM
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

module EX_MEM(  
    input wire write,  
    input wire clk,
    input wire res,     
    input wire [31:0] pc_in,
    input wire [2:0] func3_in,
    input wire [6:0] func7_in,
    input wire zero_in,
    input wire [31:0] ALU_in,
    input wire [31:0] reg2_data_in,
    input wire [4:0] rd_in,
    input wire RegWrite_EX,
    input wire MemtoReg_EX,
    input wire MemRead_EX,
    input wire MemWrite_EX,
    input wire Branch_EX,
    
    output reg RegWrite_MEM,
    output reg MemtoReg_MEM,
    output reg MemRead_MEM,
    output reg MemWrite_MEM,
    output reg Branch_MEM,
    output reg [31:0] pc_out,
    output reg [2:0] func3_out,
    output reg [6:0] func7_out,
    output reg zero_out,
    output reg [31:0] alu_out,
    output reg [31:0] reg2_data_out,
    output reg [4:0] rd_out
);
       
always @(posedge clk or posedge res) begin
    if (res) begin
        // Reset data signals
        pc_out <= 32'b0;
        func3_out <= 3'b0;
        func7_out <= 7'b0;
        zero_out <= 1'b0;
        alu_out <= 32'b0;
        reg2_data_out <= 32'b0;
        rd_out <= 5'b0;

        // Reset control signals
        RegWrite_MEM <= 1'b0;
        MemtoReg_MEM <= 1'b0;
        MemRead_MEM <= 1'b0;
        MemWrite_MEM <= 1'b0;
        Branch_MEM <= 1'b0;
    end else if (write) begin
        // Update data signals
        pc_out <= pc_in;
        func3_out <= func3_in;
        func7_out <= func7_in;
        zero_out <= zero_in;
        alu_out <= ALU_in;
        reg2_data_out <= reg2_data_in;
        rd_out <= rd_in;

        // Update control signals
        RegWrite_MEM <= RegWrite_EX;
        MemtoReg_MEM <= MemtoReg_EX;
        MemRead_MEM <= MemRead_EX;
        MemWrite_MEM <= MemWrite_EX;
        Branch_MEM <= Branch_EX;
    end
end                    
                      
endmodule
