module MEM_WB(
    input wire clk,
    input wire res,              
    input wire [31:0] data_in,   
    input wire [31:0] alu_in,    
    input wire [4:0] rd_in,    
    input wire write,         
    input wire RegWrite_MEM,
    input wire MemtoReg_MEM,
    input wire MemRead_MEM,
    input wire MemWrite_MEM, 
    output reg RegWrite_WB,
    output reg MemtoReg_WB,
    output reg MemRead_WB,
    output reg MemWrite_WB,
    output reg [31:0] data_out, 
    output reg [31:0] alu_out,  
    output reg [4:0] rd_out    
);

    always @(posedge clk or posedge res) begin
        if (res) begin
            // Reset data signals
            data_out <= 32'b0;
            alu_out <= 32'b0;
            rd_out <= 5'b0;

            // Reset control signals
            RegWrite_WB <= 1'b0;
            MemtoReg_WB <= 1'b0;
            MemRead_WB <= 1'b0;
            MemWrite_WB <= 1'b0;
        end else if (write) begin
            // Update data signals
            data_out <= data_in;
            alu_out <= alu_in;
            rd_out <= rd_in;

            // Update control signals
            RegWrite_WB <= RegWrite_MEM;
            MemtoReg_WB <= MemtoReg_MEM;
            MemRead_WB <= MemRead_MEM;
            MemWrite_WB <= MemWrite_MEM;
        end
    end

endmodule
