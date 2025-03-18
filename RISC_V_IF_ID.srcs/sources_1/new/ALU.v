module ALU(
    input [3:0] ALUop,
    input [31:0] ina, inb,
    output zero,
    output reg [31:0] out
);
    reg [31:0] result;   
    
    always @(*)
    begin
        case(ALUop)
            4'b0010: result <= ina + inb;               // Addition
            4'b0110: result <= ina - inb;               // Subtraction
            4'b0000: result <= ina & inb;               // Bitwise AND
            4'b0001: result <= ina | inb;               // Bitwise OR
            4'b0011: result <= ina ^ inb;               // Bitwise XOR
            4'b0101: result <= ina >> inb[4:0];         // Logical Right Shift
            4'b0100: result <= ina << inb[4:0];         // Logical Left Shift
            4'b1001: result <= ina >>> inb[4:0];        // Arithmetic Right Shift
            4'b0111: result <= (ina < inb) ? 32'b1 : 32'b0; // Unsigned Comparison
            4'b1000: result <= ($signed(ina) < $signed(inb)) ? 32'b1 : 32'b0; // Signed Comparison
            default: result <= 32'b0;                   // Default Case
        endcase
        
        // Assign result to the output register
        out = result;
    end

    assign zero = (result == 32'b0) ? 1'b1 : 1'b0;  // Zero Flag
endmodule
