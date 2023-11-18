module riscv(input reg clk, reset,
output [31:0] PCF,
input reg [31:0] InstrF,
output MemWriteM,
output [31:0] ALUResultM, WriteDataM,
input reg [31:0] ReadDataM);
wire [6:0] opD;
wire [2:0] funct3D;
wire funct7b5D;
wire [2:0] ImmSrcD;
wire ZeroE, ALUResultEb31;
wire PCSrcE;
wire [2:0] ALUControlE;
wire ALUSrcAE, ALUSrcBE;
wire ResultSrcEb0;
wire wireWriteM;
wire [1:0] ResultSrcW;
wire wireWriteW;
wire [1:0] ForwardAE, ForwardBE;
wire StallF, StallD, FlushD, FlushE;
wire [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW;
controller c(clk, reset,
            opD, funct3D, funct7b5D, ImmSrcD,
            FlushE, ZeroE, ALUResultEb31,PCSrcE, ALUControlE, ALUSrcAE, ALUSrcBE,
            ResultSrcEb0,
            MemWriteM, wireWriteM,
            wireWriteW, ResultSrcW);
datapath dp(clk, reset,
            StallF, PCF, InstrF,
            opD, funct3D, funct7b5D, StallD, FlushD, ImmSrcD,
            FlushE, ForwardAE, ForwardBE, PCSrcE, ALUControlE,
            ALUSrcAE, ALUSrcBE, ZeroE, ALUResultEb31,
            MemWriteM, WriteDataM, ALUResultM, ReadDataM,
            wireWriteW, ResultSrcW,
            Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW);
hazard hu(Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW,
        PCSrcE, ResultSrcEb0, wireWriteM, wireWriteW,
        ForwardAE, ForwardBE, StallF, StallD, FlushD, FlushE);
endmodule
