`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Fundamentals of Digital Logic and Processor
// Designer: Shulin Zeng
// 
// Create Date: 2021/04/30
// Design Name: MultiCycleCPU
// Module Name: RegisterFile
// Project Name: Multi-cycle-cpu
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


module RegisterFile(reset, clk, RegWrite, Read_register1, Read_register2, Write_register, Write_data, Read_data1, Read_data2,a0,v0,sp,ra);
	//Input Clock Signals
	input reset;
	input clk;
	//Input Control Signals
	input RegWrite;
	//Input Data Signals
	input [4:0] Read_register1;
	input [4:0] Read_register2; 
	input [4:0] Write_register;
	input [31:0] Write_data;
	//Output Data Signals
	output [31:0] Read_data1;
	output [31:0] Read_data2;
	output [15:0]a0,v0,sp,ra;
	reg [31:0] RF_data[31:1];
   assign a0=RF_data[4][15:0];
    assign v0=RF_data[2][15:0];
    assign sp=RF_data[29][15:0];
    assign ra=RF_data[31][15:0];
	//read data
	assign Read_data1 = (Read_register1 == 5'b00000)? 32'h00000000: RF_data[Read_register1];
	assign Read_data2 = (Read_register2 == 5'b00000)? 32'h00000000: RF_data[Read_register2];
	
	integer i;
	always @(posedge reset or posedge clk) begin
		if (reset) begin
			for (i = 1; i < 32; i = i + 1) begin
				RF_data[i] <= 32'h00000000;
			end
		end else if (RegWrite && (Write_register != 5'b00000)) begin
			RF_data[Write_register] <= Write_data;
		end
	end

endmodule
			