module top(input clk, reset,
    output [31:0] WriteDataM, DataAdrM,
    output MemWriteM);
    wire [31:0] PCF, InstrF, ReadDataM;
    // instantiate processor and memories
    riscv riscv(clk, reset, PCF, InstrF, MemWriteM, DataAdrM,
                WriteDataM, ReadDataM);
    imem imem(PCF, InstrF);
    dmem dmem(clk, MemWriteM, DataAdrM, WriteDataM, ReadDataM);
endmodule
