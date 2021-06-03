`timescale 1ns/1ns

module main (btnU, btnD, clk, rst, xint, yint, zint, led_l, led_up, seg, digit);

input clk,rst;
input btnU,btnD;
input [3:0] xint,yint,zint;

output [5:0] led_l;
output led_up;
output [6:0] seg;
output [7:0] digit;

wire up,down;
wire [2:0] Bo,So;
wire [3:0] ans0,ans1,ans2;

PushButtons PB (clk, rst, btnU, btnD, up, down);
answer A1 (clk, rst, up, ans0, ans1, ans2);
BSCounter B1 (down, clk, rst, ans0, ans1, ans2, xint, yint, zint, Bo, So);
display D1 (up, down, xint, yint, zint, clk, rst, Bo, So, led_l, led_up, digit, seg);

endmodule