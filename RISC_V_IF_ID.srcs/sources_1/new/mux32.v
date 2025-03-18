module mux32(
    input wire [31:0] a,     // Input 1
    input wire [31:0] b,     // Input 2
    input wire [31:0] c,     // Input 3
    input wire [1:0] sel, // 2-bit select line
    output reg [31:0] y      // Output
);

always @(*) begin
    case (sel)
        2'b00: y = a; // Select input a
        2'b01: y = b; // Select input b
        2'b10: y = c; // Select input c
        default: y = 32'b0; // Default output (can be modified if needed)
    endcase
end

endmodule
