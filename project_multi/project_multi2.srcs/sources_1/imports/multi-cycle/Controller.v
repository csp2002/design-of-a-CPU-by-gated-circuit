`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Class: Fundamentals of Digital Logic and Processor
// Designer: Shulin Zeng, Shang Yang
// 
// Create Date: 2021/04/30
// Design Name: MultiCycleCPU
// Module Name: Controller
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


module Controller(reset, clk, OpCode, Funct, 
                PCWrite, PCWriteCond, IorD, MemWrite, MemRead,
                IRWrite, MemtoReg, RegDst, RegWrite, ExtOp, LuiOp,
                ALUSrcA, ALUSrcB, ALUOp, PCSource,sign);
    //Input Clock Signals
    input reset;
    input clk;
    //Input Signals
    input  [5:0] OpCode;
    input  [5:0] Funct;
    //Output Control Signals
    output reg PCWrite;
    output reg PCWriteCond;
    output reg IorD;
    output reg MemWrite;
    output reg MemRead;
    output reg IRWrite;
    output reg [1:0] MemtoReg;
    output reg [1:0] RegDst;
    output reg RegWrite;
    output reg ExtOp;
    output reg LuiOp;
    output reg [1:0] ALUSrcA;
    output reg [1:0] ALUSrcB;
    output reg [4:0] ALUOp;
    output reg [1:0] PCSource;
    output reg sign;
      
     reg [2:0] state; //current state
     reg [2:0] next_state; //next_state
     parameter sIF = 3'b0 ,sID = 3'b1; 
     
    //--------------Your code below-----------------------

    always @(posedge reset or posedge clk) 
    begin
        if (reset) 
            begin
                state <= 3'b0;
                next_state <=3'b0;
                PCWrite <= 1'b0;
                PCWriteCond <= 1'b0;
                IorD <= 1'b0;
                MemWrite <= 1'b0;
                MemRead <= 1'b0;
                IRWrite <= 1'b0;
                MemtoReg <= 2'b00;
                RegDst <= 2'b0;
                RegWrite <= 1'b0;
                ExtOp <= 1'b0;
                LuiOp <= 1'b0;
                ALUSrcA <= 2'b0;
                ALUSrcB <= 2'b0;
                PCSource <=2'b0;
            end
        else
        begin
            if (next_state == sIF) 
                begin
                    
                    state <= next_state;
                    next_state <= next_state + 3'b1;
                    
                    MemRead <= 1'b1;
                    IRWrite <= 1'b1;
                    PCWrite <= 1'b1;
                    PCSource <= 2'b00;
                    ALUSrcA <= 2'b00;//PC
                    IorD <= 1'b0;
                    ALUSrcB <= 2'b01;//4
        
                    PCWriteCond <= 1'b0;
                    MemWrite <= 1'b0;
                    MemtoReg <= 2'b00;
                    RegDst <= 2'b0;
                    RegWrite <= 1'b0;
                    ExtOp <= 1'b0;
                    LuiOp <= 1'b0;
                end
                
            else if (next_state == sID) 
                begin
                    state <= next_state;
                    next_state <= next_state + 3'b1;
                    ALUSrcA <= 2'b00;
                    ALUSrcB <= 2'b11;//拓展    
                    ExtOp <= 1'b1;
                    
                    PCWrite <= 1'b0;
                    PCWriteCond <= 1'b0;
                    IorD <= 1'b0;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    IRWrite <= 1'b0;
                    MemtoReg <= 2'b00;
                    RegDst <= 2'b0;
                    RegWrite <= 1'b0;
                    LuiOp <= 1'b0;
                    PCSource <=2'b0;
                end
            else if (next_state == 3'd2) 
                begin
                    state <= next_state;
                    case(OpCode)
                        6'h00: 
                            begin
                                ALUSrcA <= (Funct==6'h00 || Funct==6'h02 || Funct==6'h03 ) ? 2'b10 : 2'b01; 
                                //sll,sra,srl=rt,其他=rs
                                ALUSrcB <= 2'b00;                       
                                case(Funct)
                                    6'h08:      
                                        begin
                                            PCSource <= 2'b00;//jr
                                            PCWrite  <= 1'b1;
                                            next_state <= sIF;
                                        end
                                    6'h09:        
                                        begin
                                            PCSource <= 2'b00;//jalr
                                            PCWrite  <= 1'b1;
                                            next_state <= sIF;
                                            
                                            RegDst <= 2'b01;//01=rd   
                                            MemtoReg <= 2'b10;//PC+4
                                            RegWrite <= 1'b1;
                                        end
                                    default:
                                        begin
                                            next_state <= next_state + 3'b1;
                                        end
                                endcase
                            end
                        6'h23,6'h2b,6'h0f,6'h08,6'h09,6'h0c,6'h0b,6'h0a:      
                            begin
                                ALUSrcA <= 2'b01;   
                                ALUSrcB <= 2'b10;//imm   
                                ExtOp <=((OpCode==6'h0c)? 0 : 1);      
                                LuiOp <=((OpCode==6'h0f)? 1 : 0);      
                                next_state <= next_state +3'b1;
                            end
                        6'h04: 
                            begin
                                PCWriteCond <= 1'b1;
                                ALUSrcA <= 2'b01;
                                ALUSrcB <= 2'b00;
                                PCSource <= 2'b01;
                                next_state <= sIF;
                            end
                        6'h02: 
                            begin
                                PCWrite <= 1'b1;//jump
                                PCSource <= 2'b10;
                                next_state <= sIF;
                            end
                        6'h03: 
                            begin
                                PCWrite <= 1'b1;
                                PCSource <= 2'b10;
                                                               
                                RegDst <=  2'b10;//10=$31   
                                MemtoReg <= 2'b10;//10=PC+4
                                RegWrite <= 1'b1;
                                
                                next_state <= sIF;
                            end 
                        default: 
                            begin
                                next_state <= sIF;
                            end
                    endcase
                end
            else if (next_state == 3'd3) 
                begin
                    state<=next_state;
                    case(OpCode)
                        6'h00: 
                            begin
                                RegWrite <= 1'b1;
                                RegDst <= 2'b01;//rd
                                MemtoReg <= 2'b01;//aluout
                                next_state <= sIF;
                            end
                        6'h2b:      
                            begin
                                MemWrite<=1'b1;
                                IorD <=1'b1;
                                next_state <= sIF;
                            end
                        6'h08,6'h09,6'h0c,6'h0b,6'h0a,6'h0f:      
                            begin
                                RegWrite <= 1'b1;
                                RegDst <= 2'b00;//rt
                                MemtoReg <= 2'b01;
                                next_state <= sIF;
                            end
                        6'h23:      
                            begin
                                MemRead <= 1'b1;
                                IorD <= 1'b1;
                                IRWrite <=1'b0;
                                next_state <= next_state +3'b001;
                            end
                        default: 
                            begin
                                next_state <= sIF;
                            end
                    endcase
        
                end
            else if (next_state == 3'd4) 
                begin
                    state<=next_state;
                    case(OpCode)
                        6'h23: 
                            begin
                                RegWrite <= 1'b1;
                                RegDst <= 2'b00;
                                MemtoReg <= 2'b00;//mem
                                next_state <= sIF;
                            end
                        default: 
                            begin
                                next_state <= sIF;
                            end
                    endcase
                 end
         end
    end
    
    
    //--------------Your code below-----------------------
    //ALUOp
     always @(posedge reset or posedge clk) 
    begin
        if(reset) ALUOp<=5'd0;
        else begin
            if(next_state==sIF) begin
             ALUOp<=5'd0;       
        end
            if(next_state==sID) begin
             ALUOp<=5'd0; 
        end
            if(next_state==3'd2) begin
                    if(OpCode==6'h0) begin
                        if(Funct==6'h20) begin ALUOp<=5'd0;sign<=1;end //add  //0=add
                        if(Funct==6'h21) begin ALUOp<=5'd0;sign<=0;end //addu
                        if(Funct==6'h22) begin ALUOp<=5'd1;sign<=1;end //sub  //1=sub 
                        if(Funct==6'h23) begin ALUOp<=5'd1;sign<=0;end //subu
                        if(Funct==6'h24) begin ALUOp<=5'd2;sign<=0;end //and  //2=and
                        if(Funct==6'h25) begin ALUOp<=5'd3;sign<=0;end //or   //3=or
                        if(Funct==6'h26) begin ALUOp<=5'd4;sign<=0;end //xor  //4=xor
                        if(Funct==6'h27) begin ALUOp<=5'd5;sign<=0;end //nor  //5=nor
                        if(Funct==6'h0)  begin ALUOp<=5'd6;sign<=0;end //sll  //6=sll
                        if(Funct==6'h02) begin ALUOp<=5'd7;sign<=0;end //srl  //7=srl
                        if(Funct==6'h03) begin ALUOp<=5'd8;sign<=1;end //sra  //8=sra
                        if(Funct==6'h2a) begin ALUOp<=5'd9;sign<=1;end //slt  //9=slt
                        if(Funct==6'h2b) begin ALUOp<=5'd10;sign<=0;end//sltu //10=sltu
                        if(Funct==6'h08||Funct==6'h09) begin ALUOp<=5'd12;sign<=0;end//jr   //12=jr/jalr
                        end
                    else begin
                        if(OpCode==6'h23) begin ALUOp<=5'd0;sign<=1;end //lw
                        if(OpCode==6'h2b) begin ALUOp<=5'd0;sign<=1;end //sw
                        if(OpCode==6'h0f) begin ALUOp<=5'd13;sign<=0;end//lui  //13=lui
                        if(OpCode==6'h08) begin ALUOp<=5'd0;sign<=1;end //addi
                        if(OpCode==6'h09) begin ALUOp<=5'd0;sign<=0;end //addiu
                        if(OpCode==6'h0c) begin ALUOp<=5'd2;sign<=0;end //andi
                        if(OpCode==6'h0a) begin ALUOp<=5'd9;sign<=1;end //slti
                        if(OpCode==6'h0b) begin ALUOp<=5'd10;sign<=0;end//sltiu
                        if(OpCode==6'h04) begin ALUOp<=5'd11;sign<=0;end//beq  //11=beq
                        end
    end
    end
    end
    //--------------Your code above-----------------------

endmodule