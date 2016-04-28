

module EdgeDetectionTop #(parameter WIDTH, parameter DEPTH) (
	input clk,
	input rst_n,
	input [7:0] threshold
);

reg [WIDTH*DEPTH*8:0] inputImage;
reg [WIDTH*DEPTH:0] bmpImage;
reg vga_h_sync, vga_v_sync;
reg vga_r, vga_r1, vga_r2, vga_g, vga_g1, vga_g2, vga_b, vga_b1, vga_b2;
	


imageGetter Image #(WIDTH,DEPTH)(
	.clk(clk),
	.rst_n(rst_n),
	.theDataout(inputImage)
	);

sobel Sobel #(WIDTH,DEPTH)(
	.clk(clk),
	.threshold(threshold),
	.inputImage(inputImage),
	.bmpOutput(bmpImage)
	);

vga display #(WIDTH, DEPTH) (
	.ClkPort(clk),
	.displayImage(bmpImage),
	.vga_h_sync(vga_h_sync), 
	.vga_v_sync(vga_v_sync), 
	.vga_r(vga_r), 
	.vga_r1(vga_r1), 
	.vga_r2(vga_r2), 
	.vga_g(vga_g), 
	.vga_g1(vga_g1), 
	.vga_g2(vga_g2), 
	.vga_b(vga_b), 
	.vga_b1(vga_b1), 
	.vga_b2(vga_b2)
	
	);

	
endmodule