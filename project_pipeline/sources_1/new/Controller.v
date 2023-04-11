`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/16 15:37:17
// Design Name: 
// Module Name: Controller
// Project Name: 
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


module Controller(
   input  [5:0] OpCode,
   input  [5:0] Funct,
   output reg RegWrite,
   output reg Branch,
   output reg  [2:0] Branch_cmp_ctrl,  //控制分支判断比较器该如何比较
   output reg Jump,
   output reg MemRead,
   output reg MemWrite,
   output reg [1:0] MemtoReg,
   output reg JumpSrc,
   output reg ALUSrc1,
   output reg ALUSrc2,
   output reg [4:0] ALUOp,
   output reg [1:0] RegDst,
   output reg LuiOp,
   output reg ExtOp
    );
    always@(*)begin
    //分支，Branch,Branch_cmp_control
    if(OpCode==6'h04||OpCode==6'h05||OpCode==6'h06||OpCode==6'h07||OpCode==6'h01)begin
    Branch<=1;
    end
    else begin
    Branch<=0;
    end
    if(OpCode==6'h04)begin //beq
    Branch_cmp_ctrl<=3'b001;
    end
    else if(OpCode==6'h05)begin //bne
    Branch_cmp_ctrl<=3'b010;
    end
    else if(OpCode==6'h06)begin //blez
    Branch_cmp_ctrl<=3'b011;
    end
    else if(OpCode==6'h07)begin //bgtz
    Branch_cmp_ctrl<=3'b100;
    end
    else if(OpCode==6'h01)begin //bltz
    Branch_cmp_ctrl<=3'b101;
    end
    else begin
    Branch_cmp_ctrl<=3'b000;
    end
    //RegWrite
    if(OpCode==0)begin
    if(Funct==6'h08)begin  //jr
    RegWrite<=0;
    end
    else RegWrite<=1;
    end
    else begin
    case(OpCode)
    6'h0f,6'h0a,6'h0b,6'h03,6'h08,6'h09,6'h0c,6'h23:RegWrite<=1;
    default:RegWrite<=0;
    endcase
    end
    //RegDst
    case(OpCode)
    6'h23,6'h0f,6'h08,6'h09,6'h0c,6'h0a,6'h0b:RegDst<=2'b01;//I型和lw
    6'h03:RegDst<=2'b10;  //jal
    default:RegDst<=2'b00;
    endcase
    
    //MemRead
    MemRead<=OpCode==6'h23;  //lw
    //MemWrite
    MemWrite<=OpCode==6'h2b; //sw
    //MemtoReg
    if(OpCode==6'h23) MemtoReg<=2'b01;  //lw
    else if(OpCode==6'h03||(OpCode==6'h0&&Funct==6'h09)) MemtoReg<=2'b10; //jal,jalr
    else MemtoReg<=2'b00;
    //ALUSrc1
    if(OpCode==6'h0&&(Funct==6'h0||Funct==6'h02||Funct==6'h03))
    ALUSrc1<=1;
    else ALUSrc1<=0;
    //ALUSrc2
    case(OpCode)
    6'h23,6'h2b,6'h0f,6'h08,6'h09,6'h0c,6'h0a,6'h0b:ALUSrc2<=1;
    default:ALUSrc2<=0;
    endcase
    //ExtOp
    if(OpCode==6'h0c) ExtOp<=0;  //andi
    else ExtOp<=1;
    //LuOp
    if(OpCode==6'h0f) LuiOp<=1;  //lui
    else LuiOp<=0;
    //ALUOp
    case(OpCode)
    6'h0:begin
       case(Funct)
       6'h2a:ALUOp<=5'b01011; //slt
       6'h2b:ALUOp<=5'b01010;  //sltu
       6'h20,6'h21:ALUOp<=5'b00000;  //add,addu
       6'h22,6'h23:ALUOp<=5'b00010;  //sub,subu
       6'h24:ALUOp<=5'b00011;  //and
       6'h25:ALUOp<=5'b00100; //or
       6'h26:ALUOp<=5'b00101; //xor
       6'h27:ALUOp<=5'b00110; //nor
       6'h00:ALUOp<=5'b00111; //sll
       6'h02:ALUOp<=5'b01000; //srl
       6'h03:ALUOp<=5'b01001; //sra
       default:ALUOp<=5'b00001;
       endcase
       end
    6'h0f,6'h08,6'h09,6'h23,6'h2b:ALUOp<=5'b00000;  //lw,sw,lui,addi,addiu
    6'h0c:ALUOp<=5'b00011;  //andi
    6'h0a:ALUOp<=5'b01011;  //slti
    6'h0b:ALUOp<=5'b01010;  //sltiu
    default:ALUOp<=5'b00001;
    endcase
    //Jump
    if((OpCode==0&&(Funct==6'h08||Funct==6'h09))||(OpCode==6'h02||OpCode==6'h03))begin
    Jump<=1;
    JumpSrc<=OpCode==0;
    end
    else Jump<=0;
    //JumpSrc
    
    
    
    
    
    end
    
    
    
    
endmodule
