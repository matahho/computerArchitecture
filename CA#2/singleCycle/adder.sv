module adder (input [31:0] a, b, input ci,output co, output [31:0] s);
	assign {co, s} = a + b + ci;
endmodule
