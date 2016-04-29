module imageGetter(
	input clk
	//input rst_n
	//output [15*(54+128*(128+8))/2-1 :0] dataOut
);

parameter WIDTH = 128;
parameter DEPTH = 128;
parameter arraySize = (54 + WIDTH * (DEPTH+8))/2;
reg rst_n;
integer i;

// Before: 15 * 1091 * 8
// For the lines
//1091*8 + 3 is the number of lines XXXX words
// 54 bit header * WIDTH * DEPTH+PADDING / 2 because  XXXX instead of XX


reg [15:0] memory [0:arraySize-1];


//$readmemh for hex
reg mReadFlag;

//reg [ 16 * arraySize - 1 :0] One_D_array;
//reg [16*546 + 15 * arraySize - 6 : 0 ] One_D_array;
reg [16 * arraySize - 1 : 0 ] One_D_array;
integer j;


initial
begin
	i <= 0;
	$readmemh("aidanSample.txt", memory);
	rst_n <= 1;
	rst_n <= 0;
	rst_n <= 1;

	//dataout[15*(1091*8):0] = [1091*8+3:0][0:15] memory ;

	for (j=0; j < arraySize; j=j+1)
		begin
			if( j < arraySize )
				One_D_array[ 16*j +: 16 ] = memory[j][15:0];
//			$write("%h ",memory[j]);
//			$write("%h ",One_D_array[16*j +: 16]);
//			if(j%128 == 1)
//				$display(" ");
		end
end




always @(posedge clk, negedge rst_n)
begin
	if(!rst_n)
		begin
			//dataout <= 1'b0;
			//i = 0;
			mReadFlag <= 1'b0;
		end
	else
		begin
			begin
				if( i < 16 )
				begin
					$display("i:%d",i);
//					//dataout <= memory[i];
					$display("%d%d%d%d%d%d%d%d: %h",memory[0][7],memory[0][6],memory[0][5],memory[0][4],memory[0][3],memory[0][2],memory[0][1],memory[0][0], memory[0][15:0]);
//					$display("%d%d%d%d%d%d%d%d",memory[1][7],memory[1][6],memory[1][5],memory[1][4],memory[1][3],memory[1][2],memory[1][1],memory[1][0]);
//$display("%d%d%d%d%d%d%d%d",memory[2][7],memory[2][6],memory[2][5],memory[2][4],memory[2][3],memory[2][2],memory[2][1],memory[2][0]);
					i <= i + 1;
				end
			end
		end
end


endmodule

