`timescale 1ns / 1ps
module innerSobel( p0, p1, p2, p3, p5, p6, p7, p8, pOut);

input  [7:0] p0,p1,p2,p3,p5,p6,p7,p8;	// 8 bit pixels inputs 
output [7:0] pOut;			// 8 bit output pixel 

wire signed [10:0] gx,gy;    		//11 bits because max value of gx and gy is 255*4 and last bit for sign					 
wire signed [10:0] abs_gx,abs_gy;	//it is used to find the absolute value of gx and gy 
wire [10:0] sum;			//the max value is 255*8. here no sign bit needed. 

assign gx=( (p0*1)+(p1*0)+(p2*-1)+(p3*2)+(p5*-2)+(p6*1)+(p7*0)+(p8*-1) );//sobel mask for gradient in horiz. direction 
assign gy=( (p0*1)+(p1*2)+(p2*1)+(p3*0)+(p5*-0)+(p6*-1)+(p7*-2)+(p8*-1) );//sobel mask for gradient in vertical direction 

assign abs_gx = (gx[10]? ~gx+1 : gx);	// to find the absolute value of gx. 
assign abs_gy = (gy[10]? ~gy+1 : gy);	// to find the absolute value of gy. 

assign sum = (abs_gx+abs_gy);				// finding the sum 
assign pOut = (sum>8'd255)? 8'd255: sum[7:0];	// to limit the max value to 255  

endmodule