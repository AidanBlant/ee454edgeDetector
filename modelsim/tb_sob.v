module tb_sob;

reg [9:9] toInput;


mySobel #(9,9) sobel(
	.inputImage(toInput)
);







endmodule
