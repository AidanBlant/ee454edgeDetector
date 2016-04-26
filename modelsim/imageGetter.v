module imageGetter(
	input clk,
	input rst_n
);

reg [15:0] dataout;
//assign theDataout = dataout [15:0];

reg [15:0] memory [0:15]; 	//memory
integer i;					// 17,462 bytes for example

//$readmemh for hex

reg mReadFlag;

initial $readmemh("LENAG.txt",memory);

always @(posedge clk, negedge rst_n)
begin
if(!rst_n)
	begin
		dataout <= 1'b0;
		i = 0;
		mReadFlag <= 1'b0;
	end
else
//	begin
//		if( mReadFlag == 1'b0 )
//		begin
//			$readmemh("LENAG.txt", memory);
//			mReadFlag <= 1'b1;
//		end
//		else
		begin
			if( i < 16 )
			begin
				//dataout <= memory[i];
				
				i <= i + 1;
			end
		end
//	end
end


endmodule


//				$display($time, " << Starting the Simulation >>");
//				$display("%d%d%d%d%d%d%d%d",memory[i][7],memory[i][6],memory[i][5],memory[i][4],memory[i][3],memory[i][2],memory[i][1],memory[i][0]);
//