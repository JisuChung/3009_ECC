`timescale 1ns/1ns

module BSCounter (down, clk, rst, ans0, ans1, ans2, xint, yint, zint, Bo, So);

input [3:0] xint,yint,zint,ans0,ans1,ans2;
input down;
input clk,rst;

output wire [2:0] Bo;
output wire [2:0] So;

reg [2:0] Bi;
reg [2:0] Si;         

always @(posedge clk or negedge rst ) begin
    if(!rst) begin
        Si <= 3'b000;
        Bi <= 3'b000;
    end
    else begin
        if(down) begin
            if(ans0== xint) begin Si[0] <= 1'b1; Bi[0] <= 1'b0; end 
            else if(ans0== yint) begin Bi[0] <= 1'b1; Si[0] <= 1'b0; end 
            else if(ans0== zint)begin  Bi[0] <= 1'b1; Si[0] <= 1'b0; end
            else begin 
                Bi[0] <= 1'b0;
                Si[0] <= 1'b0;
            end

            if(ans1== yint) begin Si[1] <= 1'b1; Bi[1] <= 1'b0; end
            else if(ans1== xint) begin Bi[1] <= 1'b1; Si[1] <= 1'b0; end
            else if(ans1== zint) begin Bi[1]  <= 1'b1; Si[1] <= 1'b0; end
            else begin 
                Bi[1] <= 1'b0;
                Si[1] <= 1'b0;
            end

            if(ans2 == zint)begin  Si[2] <= 1'b1; Bi[2] <= 1'b0; end
            else if(ans2 == yint) begin  Bi[2] <= 1'b1; Si[2] <= 1'b0; end
            else if(ans2 == xint) begin  Bi[2] <= 1'b1; Si[2] <= 1'b0; end
            else begin 
                Bi[2] <= 1'b0;
                Si[2] <= 1'b0;
            end
        end
    end
end


assign Bo = Bi[0]+Bi[1]+Bi[2];
assign So = Si[0]+Si[1]+Si[2];
  


endmodule