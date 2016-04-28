// Pong VGA game
// (c) fpga4fun.com

module pong(CLK, VGA_HS, VGA_VS, VGA_R, VGA_G, VGA_B );
input CLK;
output VGA_HS, VGA_VS, VGA_R, VGA_G, VGA_B;

wire inDisplayArea;
wire [9:0] CounterX;
wire [8:0] CounterY;

hvsync_generator syncgen(.CLK(CLK), .VGA_HS(VGA_HS), .VGA_VS(VGA_VS), 
  .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));

////////////////////////////////////////////////////////////////
reg [3:0] myCount;
//wire R = BouncingObject | ball | (CounterX[3] ^ CounterY[3]);
//wire G = BouncingObject | ball;
//wire B = BouncingObject | ball;

reg VGA_R, VGA_G, VGA_B;
always @(posedge CLK)
begin
	if( myCount <= 7 )
		begin
			myCount <= myCount + 1;
			VGA_R <= 1'b0 & inDisplayArea;
			VGA_G <= 1'b0 & inDisplayArea;
			VGA_B <= 1'b0 & inDisplayArea;
		end
	else
		begin
			myCount <= 0;
			VGA_R <= 1'b1 & inDisplayArea;
			VGA_G <= 1'b1 & inDisplayArea;
			VGA_B <= 1'b1 & inDisplayArea;
		end
//	VGA_R <= edge & inDisplayArea;
//	VGA_G <= edge & inDisplayArea;
//	VGA_B <= edge & inDisplayArea;
end

endmodule