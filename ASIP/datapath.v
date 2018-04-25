module datapath (input clk, reset_n,
				// Control signals
				input write_reg_file, result_mux_select,
				input [1:0] op1_mux_select, op2_mux_select,
				input start_delay_counter, enable_delay_counter,
				input commit_branch, increment_pc,
				input alu_add_sub, alu_set_low, alu_set_high,
				input load_temp, increment_temp, decrement_temp,
				input [1:0] select_immediate,
				input [1:0] select_write_address,
				// Status outputs
				output br, brz, addi, subi, sr0, srh0, clr, mov, mova, movr, movrhs, pause,
				output delay_done,
				output temp_is_positive, temp_is_negative, temp_is_zero,
				output register0_is_zero,
				//test signals
				input [7:0] test_in,
				output [7:0] test_out,
				output [7:0] test_out1,
				output [7:0] test_out2,
				output [7:0] test_out3,
				output [7:0] test_out4,
				output [7:0] test_out5,
				// Motor control outputs
				output [3:0] stepper_signals
				
);
// The comment /*synthesis keep*/ after the declaration of a wire
// prevents Quartus from optimizing it, so that it can be observed in simulation
// It is important that the comment appear before the semicolon
wire [7:0] position /*synthesis keep*/;
wire [7:0] delay /*synthesis keep*/;
wire [7:0] register0 /*synthesis keep*/;
wire [7:0] PC /*synthesis keep*/; 
wire [7:0] data;
wire [7:0] selected0;
wire [7:0] selected1;
wire [7:0] immediate_operand;
wire [7:0] ALU_out /*synthesis keep*/;
wire [7:0] instruction,operanda,operandb;
wire [1:0] write_select;

assign test_out = instruction;		//test
assign test_out1 = delay;		//test
//assign test_out2 = temp_register;			//test
assign test_out3 = register0;		//test
assign test_out4 = position;	//test
assign test_out5 = data;	//test

decoder the_decoder (
	// Inputs
	.instruction (instruction[7:2]),
	// Outputs
	.br (br),
	.brz (brz),
	.addi (addi),
	.subi (subi),
	.sr0 (sr0),
	.srh0 (srh0),
	.clr (clr),
	.mov (mov),
	.mova (mova),
	.movr (movr),
	.movrhs (movrhs),
	.pause (pause)
);
regfile the_regfile(
	// Inputs
	.clk (clk),
	.reset_n (reset_n),
	.write (write_reg_file),
	.data (data), 
	.select0 (instruction[1:0]),
	.select1 (instruction[3:2]),
	.wr_select (write_select),
	// Outputs
	.selected0 (selected0),
	.selected1 (selected1),
	.delay (delay),
	.position (position),
	.register0 (register0)
	//.selected0 (test_out),	//test
	//.selected1 (test_out1),	//test
	//.delay (test_out2),		//test
	//.position (test_out3),	//test
	//.register0 (test_out4)	//test
);

op1_mux the_op1_mux(
	// Inputs
	.select (op1_mux_select),
	.pc (PC),
	.register (selected0),
	.register0 (register0),
	.position (position),
	// Outputs
	.result(operanda)
);

op2_mux the_op2_mux(
	// Inputs
	.select (op2_mux_select),
	.register (selected1),
	.immediate (immediate_operand),
	// Outputs
	.result (operandb)
);

delay_counter the_delay_counter(
	// Inputs
	.clk(clk),
	.reset_n (reset_n),
	.start (start_delay_counter),
	.enable (enable_delay_counter),
	.delay (delay),
	// Outputs
	.done (delay_done)
);

stepper_rom the_stepper_rom(
	// Inputs
	.address (position[2:0]),
	.clock (clk),
	// Outputs
	.q (stepper_signals)
);

pc the_pc(
	// Inputs
	.clk (clk),
	.reset_n (reset_n),
	.branch (commit_branch),
	.increment (increment_pc),
	.newpc (ALU_out),
	//.newpc(test_in),	//test
	// Outputs
	//.pc (test_out),	//test
	.pc (PC)
);

instruction_rom the_instruction_rom(
	// Inputs
	.address (PC),
	.clock (clk),
	// Outputs
	.q (instruction)
	//.q(test_out)		//test
);
//assign instruction = test_in;		//test
alu the_alu(
	// Inputs
	.add_sub (alu_add_sub),
	.set_low (alu_set_low),
	.set_high (alu_set_high),
	.operanda (operanda),
	.operandb (operandb),
	// Outputs
	.result (ALU_out)
);

temp_register the_temp_register(
	// Inputs
	.clk (clk),
	.reset_n (reset_n),
	.load (load_temp),
	.increment (increment_temp),
	.decrement (decrement_temp),
	.data (selected0),
	// Outputs
	.negative (temp_is_negative),
	.positive (temp_is_positive),
	.counter(test_out2),	//test
	.zero (temp_is_zero)
);

immediate_extractor the_immediate_extractor(
	// Inputs
	.instruction (instruction),
	.select (select_immediate),
	// Outputs
	.immediate (immediate_operand)
);

write_address_select the_write_address_select(
	// Inputs
	.select (select_write_address),
	.reg_field0 (instruction[1:0]),
	.reg_field1 (instruction[3:2]),
	// Outputs
	.write_address(write_select)
);

result_mux the_result_mux (
	.select_result (result_mux_select),
	.alu_result (ALU_out),
	.result (data)
);

branch_logic the_branch_logic(
	// Inputs
	.register0 (register0),
	// Outputs
	.branch (register0_is_zero)
);

endmodule
