



module imageGetter  #(parameter WIDTH, parameter DEPTH)(
	input clk,
	input rst_n,
	output [WIDTH*DEPTH*8:0] theDataout
);




module sobel #(parameter WIDTH, parameter DEPTH)(
	input clk,
	input [7:0] threshold,
	input [WIDTH*DEPTH*8:0] inputImage, 
	output [WIDTH*DEPTH:0] bmpOutput 

);


module vga #(parameter WIDTH, parameter DEPTH) (
	//input [WIDTH*DEPTH:0] bmpInput,
	input wire dclk,			//pixel clock: 25MHz
	input wire clr,			//asynchronous reset
	output wire hsync,		//horizontal sync out
	output wire vsync,		//vertical sync out
	output reg [2:0] red,	//red vga output
	output reg [2:0] green, //green vga output
	output reg [2:0] blue	//blue vga output
	);
