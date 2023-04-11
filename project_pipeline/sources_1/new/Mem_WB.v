`timescale 1ns / 1ps
module Mem_WB(
input wire clk,
input wire reset,
input wire Mem_RegWrite,
input wire [1:0] Mem_MemtoReg,
input wire [31:0] Mem_ReadData,
input wire [31:0] Mem_WriteAddress,
input wire [31:0] Mem_ALUout,
input wire [31:0] Mem_PCjia4
    );
    reg RegWrite;
    reg [1:0] MemtoReg;
    reg [31:0] ReadData;
    reg [31:0] WriteAddress;
    reg [31:0] ALUout;
    reg [31:0] PCjia4;
    initial begin
    RegWrite<=0;
    MemtoReg<=0;
    ReadData<=0;
    WriteAddress<=0;
    ALUout<=0;
    PCjia4<=0;
    end
    always@(posedge clk or posedge reset)begin
    if(reset)begin
        RegWrite<=0;
        MemtoReg<=0;
        ReadData<=0;
        WriteAddress<=0;
        ALUout<=0;
        PCjia4<=0;
    end
    else begin
        RegWrite<=Mem_RegWrite;
        MemtoReg<=Mem_MemtoReg;
        ReadData<=Mem_ReadData;
        WriteAddress<=Mem_WriteAddress;
        ALUout<=Mem_ALUout;
        PCjia4<=Mem_PCjia4;
    end
    end
endmodule
