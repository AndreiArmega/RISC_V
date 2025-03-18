module ALU_tb;

    // Declare inputs and outputs
    reg [3:0] ALUop;
    reg [31:0] ina, inb;
    wire zero;
    wire [31:0] out;
    
    // Instantiate the ALU module
    ALU uut (
        .ALUop(ALUop),
        .ina(ina),
        .inb(inb),
        .zero(zero),
        .out(out)
    );
    
    // Test all ALU operations
    initial begin
        // Test Addition
        ALUop = 4'b0010; ina = 32'd10; inb = 32'd20; #10;
        $display("Addition: ina=%d, inb=%d, out=%d, zero=%b", ina, inb, out, zero);
        
        // Test Subtraction
        ALUop = 4'b0110; ina = 32'd30; inb = 32'd15; #10;
        $display("Subtraction: ina=%d, inb=%d, out=%d, zero=%b", ina, inb, out, zero);
        
        // Test AND
        ALUop = 4'b0000; ina = 32'hF0F0F0F0; inb = 32'h0F0F0F0F; #10;
        $display("AND: ina=%h, inb=%h, out=%h, zero=%b", ina, inb, out, zero);
        
        // Test OR
        ALUop = 4'b0001; ina = 32'b00000000000000000000000000000110; inb =32'b00000000000000000000000000000011 ; #10;
        $display("OR: ina=%h, inb=%h, out=%h, zero=%b", ina, inb, out, zero);
        
        // Test XOR
        ALUop = 4'b0011; ina = 32'hF0F0F0F0; inb = 32'h0F0F0F0F; #10;
        $display("XOR: ina=%h, inb=%h, out=%h, zero=%b", ina, inb, out, zero);
        
        // Test Logical Right Shift
        ALUop = 4'b0101; ina = 32'd32; inb = 32'd2; #10;
        $display("Logical Right Shift: ina=%d, inb=%d, out=%d, zero=%b", ina, inb, out, zero);
        
        // Test Logical Left Shift
        ALUop = 4'b0100; ina = 32'd2; inb = 32'd3; #10;
        $display("Logical Left Shift: ina=%d, inb=%d, out=%d, zero=%b", ina, inb, out, zero);
        
        // Test Arithmetic Right Shift
        ALUop = 4'b1001; ina = 32'd32; inb = 32'd2; #10;
        $display("Arithmetic Right Shift: ina=%d, inb=%d, out=%d, zero=%b", ina, inb, out, zero);
        
        // Test Unsigned Comparison
        ALUop = 4'b0111; ina = 32'd10; inb = 32'd20; #10;
        $display("Unsigned Comparison: ina=%d, inb=%d, out=%d, zero=%b", ina, inb, out, zero);
        
        // Test Signed Comparison
        ALUop = 4'b1000; ina = 32'd10; inb = 32'd20; #10;
        $display("Signed Comparison: ina=%d, inb=%d, out=%d, zero=%b", ina, inb, out, zero);
        
        // Test Default Case
        ALUop = 4'b1111; ina = 32'd10; inb = 32'd20; #10;
        $display("Default: ina=%d, inb=%d, out=%d, zero=%b", ina, inb, out, zero);
        
        // End simulation
        $finish;
    end

endmodule
