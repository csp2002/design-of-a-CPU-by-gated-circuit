`timescale 1ns / 1ps
module PC(
input wire clk,
input wire reset,
input wire [31:0] PC_in,
input wire PC_keep,
output reg [31:0] PC_out
    );
    initial begin
    PC_out<=32'h00400000;
    end
    always@(posedge clk or posedge reset)begin
    if(reset)begin
    PC_out<=32'h00400000;
    end
    else begin
    if(!PC_keep&&(PC_in<32'h00400060)) PC_out<=PC_in;
    else if(!PC_keep) PC_out<=32'h00400060;
    
    end
    end
endmodule
