module ID_EX(
    input wire write,
    input wire clk,
    input wire reset,
    input wire [31:0] PC_in,
    input wire [2:0] func3_in,
    input wire [6:0] func7_in,
    input wire [31:0] ALU_A_in,
    input wire [31:0] ALU_B_in,
    input wire [4:0] RS1_in,
    input wire [4:0] RS2_in,
    input wire [4:0] RD_in,
    input wire [31:0] IMM_in,
    input wire RegWrite_in,
    input wire MemtoReg_in,
    input wire MemRead_in,
    input wire MemWrite_in,
    input wire [1:0] ALUOPIN,
    input wire ALUSRC,
    output reg ALUSRCOUT, 
    output reg [1:0] ALUOPOUT,
    output reg RegWrite_EX,
    output reg MemtoReg_EX,
    output reg MemRead_EX,
    output reg MemWrite_EX,
    output reg [31:0] PC_out,
    output reg [2:0] func3_out,
    output reg [6:0] func7_out,
    output reg [31:0] ALU_A_out,
    output reg [31:0] ALU_B_out,
    output reg [4:0] RS1_out,
    output reg [4:0] RS2_out,
    output reg [4:0] RD_out,
    output reg [31:0] IMM_out
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset all outputs to zero
        PC_out <= 32'b0;
        func3_out <= 3'b0;
        func7_out <= 7'b0;
        ALU_A_out <= 32'b0;
        ALU_B_out <= 32'b0;
        RS1_out <= 5'b0;
        RS2_out <= 5'b0;
        IMM_out <= 32'b0;
        RD_out <= 5'b0;
        RegWrite_EX <= 1'b0;
        MemtoReg_EX <= 1'b0;
        MemRead_EX <= 1'b0;
        MemWrite_EX <= 1'b0;
        ALUOPOUT<= 2'b0;
        ALUSRCOUT<=1'b0;
    end else if (write) begin
        // Write inputs to outputs
        PC_out <= PC_in;
        func3_out <= func3_in;
        func7_out <= func7_in;
        ALU_A_out <= ALU_A_in;
        ALU_B_out <= ALU_B_in;
        RS1_out <= RS1_in;
        RS2_out <= RS2_in;
        IMM_out <= IMM_in;
        RD_out <= RD_in;
        RegWrite_EX <= RegWrite_in;
        MemtoReg_EX <= MemtoReg_in;
        MemRead_EX <= MemRead_in;
        MemWrite_EX <= MemWrite_in;
        ALUOPOUT <= ALUOPIN;
        ALUSRCOUT<=ALUSRC;
    end
end

endmodule
