module ALU(input [31:0] a , b ,input [2:0] aluop ,output z ,output[31:0] o);


	assign o = (aluop == 3'b000) ? (a + b) :	
		   (aluop == 3'b001) ? (a - b) :
		   (aluop == 3'b010) ? (a & b) :
		   (aluop == 3'b011) ? (a | b) : 
		   (aluop == 3'b100) ? (a < b) : 31'bz;


	assign z = (o == 32'b0) ? 1 : 0;


endmodule
			
