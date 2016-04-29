`timescale 1ns / 1ps
module sobel #(parameter WIDTH = 128, parameter DEPTH = 128)(
    input clk,
    input [7:0] threshold,
    input [WIDTH*DEPTH*8:0] inputImage, 
    output [WIDTH*DEPTH:0] bmpOutput 
    
    );

reg [WIDTH*DEPTH:0] imageInput2D [7:0];

reg [WIDTH*DEPTH:0] out;
assign bmpOutput = out;

reg enabled = 1'b1;
integer i = 0;
integer j = 0;
always@(posedge clk)
begin
    if(enabled)
    begin        
        //imageInput2D[i] = inputImage[i+7:i]
	for(j = 0; j < 8; j=j+1) 
	begin
		imageInput2D[i][j] <= inputImage[8*i+j];
	end
        i = i+1;
        if(i >= WIDTH*DEPTH)
            enabled = 1'b0;
    end
end




 
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

integer X = 1;
integer Y = 1;
integer r;

reg [WIDTH:0] p0 [7:0];
reg [WIDTH:0] p1 [7:0];
reg [WIDTH:0] p2 [7:0];
reg [WIDTH:0] p3 [7:0];
reg [WIDTH:0] p5 [7:0];
reg [WIDTH:0] p6 [7:0];
reg [WIDTH:0] p7 [7:0];
reg [WIDTH:0] p8 [7:0];

wire [WIDTH:0] sum [7:0];
genvar g;
generate 
	for (g = 0; g < WIDTH; g = g + 1) 
	begin
	    innerSobel inst(p0[g], p1[g], p2[g], p3[g], p5[g], p6[g], p7[g], p8[g], sum[g]);
	end 
endgenerate

always @(posedge clk)
begin
    if(Y < DEPTH-1)
    begin
        Y <= Y + 1;
        for(X=1; X<=(WIDTH-1); X= X+1)
        begin
		for(r=0; r<WIDTH; r = r+1)
		begin
			p0[r] <= imageInput2D[Y*WIDTH-WIDTH+X-1];		
        		p1[r] <= imageInput2D[Y*WIDTH-WIDTH+X];
			p2[r] <= imageInput2D[Y*WIDTH-WIDTH+X+1];
			p3[r] <= imageInput2D[Y*WIDTH+X-1];
			p5[r] <= imageInput2D[Y*WIDTH+X+1];
			p6[r] <= imageInput2D[Y*WIDTH+WIDTH+X-1];
			p7[r] <= imageInput2D[Y*WIDTH+WIDTH+X];
			p8[r] <= imageInput2D[Y*WIDTH+WIDTH+X+1];
		end
            	//apply threshold and write to out array if edge
            	applyThresh(threshold, Y*WIDTH+X, sum[Y]);
            	out[Y*WIDTH+X] <= isEdge[Y*WIDTH+X];

        end//for loop width
    end//check for over depth
end //always depth


endmodule
