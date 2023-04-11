module multichoice(
clk,in,out,number0,number1,number2,number3,number4,number5,number6,number7
,number8,number9,number10,number11,number12,number13,number14,number15
    );
input [1:0]in,clk;
input [3:0]number0;
input [3:0]number1;
input [3:0]number2;
input [3:0]number3;
input [3:0]number4;
input [3:0]number5;
input [3:0]number6;
input [3:0]number7;
input [3:0]number8;
input [3:0]number9;
input [3:0]number10;
input [3:0]number11;
input [3:0]number12;
input [3:0]number13;
input [3:0]number14;
input [3:0]number15;
output [3:0]out;
reg[3:0] out;

always @(*)
begin
if(in==2'd0) begin
if(clk==2'd0) begin
out<=number0;
end

if(clk==2'd1) begin
out<=number1;
end

if(clk==2'd2) begin
out<=number2;
end

if(clk==2'd3) begin
out<=number3;
end

end

if(in==2'd1) begin
if(clk==2'd0) begin
out<=number4;
end

if(clk==2'd1) begin
out<=number5;
end

if(clk==2'd2) begin
out<=number6;
end

if(clk==2'd3) begin
out<=number7;
end

end

if(in==2'd2) begin
if(clk==2'd0) begin
out<=number8;
end

if(clk==2'd1) begin
out<=number9;
end

if(clk==2'd2) begin
out<=number10;
end

if(clk==2'd3) begin
out<=number11;
end

end

if(in==2'd3) begin
if(clk==2'd0) begin
out<=number12;
end

if(clk==2'd1) begin
out<=number13;
end

if(clk==2'd2) begin
out<=number14;
end

if(clk==2'd3) begin
out<=number15;
end

end
end
endmodule
