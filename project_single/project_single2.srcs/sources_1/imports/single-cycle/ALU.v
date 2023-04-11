
module ALU(in1, in2, ct, sign, out, zero);
	input [31:0] in1, in2;
	input [4:0] ct;
	input sign;
	output reg [31:0] out;
	output zero;
	reg zero;
	
	// Your code below
reg tmp;
always @(*) begin
zero=0;
if(ct==5'd0) begin out<=in1+in2;end 
if(ct==5'd1) begin out<=in1-in2;end 
if(ct==5'd2) begin out<=in1&in2;end 
if(ct==5'd3) begin out<=in1|in2;end 
if(ct==5'd4) begin out<=in1^in2;end 
if(ct==5'd5) begin out<=~(in1|in2);end 
if(ct==5'd6) begin out<=in2<<in1;end 
if(ct==5'd7) begin out<=in2>>in1;end 
if(ct==5'd8) begin out=$signed(in2)>>>in1;end 
if(ct==5'd9) begin if(in1[31]==1&&in2[31]==0) out<=1;
else if(in1[31]==0&&in2[31]==1) out<=0;
else out<=(in1<in2);
end 
if(ct==5'd10) begin out<=(in1<in2);end 
if(ct==5'd11) begin out<=in1-in2;zero<=(out==0);end
if(ct==5'd12) begin out<=in1;end 
if(ct==5'd13) begin out<=in2;end 

end
endmodule

	// Your code above
	
