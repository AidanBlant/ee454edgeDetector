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
always@(posedge clk)
begin
    if(enabled)
    begin        
        //imageInput2D[i] = inputImage[i+7:i];
	imageInput2D[i][7:0] = 8'b10110101;
        i = i+1;
        if(i >= WIDTH*DEPTH)
            enabled = 1'b0;
    end
end




reg [7:0] p0,p1,p2,p3,p5,p6,p7,p8; 	// 8 bit pixels inputs
wire [7:0] sum; 
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
//TODO: Only one sobel module, need one for every X in WIDTH!!!!
innerSobel inner(p0, p1, p2, p3, p5, p6, p7, p8, sum);
always @(posedge clk)
begin
    if(Y < DEPTH-1)
    begin
        Y <= Y + 1;
        for(X=1; X<=(WIDTH-1); X= X+1)
        begin
		p0 <= imageInput2D[Y*WIDTH-WIDTH+X-1];		
        	p1 <= imageInput2D[Y*WIDTH-WIDTH+X];
		p2 <= imageInput2D[Y*WIDTH-WIDTH+X+1];
		p3 <= imageInput2D[Y*WIDTH+X-1];
		p5 <= imageInput2D[Y*WIDTH+X+1];
		p6 <= imageInput2D[Y*WIDTH+WIDTH+X-1];
		p7 <= imageInput2D[Y*WIDTH+WIDTH+X];
		p8 <= imageInput2D[Y*WIDTH+WIDTH+X+1];
		#1
            	//apply threshold and write to out array if edge
            	applyThresh(threshold, Y*WIDTH+X, sum);
            	out[Y*WIDTH+X] <= isEdge[Y*WIDTH+X];

        end//for loop width
    end//check for over depth
end //always depth


endmodule
