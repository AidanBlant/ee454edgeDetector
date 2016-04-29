`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// VGA Module derive from Yinyi's Snake game
// Author:  	Aidan Blant
//				Yinyi Chen
//				Emma Smih
//////////////////////////////////////////////////////////////////////////////////
module vga #(parameter WIDTH = 4, parameter DEPTH = 4)(
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
	
//////////////////////////////////////////////////////////////////////////////////////////
	
/*  LOCAL SIGNALS */
wire	reset, start, ClkPort, board_clk, clk, button_clk;

BUF BUF1 (board_clk, ClkPort); 	


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

reg [3:0] state;	
localparam START = 4'b0001, PLAYING = 4'b0010, DEAD = 4'b0100, WIN = 4'b1000;


hvsync_generator syncgen(.clk(clk), .reset(reset),.vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));


/////////////////////////////////////////////////////////////////////
// Some memory reading stuff

//reg [15:0] memory [0:15]; 	//memory
//integer i;					// 17,462 bytes for example
//reg mReadFlag;

//initial $readmemh("LENAG.txt",memory);
//			mReadFlag <= 1'b1;
				//dataout <= memory[i];
//				$display($time, " << Starting the Simulation >>");
//				$display("%d%d%d%d%d%d%d%d",memory[i][7],memory[i][6],memory[i][5],memory[i][4],memory[i][3],memory[i][2],memory[i][1],memory[i][0]);

// Width * Depth = 200 * 200 = 40000
reg [40000:0] theOutputArray [0:15];
integer i;

always@(posedge clk)
begin
//	for( i = 0; i < 40; i = i + i )	// Can't use for loops
//	begin
//		if( i%20 == 0 )
//			theOutputArray[i] = 1'b1;
//		else if( i%20 == 1 )
//			theOutputArray[i] = 1'b1;
//		else
//			theOutputArray[i] = 1'b0;
//	end
end

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
