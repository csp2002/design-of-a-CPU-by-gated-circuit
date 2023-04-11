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
            if(ALUOp==5'b00000)begin  //�ӷ�
            Result<=in1+in2;
            end
            if(ALUOp==5'b00001)begin  //ʲôҲ����
            Result<=0;
            end
            if(ALUOp==5'b00010)begin  //����
            Result<=in1-in2;
            end
            if(ALUOp==5'b00011)begin  //��λ��
            Result<=in1&in2;
            end
            if(ALUOp==5'b00100)begin  //��λ��
            Result<=in1|in2;
            end
            if(ALUOp==5'b00101)begin  //��λ���
            Result<=in1^in2;
            end
            if(ALUOp==5'b00110)begin  //��λ���
            Result<=(~in1)&(~in2);
            end
            if(ALUOp==5'b00111)begin  //�߼�����
            Result<=in2<<in1;
            end
            if(ALUOp==5'b01000)begin //�߼�����
            Result<=in2>>in1;
            end
            if(ALUOp==5'b01001)begin  //��������
            Result<=({32{in2[31]}}<<(6'd32-{1'b0,in1[4:0]})|(in2>>in1[4:0]));
            end
            if(ALUOp==5'b01010)begin  //�޷��űȽ�
            Result<=(in1<in2)?1:0;  //С����ALU���1����֮���0
            end
            if(ALUOp==5'b01011)begin  //�з��űȽ�,С�������1����֮�����0
            if(in1[31]==1&&in2[31]==0)
                Result<=1;
              else if(in1[31]==0&&in2[31]==1)
                Result<=0;
              else 
                Result<=(in1<in2)?1:0;
              
        
            end
      
            
            
            end

endmodule

