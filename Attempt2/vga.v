`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// VGA Module derive from Yinyi's Snake game
// Author:  	Aidan Blant
//				Yinyi Chen
//				Emma Smih
//////////////////////////////////////////////////////////////////////////////////
module vga #(parameter WIDTH = 128, parameter DEPTH = 128)(
    ClkPort, displayImage, vga_h_sync, vga_v_sync, vga_r_out, vga_g_out, vga_b_out
);
	
input ClkPort;
input [WIDTH*DEPTH*8:0] displayImage;
output vga_h_sync, vga_v_sync; 
output [2:0] vga_r_out;
output [2:0] vga_g_out;
output [2:0] vga_b_out;
reg [2:0] vga_r, vga_g, vga_b;

assign vga_r_out = vga_r;
assign vga_g_out = vga_g;
assign vga_b_out = vga_b;
	

wire inDisplayArea;
wire [9:0] CounterX;
wire [9:0] CounterY;

reg [3:0] state;	
localparam START = 4'b0001, PLAYING = 4'b0010, DEAD = 4'b0100, WIN = 4'b1000;


hvsync_generator syncgen(.clk(clk), .reset(reset),.vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));


/////////////////////////////////////////////////////////////////
///////////////		VGA control starts here		/////////////////
/////////////////////////////////////////////////////////////////

// Edges

//wire R = (CounterX % 10 == 0) || (CounterX % 10 == 1) || (CounterY%10 == 1);
//wire G = (CounterX % 10 == 0) || (CounterX % 10 == 1) || (CounterY%10 == 5);
//wire B = (CounterX % 10 == 0) || (CounterX % 10 == 1);
wire R = displayImage[ CounterY * WIDTH + CounterX ];
wire G = displayImage[ CounterY * WIDTH + CounterX ];
wire B = displayImage[ CounterY * WIDTH + CounterX ];


always @(posedge clk)
begin
	vga_r[0] <= R & inDisplayArea;
	vga_r[1] <= R & inDisplayArea;
	vga_r[2] <= R & inDisplayArea;
    	vga_g[0] <= G & inDisplayArea & 1'b0;
	vga_g[1] <= G & inDisplayArea;
	vga_g[2] <= G & inDisplayArea;
	vga_b[0] <= B & inDisplayArea;
	vga_b[1] <= B & inDisplayArea & 1'b0;
	vga_b[2] <= B & inDisplayArea;
end

/////////////////////////////////////////////////////////////////
//////////////  	  VGA control ends here 	 ///////////////////
/////////////////////////////////////////////////////////////////


endmodule
