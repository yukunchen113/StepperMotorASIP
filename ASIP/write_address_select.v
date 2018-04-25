module write_address_select (input [1:0] select, input [1:0] reg_field0, reg_field1, output reg [1:0] write_address);
	always@(*)
	begin
		case (select)
			2'b00: write_address = 2'b0;
			2'b01: write_address = reg_field0;
			2'b10: write_address = reg_field1;
			2'b11: write_address = 2'b10;
		endcase
	end


endmodule
