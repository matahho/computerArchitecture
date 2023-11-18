module mux4to1_32bit (input[31:0] a , input[31:0]b, input[31:0]c , input[31:0]d,input[1:0] sel , output[31:0] out);
    
    	assign out = (sel== 2'b00) ? a : 
                (sel== 2'b01) ? b :
                (sel== 2'b10) ? c :
                (sel== 2'b11) ? d : 32'bz;
endmodule