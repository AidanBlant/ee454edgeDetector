module sobel #(parameter WIDTH, parameter DEPTH)(

	input [WIDTH*DEPTH:0] inputImage,
	output bmpOutput

);

integer Y;
integer X;
integer I;
integer J;
integer sumX;
integer sumY;
integer SUM;

integer theAbs;

integer xSum;
integer ySum;

task absX;
	input integer a;
	begin
		if( a < 0 )
			xSum = a * -1;
		else
			xSum = a;
	end
endtask


task absY;
	input integer a;
	begin
		if( a < 0 )
			ySum = a * -1;
		else
			ySum = a;
	end
endtask




initial
begin

for(Y=0; Y<=(DEPTH-1); Y = Y+1)
begin
	for(X=0; X<=(WIDTH-1); X= X+1)
	begin
		sumX = 0;
		sumY = 0;

        // image boundaries
		if(Y==0 || Y==(DEPTH-1))
			SUM = 0;
		else if(X==0 || X==(WIDTH-1))
			SUM = 0;

		// Convolution starts here
		else
		begin

			//-------X GRADIENT APPROXIMATION-----
			for(I=-1; I <= 1; I = I + 1)
				begin
					for(J=-1; J<=1; J = J + 1)
					begin
						//sumX = sumX + (integer)( (*(originalImage.data + X + I + (Y + J)*WIDTH)) * GX[I+1][J+1]);
						sumX = sumX + 2; // Random garbage
					end
			end

			//-------Y GRADIENT APPROXIMATION------
			for(I=-1; I<=1; I = I + 1)
			begin
				for(J=-1; J<=1; J = J + 1)
				begin
					//sumY = sumY + (int)( (*(originalImage.data + X + I + (Y + J)*originalImage.cols)) * GY[I+1][J+1]);
				end
			end

			//---GRADIENT MAGNITUDE APPROXIMATION (Myler p.218)---
			absX(sumX);
			absY(sumY);

			//SUM = abs(sumX) + abs(sumY);
			SUM = xSum + ySum;
		end

		if(SUM>255) SUM=255;
		if(SUM<0) SUM=0;

		//*(edgeImage.data + X + Y*originalImage.cols) = 255 - (unsigned char)(SUM);
		//fwrite((edgeImage.data + X + Y*originalImage.cols),sizeof(char),1,bmpOutput);

	end

end

end

endmodule
