`timescale 1ns / 1ps

module EX_MEM(
input wire clk,
input wire reset,
input wire EX_RegWrite,
input wire EX_MemRead,
input wire EX_MemWrite,
input wire [1:0] EX_MemtoReg,
input wire [31:0] EX_ALUout,
input wire [31:0] EX_PCjia4,
input wire [31:0] EX_WriteData,
input wire [4:0] EX_WriteAddress
    );
    reg RegWrite;
    reg MemRead;
    reg MemWrite;
    reg [1:0] MemtoReg;
    reg [31:0] ALUout;
    reg [31:0] PCjia4;
    reg [31:0] WriteData;
    reg [4:0] WriteAddress;
    initial
    begin
    RegWrite<=0;
    MemRead<=0;
    MemWrite<=0;
    MemtoReg<=0;
    ALUout<=0;
    PCjia4<=0;
    WriteData<=0;
    WriteAddress<=0;
    end
    always@(posedge clk or posedge reset)begin
    if(reset)begin
       RegWrite<=0;
       MemRead<=0;
       MemWrite<=0;
       MemtoReg<=0;
       ALUout<=0;
       PCjia4<=0;
       WriteData<=0;
       WriteAddress<=0;
    end
    else begin
       RegWrite<=EX_RegWrite;
       MemRead<=EX_MemRead;
       MemWrite<=EX_MemWrite;
       MemtoReg<=EX_MemtoReg;
       ALUout<=EX_ALUout;
       PCjia4<=EX_PCjia4;
       WriteData<=EX_WriteData;
       WriteAddress<=EX_WriteAddress;
    end
    end
endmodule
