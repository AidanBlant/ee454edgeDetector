module hvsync_generator(CLK, VGA_HS, VGA_VS, inDisplayArea, CounterX, CounterY);
input CLK;
output VGA_HS, VGA_VS;
output inDisplayArea;
output [9:0] CounterX;
output [8:0] CounterY;

//////////////////////////////////////////////////
reg [9:0] CounterX;
reg [8:0] CounterY;
wire CounterXmaxed = (CounterX==10'h2FF);

always @(posedge CLK)
if(CounterXmaxed)
	CounterX <= 0;
else
	CounterX <= CounterX + 1;

always @(posedge CLK)
if(CounterXmaxed) CounterY <= CounterY + 1;

reg	vga_HSs, vga_VSs;
always @(posedge CLK)
begin
	vga_HSs <= (CounterX[9:4]==6'h2D); // change this value to move the display horizontally
	vga_VSs <= (CounterY==500); // change this value to move the display vertically
end

reg inDisplayArea;
always @(posedge CLK)
if(inDisplayArea==0)
	inDisplayArea <= (CounterXmaxed) && (CounterY<480);
else
	inDisplayArea <= !(CounterX==639);
	
assign VGA_HS = ~vga_HSs;
assign VGA_VS = ~vga_VSs;

endmodule
