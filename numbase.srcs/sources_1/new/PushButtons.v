`timescale 1ns/1ns

module PushButtons (clk, rst, btnU,  btnD,  up, down);

input clk, rst;
input btnU, btnD;

output reg up, down;

reg btnUC_old, btnDC_old; 
wire btnUC, btnDC;

debounce dbU(btnU, clk, btnUC);
debounce dbD(btnD, clk, btnDC);    

always@(posedge clk) begin
    btnUC_old <= btnUC;
    btnDC_old <= btnDC;
    
    if (btnUC_old == 1'b0 && btnUC == 1'b1) up <= 1'b1;
    else up <= 1'b0;
    if (btnDC_old == 1'b0 && btnDC == 1'b1) down <= 1'b1; 
    else down <= 1'b0;
end

endmodule