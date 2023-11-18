module regfile(input reg clk,input reg we3,input reg [4:0] add1, add2, add3,input reg [31:0] wd3,output reg [31:0] rd1, rd2);
    reg [31:0] rf[31:0];
    always @(negedge clk) begin
        if (we3) rf[add3] <= wd3;
    end



    assign rd1 = (add1 != 0) ? rf[add1] : 0;
    
    assign rd2 = (add2 != 0) ? rf[add2] : 0;
endmodule
