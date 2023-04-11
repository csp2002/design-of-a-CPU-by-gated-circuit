`timescale 1ns / 1ps

module Inst_memory(
input wire [31:0] ReadAddress,
output wire [31:0] Read_instruction
    );
    parameter RAM_SIZE=256;
    
    reg [31:0] data[RAM_SIZE-1:0];
    assign Read_instruction=((ReadAddress[31:8]==24'h004000)&&(ReadAddress[9:2]<9'h18))?data[ReadAddress[9:2]]:32'h00000000;
    integer i;
    initial
    begin
    data[9'h0]<=32'h2008ffff;
    data[9'h1]<=32'h00865023;
    data[9'h2]<=32'h21080001;
    data[9'h3]<=32'h01488022;
    data[9'h4]<=32'h06000012;
    data[9'h5]<=32'h2009ffff;
    data[9'h6]<=32'h21290001;
    data[9'h7]<=32'h1126000d;
    data[9'h8]<=32'h00055821;
    data[9'h9]<=32'h00076021;
    data[9'hA]<=32'h01296820;
    data[9'hB]<=32'h01097820;
    data[9'hC]<=32'h01ad7020;
    data[9'hD]<=32'h01efc020;
    data[9'hE]<=32'h0318c820;
    data[9'hF]<=32'h018e6020;
    data[9'h10]<=32'h01795820;
    data[9'h11]<=32'h8d8c0000;
    data[9'h12]<=32'h8d6b0000;
    data[9'h13]<=32'h116cfff2;
    data[9'h14]<=32'h1526ffed;
    data[9'h15]<=32'h20420001;
    data[9'h16]<=32'h08100002;
    data[9'h17]<=32'h0040b820;
    //for(i=9'h18;i<RAM_SIZE;i=i+1)begin
   // data[i]<=0;
   // end
    
    end
endmodule
