`timescale 1ns / 1ps
module Data_memory(
input wire clk,
input wire reset,
input wire [15:0] shumaguan,
input wire [31:0] Address,
input wire [31:0] Write_data,
input wire MemRead,
input wire MemWrite,
output wire [31:0] Mem_data,
output reg [7:0] leds,
output reg [3:0] AN,
output reg [7:0] BCD
    );
    parameter RAM_SIZE=512;
    reg [31:0] data [RAM_SIZE-1:0];
    wire [29:0] Address_word;   //×ÖµØÖ·
    assign Address_word=Address[31:2];
    assign Mem_data = MemRead == 0 ? 0 :Address_word < RAM_SIZE ? data[Address_word] :Address_word == 30'b010000000000000000000000000011 ? {24'b0, leds} :Address_word == 30'b010000000000000000000000000100 ? {20'b0, AN, BCD} :0;
   integer i;
   initial begin
   leds<=0;
   AN<=0;
   BCD<=0;
   data[0]<=32'd99;  //Ä£Ê½´®
   data[1]<=32'd115;
   data[2]<=32'd112;
   data[3]<=32'd102;//Æ¥Åä´®
   data[4]<=32'd121;
   data[5]<=32'd102;
   data[6]<=32'd106;
   data[7]<=32'd118;
   data[8]<=32'd99;
   data[9]<=32'd115;
   data[10]<=32'd112;
   data[11]<=32'd117;
   data[12]<=32'd117;
   data[13]<=32'd103;
   data[14]<=32'd100;
   data[15]<=32'd99;
   data[16]<=32'd115;
   data[17]<=32'd112;
   data[18]<=32'd121;
   data[19]<=32'd104;
   data[20]<=32'd103;
   data[21]<=32'd121;
   data[22]<=32'd111;
   data[23]<=32'd99;
   data[24]<=32'd115;
   data[25]<=32'd112;
   data[26]<=32'd110;
   data[27]<=32'd111;
   data[28]<=32'd115;
   data[29]<=32'd120;
   data[30]<=32'd106;
   data[31]<=32'd118;
   data[32]<=32'd121;
   for(i=33;i<RAM_SIZE;i=i+1)begin
   data[i]<=0;
   end
   end
   integer j;
   always@(posedge clk or posedge reset)begin
   if(reset)begin
   leds<=0;
   AN<=0;
   BCD<=0;
   data[0]<=32'd99;  //Ä£Ê½´®
      data[1]<=32'd115;
      data[2]<=32'd112;
      data[3]<=32'd102;//Æ¥Åä´®
      data[4]<=32'd121;
      data[5]<=32'd102;
      data[6]<=32'd106;
      data[7]<=32'd118;
      data[8]<=32'd99;
      data[9]<=32'd115;
      data[10]<=32'd112;
      data[11]<=32'd117;
      data[12]<=32'd117;
      data[13]<=32'd103;
      data[14]<=32'd100;
      data[15]<=32'd99;
      data[16]<=32'd115;
      data[17]<=32'd112;
      data[18]<=32'd121;
      data[19]<=32'd104;
      data[20]<=32'd103;
      data[21]<=32'd121;
      data[22]<=32'd111;
      data[23]<=32'd99;
      data[24]<=32'd115;
      data[25]<=32'd112;
      data[26]<=32'd110;
      data[27]<=32'd111;
      data[28]<=32'd115;
      data[29]<=32'd120;
      data[30]<=32'd106;
      data[31]<=32'd118;
      data[32]<=32'd121;
      for(i=33;i<RAM_SIZE;i=i+1)begin
      data[i]<=0;
   end   
   end
   else begin
   if(MemWrite)begin
     if(Address_word<RAM_SIZE)begin
     data[Address_word]<=Write_data;
     end

   end
      BCD<=shumaguan[7:0];
   AN<=shumaguan[11:8];
   
   end
   
   end
endmodule
