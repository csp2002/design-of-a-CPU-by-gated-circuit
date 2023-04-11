
module ALUControl(
op,fu,ct,sign
    );
    input [5:0]op,fu;
    output [4:0]ct;
    output sign;
    reg [4:0]ct;
    reg sign;
    always @(*) begin
    if(op==6'h0) begin
    if(fu==6'h20) begin ct<=5'd0;sign<=1;end //add  //0=add
    if(fu==6'h21) begin ct<=5'd0;sign<=0;end //addu
    if(fu==6'h22) begin ct<=5'd1;sign<=1;end //sub  //1=sub 
    if(fu==6'h23) begin ct<=5'd1;sign<=0;end //subu
    if(fu==6'h24) begin ct<=5'd2;sign<=0;end //and  //2=and
    if(fu==6'h25) begin ct<=5'd3;sign<=0;end //or   //3=or
    if(fu==6'h26) begin ct<=5'd4;sign<=0;end //xor  //4=xor
    if(fu==6'h27) begin ct<=5'd5;sign<=0;end //nor  //5=nor
    if(fu==6'h0) begin ct<=5'd6;sign<=0;end  //sll  //6=sll
    if(fu==6'h02) begin ct<=5'd7;sign<=0;end //srl  //7=srl
    if(fu==6'h03) begin ct<=5'd8;sign<=1;end //sra  //8=sra
    if(fu==6'h2a) begin ct<=5'd9;sign<=1;end //slt  //9=slt
    if(fu==6'h2b) begin ct<=5'd10;sign<=0;end//sltu //10=sltu
    if(fu==6'h08||fu==6'h09) begin ct<=5'd12;sign<=0;end//jr   //12=jr/jalr
    end
    else begin
    if(op==6'h23) begin ct<=5'd0;sign<=1;end //lw
    if(op==6'h2b) begin ct<=5'd0;sign<=1;end //sw
    if(op==6'h0f) begin ct<=5'd13;sign<=0;end//lui  //13=lui
    if(op==6'h08) begin ct<=5'd0;sign<=1;end //addi
    if(op==6'h09) begin ct<=5'd0;sign<=0;end //addiu
    if(op==6'h0c) begin ct<=5'd2;sign<=0;end //andi
    if(op==6'h0a) begin ct<=5'd9;sign<=1;end //slti
    if(op==6'h0b) begin ct<=5'd10;sign<=0;end//sltiu
    if(op==6'h04) begin ct<=5'd11;sign<=0;end//beq  //11=beq
    //j,jal don't need ALU
    end
    end
endmodule

