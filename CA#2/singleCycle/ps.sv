module pc(input clk,rst,input [31:0]inadrs,output [31:0] outadrs);

	reg [31:0]buff;
	always @(posedge clk ,posedge rst) begin
		if(rst)
			buff<=32'b0;
		else
			buff<=inadrs;
	end
	assign outadrs=buff;
	
endmodule


