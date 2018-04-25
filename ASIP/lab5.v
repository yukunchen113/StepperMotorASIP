// This is the top-level file for lab 5 that connects the datapath and the control unit
module lab5 (input clk, reset_n, output [3:0] stepper_signals, output [3:0] LEDG, 
output [5:0] state, // test
output [7:0] test_out,
output [7:0] test_out1,
output [7:0] test_out2,
output [7:0] test_out3,
output [7:0] test_out4,
output [7:0] test_out5
);

wire br, brz, addi, subi, sr0, srh0, clr, mov, mova, movr, movrhs, pause;
wire delay_done;
wire temp_is_positive, temp_is_negative, temp_is_zero;
wire register0_is_zero;

wire write_reg_file, result_mux_select;
wire [1:0] op1_mux_select, op2_mux_select;
wire start_delay_counter, enable_delay_counter;
wire commit_branch, increment_pc;
wire alu_add_sub, alu_set_low, alu_set_high;
wire load_temp_register, increment_temp_register, decrement_temp_register;
wire [1:0] select_immediate;
wire [1:0] select_write_address;

// connect stepper signals to the green LEDs, so that we can observe them visually
assign LEDG = stepper_signals;

control_fsm the_control_fsm (
	.state(state), //test
	.clk (clk),
	.reset_n (reset_n),
	// Status inputs
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
	.pause (pause),
	.delay_done (delay_done),
	.temp_is_positive (temp_is_positive),
	.temp_is_negative (temp_is_negative),
	.temp_is_zero (temp_is_zero),
	.register0_is_zero (register0_is_zero),
	// Control signal outputs
	.write_reg_file (write_reg_file),
	.result_mux_select (result_mux_select),
	.op1_mux_select (op1_mux_select),
	.op2_mux_select (op2_mux_select),
	.start_delay_counter (start_delay_counter),
	.enable_delay_counter (enable_delay_counter),
	.commit_branch (commit_branch),
	.increment_pc (increment_pc),
	.alu_add_sub (alu_add_sub),
	.alu_set_low (alu_set_low),
	.alu_set_high (alu_set_high),
	.load_temp_register (load_temp_register),
	.increment_temp_register (increment_temp_register),
	.decrement_temp_register (decrement_temp_register),
	.select_immediate (select_immediate),
	.select_write_address (select_write_address)	
);

datapath the_datapath (
	.clk (clk),
	.reset_n (reset_n),
	// Control signals
	.write_reg_file (write_reg_file),
	.result_mux_select (result_mux_select),
	.op1_mux_select (op1_mux_select),
	.op2_mux_select (op2_mux_select),
	.start_delay_counter (start_delay_counter),
	.enable_delay_counter (enable_delay_counter),
	.commit_branch (commit_branch),
	.increment_pc (increment_pc),
	.alu_add_sub (alu_add_sub),
	.alu_set_low (alu_set_low),
	.alu_set_high (alu_set_high),
	.load_temp (load_temp_register),
	.increment_temp (increment_temp_register),
	.decrement_temp (decrement_temp_register),
	.select_immediate (select_immediate),
	.select_write_address (select_write_address),
	// Status outputs
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
	.pause (pause),
	.delay_done (delay_done),
	.temp_is_positive (temp_is_positive),
	.temp_is_negative (temp_is_negative),
	.temp_is_zero (temp_is_zero),
	.register0_is_zero (register0_is_zero),
	// Temporary outputs for debugging purposes
	.test_out(test_out),
	.test_out1(test_out1),
	.test_out2(test_out2),
	.test_out3(test_out3),
	.test_out4(test_out4),
	.test_out5(test_out5),
	// Motor control outputs
	.stepper_signals (stepper_signals)
);


endmodule
