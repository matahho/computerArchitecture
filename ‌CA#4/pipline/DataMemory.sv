module dmem(clk, writeEn, a, wd,rd);

input reg clk, writeEn;
input reg [31:0] a, wd;
output reg [31:0] rd;


    reg [31:0] dataReg[63:0];
    assign rd = dataReg [a[31:2]]; 
    always @(posedge clk) begin


        if (writeEn) dataReg[a[31:2]] <= wd;
    end


    
endmodule
