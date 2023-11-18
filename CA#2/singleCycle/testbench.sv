`timescale 1ns/1ns

module testbench();

	reg clk,rst;
/*
	wire PCSrc , memWrite , AddSrc , AluSrc , Regwrite ;
	wire [2:0] AluControl , immSrc  ;
	wire [1:0] ResultSrc;*/

  wire [6:0]opcode; 
  
  TOP theTop(clk , rst , opcode);


	initial begin
	rst = 1'b1;
  #50 clk=1'b1;
  #100 rst = 1'b0;
	repeat(1000)#50 clk=~clk;
	end


endmodule 
