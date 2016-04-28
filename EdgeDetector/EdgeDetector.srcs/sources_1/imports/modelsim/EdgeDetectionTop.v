

module EdgeDetectionTop #(parameter WIDTH = 128, parameter DEPTH = 128) (
	input clk,
	input rst_n
);

wire [WIDTH*DEPTH*8:0] inputImage;
wire [WIDTH*DEPTH:0] bmpImage;
reg vga_h_sync, vga_v_sync;
reg vga_r, vga_r1, vga_r2, vga_g, vga_g1, vga_g2, vga_b, vga_b1, vga_b2;
reg [7:0] thresh = 'b00110011;
 

imageGetter #(WIDTH,DEPTH) Image(
	.clk(clk),
	.rst_n(rst_n),
	.theDataout(inputImage)
	);

sobel #(WIDTH,DEPTH) Sobel(
	.clk(clk),
	.threshold(thresh),
	.inputImage(inputImage),
	.bmpOutput(bmpImage)
	);

vga #(WIDTH,DEPTH) display(
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