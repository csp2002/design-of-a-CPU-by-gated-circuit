`timescale 1ns / 1ps
module BranchandJump(
input wire Branch_cmp_out,
input wire Jump,
output wire IF_ID_flush,
output wire ID_EX_flush
    );
    assign IF_ID_flush=Branch_cmp_out||Jump;
    assign ID_EX_flush=Branch_cmp_out;
endmodule
