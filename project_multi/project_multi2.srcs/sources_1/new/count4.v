module count4(clk,out,count,reset);
input clk,reset;
output [3:0]out;
reg [3:0]out;
output reg [1:0]count;
always @(negedge reset or posedge clk)
begin
if(reset) begin out<=4'b0001;count<=2'd0; end
else begin
if(out==4'b0001) out<=4'b0010;
if(out==4'b0010) out<=4'b0100;
if(out==4'b0100) out<=4'b1000;
if(out==4'b1000) out<=4'b0001;
if(count==2'd3) count<=2'd0;
else count<=count+1;
end
end
endmodule
