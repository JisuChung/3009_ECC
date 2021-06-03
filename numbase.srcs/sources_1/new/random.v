`timescale 1ns/1ns

module random (clk, rst, data1, data2, data3);

input clk;
input rst;

output reg [3:0] data1, data2, data3;

reg [4:0] datab;
reg [4:0] datac;
reg [4:0] datad;
reg [4:0] datab_next;
reg [4:0] datac_next;
reg [4:0] datad_next;

always @(*) begin
  datab_next[4] = datab[4]^datab[1];
  datab_next[3] = datab[3]^datab[0];
  datab_next[2] = datab[2]^datab_next[4];
  datab_next[1] = datab[1]^datab_next[3];
  datab_next[0] = datab[0]^datab_next[2];
  datac_next[4] = datac[4]^datac[1];
  datac_next[3] = datac[3]^datac[0];
  datac_next[2] = datac[2]^datac_next[4];
  datac_next[1] = datac[1]^datac_next[3];
  datac_next[0] = datac[0]^datac_next[2];
  datad_next[4] = datad[4]^datad[1];
  datad_next[3] = datad[3]^datad[0];
  datad_next[2] = datad[2]^datad_next[4];
  datad_next[1] = datad[1]^datad_next[3];
  datad_next[0] = datad[0]^datad_next[2];
end

always @(posedge clk or negedge rst) begin
  if(!rst) begin
    datab <= 5'h1f;
    datac <= 5'h2b;
    datad <= 5'hf0;
    end
  else begin
    datab <= datab_next;
    datac <= datac_next;
    datad <= datad_next;
    end
end

always @(*) begin
    data1 = datab %'d9 + 1;
    data2 = datac %'d9 + 1;
    data3 = datad %'d9 + 1;
end

endmodule