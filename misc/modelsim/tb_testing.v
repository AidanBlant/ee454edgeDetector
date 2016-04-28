module tb_testing;

parameter clk_cycle=10;
reg clock;
reg [7:0] thresh;
reg [7:0] pixelIn;
reg [15:0] theOutput;


initial
begin

clock = 1'b0;
thresh = 



end



mySobel #(,) sobel(
	.clk(clock),
	.threshold(thresh),
	.pixel(pixelIn), 
	.bmpOutput(theOutput) 

);







endmodule