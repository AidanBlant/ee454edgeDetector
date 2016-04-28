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

);



vga #(9,9) display(
	.bmpInput(TEST),
	.dclk(clk),			
	.clr(rst),			
	.hsync(hsyncOut),		
	.vsync(vsyncOut),		
	.red(redOut),	
	.green(greenOut),
	.blue(blueOut)	
	
	
);





endmodule
