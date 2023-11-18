
module flopenrc #(parameter WIDTH = 8)
            (input reg clk, reset, clear, en,
            input reg [WIDTH-1:0] d,
            output reg [WIDTH-1:0] q);
    always @(posedge clk, posedge reset) begin
        if (reset) q <= 0;
        else if (en)
        if (clear) q <= 0;
        else q <= d;
    end
endmodule