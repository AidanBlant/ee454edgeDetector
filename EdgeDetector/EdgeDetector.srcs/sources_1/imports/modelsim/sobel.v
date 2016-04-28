module sobel #(parameter WIDTH, parameter DEPTH)(
	input clk,
	input [7:0] threshold,
	input [WIDTH*DEPTH*8:0] inputImage, 
	output [WIDTH*DEPTH:0] bmpOutput 

);

reg [WIDTH*DEPTH:0] out;
reg [7:0] SUM;
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
				SUM = 0;
			else if(X==0 || X==(WIDTH-1))
				SUM = 0;	
			else
				innerSobel(inputImage[Y*WIDTH-WIDTH+X-1],inputImage[Y*WIDTH-WIDTH+X],inputImage[Y*WIDTH-WIDTH+X+1],inputImage[Y*WIDTH+X-1],inputImage[Y*WIDTH+X],inputImage[Y*WIDTH+X+1],inputImage[Y*WIDTH+WIDTH+X-1],inputImage[Y*WIDTH+WIDTH+X],inputImage[Y*WIDTH+WIDTH+X+1], SUM);

			applyThresh(threshold, Y*WIDTH+X, SUM);
			out[Y*WIDTH+X] <= isEdge[Y*WIDTH+X];
		end

	end
end




endmodule
