`timescale 1ns / 1ps
module IF_ID(
input wire clk,
input wire reset,
input wire keep,
input wire flush,
input wire [31:0] fetch_instruction,
input wire [31:0] IF_PCjia4,
output reg [5:0] OpCode,
output reg [4:0] rs,
output reg [4:0] rt,
output reg [4:0] rd,
output reg [4:0] shamt,
output reg [5:0] Funct,
output reg [31:0] PCjia4
    );
initial 
    begin
    OpCode<=0;
    rs<=0;
    rt<=0;
    rd<=0;
    shamt<=0;
    Funct<=0;
    PCjia4<=0;
    end
    always@(posedge clk or posedge reset)begin
    if(reset)begin
    OpCode<=0;
    rs<=0;
    rt<=0;
    rd<=0;
    shamt<=0;
    Funct<=0;
    PCjia4<=0;    
    end
    else if(flush)begin
    OpCode<=0;
    rs<=0;
    rt<=0;
    rd<=0;
    shamt<=0;
    Funct<=0;
    PCjia4<=0;       
    end
    else if(!keep) begin
    OpCode<=fetch_instruction[31:26];
    rs<=fetch_instruction[25:21];
    rt<=fetch_instruction[20:16];
    rd<=fetch_instruction[15:11];
    shamt<=fetch_instruction[10:6];
    Funct<=fetch_instruction[5:0];
    PCjia4<=IF_PCjia4;
    end
    end
    
endmodule
