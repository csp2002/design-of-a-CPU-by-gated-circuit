`timescale 1ns / 1ps

module pipeline(
input wire sysclk,
input wire reset,
output wire [7:0] leds,
output wire [3:0] AN,
output wire [7:0] BCD
    );
    wire clk;
    assign clk=sysclk;
    //PC
    wire [31:0] PC_in;
    wire [31:0] PC_out;
    wire PC_keep;
    PC PC(clk,reset,PC_in,PC_keep,PC_out);
    //ָ��洢��
    wire [31:0] Read_instruction;
    Inst_memory Inst_memory(PC_out,Read_instruction);
    //IF/ID�Ĵ���
    wire IF_ID_keep;
    wire IF_ID_flush;
    wire [31:0] PCjia4;
    wire [5:0] OpCode;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] shamt;
    wire [5:0] Funct;
    IF_ID IF_ID(clk,reset,IF_ID_keep,IF_ID_flush,Read_instruction,PC_out+4,OpCode,rs,rt,rd,shamt,Funct,PCjia4);
    //�Ĵ�����
    wire MEM_WB_RegWrite;
    wire [4:0] MEM_WB_WriteAddress;
    wire [31:0] MEM_WB_WriteData;
    wire [31:0] ReadData1;
    wire [31:0] ReadData2;
    wire [31:0] s7;
    RegFile RegFile(reset,clk,MEM_WB_RegWrite,rs,rt,MEM_WB_WriteAddress,MEM_WB_WriteData,s7,ReadData1,ReadData2);
    //�����źŲ���
    wire RegWrite;
    wire Branch;
    wire [2:0] Branch_cmp_ctrl;
    wire Jump;
    wire MemRead;
    wire MemWrite;
    wire [1:0]MemtoReg;
    wire JumpSrc;
    wire ALUSrc1;
    wire ALUSrc2;
    wire [4:0] ALUOp;
    wire [1:0] RegDst;
    wire LuiOp;
    wire ExtOp;
    Controller Controller(OpCode,Funct,RegWrite,Branch,Branch_cmp_ctrl,Jump,MemRead,MemWrite,MemtoReg,JumpSrc,ALUSrc1,ALUSrc2,ALUOp,RegDst,LuiOp,ExtOp);
    //Jָ��Ŀ���ַ��·ѡ����,JumpSrc=0ʱΪαֱ��Ѱַ�������ȡ�Ĵ����еĵ�ַ
    wire [31:0] J_Address;
    wire [31:0] ReadData1_final;
    wire [31:0] ReadData2_final;
    assign J_Address=(Jump==0)?(PC_out+4):JumpSrc?ReadData1_final:{PCjia4[31:28],rs,rt,rd,shamt,Funct,2'b00};
    //��������չ��Ԫ
    wire[31:0] ImmExtOut;
    ImmExtend ImmExtend(ExtOp,LuiOp,{rd,shamt,Funct},ImmExtOut);
    //ID_EX�Ĵ���
    wire ID_EX_flush;
    ID_EX ID_EX(clk,reset,ID_EX_flush,RegWrite,MemRead,MemWrite,MemtoReg,ALUSrc1,ALUSrc2,Branch,Branch_cmp_ctrl,ALUOp,RegDst,ReadData1_final,ReadData2_final,ImmExtOut,PCjia4,shamt,rt,rd);
    //ALU
    wire [31:0] in1;
    wire [31:0] in2;
    wire [31:0] Result;
    assign in1=ID_EX.ALUSrc1?{27'b0,ID_EX.shamt}:ID_EX.ReadData1;
    assign in2=ID_EX.ALUSrc2?ID_EX.imm_ext:ID_EX.ReadData2;
    ALU ALU(ID_EX.ALUOp,in1,in2,Result);
    //д��ļĴ�����·ѡ����
    wire [4:0] EX_WriteAddress;
    assign EX_WriteAddress = (ID_EX.RegDst==2'b00)? ID_EX.rd:(ID_EX.RegDst==2'b01)?ID_EX.rt:5'd31;
    //��֧
    wire Branch_cmp_out;
    Branch_cmp Branch_cmp(ID_EX.Branch_cmp_ctrl,in1,in2,Branch_cmp_out);
    assign PC_in=Branch_cmp_out?ID_EX.PCjia4+(ID_EX.imm_ext<<2):J_Address;
    //EX_MEM�Ĵ���
    EX_MEM EX_MEM(clk,reset,ID_EX.RegWrite,ID_EX.MemRead,ID_EX.MemWrite,ID_EX.MemtoReg,Result,ID_EX.PCjia4,ID_EX.ReadData2,EX_WriteAddress);
    //���ݴ洢��
    wire [31:0] ReadData3;//�����ݴ洢������������
    Data_memory Data_memory(clk,reset,xianshi.out0,EX_MEM.ALUout,EX_MEM.WriteData,EX_MEM.MemRead,EX_MEM.MemWrite,ReadData3,leds,AN,BCD);
    //MEM_WB
    MEM_WB MEM_WB(clk,reset,EX_MEM.RegWrite,EX_MEM.MemtoReg,ReadData3,EX_MEM.WriteAddress,EX_MEM.ALUout,EX_MEM.PCjia4);
    assign MEM_WB_WriteAddress=MEM_WB.WriteAddress;
    assign MEM_WB_RegWrite=MEM_WB.RegWrite;
    assign MEM_WB_WriteData= (MEM_WB.MemtoReg==2'b00)? MEM_WB.ALUout:(MEM_WB.MemtoReg==2'b01)? MEM_WB.ReadData:MEM_WB.PCjia4;
    //ת����Ԫ
    wire lw_stall;
    wire [1:0]ForwardA;
    wire [1:0]ForwardB;
    Forwarding Forwarding(ID_EX.RegWrite,EX_WriteAddress,EX_MEM.RegWrite,EX_MEM.WriteAddress,rs,rt,ID_EX.MemRead,ForwardA,ForwardB,lw_stall);
    assign PC_keep=lw_stall;
    assign IF_ID_keep=lw_stall;
    //��֧��תð�մ���Ԫ
    wire ID_EX_flush_branch;
    BranchandJump BranchandJump(Branch_cmp_out,Jump,IF_ID_flush,ID_EX_flush_branch);
    assign ID_EX_flush=ID_EX_flush_branch||lw_stall;
    //ALU�����·ѡ����������ת��
    wire [31:0] Writedata_ff= (EX_MEM.MemtoReg==2'b00)? EX_MEM.ALUout :(EX_MEM.MemtoReg==2'b01)? ReadData3 : EX_MEM.PCjia4;  //ǰǰ��ָ�д��Ĵ����ѵĽ��
    assign ReadData1_final= ForwardA==2'b01 ? Result:
                            ForwardA==2'b10 ? Writedata_ff:
                            ReadData1;
    assign ReadData2_final= ForwardB==2'b01 ? Result:
                           ForwardB==2'b10 ? Writedata_ff:
                           ReadData2;
    wire pose;
    cnt_1ms cnt_1ms(clk,reset,pose);
    xianshi xianshi(pose,s7);
    
endmodule
