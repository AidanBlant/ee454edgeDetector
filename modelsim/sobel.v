module sobel #(parameter WIDTH, parameter DEPTH)(
	input clk,
	input [7:0] threshold,
	input [7:0] pixel, 
	output [WIDTH*DEPTH:0] bmpOutput 

);

reg [WIDTH*DEPTH:0] out;
reg [7:0] SUM;
integer X;
integer Y;

assign bmpOutput = out;

reg enabled = 1'b1;
reg[7:0] inputImage [WIDTH*DEPTH:0];
integer i = 0;

always@(posedge clk)
begin
	if(enabled)
	begin		
		inputImage[i] = pixel;
		i = i+1;
		if(i >= WIDTH*DEPTH)
			enabled = 1'b0;
	end
end

reg isEdge;
task applyThresh;
	input integer t;
	input [7:0] val;
	begin
		if( val > t )
			isEdge = 1;
		else
			isEdge = 0;
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

			applyThresh(threshold, SUM);
			out[Y*WIDTH+X] <= isEdge;
		end

	end
end




endmodule
