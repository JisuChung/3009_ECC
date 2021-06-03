`timescale 1ns / 1ns

module D_FF( clk_out, D, Q, Qbar );

input clk_out;
input D;

output reg Q;
output reg Qbar;
    
always @ (posedge clk_out) begin
    Q <= D;
    Qbar <= ~Q;
end
       
endmodule