`timescale 1ns / 1ps
module test_pipeline();
reg clk;
reg reset;
wire [7:0] leds;
wire [3:0] AN;
wire [7:0] BCD;
pipeline pipeline(clk,reset,leds,AN,BCD);
   initial begin
     reset = 1;
     clk = 1;
     #10 reset = 0;
 end
 
 always #10 clk = ~clk;
endmodule
