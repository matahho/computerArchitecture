module mux2 #(parameter WIDTH = 8) (input reg [WIDTH - 1:0] d0, d1,
                                    input reg s,
                                    output reg [WIDTH - 1:0] y);
    assign y = s ? d1 : d0;
endmodule
