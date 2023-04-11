
module CPU(reset, system_clk,led,Cathodes,an,buttom,sw);
	input wire reset, system_clk,buttom;
	output [7:0]led;
	output [6:0]Cathodes;
	output [3:0]an;
	input [1:0]sw;
    //--------------Your code below-----------------------
    reg [31:0] PC;
    wire [31:0] PC_next,Inst,Ext_out,ALU_in1,ALU_in2,Reg_out2,Reg_out1,ALU_out,Reg_write1;
    wire [31:0] Mem_Read,Lu_out,Reg_write2,PC4,Jump_Addr,Branch_Addr;
    wire [1:0] RegDst;
	wire [1:0] PCSrc;
	wire Branch;
	wire MemRead;
	wire [1:0] MemtoReg;
	wire [4:0] ALUOp;
	wire ExtOp;
	wire LuOp;
	wire MemWrite;
	wire ALUSrc1;
	wire ALUSrc2;
	wire RegWrite;
    wire sign1;
    wire [4:0]Reg_writeAddr;
    wire Zero;
    wire [7:0]led;
    wire [3:0]number0,number1,number2,number3,number4,number5,number6,number7
    ,number8,number9,number10,number11,number12,number13,number14,number15;
    wire clk2,clk;
    wire [1:0]count;
    wire [3:0]number;
    
    clk_gen myclk(system_clk,reset,clk2);
    
    debounce mydebounce(system_clk,buttom,clk);
    
    
    

    always @(posedge clk or posedge reset)
        if(reset) PC<=32'h0;
        else PC<=PC_next;
        
        

        assign PC4=PC+32'd4;
        InstructionMemory Inst1(
        .Address(PC), 
        .Instruction(Inst)
        );

        Control control1(.OpCode(Inst[31:26]), 
        .Funct(Inst[5:0]),
        .PCSrc(PCSrc), 
        .Branch(Branch), 
        .RegWrite(RegWrite), 
        .RegDst(RegDst), 
        .MemRead(MemRead),
        .MemWrite(MemWrite), 
        .MemtoReg(MemtoReg),
        .ALUSrc1(ALUSrc1),
        .ALUSrc2(ALUSrc2),
        .ExtOp(ExtOp), 
        .LuOp(LuOp));

        ALUControl control2(.op(Inst[31:26]),
        .fu(Inst[5:0]),
        .ct(ALUOp),
        .sign(sign1));

        assign Reg_writeAddr=(RegDst==2'b00)?Inst[15:11]:(RegDst==2'b01)?Inst[20:16]:5'b11111;//多路选择�?1，用于�?�择寄存器堆写入的地�?（rt，rd或ra�?

        RegisterFile Reg1(.reset(reset), 
        .clk(clk), 
        .RegWrite(RegWrite), 
        .Read_register1(Inst[25:21]), 
        .Read_register2(Inst[20:16]),
        .Write_register(Reg_writeAddr), 
        .Write_data(Reg_write2), 
        .Read_data1(Reg_out1), 
        .Read_data2(Reg_out2),
        .a0({number0,number1,number2,number3}),
        .v0({number4,number5,number6,number7}),
        .sp({number8,number9,number10,number11}),
        .ra({number12,number13,number14,number15})
        );
 
        assign Ext_out=(ExtOp)?{{16{Inst[15]}},Inst[15:0]}:{16'h0000,Inst[15:0]};    //多路选择�?2，用于�?�择是否为有符号拓展
 
        assign Lu_out=(LuOp)?{Inst[15:0],16'h0000}:Ext_out;//多路选择�?3，用于�?�择拓展数是lui指令�?要的�?16位拓展还是立即数拓展

        assign ALU_in1=(ALUSrc1)?{27'h0,Inst[10:6]}:Reg_out1;//多路选择�?4，用于�?�择ALU第一个输入是rs还是偏移�?

        assign ALU_in2=(ALUSrc2)?Lu_out:Reg_out2;//多路选择�?5，用于�?�择用于选择ALU第一个输入是rt还是拓展�?

        ALU ALU1(.in1(ALU_in1),
         .in2(ALU_in2), 
         .ct(ALUOp), 
         .sign(sign1), 
         .out(ALU_out), 
         .zero(Zero));

        DataMemory Mem(.reset(reset), 
        .clk(clk), 
        .Address(ALU_out), 
        .Write_data(Reg_out2), 
        .Read_data(Mem_Read), 
        .MemRead(MemRead), 
        .MemWrite(MemWrite));

        assign Reg_write1=(MemtoReg[0])?Mem_Read:ALU_out;//多路选择�?6，用于�?�择写入寄存器是内存的结果还是ALU的结�?

        assign Reg_write2=(MemtoReg[1])?PC4:Reg_write1;//多路选择�?7，用于�?�择寄存器是上面选择器的结果还是PC+4

        assign Jump_Addr={PC4[31:28],Inst[25:0],2'b00};
        
        assign Branch_Addr=(Branch&&Zero)? PC4+{Lu_out[29:0],2'b00}:PC4;//多路选择�?8，用于�?�择branch指令的下条指令是否跳�?

        assign PC_next=(PCSrc==2'b00)?PC4:(PCSrc==2'b01)?Branch_Addr:(PCSrc==2'b10)?Jump_Addr:Reg_out1;//多路选择�?9，用于�?�择下一条PC地址的来源（PC+4、Branch、j/jal、jr/jarl�?

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
        
        assign led[0]=PC[0];
        assign led[1]=PC[1];
        assign led[2]=PC[2];
        assign led[3]=PC[3];
        assign led[4]=PC[4];
        assign led[5]=PC[5];
        assign led[6]=PC[6];
        assign led[7]=PC[7];
        

        
    //--------------Your code above-----------------------

endmodule
	