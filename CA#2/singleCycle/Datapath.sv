module Datapath(input clk,rst,PCSrc,input[1:0] ResultSrc,input memWrite,input[2:0] AluControl,input AddSrc,AluSrc,input[2:0] immSrc,input Regwrite,output[6:0]opcode , output[2:0] func3,output[6:0]func7 , output z );


	wire [31:0] pcnext , thepc;
	wire [31:0] ins , InForAdd;

	wire [31:0] RD1 , RD2 ;
	wire [31:0] srcB , immOut , AluOut , MD , AdderOut , WD , NewPC;

	assign inadrs = 32'b0;

	wire[31:0]pcPlus4 , pctarget ; 
 	


	mux2to1_32bit inputOfPC (NewPC , AdderOut , PCSrc , pcnext);

	pc programCounter (clk,rst,pcnext, thepc);

	wire co1;
	adder Adder1 (thepc, 32'd4, 1'b0, co1, NewPC);
 	insmem instructionMemory (thepc, ins);


	regFile registerFile (clk, Regwrite,ins[19:15], ins[24:20], ins[11:7], WD, RD1, RD2);


	ImmExtend Extend (immSrc , ins[31:7] , immOut);


	mux2to1_32bit inputOfAdderWithImm (RD1 , thepc , AddSrc , InForAdd);

	mux2to1_32bit aluSelB (RD2 , immOut , AluSrc , srcB);
	  

	wire coOfPcAndImm;
	adder pcAndImm(InForAdd, immOut ,1'b0,coOfPcAndImm, AdderOut);


	ALU ALU1 (RD1, srcB, AluControl, z, AluOut);

	datamem DataMemory(clk ,AluOut,RD2,memWrite,MD);


	mux4to1_32bit inputOfReg (AluOut, MD , immOut , NewPC , ResultSrc , WD);

	assign opcode = ins[6:0];
	assign func3 = ins[14:12];
	assign func7 = ins[31:25];
endmodule
