module alu (input add_sub, set_low, set_high, input [7:0] operanda , operandb, output reg [7:0] result);
	always@(*)
		begin
			case ({set_low,set_high})
				2'b10: result = {operanda[7:4], operandb[3:0]};
				2'b01: result = {operandb[3:0], operanda[3:0]};
				2'b00:
					begin
						if(~add_sub) result = operanda + operandb;
						else result = operanda - operandb;
					end
				2'b11: result = 8'b0;
			endcase
		end
endmodule
