module datapath(input reg clk, reset,
                input reg StallF,
                output [31:0] PCF,
                input reg [31:0] InstrF,
                output [6:0] opD,
                output [2:0] funct3D,
                output funct7b5D,
                input reg StallD, FlushD,
                input reg [2:0] ImmSrcD,
                input reg FlushE,
                input reg [1:0] ForwardAE, ForwardBE,
                input reg PCSrcE,
                input reg [2:0] ALUControlE,
                input reg ALUSrcAE, 
                input reg ALUSrcBE,
                output ZeroE, ALUResultEb31,
                input reg MemWriteM,
                output [31:0] WriteDataM, ALUResultM,
                input reg [31:0] ReadDataM,
                input reg RegWriteW,
                input reg [1:0] ResultSrcW,
                output [4:0] Rs1D, Rs2D, Rs1E, Rs2E,
                output [4:0] RdE, RdM, RdW);


    wire [31:0] PCNextF, PCPlus4F;





    wire [31:0] InstrD;
    wire [31:0] PCD, PCPlus4D;
    wire [31:0] RD1D, RD2D;
    wire [31:0] ImmExtD;
    wire [4:0] RdD;




    wire [31:0] RD1E, RD2E;
    wire [31:0] PCE, ImmExtE;
    wire [31:0] SrcAE, SrcBE;
    wire [31:0] SrcAEforward;
    wire [31:0] ALUResultE;
    wire [31:0] WriteDataE;
    wire [31:0] PCPlus4E;
    wire [31:0] PCTargetE;





    wire [31:0] PCPlus4M;





    wire [31:0] ALUResultW;
    wire [31:0] ReadDataW;
    wire [31:0] PCPlus4W;
    wire [31:0] ResultW;







    mux2 #(32) pcmux(PCPlus4F, PCTargetE, PCSrcE, PCNextF);
    flopenr #(32) pcreg(clk, reset, ~StallF, PCNextF, PCF);
    adder pcadd(PCF, 32'h4, PCPlus4F);





    flopenrc #(96) regD(clk, reset, FlushD, ~StallD,
                        {InstrF, PCF, PCPlus4F},
                        {InstrD, PCD, PCPlus4D});

    assign opD = InstrD[6:0];
    assign funct3D = InstrD[14:12];
    assign funct7b5D = InstrD[30];
    assign Rs1D = InstrD[19:15];
    assign Rs2D = InstrD[24:20];
    assign RdD = InstrD[11:7];
    assign ALUResultEb31 = ALUResultE[31];
    regfile rf(clk, RegWriteW, Rs1D, Rs2D, RdW, ResultW, RD1D, RD2D);
    extend ext(InstrD[31:7], ImmSrcD, ImmExtD);


    floprc #(175) regE(clk, reset, FlushE,
                    {RD1D, RD2D, PCD, Rs1D, Rs2D, RdD, ImmExtD, PCPlus4D},
                    {RD1E, RD2E, PCE, Rs1E, Rs2E, RdE, ImmExtE, PCPlus4E});
    mux3 #(32) faemux(RD1E, ResultW, ALUResultM, ForwardAE, SrcAEforward);
    mux2 #(32) srcamux(SrcAEforward, 32'b0, ALUSrcAE, SrcAE); 
    mux3 #(32) fbemux(RD2E, ResultW, ALUResultM, ForwardBE, WriteDataE);
    mux2 #(32) srcbmux(WriteDataE, ImmExtE, ALUSrcBE, SrcBE);
    alu alu(SrcAE, SrcBE, ALUControlE, ALUResultE, ZeroE);
    adder branchadd(ImmExtE, PCE, PCTargetE);


    flopr #(101) regM(clk, reset,
                    {ALUResultE, WriteDataE, RdE, PCPlus4E},
                    {ALUResultM, WriteDataM, RdM, PCPlus4M});







    flopr #(101) regW(clk, reset,
                    {ALUResultM, ReadDataM, RdM, PCPlus4M},
                    {ALUResultW, ReadDataW, RdW, PCPlus4W});
    mux3 #(32) resultmux(ALUResultW, ReadDataW, PCPlus4W, ResultSrcW,
                        ResultW);
endmodule
