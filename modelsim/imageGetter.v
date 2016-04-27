module imageGetter  #(parameter WIDTH, parameter DEPTH)(
	input clk,
	input rst_n,
	output [WIDTH*DEPTH*8:0] theDataout
);

reg [WIDTH*DEPTH*8:0] dataout;
assign theDataout = dataout;

reg [WIDTH*DEPTH*8:0] memory; 	//memory
integer i;					// 17,462 bytes for example

//$readmemh for hex

reg mReadFlag;

initial $readmemh("LENAG.txt",memory);

always @(posedge clk, negedge rst_n)
begin
if(!rst_n)
	begin
		dataout <= 'b0;
		i = 0;
		mReadFlag <= 1'b0;
	end
else
	begin
		if( mReadFlag == 1'b0 )
		begin
			$readmemh("LENAG.txt", memory);
			mReadFlag <= 1'b1;
		end
	end
end


endmodule


//				$display($time, " << Starting the Simulation >>");
//				$display("%d%d%d%d%d%d%d%d",memory[i][7],memory[i][6],memory[i][5],memory[i][4],memory[i][3],memory[i][2],memory[i][1],memory[i][0]);
//