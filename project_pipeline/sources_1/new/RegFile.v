`timescale 1ns / 1ps

module RegFile(
	input wire reset,
	input wire clk,
	input wire RegWrite,
	input wire [4:0] Read_Address1,
	input wire [4:0] Read_Address2,
	input wire [4:0] Write_Address,
	input wire [31:0] Write_data,
	output wire [31:0] s7,
	output wire [31:0] Read_data1,
	output wire [31:0] Read_data2
	);
	
	reg [31:0] RF_data[31:1];
	
	//先写后读
	assign Read_data1 = (Read_Address1 == 5'b00000)? 32'h00000000:RegWrite&&Write_Address==Read_Address1?Write_data: RF_data[Read_Address1];
	assign Read_data2 = (Read_Address2 == 5'b00000)? 32'h00000000:RegWrite&&Write_Address==Read_Address2?Write_data: RF_data[Read_Address2];
	assign s7=RF_data[23];
	integer i;
	always @(posedge reset or posedge clk) begin
		if (reset) begin
			for (i = 1; i < 4; i = i + 1) begin
				RF_data[i] <= 32'h00000000;
			end
			RF_data[4]<=32'd30; //字符串长度给$a0
			RF_data[5]<=32'd12;//字符串起始地址给$a1
			RF_data[6]<=32'd3;//模式串长度给$a2
			RF_data[7]<=32'd0;//模式串起始地址给$a3
			for (i = 8; i < 29; i = i + 1) begin
                            RF_data[i] <= 32'h00000000;
                        end
			RF_data[29]<=32'h000007fc;   //sp
			for(i=30;i<32;i=i+1)begin
			    RF_data[i]<=32'h00000000;
			end
		end else if (RegWrite && (Write_Address != 5'b00000)) begin
			RF_data[Write_Address] <= Write_data;
		end
	end

endmodule
			
