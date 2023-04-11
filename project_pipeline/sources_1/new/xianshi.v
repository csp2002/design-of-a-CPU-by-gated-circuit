`timescale 1ns / 1ps

module xianshi(
input wire pose,
input wire [31:0] s7,
output reg [15:0] out0
    );
    reg [15:0] out_an0;
    reg [15:0] out_an1;
    reg [15:0] out_an2;
    reg [15:0] out_an3;
    reg [1:0] state;
    always@(*)begin
    case(s7[3:0])
        4'd0: out_an0<=16'h013f;
        4'd1: out_an0<=16'h0106;
        4'd2: out_an0<=16'h015b;
        4'd3: out_an0<=16'h014f;
        4'd4: out_an0<=16'h0166;
        4'd5: out_an0<=16'h0167;
        4'd6: out_an0<=16'h017d;
        4'd7: out_an0<=16'h0107;
        4'd8: out_an0<=16'h017f;
        4'd9: out_an0<=16'h016f;
        4'd10: out_an0<=16'h0177;
        4'd11: out_an0<=16'h017c;
        4'd12: out_an0<=16'h0139;
        4'd13: out_an0<=16'h015e;
        4'd14: out_an0<=16'h017b;
        4'd15: out_an0<=16'h0171;
        endcase
    case(s7[7:4])
            4'd0: out_an1<=16'h023f;
            4'd1: out_an1<=16'h0206;
            4'd2: out_an1<=16'h025b;
            4'd3: out_an1<=16'h024f;
            4'd4: out_an1<=16'h0266;
            4'd5: out_an1<=16'h0267;
            4'd6: out_an1<=16'h027d;
            4'd7: out_an1<=16'h0207;
            4'd8: out_an1<=16'h027f;
            4'd9: out_an1<=16'h026f;
            4'd10: out_an1<=16'h0277;
            4'd11: out_an1<=16'h027c;
            4'd12: out_an1<=16'h0239;
            4'd13: out_an1<=16'h025e;
            4'd14: out_an1<=16'h027b;
            4'd15: out_an1<=16'h0271;
            endcase    
    case(s7[11:8])
                4'd0: out_an2<=16'h043f;
                4'd1: out_an2<=16'h0406;
                4'd2: out_an2<=16'h045b;
                4'd3: out_an2<=16'h044f;
                4'd4: out_an2<=16'h0466;
                4'd5: out_an2<=16'h0467;
                4'd6: out_an2<=16'h047d;
                4'd7: out_an2<=16'h0407;
                4'd8: out_an2<=16'h047f;
                4'd9: out_an2<=16'h046f;
                4'd10: out_an2<=16'h0477;
                4'd11: out_an2<=16'h047c;
                4'd12: out_an2<=16'h0439;
                4'd13: out_an2<=16'h045e;
                4'd14: out_an2<=16'h047b;
                4'd15: out_an2<=16'h0471;
                endcase  
    case(s7[15:12])       
    4'd0: out_an3<=16'h083f;
    4'd1: out_an3<=16'h0806;
    4'd2: out_an3<=16'h085b;
    4'd3: out_an3<=16'h084f;
    4'd4: out_an3<=16'h0866;
    4'd5: out_an3<=16'h0867;
    4'd6: out_an3<=16'h087d;
    4'd7: out_an3<=16'h0807;
    4'd8: out_an3<=16'h087f;
    4'd9: out_an3<=16'h086f;
    4'd10: out_an3<=16'h0877;
    4'd11: out_an3<=16'h087c;
    4'd12: out_an3<=16'h0839;
    4'd13: out_an3<=16'h085e;
    4'd14: out_an3<=16'h087b;
    4'd15: out_an3<=16'h0871;
    endcase          
    end
    always@(posedge pose)begin
    if(state==2'b00)begin
    state<=2'b01;
    out0<=out_an0;
    end
    else if(state==2'b01)begin
    state<=2'b10;
    out0<=out_an1;
    end
    else if(state==2'b10)begin
    state<=2'b11;
    out0<=out_an2;
    end
    else if(state==2'b11)begin
    state<=2'b00;
    out0<=out_an3;
    end
    else state=2'b00;
    end
endmodule
