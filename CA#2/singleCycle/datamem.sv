

module datamem(input clk , input[31:0] address,writedata, input memWrite, output[31:0] readdata);
  	reg[31:0] memData[2047:0];
  	initial begin
    	$readmemb("array.txt", memData);
  	end
  	always@(posedge clk)begin
    		if(memWrite) memData[address] = writedata;
  	end
  	assign readdata = memData[address] ;

endmodule
