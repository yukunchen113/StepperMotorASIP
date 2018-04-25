module delay_counter (input clk, reset_n, start, enable, input [7:0] delay, output reg done);
parameter BASIC_PERIOD=19'd500000;
	reg [7:0] delay_saved;
	reg [18:0] item;
	reg [7:0] item2;
	reg divided_clk;
	always @(posedge clk)//clock divider
	begin
		if(start) delay_saved = delay;
		if(!enable)
		begin
			done = 0;
			item2 = 0;
		end
		if (item == BASIC_PERIOD) //if item reached the requested value
			begin//run the counter 
				if(enable)
					begin
						if(item2 == delay_saved)
							begin
								done = 1;
								item2 = 0;
							end
						else
							begin
								//done = 0;
								item2 = item2 + 1;
							end
					end
				item = 0;
			end
		else 
			begin
				item = item+1; //otherwise, during normal times, increment the item
			end
	end

/*	reg [7:0] reg0,reg1;
	
	reg divided_clk,start_flg;//make a clock divider that counts every BASIC_PERIOD*clk period seconds.
	reg [18:0] item;//temporary register to hold the value of the current count, needs 19 bits
	initial
		begin
			start_flg = 1'b0;
		end
	always @(posedge clk)//clock divider
	begin
		if (start) start_flg =1'b1;
		if (item == BASIC_PERIOD) //if item reached the requested value
			begin
				item = 0; // start item at 0 again
				divided_clk=1; //send a clock pulse
			end
		else 
			begin
				item = item+1; //otherwise, during normal times, increment the item
				divided_clk =0; // divided_clk should be 0 during other times
			end
	end
	
	
	always@(posedge divided_clk)
	begin
		if(!reset_n)
			begin
				done = 1'b0;
				reg1 = 8'b0;
				reg0 = 8'b0;
			end
		else
			begin
				if(start)//if start is pushed
					begin
						reg1 = delay; //reg1 holds the delay value
						reg0 = delay; //reg0 is used as a counter to be decremented from the delay value
					end
				if(start_flg)
					begin
						if(enable) // enable the delay counter
						begin
							if(reg0 >0) 
								begin
									reg0 = reg0-1;
									done = 0; //if counter hasn't reached desired value of 0
								end
							else
								begin
									done = 1; //hold this value when delay is still pressed
								end
						end
						else
							begin
								done = 0; // this needs to be here in case to set done back to 0 when enable is not pressed
								reg0 = reg1; // reset the delay value into the decrement counter
							end
					end
			end
	end

*/
endmodule