
module InstructionMemory(Address, Instruction);
	input [31:0] Address;
	output reg [31:0] Instruction;
	
	always @(*)
		case (Address[9:2])
			// addi $a0, $zero, 12123 #(0x2f5b)
			8'd0:    Instruction <= 32'h20040005;
                        // addiu $a1, $zero, -12345 #(0xcfc7)
                        8'd1:    Instruction <= 32'h00001026;
                        // sll $a2, $a1, 16
                        8'd2:    Instruction <= 32'h0c000004;
                        // sra $a3, $a2, 16
                        8'd3:    Instruction <= 32'h1000ffff;
                        // beq $a3, $a1, L1
                        8'd4:    Instruction <= 32'h23bdfff8;
                        // lui $a0, 22222 #(0x56ce)
                        8'd5:    Instruction <= 32'hafbf0004;
                        // L1:
                        // add $t0, $a2, $a0
                        8'd6:    Instruction <= 32'hafa40000;
                        // sra $t1, $t0, 8
                        8'd7:    Instruction <= 32'h28880001;
                        // addi $t2, $zero, -12123 #(0xd0a5)
                        8'd8:    Instruction <= 32'h11000002;
                        // slt $v0, $a0, $t2
                        8'd9:    Instruction <= 32'h23bd0008;
                        // sltu $v1, $a0, $t2
                        8'd10:   Instruction <= 32'h03e00008;
                        // Loop:
                        // j Loop
                        8'd11:   Instruction <= 32'h00821020;
                        8'd12:   Instruction <= 32'h2084ffff;
                        8'd13:   Instruction <= 32'h0c000004;
                        8'd14:   Instruction <= 32'h8fa40000;
                        8'd15:   Instruction <= 32'h8fbf0004;
                        8'd16:   Instruction <= 32'h23bd0008;
                        8'd17:   Instruction <= 32'h00821020;
                        8'd18:   Instruction <= 32'h03e00008;

			
			default: Instruction <= 32'h00000000;
		endcase
		
endmodule
