module imem(input reg[31:0] adrs , output reg [31:0] ins);

	wire [31:0]pc ;
	assign pc = {2'b0,adrs[31:2]};
	reg [31:0] memreg[63:0];

	initial begin 
	 	$readmemb("code.txt",memreg);
  	end
  
	assign ins=memreg[pc];

	
endmodule
	
