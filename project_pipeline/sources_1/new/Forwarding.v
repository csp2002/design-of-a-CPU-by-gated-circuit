`timescale 1ns / 1ps
module Forwarding
(
    input wire ID_EX_RegWrite,
    input wire [4:0] ID_EX_WriteAddress,
    input wire EX_MEM_RegWrite,
    input wire [4:0] EX_MEM_WriteAddress,
    input wire [4:0] rs,
    input wire [4:0] rt,
    input wire ID_EX_MemRead,

    output reg [1:0] ForwardA,     
    output reg [1:0] ForwardB,
    output reg lw_stall
);
always@(*)begin
if(ID_EX_RegWrite&&
(ID_EX_WriteAddress!=0)&&
(ID_EX_WriteAddress==rs)
)begin
ForwardA<=2'b01;
end
else if(EX_MEM_RegWrite&&
(EX_MEM_WriteAddress!=0)&&
(EX_MEM_WriteAddress==rs)
)
begin
ForwardA<=2'b10;
end
else ForwardA<=2'b0;

if(ID_EX_RegWrite&&
(ID_EX_WriteAddress!=0)&&
(ID_EX_WriteAddress==rt)
)begin
ForwardB<=2'b01;
end
else if(EX_MEM_RegWrite&&
(EX_MEM_WriteAddress!=0)&&
(EX_MEM_WriteAddress==rt)
)begin
ForwardB<=2'b10;
end
else ForwardB<=2'b0;

if(ID_EX_MemRead&&
((ID_EX_WriteAddress==rs)||(ID_EX_WriteAddress==rt))&&
(ID_EX_WriteAddress!=0)
)begin
lw_stall<=1;
end
else lw_stall<=0;
end

endmodule

