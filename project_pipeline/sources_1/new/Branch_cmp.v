`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/16 15:56:15
// Design Name: 
// Module Name: Branch_cmp
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


module Branch_cmp(
input [2:0] Branch_cmp_ctrl,
input [31:0] Branch_cmp_in1,
input [31:0] Branch_cmp_in2,
output reg Branch_cmp_out
    );
    always@(*)begin
    case(Branch_cmp_ctrl)
    3'b000:  //非分支指令
    begin
    Branch_cmp_out<=0;
    end
    3'b001:  //beq
    begin
    if(Branch_cmp_in1==Branch_cmp_in2)begin
    Branch_cmp_out<=1;
    end
    else Branch_cmp_out<=0;
    end
    3'b010:  //bne
    begin
    if(Branch_cmp_in1==Branch_cmp_in2)begin
    Branch_cmp_out<=0;
    end
    else Branch_cmp_out<=1;
    end
    3'b011:begin  //blez
    if(Branch_cmp_in1==32'b0||Branch_cmp_in1[31]==1)begin
    Branch_cmp_out<=1;
    end
    else Branch_cmp_out<=0;
    end
    3'b100:begin  //bgtz
    if(Branch_cmp_in1[31]==0&&Branch_cmp_in1!=32'b0)begin
    Branch_cmp_out<=1;
    end
    else Branch_cmp_out<=0;
    end
    3'b101:begin   //bltz
    if(Branch_cmp_in1[31]==1&&Branch_cmp_in2[31]==0)
    Branch_cmp_out<=1;
    else if(Branch_cmp_in1[31]==0&&Branch_cmp_in2[31]==1)
    Branch_cmp_out<=0;
    else 
    Branch_cmp_out<=(Branch_cmp_in1<Branch_cmp_in2)?1:0;
    end
    endcase
    end
endmodule
