module mux2to1_32bit (input[31:0] a , input[31:0]b ,input sel , output[31:0] out);
    
    	assign out = (sel== 1'b0) ? a : b ;
endmodule