`timescale 1ns/1ns

module answer (clk, rst, up, ans0, ans1, ans2);

input clk,rst,up;

output wire [3:0] ans0,ans1,ans2;

wire [3:0] c0,c1,c2;
reg [3:0] a0,a1,a2;

random (clk, rst, c0, c1, c2);

always@(posedge clk or negedge rst) begin
    if(!rst) begin
        a0 <= 4'b0000;
        a1 <= 4'b0000;
        a2 <= 4'b0000;
    end
    else if (up) begin         
        if (c0 == c1) begin
            a0 <= c0;
            a1 <= c1+4'b0001;
            a2 <= c2; 
        end
        else if (c1 == c2) begin       
            a0 <= c0;
            a1 <= c1;
            a2 <= c2+4'b0001; 
        end
        else if (c2 == c0) begin
            a0 <= c0;
            a1 <= c1;
            a2 <= c2+4'b0001; 
        end
        else begin
            a0 <= c0;
            a1 <= c1;
            a2 <= c2;
        end
    end
end

assign ans0 = (a0%'d9+1);
assign ans1 = (a1%'d9+1);
assign ans2 = (a2%'d9+1);            


endmodule