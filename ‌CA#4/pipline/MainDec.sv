module maindec(input reg [6:0] op,
                output reg [1:0] ResultSrc,
                output reg MemWrite,
                output reg Branch,
                output reg ALUSrcA, // for lui
                output reg ALUSrcB,
                output reg RegWrite, Jump,
                output reg [2:0] ImmSrc,
                output reg [1:0] ALUOp);

                
    reg [12:0] controls;
    assign {RegWrite, ImmSrc, ALUSrcA, ALUSrcB, MemWrite,
            ResultSrc, Branch, ALUOp, Jump} = controls;


    always @(*) begin
        case(op)
            7'b0000011: controls = 13'b1_000_0_1_0_01_0_00_0; 
            7'b0100011: controls = 13'b0_001_0_1_1_00_0_00_0; 
            7'b0110011: controls = 13'b1_xxx_0_0_0_00_0_10_0; 
            7'b1100011: controls = 13'b0_010_0_0_0_00_1_01_0; 
            7'b0010011: controls = 13'b1_000_0_1_0_00_0_10_0; //I-type ALU
            7'b1101111: controls = 13'b1_011_0_0_0_10_0_00_1; //jal
            7'b0110111: controls = 13'b1_100_1_1_0_00_0_00_0; //lui
            7'b0000000: controls = 13'b0_000_0_0_0_00_0_00_0; 

            default: controls = 13'bx_xxx_x_x_x_xx_x_xx_x;
 
        endcase
    end
endmodule