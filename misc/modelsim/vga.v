`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module vga /*parameter WIDTH, parameter DEPTH*/(
	//input [WIDTH*DEPTH:0] bmpInput,
	input wire CLK,			//pixel clock: 25MHz
	input wire CPU_RESETN,			//asynchronous reset
	output wire VGA_HS,		//horizontal sync out
	output wire VGA_VS,		//vertical sync out
	output reg [2:0] VGA_R,	//red vga output
	output reg [2:0] VGA_G, //green vga output
	output reg [2:0] VGA_B	//blue vga output
	);

// video structure constants
parameter hpixels = 9;// horizontal pixels per line
parameter vlines = 9; // vertical lines per frame
parameter hpulse = 96; 	// hsync pulse length
parameter vpulse = 2; 	// vsync pulse length

parameter hbp = 144; 	// end of horizontal back porch
parameter hfp = 784; 	// beginning of horizontal front porch
parameter vbp = 31; 		// end of vertical back porch
parameter vfp = 511; 	// beginning of vertical front porch

reg [9*9:0] bmpInput = 81'b0000010000100001000010000100001000010000100001000010000100001000010000010000100001;


// registers for storing the horizontal & vertical counters
reg [9:0] hc;
reg [9:0] vc;

// Horizontal & vertical counters --
// this is how we keep track of where we are on the screen.
// ------------------------
// Sequential "always block", which is a block that is
// only triggered on signal transitions or "edges".
// posedge = rising edge  &  negedge = falling edge
// Assignment statements can only be used on type "reg" and need to be of the "non-blocking" type: <=
always @(posedge CLK or posedge CPU_RESETN)
begin
	// reset condition
	if (CPU_RESETN == 1)
	begin
		hc <= 0;
		vc <= 0;
	end
	else
	begin
		// keep counting until the end of the line
		if (hc < hpixels - 1)
			hc <= hc + 1;
		else
		// When we hit the end of the line, reset the horizontal
		// counter and increment the vertical counter.
		// If vertical counter is at the end of the frame, then
		// reset that one too.
		begin
			hc <= 0;
			if (vc < vlines - 1)
				vc <= vc + 1;
			else
				vc <= 0;
		end
		
	end
end

// generate sync pulses (active low)
// ----------------
// "assign" statements are a quick way to
// give values to variables of type: wire
assign VGA_HS = (hc < hpulse) ? 0:1;
assign VGA_VS = (vc < vpulse) ? 0:1;

// display 100% saturation colorbars
// ------------------------
// Combinational "always block", which is a block that is
// triggered when anything in the "sensitivity list" changes.
// The asterisk implies that everything that is capable of triggering the block
// is automatically included in the sensitivty list.  In this case, it would be
// equivalent to the following: always @(hc, vc)
// Assignment statements can only be used on type "reg" and should be of the "blocking" type: =
always @(*)
begin

	// display black when edge
	if (bmpInput[vc*9+hc]==1)
	begin
		VGA_R = 3'b111;
		VGA_G = 3'b111;
		VGA_B = 3'b111;
	end
	// white because not edge
	else
	begin
		VGA_R = 3'b000;
		VGA_G = 3'b000;
		VGA_B = 3'b000;
	end
	
end

endmodule
