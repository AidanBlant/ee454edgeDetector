module file_readmemh;

parameter numRows = 128; // the Height
parameter numColumns = 128; // the Width

reg [15:0] data [0:8731];
reg [7:0] imageOut[0:16384];

// initialize the hexadecimal reads from the vectors.txt file
initial $readmemh("LENAG3.txt", data);
// Note: BMP Header is 54 bytes
// padding every line, so 8 bitsBytes? every 128 pixels


integer i;
integer j;
integer imIter;
integer x;
integer y;

reg [15:0] a;


/*read and display the values from the text file on screen*/ 

initial
begin
	$display("rdata:");

	imIter = 0;

	for ( i = 0; i < numRows; i=i+1)
	begin
		$write("i:%d ",i);
		for( j = 0; j < numColumns; j = j + 1 )
		begin
			// So i * (numColumns + padding) makes the row, and 54 is offset, and +j
			// Also though, extra at 129 makes it weird?
			a = data[ 54 + (i*numColumns) + j ];

			imageOut[imIter] = a[15:8];
			imageOut[imIter+1] = a[7:0];
			imIter = imIter + 2;
			
			//$write("%d",imIter);
		end
		//$display("");
	end

	$display("imIter: %d", imIter);
	$display("Now showing the output array");

	for( x = 0; x < 128; x = x + 1 )
	begin
		$write("X:%-3d: ",x);

		for( y = 0; y < 128; y = y + 1 )
		begin
			//$write("%-2d:%-3d ", (x*numColumns)+y, imageOut[ ( x * 128 ) + y] );
			$write("%-3d ",imageOut[ (x*128) + y ]);	
		end
		$display("");
	end

end


endmodule 

//		$write("%d:%h",i,a);
//			$write("%d:%-4h ",i,data[i]);
//			$write("%-3d ",b);
//			$display("%-3d",c);