module op1_mux (input [1:0] select, input [7:0] pc, register, register0, position,
				output reg [7:0] result);
	always@(*)
		begin
			case (select)
				2'b00: result = pc;
				2'b01: result = register;
				2'b10: result = position;
				2'b11: result = register0;
			endcase
		end
endmodule
