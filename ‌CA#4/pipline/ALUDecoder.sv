module aludec(opb5,funct3,funct7b5,ALUOp,ALUControl);

    input reg opb5;
    input reg [2:0] funct3;
    input reg funct7b5;
    input reg [1:0] ALUOp;
    output reg [2:0] ALUControl;



    reg RtypeSub;
    assign RtypeSub = funct7b5 & opb5;


    always @(*) begin
        case(ALUOp)
        2'b00: ALUControl = 3'b000; /*adding*/
        2'b01: ALUControl = 3'b001; /* sub*/
        default: case(funct3) // R-type or I-type ALU
                3'b000: if (RtypeSub)
                    ALUControl = 3'b001;
                else
                    ALUControl = 3'b000; 
                3'b010: ALUControl = 3'b101;
                3'b100: ALUControl = 3'b100;
                3'b110: ALUControl = 3'b011; 

                3'b111: ALUControl = 3'b010; 

            endcase


        endcase
    end
endmodule
