module regFile(input clk, regWrite, input[4:0] readReg1,readReg2, writeReg, input[31:0] writeData, output reg[31:0] regData1,regData2);
  	reg[0:31] regData[31:0];
	 wire[0:31] regData11[31:0];
	
	
	
	
	
	
  	always@(readReg1, regData[readReg1])begin
		regData[32'b0] = 32'b0;
    		if(readReg1 == 5'b0) regData1 <= 32'b0;
    		else regData1 <= regData[readReg1];
  	end
  	always@(readReg2, regData[readReg2])begin
		regData[32'b0] = 32'b0;
    		if(readReg2 == 5'b0) regData2 <= 32'b0;
    		else regData2 <= regData[readReg2];
  	end
  	always@(posedge clk) begin
		regData[32'b0] = 32'b0;
		if(regWrite) regData[writeReg] <= writeData;
  	end
	assign regData11 = regData;
endmodule


	
