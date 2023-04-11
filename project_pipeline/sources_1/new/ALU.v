`timescale 1ns / 1ps
module ALU(ALUOp, in1, in2, Result);
    // Control Signals
    input [4:0] ALUOp;
   
    // Input Data Signals
    input [31:0] in1;
    input [31:0] in2;
    // Output 
    
    output reg [31:0] Result;
always@(*)
            begin
            if(ALUOp==5'b00000)begin  //加法
            Result<=in1+in2;
            end
            if(ALUOp==5'b00001)begin  //什么也不干
            Result<=0;
            end
            if(ALUOp==5'b00010)begin  //减法
            Result<=in1-in2;
            end
            if(ALUOp==5'b00011)begin  //按位与
            Result<=in1&in2;
            end
            if(ALUOp==5'b00100)begin  //按位或
            Result<=in1|in2;
            end
            if(ALUOp==5'b00101)begin  //按位异或
            Result<=in1^in2;
            end
            if(ALUOp==5'b00110)begin  //按位或非
            Result<=(~in1)&(~in2);
            end
            if(ALUOp==5'b00111)begin  //逻辑左移
            Result<=in2<<in1;
            end
            if(ALUOp==5'b01000)begin //逻辑右移
            Result<=in2>>in1;
            end
            if(ALUOp==5'b01001)begin  //算术右移
            Result<=({32{in2[31]}}<<(6'd32-{1'b0,in1[4:0]})|(in2>>in1[4:0]));
            end
            if(ALUOp==5'b01010)begin  //无符号比较
            Result<=(in1<in2)?1:0;  //小于则ALU输出1，反之输出0
            end
            if(ALUOp==5'b01011)begin  //有符号比较,小于则输出1，反之则输出0
            if(in1[31]==1&&in2[31]==0)
                Result<=1;
              else if(in1[31]==0&&in2[31]==1)
                Result<=0;
              else 
                Result<=(in1<in2)?1:0;
              
        
            end
      
            
            
            end

endmodule

