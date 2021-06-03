`timescale 1ns/1ns

module main_Tb;
   reg [3:0] xint ;
   reg [3:0] yint ;
   reg [3:0] zint;
   reg [11:0] Cin ;
   reg rst=1'b0;
   reg clk=1'b0;
   reg btnU=1'b0;
   reg btnD=1'b0;
    wire [3:0] aa0,aa1,aa2,c0,c1,c2;
    integer i;
  //  reg [3:0] c0,c1,c2;
    //wire [3:0] a0,a1,a2;   
    wire [2:0] li;  
   // wire [2:0] lifecount;
   //reg [11:0] Ans = 12'b0;
   //wire [11:0] Ans= 12'b0;
   //assign Ans = 12'b100101010010;
   //reg clk,rst=0;
  // wire [2:0] B,S;
 //  wire LCount;
   //parameter tlimit =100;
   //parameter ckPeriod=7;

   wire [2:0] Bo;
   wire [2:0] So;
   reg [1:0] count1;
    reg clk_10000;
    reg [3:0] mema [0:5];
    reg [3:0] memb [0:5];
    reg [3:0] memc [0:5];
reg [2:0] count3;
 //   reg [3:0] c0,c1,c2;
   wire [5:0] led_l;
   wire [6:0] seg;
   wire [7:0] digit;
   //reg[1:0] count1;
   //reg clk_10000;
  main U1 (btnU,clk,btnD, rst, xint,yint,zint, led_l, seg, digit);
    
    initial begin
        $readmemb("data_a.mem",mema);
      $readmemb("data_b.mem",memb);
      $readmemb("data_c.mem",memc);
        #10 rst = 1'b1;
            /*for(i=0;i<20;i=i+1) begin
                #5 enter=1'b1;
                #5 enter =1'b0;
                
                #20 start=1'b1; 
                #20 start=1'b0;end
             */   
    end
    
    always #4 clk=~clk;
    always #200 btnU=~btnU;
    always #400 btnD=~btnD;    
    always@(posedge clk or negedge rst) begin
        if(!rst) begin
            count1 <= 2'b00;
            clk_10000 <= 0;
        end
        
        else begin
   
            if(count1=='d3) begin
                count1 <= 2'b00;
                clk_10000 = ~clk_10000;
            end
            else begin
                count1 <= count1+1;
            end
        end
    end
   


    always@(posedge clk_10000 or negedge rst) begin
        if(!rst)
           count3  <= 3'b0;
            
        else begin
    
            if(count3 < 5)
                count3 <=count3 + 1;
            else
              count3 <= 3'b0;
        end
    end
 
    always@(posedge clk_10000 or negedge rst) begin
        if(!rst) begin
            xint <= 1'b0;
            yint <= 1'b0;
           zint <= 1'b0;
          // Ans<= 12'b100101010010;
          // Cin <={zint,yint,xint};
        end
        else begin
            Cin <={zint,yint,xint};
            xint <= mema[count3];
            yint <= memb[count3];
           zint <= memc[count3];
            //c0 <= ($random%'d9+1);
           // c1 <= ($random%'d9+1);
         //   c2 <= ($random%'d9+1);
         //   
	  
         //  Ans<= 12'b100101010010;
           //Cin <= xint+yint+zint;
           //Cin <={zint,yint,xint};
        end
    end
    
   
	



 /* always@(posedge clk_10000 or negedge rst) begin
 	if(!rst) 
 	   Ans<=12'b0;
 	else begin



             Ans[3:0] <=(a0%'d9)+1;
             Ans[7:4] <=(a1%'d9)+1;
             Ans[11:8] <=(a2%'d9)+1;
             Ans <={Ans[11:8],Ans[7:4],Ans[3:0]};end
             
  end           

*/


//assign Ans[3:0] =(a0%'d9+1);
//assign Ans[7:4] =(a1%'d9+1);
//assign Ans[11:8] =(a2%'d9+1);
//assign Ans ={Ans[11:8],Ans[7:4],Ans[3:0]};
    
        //always@(negedge clk_10000 or negedge rst) begin
           // Cin <={zint,yint,xint}; end
endmodule