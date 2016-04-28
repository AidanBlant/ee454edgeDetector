`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// VGA Module derive from Yinyi's Snake game
// Author:  	Aidan Blant
//				Yinyi Chen
//				Emma Smih
//////////////////////////////////////////////////////////////////////////////////
module vga #(parameter WIDTH = 128, parameter DEPTH = 128)(
	ClkPort, displayImage, vga_h_sync, vga_v_sync, vga_r, vga_r1, vga_r2, vga_g, vga_g1, vga_g2, vga_b, vga_b1, vga_b2
);
	
input ClkPort;
output [WIDTH*DEPTH:0] displayImage;
output vga_h_sync, vga_v_sync, vga_r, vga_r1, vga_r2, vga_g, vga_g1, vga_g2, vga_b, vga_b1, vga_b2;
reg vga_r, vga_r1, vga_r2, vga_g, vga_g1, vga_g2, vga_b, vga_b1, vga_b2;
	
//////////////////////////////////////////////////////////////////////////////////////////
	
/*  LOCAL SIGNALS */
wire	reset, start, ClkPort, board_clk, clk, button_clk;

BUF BUF1 (board_clk, ClkPort); 	
BUF BUF2 (reset, Sw1);


reg [27:0]	count;
reg [27:0]  speed;	// time period(in ns) between snake position update
reg [27:0]	DIV_CLK;

always @ (posedge board_clk, posedge reset)  
begin
	if (reset)
		begin
			count <= 0;
			DIV_CLK <= 0;
		end
	else if (count == speed)
		begin
			count <= 1;
			DIV_CLK <= DIV_CLK + 1'b1;
		end
  else
		begin
			count <= count + 1'b1;
			DIV_CLK <= DIV_CLK +1'b1;
		end
end	

assign	button_clk = DIV_CLK[18];
assign	clk = DIV_CLK[1];
//assign 	{St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar} = {5'b11111};

wire inDisplayArea;
wire [9:0] CounterX;
wire [9:0] CounterY;


hvsync_generator syncgen(.clk(clk), .reset(reset),.vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));

/////////////////////////////////////////////////////////////////
///////////////		VGA control starts here		/////////////////
/////////////////////////////////////////////////////////////////

// Edges

wire R = displayImage[ CounterY * WIDTH + CounterX ];
wire G = displayImage[ CounterY * WIDTH + CounterX ];
wire B = displayImage[ CounterY * WIDTH + CounterX ];

always @(posedge clk)
begin
	vga_r <= R & inDisplayArea;
	vga_r1 <= R & inDisplayArea;
	vga_r2 <= R & inDisplayArea;
    vga_g <= G & inDisplayArea;
	vga_g1 <= G & inDisplayArea;
	vga_g2 <= G & inDisplayArea;
	vga_b <= B & inDisplayArea;
	vga_b1 <= B & inDisplayArea;
	vga_b2 <= B & inDisplayArea;
end

/////////////////////////////////////////////////////////////////
//////////////  	  VGA control ends here 	 ///////////////////
/////////////////////////////////////////////////////////////////


endmodule
