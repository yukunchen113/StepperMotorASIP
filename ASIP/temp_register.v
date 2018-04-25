module temp_register (input clk, reset_n, load, increment, decrement, input [7:0] data,
					output reg [7:0] counter,//test
					output negative, positive, zero
					);
	//reg [7:0] counter;
	assign negative = counter[7];
	assign zero = (counter == 8'b0);
	assign positive =(~zero&~negative);
	always@(posedge clk)
		begin
			if(!reset_n) counter = 8'b0;
			else
			begin
				if(load) 
					begin
						counter = data;
					end
				if(increment) counter = counter + 1;
				if(decrement) counter = counter - 1;		
			end
		end
endmodule
