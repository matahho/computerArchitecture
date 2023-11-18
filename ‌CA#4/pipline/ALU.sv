module alu (input reg[31:0] SrcA, SrcB, input reg[2:0] ALUControl,
            output reg[31:0] ALUResult, output reg Zero);
    //parameter [2:0] ADD = 3'b000, SUB = 3'b001, AND = 3'b010, OR = 3'b011, XOR = 3'b100, SLT = 3'b101;

    wire [32:0] x; 
    always @(*) begin
        case (ALUControl)
            3'b000: ALUResult = SrcA + SrcB; 
            3'b001: ALUResult = SrcA - SrcB; 
            3'b010: ALUResult = SrcA & SrcB; 
            3'b011: ALUResult = SrcA | SrcB; 
            3'b100: ALUResult = SrcA ^ SrcB; 
            3'b101: ALUResult = {31'b0, x[32]};
            default: ALUResult = 32'bx;
        endcase
    end



    assign x = {SrcA[31], SrcA[31:0]} - {SrcB[31], SrcB[31:0]};





    assign Zero = (SrcA == SrcB) ? 1'b1 : 1'b0;

endmodule
