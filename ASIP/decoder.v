module decoder (input [5:0] instruction,
				output br, brz, addi, subi, sr0, srh0, clr, mov, mova, movr, movrhs, pause
);

	assign br = (instruction[5:3] == 3'b100);
	assign clr = (instruction[5:0] == 6'b011000);
	assign brz = (instruction[5:3] == 3'b101);
	assign addi = (instruction[5:3] == 3'b000);
	assign subi = (instruction[5:3] == 3'b001);
	assign sr0 = (instruction[5:2] == 4'b0100);
	assign srh0 = (instruction[5:2] == 4'b0101);
	assign mov = (instruction[5:2] == 4'b0111);
	assign mova = (instruction[5:0] == 6'b110000);
	assign movr = (instruction[5:0] == 6'b110001);
	assign movrhs = (instruction[5:0] == 6'b110010);
	assign pause = (instruction[5:0] == 6'b111111);
endmodule
