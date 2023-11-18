module controller(input reg clk, reset,
                // Decode stage control signals
                input reg [6:0] opD,
                input reg [2:0] funct3D,
                input reg funct7b5D,
                output [2:0] ImmSrcD,
                // Execute stage control signals
                input reg FlushE,
                input reg ZeroE, ALUResultEb31,
                output PCSrcE, // for datapath and Hazard Unit
                output [2:0] ALUControlE,
                output ALUSrcAE,
                output ALUSrcBE, // for lui
                output ResultSrcEb0, // for Hazard Unit
                // Memory stage control signals
                output MemWriteM,
                output RegWriteM, // for Hazard Unit
                // Writeback stage control signals
                output RegWriteW, // for datapath and Hazard Unit
                output [1:0] ResultSrcW);
                // pipelined control signals
    parameter [2:0] BEQ = 000, BNE = 001, BLT = 100, BGE = 101;
    wire RegWriteD, RegWriteE;
    wire [1:0] ResultSrcD, ResultSrcE, ResultSrcM;
    wire MemWriteD, MemWriteE;
    wire JumpD, JumpE;
    wire BranchD, BranchE;
    wire [1:0] ALUOpD;
    wire [2:0] ALUControlD;
    wire ALUSrcAD;
    wire ALUSrcBD; // for lui
    // Decode stage wire
    reg BranchResE;
    maindec md(opD, ResultSrcD, MemWriteD, BranchD,
    ALUSrcAD, ALUSrcBD, RegWriteD, JumpD, ImmSrcD, ALUOpD);
    aludec ad(opD[5], funct3D, funct7b5D, ALUOpD, ALUControlD);
    // Execute stage pipeline control register and wire
    floprc #(11) controlregE(clk, reset, FlushE,
                            {RegWriteD, ResultSrcD, MemWriteD, JumpD, BranchD,
                            ALUControlD, ALUSrcAD, ALUSrcBD},
                            {RegWriteE, ResultSrcE, MemWriteE, JumpE, BranchE,
                            ALUControlE, ALUSrcAE, ALUSrcBE});
    always @(*) begin
        case (funct3D)
            BEQ: BranchResE = BranchE & ZeroE;
            BNE: BranchResE = BranchE & (~ZeroE);
            BLT: BranchResE = BranchE & (~ALUResultEb31);
            BGE: BranchResE = BranchE & (ALUResultEb31);
            default: BranchResE = 1'b0; // Assign a default value in case none of the above conditions are satisfied.
        endcase
    end
    assign PCSrcE = BranchResE | JumpE;
    assign ResultSrcEb0 = ResultSrcE[0];
    // Memory stage pipeline control register
    flopr #(4) controlregM(clk, reset,
                        {RegWriteE, ResultSrcE, MemWriteE},
                        {RegWriteM, ResultSrcM, MemWriteM});
    // Writeback stage pipeline control register
    flopr #(3) controlregW(clk, reset,
                        {RegWriteM, ResultSrcM},
                        {RegWriteW, ResultSrcW});
endmodule
