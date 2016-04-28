
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// VGA Module derive from Yinyi's Snake game
// Author:  	Aidan Blant
//				Yinyi Chen
//				Emma Smih
//////////////////////////////////////////////////////////////////////////////////
module vga_demo(
ClkPort, vga_h_sync, vga_v_sync, 
	vga_r, vga_r1, vga_r2, vga_g, vga_g1, vga_g2, vga_b, vga_b1, vga_b2, 
	Sw0, Sw1, Sw6, Sw7, btnU, btnD,btnR, btnL
);
	
input ClkPort, Sw0, btnU, btnD, btnR, btnL, Sw0, Sw1, Sw6, Sw7;
output vga_h_sync, vga_v_sync, vga_r, vga_r1, vga_r2, vga_g, vga_g1, vga_g2, vga_b, vga_b1, vga_b2;
reg vga_r, vga_r1, vga_r2, vga_g, vga_g1, vga_g2, vga_b, vga_b1, vga_b2;
	
//////////////////////////////////////////////////////////////////////////////////////////
	
/*  LOCAL SIGNALS */
wire	reset, start, ClkPort, board_clk, clk, button_clk;

BUF BUF1 (board_clk, ClkPort); 	
BUF BUF2 (reset, Sw1);

BUF BUF3 (start, Sw0);
BUF BUF4 (level2, Sw6);
BUF BUF5 (level3, Sw7);

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
wire R = theOutputArray[ CounterY * 200 + CounterX ];
wire G = theOutputArray[ CounterY * 200 + CounterX ];
wire B = theOutputArray[ CounterY * 200 + CounterX ];


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
















/////////////////////////////////////////////////////////////////
//////////////  	  LD control starts here 	 ///////////////////
/////////////////////////////////////////////////////////////////

wire LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7;

assign LD0 = btnR;

assign LD1 = btnL;

assign LD2 = btnD;
assign LD3 = btnU;

assign LD4 =start;

assign LD5 = (state == START);	

assign LD6 = (state == PLAYING);

assign LD7 = (state == DEAD);

/////////////////////////////////////////////////////////////////
//////////////  	  LD control ends here 	 	////////////////////
/////////////////////////////////////////////////////////////////













































/////////////////////////////////////////////////////////////////
//////////////  	  SSD control starts here 	 ///////////////////
/////////////////////////////////////////////////////////////////
reg 	[3:0]	SSD;
reg 	[3:0]	SSD0, SSD1, SSD2, SSD3;
wire 	[1:0] ssdscan_clk;

always@(DIV_CLK[25])
begin
	SSD3 <= 4'b1111;
	SSD2 <= 4'b1111;
	SSD1 <= 4'b1111;
	//SSD0 <= score;
	if(state == DEAD) 
	begin
		SSD3 <= 4'b0000;
		SSD2 <= 4'b1110;
		SSD1 <= 4'b1010;
		SSD0 <= 4'b0000;
	end
	else if (level3)
		SSD3 <= 4'b0011;
	else if (level2)
		SSD3 <= 4'b0010;
	else
		SSD3 <= 4'b0001;
end

// need a scan clk for the seven segment display 
// 191Hz (50MHz / 2^18) works well
assign ssdscan_clk = DIV_CLK[19:18];	
assign An0	= !(~(ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 00
assign An1	= !(~(ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 01
assign An2	= !( (ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 10
assign An3	= !( (ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 11

always @ (ssdscan_clk, SSD0, SSD1, SSD2, SSD3)
begin : SSD_SCAN_OUT
	case (ssdscan_clk) 
		2'b00:
				SSD = SSD0;
		2'b01:
				SSD = SSD1;
		2'b10:
				SSD = SSD2;
		2'b11:
				SSD = SSD3;
	endcase 
end	

// and finally convert SSD_num to ssd
reg [6:0]  SSD_CATHODES;
assign {Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp} = {SSD_CATHODES, 1'b1};
// Following is Hex-to-SSD conversion

always @ (SSD) 
begin : HEX_TO_SSD
	case (SSD)		
		4'b1111: SSD_CATHODES = 7'b1111111 ; //Nothing 
		4'b0000: SSD_CATHODES = 7'b0000001 ; //0
		4'b0001: SSD_CATHODES = 7'b1001111 ; //1
		4'b0010: SSD_CATHODES = 7'b0010010 ; //2
		4'b0011: SSD_CATHODES = 7'b0000110 ; //3
		4'b0100: SSD_CATHODES = 7'b1001100 ; //4
		4'b0101: SSD_CATHODES = 7'b0100100 ; //5
		4'b0110: SSD_CATHODES = 7'b0100000 ; //6
		4'b0111: SSD_CATHODES = 7'b0001111 ; //7
		4'b1000: SSD_CATHODES = 7'b0000000 ; //8
		4'b1001: SSD_CATHODES = 7'b0000100 ; //9
		4'b1010: SSD_CATHODES = 7'b0001000 ; //10 or A
		4'b1011: SSD_CATHODES = 7'b0000000 ; //B
		4'b1100: SSD_CATHODES = 7'b0110001 ; //C
		4'b1101: SSD_CATHODES = 7'b0000001 ; //D
		4'b1110: SSD_CATHODES = 7'b0110000 ; //E
		default: SSD_CATHODES = 7'bXXXXXXX ; // default is not needed as we covered all cases
	endcase
end

/////////////////////////////////////////////////////////////////
//////////////  	  SSD control ends here 	 ///////////////////
/////////////////////////////////////////////////////////////////
endmodule


