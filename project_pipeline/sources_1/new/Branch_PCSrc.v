`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/17 14:21:06
// Design Name: 
// Module Name: Branch_PCSrc
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


module Branch_PCSrc(
input wire [31:0] EX_PCjia4,
input wire [31:0] imm,
output wire [31:0] Branch_PC 
    );
    assign Branch_PC=EX_PCjia4+imm<<2;
endmodule
