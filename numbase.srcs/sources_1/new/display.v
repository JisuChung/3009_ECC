`timescale 1ns/1ns

module display (up, down, xint, yint, zint, clk, rst, Bo, So, led_l, led_up, digit, seg);

input clk, rst;
input [3:0] xint,yint,zint;
input [2:0] Bo,So;
input up, down;

output reg [6:0] seg; 
output reg [7:0] digit;
output reg [5:0] led_l;
output reg led_up;

reg [2:0] life;
reg [6:0] seg1,seg2,seg3;
reg [27:0] seg4;
reg [31:0] count;
reg clk_10000;
reg intro;

always@(posedge clk or negedge rst) begin
    if(!rst) begin
        life <= 3'b110;
        intro <= 1'b0;
    end
    
    else begin
        if (So == 3'b011 ) begin
            life <= 3'b110;
        end
        if(up) begin
            intro <= intro + 1;
            life <= 3'b110;
        end
        else begin
            if (down) begin
                life <= life - 3'b001;
            end
        end 
    end
end

always @(life) begin
    case(life)
        3'b000: led_l=6'b000000;
        3'b001: led_l=6'b000001;
        3'b010: led_l=6'b000011;
        3'b011: led_l=6'b000111;
        3'b100: led_l=6'b001111;
        3'b101: led_l=6'b011111;
        3'b110: led_l=6'b111111;
        default: led_l= 6'b111111;
    endcase
end

always @(intro) begin
    case(intro)
        1'b0: led_up = 1'b0;
        1'b1: led_up = 1'b1;
    endcase
end

parameter zero=7'b0000001, one=7'b1001111, two=7'b0010010, three=7'b0000110,
            four=7'b1001100, five=7'b0100100, six=7'b0100000, seven=7'b0001111,
            eight=7'b0000000, nine=7'b0000100 ,ba=7'b0000000, l=7'b1110001, lo=7'b0000001,
            s=7'b0100100, e=7'b0110000, g=7'b0100000, d=7'b1000010, null = 7'b1111110, o=7'b1100010;

always@(xint or yint or zint) begin
    case(xint)
        4'b0000: seg1= zero;
        4'b0001: seg1=one;
        4'b0010: seg1= two;
        4'b0011: seg1= three;
        4'b0100: seg1= four;
        4'b0101: seg1= five;
        4'b0110: seg1= six;
        4'b0111: seg1= seven;
        4'b1000: seg1= eight;
        4'b1001: seg1= nine;
        default: seg1= null;
     endcase
    case(yint)
        4'b0000: seg2= zero;
        4'b0001: seg2=one;
        4'b0010: seg2= two;
        4'b0011: seg2= three;
        4'b0100: seg2= four;
        4'b0101: seg2= five;
        4'b0110: seg2= six;
        4'b0111: seg2= seven;
        4'b1000: seg2= eight;
        4'b1001: seg2= nine;
        default: seg2= null;
     endcase
    case(zint)
        4'b0000: seg3= zero;
        4'b0001: seg3= one;
        4'b0010: seg3= two;
        4'b0011: seg3= three;
        4'b0100: seg3= four;
        4'b0101: seg3= five;
        4'b0110: seg3= six;
        4'b0111: seg3= seven;
        4'b1000: seg3= eight;
        4'b1001: seg3= nine;
        default: seg3= null;
     endcase    
end

always@(Bo or So or life ) begin
    if(life > 3'b000) begin
        case({Bo,So})
            6'b000000: seg4= {zero,ba,zero,s};
            6'b000001: seg4= {zero,ba,one,s};
            6'b000010: seg4= {zero,ba,two,s};
            6'b000011: seg4= {g,o,o,d}; 
            6'b001000: seg4= {one,ba,zero,s};
            6'b001001: seg4= {one,ba,one,s};
            6'b001010: seg4= {one,ba,two,s};

            6'b010000: seg4= {two,ba,zero,s};
            6'b010001: seg4= {two,ba,one,s};

            6'b011000: seg4= {three,ba,zero,s};
	
            default: seg4=28'b1111110_1111110_1111110_1111110;
        endcase
    end
    else if (life ==3'b000)
	   seg4= {l,lo,s,e};
end


always @(posedge clk or negedge rst) begin
    if(!rst) begin
        count <= 32'b0;
        clk_10000 <= 0;
    end
    else begin
        if(count=='d10000) begin
            count <= 32'b0;
            clk_10000 = ~clk_10000;
        end
        else begin
            count <= count+1;
        end
    end
end

always @(posedge clk_10000 or negedge rst) begin
    if(!rst) begin
        digit <= 8'b1111_1110;
    end
    else if (clk_10000) begin
        digit <= {digit[6:0], digit[7]};
    end
end

always @(digit or seg1 or seg2 or seg3 or seg4 or seg) begin
    case(digit)
        8'b1111_1110: seg=seg1[6:0];
        8'b1111_1101: seg=seg2[6:0];
        8'b1111_1011: seg=seg3[6:0];
	    8'b1111_0111: seg= 7'b1111111;
	    8'b1110_1111: seg=seg4[6:0];
	    8'b1101_1111: seg=seg4[13:7];
        8'b1011_1111: seg=seg4[20:14];
	    8'b0111_1111: seg=seg4[27:21];
        default: seg=7'b0;
    endcase
end

endmodule       