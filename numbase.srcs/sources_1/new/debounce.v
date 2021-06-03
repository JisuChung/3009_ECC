`timescale 1ns / 1ns

module debounce(push, clk, pushclr);

input push;
input clk;

output pushclr;
    
wire clk_out;
wire Q1, Q2, Q2_bar;

checlk check (clk, clk_out);
D_FF D1 (clk_out, push, Q1);
D_FF D2 (clk_out, Q1, Q2);

assign Q2_bar = ~Q2;
assign pushclr = Q1 & Q2_bar;


endmodule