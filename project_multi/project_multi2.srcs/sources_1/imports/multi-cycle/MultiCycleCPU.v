`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Fundamentals of Digital Logic and Processor
// Designer: Shulin Zeng
// 
// Create Date: 2021/04/30
// Design Name: MultiCycleCPU
// Module Name: MultiCycleCPU
// Project Name: Multi-cycle-cpu
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module MultiCycleCPU (reset, system_clk,led,Cathodes,an,buttom,sw);
    //Input Clock Signals
    input  reset;
    input  system_clk;
    input buttom;
    output [7:0]led;
    output [6:0]Cathodes;
    output [3:0]an;
    input [1:0]sw;
    
    //--------------Your code below-----------------------
    wire [31:0]PC_next,Mem_out,Ext_out,Ext_out_Shift,Ext_out1,Mem_Addr,Reg_out1,
    Reg_out2,ALU_out,MDR_out,PC_out,RegWrite_data,Read_data1,Read_data2,
    ALU_in1,ALU_in2,ALU_result;
    wire PCWrite1,PCWrite2;
    wire PCWriteCond;
    wire IorD;
    wire MemWrite;
    wire MemRead;
    wire IRWrite;
    wire [1:0] MemtoReg;
    wire [1:0] RegDst;
    wire RegWrite;
    wire ExtOp;
    wire LuiOp;
    wire [1:0] ALUSrcA;
    wire [1:0] ALUSrcB;
    wire [4:0] ALUOp;
    wire [1:0] PCSource;
    wire Sign;
    wire [5:0] OpCode,Funct;
    wire [4:0] rs,rt,rd,Write_register;
    wire [4:0] Shamt;
    wire Zero;
    wire [7:0]led;
    wire clk2,clk;
    wire [3:0]number0,number1,number2,number3,number4,number5,number6,number7 ,number8,number9,number10,number11,number12,number13,number14,number15;
           wire [1:0]count;
         wire [3:0]number;
    clk_gen myclk(system_clk,reset,clk2);
             
             debounce mydebounce(system_clk,buttom,clk);
             count4 mycount(clk2,an,count,reset);
             multichoice mychoice(
                     .clk(count),
                     .in(sw),
                     .out(number),
                     .number0(number0),
                     .number1(number1),
                     .number2(number2),
                     .number3(number3),
                     .number4(number4),
                     .number5(number5),
                     .number6(number6),
                     .number7(number7),
                     .number8(number8),
                     .number9(number9),
                     .number10(number10),
                     .number11(number11),
                     .number12(number12),
                     .number13(number13),
                     .number14(number14),
                     .number15(number15)
                     );
                         
                     BCD7 myBCD(number,Cathodes);
                     
    always @(posedge clk or posedge reset);
    PC PC1(
        .reset(reset), 
        .clk(clk), 
        .PCWrite(PCWrite2),
        .PC_i(PC_next), 
        .PC_o(PC_out)
    );

    assign Mem_Addr=IorD?ALU_out:PC_out;//选择Memory地址来源

    InstAndDataMemory Inst
    (.reset(reset), 
    .clk(clk), 
    .Address(Mem_Addr), 
    .Write_data(Reg_out2), 
    .MemRead(MemRead), 
    .MemWrite(MemWrite), 
    .Mem_data(Mem_out)
    );

    InstReg Instreg1(.reset(reset), 
    .clk(clk), 
    .IRWrite(IRWrite), 
    .Instruction(Mem_out), 
    .OpCode(OpCode), 
    .rs(rs), 
    .rt(rt), 
    .rd(rd), 
    .Shamt(Shamt), 
    .Funct(Funct)
    );

    Controller Control1(
    .reset(reset), 
    .clk(clk), 
    .OpCode(OpCode), 
    .Funct(Funct), 
    .PCWrite(PCWrite1), 
    .PCWriteCond(PCWriteCond), 
    .IorD(IorD), 
    .MemWrite(MemWrite), 
    .MemRead(MemRead),
    .IRWrite(IRWrite), 
    .MemtoReg(MemtoReg), 
    .RegDst(RegDst), 
    .RegWrite(RegWrite), 
    .ExtOp(ExtOp), 
    .LuiOp(LuiOp),
    .ALUSrcA(ALUSrcA), 
    .ALUSrcB(ALUSrcB), 
    .ALUOp(ALUOp), 
    .PCSource(PCSource),
    .sign(Sign));

    RegTemp MDR(.reset(reset), 
    .clk(clk), 
    .Data_i(Mem_out), 
    .Data_o(MDR_out)
    );


    assign Write_register=(RegDst==2'b10)?5'd31:(RegDst==2'b01)?rd:rt;//选择寄存器堆写入地址
    assign RegWrite_data=(MemtoReg==2'b10)?PC_out:(MemtoReg==2'b01)?ALU_out:MDR_out;//选择寄存器堆写入数据

    RegisterFile reg1(.reset(reset), 
    .clk(clk), 
    .RegWrite(RegWrite), 
    .Read_register1(rs), 
    .Read_register2(rt), 
    .Write_register(Write_register), 
    .Write_data(RegWrite_data), 
    .Read_data1(Read_data1), 
    .Read_data2(Read_data2),
    .a0({number0,number1,number2,number3}),
            .v0({number4,number5,number6,number7}),
            .sp({number8,number9,number10,number11}),
            .ra({number12,number13,number14,number15})
    );
assign led[0]=PC_out[0];
            assign led[1]=PC_out[1];
            assign led[2]=PC_out[2];
            assign led[3]=PC_out[3];
            assign led[4]=PC_out[4];
            assign led[5]=PC_out[5];
            assign led[6]=PC_out[6];
            assign led[7]=PC_out[7];
    ImmProcess Imm1(
    .ExtOp(ExtOp), 
    .LuiOp(LuiOp), 
    .Immediate({rd,Shamt,Funct}), 
    .ImmExtOut(Ext_out), 
    .ImmExtShift(Ext_out_Shift)
    ); 

    RegTemp RegA(
    .reset(reset), 
    .clk(clk), 
    .Data_i(Read_data1), 
    .Data_o(Reg_out1));

    RegTemp RegB(
    .reset(reset), 
    .clk(clk), 
    .Data_i(Read_data2), 
    .Data_o(Reg_out2));

    assign ALU_in1=(ALUSrcA==2'b10)?{27'b0,Shamt}:(ALUSrcA==2'b01)?Reg_out1:PC_out;//选择ALU输入1
    assign ALU_in2=(ALUSrcB==2'b11)?Ext_out_Shift:(ALUSrcB==2'b10)?Ext_out:(ALUSrcB==2'b01)?32'd4:Reg_out2;//选择ALU输入2

    ALU ALU1(
    .in1(ALU_in1), 
    .in2(ALU_in2), 
    .ct(ALUOp), 
    .sign(Sign), 
    .out(ALU_result), 
    .zero(Zero)
    );

    RegTemp ALUout(
    .reset(reset),
    .clk(clk), 
    .Data_i(ALU_result), 
    .Data_o(ALU_out)
    );

    assign PC_next=(PCSource==2'b10)?{PC_out[31:28],rs,rt,rd,Shamt,Funct,2'b00}:
    (PCSource==2'b01)?ALU_out:ALU_result;//选择PC地址来源

    assign PCWrite2=((PCWriteCond&&Zero)||PCWrite1)?1'b1:1'b0;







    



    //--------------Your code above-----------------------

endmodule