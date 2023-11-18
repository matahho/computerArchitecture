module extend(input reg [31:7] instr, input reg [2:0] immsrc, output reg [31:0] immext);
    parameter [2:0] JTYPE = 3'b000, STYPE = 3'b001, BTYPE = 3'b010, JAL = 3'b011, LUI = 3'b100;
    always @(*) begin
        case(immsrc)

            JTYPE: immext = {{20{instr[31]}}, instr[31:20]};


            STYPE: immext = {{20{instr[31]}}, instr[31:25], instr[11:7]};


            BTYPE: immext = {{20{instr[31]}}, instr[7], instr[30:25],instr[11:8], 1'b0};
            
            JAL: immext = {{12{instr[31]}}, instr[19:12], instr[20],instr[30:21], 1'b0};

            LUI: immext = {instr[31:12], 12'b0};


            default: immext = 32'bx;
            
        endcase
    end
endmodule
