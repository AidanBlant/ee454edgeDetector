module tb_sob;

reg [0:80] toInput;
reg [0:80] theOutput;
wire hsyncOut;
wire vsyncOut;
reg [2:0] redOut;
reg [2:0] greenOut;
reg [2:0] blueOut;

mySobel #(9,9) sobel(
	.inputImage(toInput),
	.bmpImage(theOutput)

parameter clk_cycle=10;
reg clk;
reg reset_n;
wire theDataout;

always #(clk_cycle/2) clk=~clk;

vga #(9,9) display(
	.bmpInput(theOutput),
	.dclk(clk),			
	.clr(rst),			
	.hsync(hsyncOut),		
	.vsync(vsyncOut),		
	.red(redOut),	
	.green(greenOut),
	.blue(blueOut)	
	
);


initial
begin
	reset_n=1'b0;
	clk=1'b0;
	#(clk_cycle*4)
	reset_n=1'b1;
end




endmodule
