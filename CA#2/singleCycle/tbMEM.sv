`timescale 1ns/1ns
module tbtb ();
  
  wire [31:0] ins ;
  insmem ff(32'b0 , ins);
  initial begin 
    #100 ;
  end
  
endmodule
