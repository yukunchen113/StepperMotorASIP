module pc (input clk, reset_n, branch, increment, input [7:0] newpc,
			output reg [7:0] pc);
parameter RESET_LOCATION = 8'h00;
	always@(posedge clk)
		begin
			if(!reset_n) pc = RESET_LOCATION;
			else
			begin
				if(increment) pc = pc+1;
				if(branch) pc = newpc;
			end
		end	
endmodule
