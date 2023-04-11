`timescale 1ns / 1ps

module ID_EX(
input wire clk,
input wire reset,
input wire flush,
input wire ID_RegWrite,
input wire ID_MemRead,
input wire ID_MemWrite,
input wire [1:0]ID_MemtoReg,
input wire ID_ALUSrc1,
input wire ID_ALUSrc2,
input wire ID_Branch,
input wire [2:0] ID_Branch_cmp_ctrl,
input wire [4:0] ID_ALUOp,
input wire [1:0] ID_RegDst,
input wire [31:0] ID_ReadData1,
input wire [31:0] ID_ReadData2,
input wire [31:0] ID_imm_ext,
input wire [31:0] ID_PCjia4,
input wire [4:0] ID_shamt,
input wire [4:0] ID_rt,
input wire [4:0] ID_rd
    );
    reg RegWrite;
    reg MemRead;
    reg MemWrite;
    reg [1:0]MemtoReg;
    reg ALUSrc1;
    reg ALUSrc2;
    reg Branch;
    reg [2:0]Branch_cmp_ctrl;
    reg [4:0]ALUOp;
    reg [1:0]RegDst;
    reg [31:0]ReadData1;
    reg [31:0]ReadData2;
    reg [31:0]imm_ext;
    reg [31:0]PCjia4;
    reg [4:0] shamt;
    reg [4:0] rt;
    reg [4:0] rd;
    initial
    begin
    RegWrite<=0;
    MemRead<=0;
    MemWrite<=0;
    MemtoReg<=2'b0;
    ALUSrc1<=0;
    ALUSrc2<=0;
    Branch<=0;
    Branch_cmp_ctrl<=3'b0;
    ALUOp<=5'b0;
    RegDst<=2'b0;
    ReadData1<=32'b0;
    ReadData2<=32'b0;
    imm_ext<=32'b0;
    PCjia4<=32'b0;
    shamt<=5'b0;
    rt<=5'b0;
    rd<=5'b0;
    end
    always@(posedge clk or posedge reset)begin
    if(reset)begin
    RegWrite<=0;
    MemRead<=0;
    MemWrite<=0;
    MemtoReg<=2'b0;
    ALUSrc1<=0;
    ALUSrc2<=0;
    Branch<=0;
    Branch_cmp_ctrl<=3'b0;
    ALUOp<=5'b0;
    RegDst<=2'b0;
    ReadData1<=32'b0;
    ReadData2<=32'b0;
    imm_ext<=32'b0;
    PCjia4<=32'b0;
    shamt<=5'b0;
    rt<=5'b0;
    rd<=5'b0;    
    end
    else if(flush)begin
    RegWrite<=0;
    MemRead<=0;
    MemWrite<=0;
    MemtoReg<=2'b0;
    ALUSrc1<=0;
    ALUSrc2<=0;
    Branch<=0;
    Branch_cmp_ctrl<=3'b0;
    ALUOp<=5'b0;
    RegDst<=2'b0;
    ReadData1<=32'b0;
    ReadData2<=32'b0;
    imm_ext<=32'b0;
    PCjia4<=32'b0;
    shamt<=5'b0;
    rt<=5'b0;
    rd<=5'b0;        
    end
    else begin
    RegWrite<=ID_RegWrite;
    MemRead<=ID_MemRead;
    MemWrite<=ID_MemWrite;
    MemtoReg<=ID_MemtoReg;
    ALUSrc1<=ID_ALUSrc1;
    ALUSrc2<=ID_ALUSrc2;
    Branch<=ID_Branch;
    Branch_cmp_ctrl<=ID_Branch_cmp_ctrl;
    ALUOp<=ID_ALUOp;
    RegDst<=ID_RegDst;
    ReadData1<=ID_ReadData1;
    ReadData2<=ID_ReadData2;
    imm_ext<=ID_imm_ext;
    PCjia4<=ID_PCjia4;
    shamt<=ID_shamt;
    rt<=ID_rt;
    rd<=ID_rd;
    end
    end
    
    
endmodule
