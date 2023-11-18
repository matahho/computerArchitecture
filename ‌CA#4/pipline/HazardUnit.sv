
module hazard(input reg [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW,
            input reg PCSrcE, ResultSrcEb0,
            input reg RegWriteM, RegWriteW,
            output reg [1:0] ForwardAE, ForwardBE,
            output reg StallF, StallD, FlushD, FlushE);

            
            reg lwStallD;





            always @(*) begin
                ForwardAE = 2'b00;
                ForwardBE = 2'b00;
                if (Rs1E != 5'b0) begin
                    if ((Rs1E == RdM) & RegWriteM) ForwardAE = 2'b10;
                    else if ((Rs1E == RdW) & RegWriteW) ForwardAE = 2'b01;
                end
                if (Rs2E != 5'b0) begin
                    if ((Rs2E == RdM) & RegWriteM) ForwardBE = 2'b10;
                    else if ((Rs2E == RdW) & RegWriteW) ForwardBE = 2'b01;
                end
            end





            assign lwStallD = ResultSrcEb0 & ((Rs1D == RdE) | (Rs2D == RdE));
            assign StallD = lwStallD;
            assign StallF = lwStallD;
            assign FlushD = PCSrcE;
            assign FlushE = lwStallD | PCSrcE;
            
endmodule
