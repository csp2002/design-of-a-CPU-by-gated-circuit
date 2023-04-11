`timescale 1ns / 1ps
module cnt_1ms(
input wire clk,
input wire reset,
output wire pose0
    );
    reg [31:0] counter;
    reg pose;
    always@(posedge clk or posedge reset)begin
    if(reset)begin
    pose<=0;
    counter<=0;
    end
    else begin
    if(counter==32'd1000)begin
    pose<=1;
    counter<=0;
    end
    else begin
    counter<=counter+1;
    pose<=0;
    end
    end
    end
    assign pose0=pose;
endmodule
