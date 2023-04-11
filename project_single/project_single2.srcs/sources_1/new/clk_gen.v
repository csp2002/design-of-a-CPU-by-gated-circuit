module clk_gen(
    clk, 
    reset, 
    clk_10K
);

input           clk;
input           reset;
output          clk_10K;

reg             clk_10K;

parameter   CNT = 16'd5000;

reg     [15:0]  count;

always @(posedge clk or posedge reset)
begin
    if(reset) begin
        clk_10K <= 1'b0;
        count <= 16'd0;
    end
    else begin
        count <= (count==CNT-16'd1) ? 16'd0 : count + 16'd1;
        clk_10K <= (count==16'd0) ? ~clk_10K : clk_10K;
    end
end

endmodule

