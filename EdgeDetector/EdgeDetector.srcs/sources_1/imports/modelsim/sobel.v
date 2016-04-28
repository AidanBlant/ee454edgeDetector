module sobel #(parameter WIDTH = 128, parameter DEPTH = 128)(
	input clk,
	input [7:0] threshold,
	input [WIDTH*DEPTH*8:0] inputImage, 
	output [WIDTH*DEPTH:0] bmpOutput 

);

reg [WIDTH*DEPTH:0] out;


integer X;
integer Y;

assign bmpOutput = out;

reg enabled = 1'b1;
integer i = 0;

//always@(posedge clk)
//begin
//	if(enabled)
//	begin		
//		inputImage[i] = pixel;
//		i = i+1;
//		if(i >= WIDTH*DEPTH)
//			enabled = 1'b0;
//	end
//end

reg [DEPTH*WIDTH:0] isEdge;
reg [DEPTH*WIDTH:0] gx [10:0];
reg [DEPTH*WIDTH:0] gy [10:0];    		//11 bits because max value of gx and gy is 255*4 and last bit for sign					 
reg [DEPTH*WIDTH:0] abs_gx [10:0];
reg [DEPTH*WIDTH:0] abs_gy [10:0];    //it is used to find the absolute value of gx and gy 
reg [DEPTH*WIDTH:0] SUM [10:0];            //the max value is 255*8. here no sign bit needed. 
reg [DEPTH*WIDTH:0] sum [10:0];

task applyThresh;
	input integer t;
	input integer q;
	input [7:0] val;
	begin
		if( val > t )
			isEdge[q] = 1;
		else
			isEdge[q] = 0;
	end
endtask

initial
begin
	for(Y=0; Y<=(DEPTH-1); Y = Y+1)
	begin
		for(X=0; X<=(WIDTH-1); X= X+1)
		begin

	        // image boundaries
			if(Y==0 || Y==(DEPTH-1))
				SUM[Y*WIDTH+X] <= 0;
			else if(X==0 || X==(WIDTH-1))
				SUM[Y*WIDTH+X] <= 0;	
			else
            begin
			   //p0 inputImage[Y*WIDTH-WIDTH+X-1],
			   //p1 inputImage[Y*WIDTH-WIDTH+X],
			   //p2 inputImage[Y*WIDTH-WIDTH+X+1],
			   //p3 inputImage[Y*WIDTH+X-1],
			   //p4 inputImage[Y*WIDTH+X],
			   //p5 inputImage[Y*WIDTH+X+1],
			   //p6 inputImage[Y*WIDTH+WIDTH+X-1],
			   //p7 inputImage[Y*WIDTH+WIDTH+X],
			   //p8 inputImage[Y*WIDTH+WIDTH+X+1],
               //assign gx=( (p0*1)+(p1*0)+(p2*-1)+(p3*2)+(p5*-2)+(p6*1)+(p7*0)+(p8*-1) );//sobel mask for gradient in horiz. direction 
               //assign gy=( (p0*1)+(p1*2)+(p2*1)+(p3*0)+(p5*-0)+(p6*-1)+(p7*-2)+(p8*-1) );//sobel mask for gradient in vertical direction 
			   
			   //sobel mask for gradient in horiz. direction 
				gx[Y*WIDTH+X] <=( (inputImage[Y*WIDTH-WIDTH+X-1]*1)+(inputImage[Y*WIDTH-WIDTH+X]*0)+(inputImage[Y*WIDTH-WIDTH+X+1]*-1)+(inputImage[Y*WIDTH+X-1]*2)+(inputImage[Y*WIDTH+X+1]*-2)+(inputImage[Y*WIDTH+WIDTH+X-1]*1)+(inputImage[Y*WIDTH+WIDTH+X]*0)+(inputImage[Y*WIDTH+WIDTH+X+1]*-1) );
				//sobel mask for gradient in vertical direction 
				gy[Y*WIDTH+X] <=( (inputImage[Y*WIDTH-WIDTH+X-1]*1)+(inputImage[Y*WIDTH-WIDTH+X]*2)+(inputImage[Y*WIDTH-WIDTH+X+1]*1)+(inputImage[Y*WIDTH+X-1]*0)+(inputImage[Y*WIDTH+X+1]*-0)+(inputImage[Y*WIDTH+WIDTH+X-1]*-1)+(inputImage[Y*WIDTH+WIDTH+X]*-2)+(inputImage[Y*WIDTH+WIDTH+X+1]*-1) );

                abs_gx[Y*WIDTH+X] <= (gx[Y*WIDTH+X][10]? ~gx[Y*WIDTH+X]+1 : gx[Y*WIDTH+X]);    // to find the absolute value of gx. 
                abs_gy[Y*WIDTH+X] <= (gy[Y*WIDTH+X][10]? ~gy[Y*WIDTH+X]+1 : gy[Y*WIDTH+X]);    // to find the absolute value of gy. 
                
                sum[Y*WIDTH+X] <= (abs_gx[Y*WIDTH+X]+abs_gy[Y*WIDTH+X]);                // finding the sum 
                SUM[Y*WIDTH+X] <= (sum[Y*WIDTH+X]>8'd255)? 8'd255: sum[Y*WIDTH+X];    // to limit the max value to 255  
     
                    
            end    
            applyThresh(threshold, Y*WIDTH+X, SUM[Y*WIDTH+X]);
			out[Y*WIDTH+X] <= isEdge[Y*WIDTH+X];
		end

	end
end




endmodule
