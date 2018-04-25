module result_mux (
	input select_result,
	input [7:0] alu_result,
	output [7:0] result
);
	assign result = (select_result)?alu_result:8'b0;
endmodule
