
module Control(OpCode, Funct,
	PCSrc, Branch, RegWrite, RegDst, 
	MemRead, MemWrite, MemtoReg, 
	ALUSrc1, ALUSrc2, ExtOp, LuOp);
	input [5:0] OpCode;
	input [5:0] Funct;
	output [1:0] PCSrc;
	output Branch;
	output RegWrite;
	output [1:0] RegDst;
	output MemRead;
	output MemWrite;
	output [1:0] MemtoReg;
	output ALUSrc1;
	output ALUSrc2;
	output ExtOp;
	output LuOp;
	
	reg [1:0] PCSrc;
    reg Branch;
    reg RegWrite;
    reg [1:0] RegDst;
    reg MemRead;
    reg MemWrite;
    reg [1:0] MemtoReg;
    reg ALUSrc1;
    reg ALUSrc2;
    reg ExtOp;
    reg LuOp;	
	
	// Your code below
always @(*) begin
	PCSrc=2'b00;
	Branch=1'b0;
	RegWrite=1'b1;
	RegDst=2'b0;
	MemRead=1'b0;
	MemWrite=1'b0;
	MemtoReg=2'b00;
	ALUSrc1=1'b0;
	ALUSrc2=1'b0;
	ExtOp=1'b1;
	LuOp=1'b0;
	if(OpCode==6'h04) 
	begin
		PCSrc[0]=1;
		Branch=1;
	end

	if(OpCode==6'h02||OpCode==6'h03)
	begin
		PCSrc=2'b10;
	end

	if((OpCode==6'h0&&Funct==6'h08)||(OpCode==6'h0&&Funct==6'h09))
	begin
		PCSrc=2'b11;
	end

	if(OpCode==6'h2b||OpCode==6'h02||OpCode==6'h04||(OpCode==6'h0&&Funct==6'h08))
	begin
		RegWrite=1'b0;
	end

	if(OpCode==6'h23||OpCode==6'h2b||OpCode==6'h0f||OpCode==6'h08||OpCode==6'h09||OpCode==6'h0c||
	OpCode==6'h0a||OpCode==6'h0b)
	begin
		RegDst=2'b01;//dst=rt
		ALUSrc2=1'b1;
	end
	

	if(OpCode==6'h03||(OpCode==6'h0&&Funct==6'h09))
	begin
		RegDst=2'b10;//dst=$31
		MemtoReg=2'b10;//PC+4
	end

	if(OpCode==6'h23)
	begin
		MemRead=1'b1;
		MemtoReg=2'b01;
	end

	if(OpCode==6'h2b)
	begin
		MemWrite=1'b1;
	end

	if(OpCode==6'h0&&(Funct==6'h0||Funct==6'h02||Funct==6'h03))
	begin
		ALUSrc1=1'b1;
	end

	if(OpCode==6'h0c)
	begin
		ExtOp=1'b0;
	end

	if(OpCode==6'h0f)
	begin
		LuOp=1'b1;
	end

end
	// Your code above

	
endmodule