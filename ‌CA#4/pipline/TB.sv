module testbench();
    reg clk;
    reg rst;
    wire [31:0] WriteData, DataAdr;

    wire MemWrite;

    top toptop(clk, rst, WriteData, DataAdr, MemWrite);


	initial begin
	rst = 1'b1;
  #50 clk=1'b1;
  #100 rst = 1'b0;
	repeat(1000)#50 clk=~clk;
	end


endmodule
