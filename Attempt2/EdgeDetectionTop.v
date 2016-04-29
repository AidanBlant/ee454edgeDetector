`timescale 1ns / 1ps
module EdgeDetectionTop #(parameter WIDTH = 128, parameter DEPTH = 128) (
	//input ClkPort
);

reg ClkPort;
reg [WIDTH*DEPTH*8:0] inputImage;
wire [WIDTH*DEPTH:0] bmpOut;
wire vga_h_sync, vga_v_sync;
wire [2:0] vga_r;
wire [2:0] vga_g;
wire [2:0] vga_b;
reg [7:0] thresh = 'b00110011;


parameter CLK_PERIOD=100;
always 	#(CLK_PERIOD/2) ClkPort=~ClkPort;

initial 
begin
ClkPort=0;
end

integer flag = 0;
integer i = 0;
always@(posedge ClkPort) 
begin
    if(i > WIDTH*DEPTH)
    begin
	flag = 1;
   	i <= i+1;
    end
    if(i%2==0 && flag == 0)     
         inputImage[i] = 1;
end



//imageGetter #(WIDTH,DEPTH) Image(
//	.clk(clk),
//	.theDataout(inputImage)
//	);

sobel #(WIDTH,DEPTH) Sobel(
	.clk(ClkPort),
	.threshold(thresh),
	.inputImage(inputImage),
	.bmpOutput(bmpOut)
	);

vga #(WIDTH,DEPTH) display(
	.ClkPort(ClkPort),
	.displayImage(bmpImage),
	.vga_h_sync(vga_h_sync), 
	.vga_v_sync(vga_v_sync), 
	.vga_r_out(vga_r), 
	.vga_g_out(vga_g), 
	.vga_b_out(vga_b)
	);
	
endmodule