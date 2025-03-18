module mux4_1(ina,inb,inc,sel,out);
  
  input [31:0] ina,inb,inc;
  input [1:0] sel;
  output reg [31:0] out;
  
  always@(ina,inb,inc,sel) begin
    case(sel)
      2'b00: out = ina;
      2'b01: out = inb;
      2'b10: out = inc;
      2'b11: out = ina;
    endcase
  end

endmodule