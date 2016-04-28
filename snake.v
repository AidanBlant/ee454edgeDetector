

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Snake Game
// Author:  Kimberly Santiago
//				Yinyi Chen
//////////////////////////////////////////////////////////////////////////////////
module vga_demo(ClkPort, vga_h_sync, vga_v_sync, 
	vga_r, vga_r1, vga_r2, vga_g, vga_g1, vga_g2, vga_b, vga_b2, 
	Sw0, Sw1, Sw6, Sw7, btnU, btnD,btnR, btnL,
	/*St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar,
	An0, An1, An2, An3, Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp,
	LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7*/);
	
	input ClkPort, Sw0, btnU, btnD, btnR, btnL, Sw0, Sw1, Sw6, Sw7;
//	output St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar;
	output vga_h_sync, vga_v_sync, vga_r, vga_r1, vga_r2, vga_g, vga_g1, vga_g2, vga_b, vga_b2;
//	output An0, An1, An2, An3, Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp;
//	output LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7;
	reg vga_r, vga_r1, vga_r2, vga_g, vga_g1, vga_g2, vga_b, vga_b2;
	
	//////////////////////////////////////////////////////////////////////////////////////////
	
	/*  LOCAL SIGNALS */
	wire	reset, start, level2, level3, ClkPort, board_clk, clk, button_clk;
	
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
//	assign 	{St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar} = {5'b11111};
	
	wire inDisplayArea;
	wire [9:0] CounterX;
	wire [9:0] CounterY;
	
	reg [3:0] state;	
	localparam START = 4'b0001, PLAYING = 4'b0010, DEAD = 4'b0100, WIN = 4'b1000;


	reg [3:0] score;

	hvsync_generator syncgen(.clk(clk), .reset(reset),.vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));
	
	
	// random number generator for x_fruit
	reg [8:0] a;
	//LFSR feedback bit
	wire feedback_a;
	assign feedback_a = a[0]^a[8];
	always @ (posedge board_clk)
		begin
			if (reset)
				begin
					a[8:0] <= 10'b111111111;
				end
			else if (count == speed)
				 begin
					a[8] <= feedback_a;
					a[7] <= a[8];
					a[6] <= a[7];
					a[5] <= a[6];
					a[4] <= a[5];
					a[3] <= a[4];
					a[2] <= a[3];
					a[1] <= a[2];
					a[0] <= a[1];
				end
		end

	
	// random number generator for y_fruit
	reg [7:0] b;
	//LFSR feedback bit
	wire feedback_b;
	assign feedback_b = b[0]^b[7];
	always @ (posedge board_clk)
		begin
			if (reset)
				begin
					b[7:0] <= 8'b11111111;
				end
			else if (count == speed)
				 begin
					b[0] <= feedback_b;
					b[1] <= b[0];
					b[2] <= b[1];
					b[3] <= b[2];
					b[4] <= b[3];
					b[5] <= b[4];
					b[6] <= b[5];
					b[7] <= b[6];
				end
		end


	
	
	reg [3:0] snake_direction;  // up, down, left, right
	reg [9:0] x_head;
	reg [9:0] y_head;
	reg [9:0] x_snake [15:0]; // an array of x-coordinates of the individual blocks
	reg [9:0] y_snake [15:0];
	reg [3:0] snake_length;
	reg [15:0] is_exist; // whether a block should be displayed	
	
	reg [9:0] x_fruit;
	reg [9:0] y_fruit;
	
	// boundaries of the snake head and the fruit
	wire [9:0] head_up;
	wire [9:0] head_down;
	wire [9:0] head_left;
	wire [9:0] head_right;
	wire [9:0] fruit_up;
	wire [9:0] fruit_down;
	wire [9:0] fruit_left;
	wire [9:0] fruit_right;
	assign head_up = y_head - 10;
	assign head_down = y_head +10;
	assign head_left = x_head -10;
	assign head_right = x_head +10;
	assign fruit_up = y_fruit -5;
	assign fruit_down = y_fruit +5;
	assign fruit_left = x_fruit -5;
	assign fruit_right = x_fruit+5;
	
	// read the snake direction from the buttons
	always @(posedge board_clk)
		begin
			if(count == speed)
				if(state == PLAYING)
					begin
					if(btnD && ~btnU && snake_direction!=4'b1000)
						begin
							snake_direction <= 4'b0100;
						end
					else if(btnU && ~btnD && snake_direction!=4'b0100)
						begin
							snake_direction <= 4'b1000;
						end
					else if(btnL && ~btnR && snake_direction!=4'b0001)
						begin
							snake_direction <= 4'b0010;
						end
					else if(btnR && ~btnL && snake_direction!=4'b0010)
						begin
							snake_direction <= 4'b0001;
						end	
					end	
				else
					snake_direction <= 4'b0000; //default to stay still
		end
		
		// state machine
		always @ (posedge board_clk)
			begin
				if (count == speed)
					begin
					if(~start)
					begin
						state <= START;
						
						// set the speed of the game 
						if (level3)
							begin
								speed <= 8000000; // fastest
							end
						else if (level2)
							begin
								speed <= 12000000;
							end
						else
							begin
								speed <= 17000000;
							end
						// initial values
						score<= 0;
						snake_length <= 4'b0010;
						x_snake[0] <= 240;
						y_snake[0] <= 240;
						x_snake[1] <= 220;
						y_snake[1] <= 240;
						is_exist <= 0;
						is_exist[0] <= 1;
						is_exist[1] <= 1;
						x_head <= 240;
						y_head <= 240;
						
						x_fruit <= 300;
						y_fruit <= 300;
					end
					else
					begin					
						case(state)
							START:
							begin
								if(start)
									state <= PLAYING;
							end
							
							PLAYING:
							begin
							x_head <= x_snake[0];
							y_head <= y_snake[0];
							case (snake_direction)
								4'b0001: //moving right
									begin
										x_snake[0] <= x_snake[0] + 20;
										x_head <= x_snake[0] + 20;
										if (head_right >= fruit_left && 
											head_up <= fruit_down &&
											head_down >=fruit_up ) // if collide with fruit
											begin
												x_fruit <= {2'b00, a+15};
												y_fruit <= {2'b000, b+15};	
												snake_length <= snake_length + 1;
												is_exist[snake_length] <=1;
												x_snake[snake_length] <= x_snake[snake_length-1]-20;
												y_snake[snake_length] <= y_snake[snake_length-1];
												
												score <= score +1;
											end
									else if (head_right >= 620) // check if collide with walls
											begin
											state <= DEAD;
											end
									
									end
								4'b0010: //moving left
									begin
										x_snake[0] <= x_snake[0]- 20;
										x_head <= x_snake[0] -20;
										if (head_left <= fruit_right &&
											head_up <= fruit_down &&
											head_down >= fruit_up)
											begin
												x_fruit <= {2'b00, a+15};
												y_fruit <= {2'b000, b+15};	
												snake_length <= snake_length + 1;
												is_exist[snake_length] <=1;
												x_snake[snake_length] <= x_snake[snake_length-1]+20;
												y_snake[snake_length] <= y_snake[snake_length-1];
												score <= score +1;

											end
									else if (head_left <= 20) // check if collide with walls
											begin
												state <= DEAD;
											end
									end
								4'b0100: //moving down
									begin
										y_snake[0] <= y_snake[0] + 20;
										y_head <= y_snake[0] + 20;
										if (head_down >= fruit_up &&
											head_left <= fruit_right &&
											head_right >= fruit_left)
											begin
												x_fruit <= {2'b00, a+15};
												y_fruit <= {2'b000, b+15};	
												snake_length <= snake_length + 1;
												is_exist[snake_length] <=1;
												x_snake[snake_length] <= x_snake[snake_length-1];
												y_snake[snake_length] <= y_snake[snake_length-1]-20;
												score <= score +1;
											end
									else if (head_down >= 460) // check if collide with walls
											begin
												state <= DEAD;
											end
									end
								4'b1000: //moving up
									begin
										y_snake[0] <= y_snake[0] - 20;
										y_head <= y_snake[0] - 20;
										if (head_up <= fruit_down &&
											head_left <= fruit_right &&
											head_right >= fruit_left)
											begin
												x_fruit <= {2'b00, a+15};
												y_fruit <= {2'b000, b+15};	
												snake_length <= snake_length + 1;
												is_exist[snake_length] <=1;
												x_snake[snake_length] <= x_snake[snake_length-1];
												y_snake[snake_length] <= y_snake[snake_length-1]+20;
												score <= score +1;
											end
									else if (head_up <= 20) // check if collide with walls
											begin
												state <= DEAD;
											end
									end
								4'b0000: 
									begin
										x_head <= x_head;
										y_head <= y_head;
									end
							endcase
							
							// detecting self-collision	
						
							if (!(( y_snake[0] == y_snake[1] && x_snake[0] == x_snake[1] && is_exist[1] == 1 )
									|| ( y_snake[0] == y_snake[2] && x_snake[0] == x_snake[2] && is_exist[2] == 1 )
									|| ( y_snake[0] == y_snake[3] && x_snake[0] == x_snake[3] && is_exist[3] == 1 )
									|| ( y_snake[0] == y_snake[4] && x_snake[0] == x_snake[4] && is_exist[4] == 1 )
									|| ( y_snake[0] == y_snake[5] && x_snake[0] == x_snake[5] && is_exist[5] == 1 )
									|| ( y_snake[0] == y_snake[6] && x_snake[0] == x_snake[6] && is_exist[6] == 1 )
									|| ( y_snake[0] == y_snake[7] && x_snake[0] == x_snake[7] && is_exist[7] == 1 )
									|| ( y_snake[0] == y_snake[8] && x_snake[0] == x_snake[8] && is_exist[8] == 1 )
									|| ( y_snake[0] == y_snake[9] && x_snake[0] == x_snake[9] && is_exist[9] == 1 )
									|| ( y_snake[0] == y_snake[10] && x_snake[0] == x_snake[10] && is_exist[10] == 1 )
									|| ( y_snake[0] == y_snake[11] && x_snake[0] == x_snake[11] && is_exist[11] == 1 )
									|| ( y_snake[0] == y_snake[12] && x_snake[0] == x_snake[12] && is_exist[12] == 1 )
									|| ( y_snake[0] == y_snake[13] && x_snake[0] == x_snake[13] && is_exist[13] == 1 )
									|| ( y_snake[0] == y_snake[14] && x_snake[0] == x_snake[14] && is_exist[14] == 1 )
									|| ( y_snake[0] == y_snake[15] && x_snake[0] == x_snake[15] && is_exist[15] == 1 ))
									&& snake_direction != 4'b0000)
									begin	// update the position of individual blocks										
											x_snake[1] <= x_snake[0];
											y_snake[1] <= y_snake[0];
										
											x_snake[2] <= x_snake[1];
											y_snake[2] <= y_snake[1];
										
											x_snake[3] <= x_snake[2];
											y_snake[3] <= y_snake[2];
										
											x_snake[4] <= x_snake[3];
											y_snake[4] <= y_snake[3];
											
											x_snake[5] <= x_snake[4];
											y_snake[5] <= y_snake[4];
											
											x_snake[6] <= x_snake[5];
											y_snake[6] <= y_snake[5];
											
											x_snake[7] <= x_snake[6];
											y_snake[7] <= y_snake[6];
											
											x_snake[8] <= x_snake[7];
											y_snake[8] <= y_snake[7];
											
											x_snake[9] <= x_snake[8];
											y_snake[9] <= y_snake[8];
											
											x_snake[10] <= x_snake[9];
											y_snake[10] <= y_snake[9];
											
											x_snake[11] <= x_snake[10];
											y_snake[11] <= y_snake[10];
											
											x_snake[12] <= x_snake[11];
											y_snake[12] <= y_snake[11];
											
											x_snake[13] <= x_snake[12];
											y_snake[13] <= y_snake[12];
											
											x_snake[14] <= x_snake[13];
											y_snake[14] <= y_snake[13];
											
											x_snake[15] <= x_snake[14];
											y_snake[15] <= y_snake[14];
									end
								
								else 
									if (snake_direction != 4'b0000)
										begin
											state <= DEAD;
										end
								if(snake_length == 15) 
									state <= WIN;
						 end
				//DEAD:	
				endcase
			end
		end
	end
	
	
		/////////////////////////////////////////////////////////////////
	///////////////		VGA control starts here		/////////////////
	/////////////////////////////////////////////////////////////////
	
	// snake
	wire R = ((state==PLAYING)&&((((CounterX -x_head)*(CounterX-x_head) +(CounterY-y_head)*(CounterY-y_head))<=100)
				|| (is_exist[1] && CounterY>=(y_snake[1]-10) && CounterY<=(y_snake[1]+10) && CounterX>=(x_snake[1]-10) && CounterX<=(x_snake[1]+10))
				|| (is_exist[2] && (((CounterX -x_snake[2])*(CounterX-x_snake[2]) +(CounterY-y_snake[2])*(CounterY-y_snake[2]))<=100))
				|| (is_exist[3] && CounterY>=(y_snake[3]-10) && CounterY<=(y_snake[3]+10) && CounterX>=(x_snake[3]-10) && CounterX<=(x_snake[3]+10))
				|| (is_exist[4] && (((CounterX -x_snake[4])*(CounterX-x_snake[4]) +(CounterY-y_snake[4])*(CounterY-y_snake[4]))<=100))
				|| (is_exist[5] && CounterY>=(y_snake[5]-10) && CounterY<=(y_snake[5]+10) && CounterX>=(x_snake[5]-10) && CounterX<=(x_snake[5]+10))
				|| (is_exist[6] && (((CounterX -x_snake[6])*(CounterX-x_snake[6]) +(CounterY-y_snake[6])*(CounterY-y_snake[6]))<=100))
				|| (is_exist[7] && CounterY>=(y_snake[7]-10) && CounterY<=(y_snake[7]+10) && CounterX>=(x_snake[7]-10) && CounterX<=(x_snake[7]+10))
				|| (is_exist[8] && (((CounterX -x_snake[8])*(CounterX-x_snake[8]) +(CounterY-y_snake[8])*(CounterY-y_snake[8]))<=100))
				|| (is_exist[9] && CounterY>=(y_snake[9]-10) && CounterY<=(y_snake[9]+10) && CounterX>=(x_snake[9]-10) && CounterX<=(x_snake[9]+10))
				|| (is_exist[10] && (((CounterX -x_snake[10])*(CounterX-x_snake[10]) +(CounterY-y_snake[10])*(CounterY-y_snake[10]))<=100))
				|| (is_exist[11] && CounterY>=(y_snake[11]-10) && CounterY<=(y_snake[11]+10) && CounterX>=(x_snake[11]-10) && CounterX<=(x_snake[11]+10))
				|| (is_exist[12] && (((CounterX -x_snake[12])*(CounterX-x_snake[12]) +(CounterY-y_snake[12])*(CounterY-y_snake[12]))<=100))
				|| (is_exist[13] && CounterY>=(y_snake[13]-10) && CounterY<=(y_snake[13]+10) && CounterX>=(x_snake[13]-10) && CounterX<=(x_snake[13]+10))
				|| (is_exist[14] && (((CounterX -x_snake[14])*(CounterX-x_snake[14]) +(CounterY-y_snake[14])*(CounterY-y_snake[14]))<=100))
				|| (is_exist[15] && CounterY>=(y_snake[15]-10) && CounterY<=(y_snake[15]+10) && CounterX>=(x_snake[15]-10) && CounterX<=(x_snake[15]+10))));
	
		wire G = //border
				(((CounterY >=0 && CounterY <=10) || (CounterY >= 470 && CounterY <= 480)
				|| ((CounterX >= 0 && CounterX <=10) || (CounterX >= 630 && CounterX <=640)))
				//WIN
				|| ((state == WIN)&&(((CounterX >=210)&&(CounterX<=230)&&(CounterY>=150)&&(CounterY<=280)) // W
				|| ((CounterX >=230)&&(CounterX<=245)&&(CounterY>=240)&&(CounterY<=280))
				|| ((CounterX >=245)&&(CounterX<=260)&&(CounterY>=200)&&(CounterY<=280))
				|| ((CounterX >=260)&&(CounterX<=275)&&(CounterY>=240)&&(CounterY<=280))
				|| ((CounterX >=275)&&(CounterX<=295)&&(CounterY>=150)&&(CounterY<=280))
				|| ((CounterX >= 310) &&(CounterX<=335) && (CounterY>=150) && (CounterY<=280))//I
				|| ((CounterX >= 350)&&(CounterX<=370)&&(CounterY>=150)&&(CounterY<=280)) //N
				|| ((CounterX>=370)&&(CounterX<=385)&&(CounterY>=150)&&(CounterY<=180))
				|| ((CounterX>=385)&&(CounterX<=405)&&(CounterY>=150)&&(CounterY<=280))))
				//DEAD
				||((state == DEAD) &&(
				   ((CounterX >= 190)&&(CounterX<=205)&&(CounterY>=150)&&(CounterY<=280)) //D
				|| ((CounterX>=205)&&(CounterX<=230)&&(((CounterY>=150)&&(CounterY<=170))||((CounterY>=260)&&(CounterY<=280))))
				|| ((CounterX>=230)&&(CounterX<=245)&&(CounterY>=150)&&(CounterY<=280))
				|| ((CounterX>=260)&&(CounterX<=275)&&(CounterY>=150)&&(CounterY<=280))//E
				|| ((CounterX>=275)&&(CounterX<=300)&&(((CounterY>=150)&&(CounterY<=180))||((CounterY>=200)&&(CounterY<=230))||((CounterY>=250)&&(CounterY<=280))))
				|| ((CounterX>= 315)&&(CounterX<=330)&&(CounterY>=150)&&(CounterY<=280))//A
				|| ((CounterX>= 330)&&(CounterX<=350)&&(((CounterY>=150)&&(CounterY<=165))||((CounterY>=210)&&(CounterY<=225))))
				|| ((CounterX>=350)&&(CounterX<=365)&&(CounterY>=150)&&(CounterY<=280))
				||((CounterX >= 380)&&(CounterX<=395)&&(CounterY>=150)&&(CounterY<=280)) //D
				|| ((CounterX>=395)&&(CounterX<=420)&&(((CounterY>=150)&&(CounterY<=170))||((CounterY>=260)&&(CounterY<=280))))
				|| ((CounterX>=420)&&(CounterX<=435)&&(CounterY>=150)&&(CounterY<=280))))
				// start
				||((state == START)&& (
					CounterY >= 150 && CounterY <= 220 &&
					(CounterX>=200 && CounterX<=240 && (CounterY<=164 || (CounterY<=192 && CounterX<=214) || (CounterY>=178 && CounterY <=192) || (CounterX>=226 && CounterY>=192) || CounterY>=206)  
					|| (CounterX >= 250 && CounterX <= 290 && (CounterY <= 164 || (CounterX >=263 && CounterX<=277) ))
					|| (CounterX >= 300 && CounterX <= 340 && (CounterX <= 314 || CounterX >= 326 || CounterY <= 164 || (CounterY>=185 && CounterY<=200)))
					|| (CounterX >= 350 && CounterX <= 390 && (CounterX <= 364 || CounterY <= 164 || (CounterY>=185 && CounterY<=200)||(CounterX>=376 && CounterX<=390 && CounterY <=185)||(CounterX >=364  && CounterX<=378 && CounterY>=200 && CounterY<=205)||(CounterX >=368  && CounterX<=382 && CounterY>=205 && CounterY<=210) || (CounterX >=372  && CounterX<=386 && CounterY>=210 && CounterY<=215) || (CounterX >=376  && CounterX<=390 && CounterY>=215 && CounterY<=220)))
					|| (CounterX >= 400 && CounterX <= 440 && (CounterY <= 164 || (CounterX >=413 && CounterX<=427) )))			
				)));
		wire B = (state == PLAYING) &&(CounterY>=(y_fruit-5) && CounterY<=(y_fruit+5) && CounterX>=(x_fruit-5) && CounterX<=(x_fruit+5));
	
	always @(posedge clk)
	begin
		vga_r <= R & inDisplayArea;
		vga_r1 <= R & inDisplayArea;
		vga_r2 <= R & inDisplayArea;
	   vga_g <= G & inDisplayArea;
		vga_g1 <= G & inDisplayArea;
		vga_g2 <= G & inDisplayArea;
		vga_b <= B & inDisplayArea;
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
		SSD0 <= score;
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


