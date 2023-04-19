/**
 * READ THIS DESCRIPTION!
 *
 * This is your processor module that will contain the bulk of your code submission. You are to implement
 * a 5-stage pipelined processor in this module, accounting for hazards and implementing bypasses as
 * necessary.
 *
 * Ultimately, your processor will be tested by a master skeleton, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file, Wrapper.v, acts as a small wrapper around your processor for this purpose. Refer to Wrapper.v
 * for more details.
 *
 * As a result, this module will NOT contain the RegFile nor the memory modules. Study the inputs 
 * very carefully - the RegFile-related I/Os are merely signals to be sent to the RegFile instantiated
 * in your Wrapper module. This is the same for your memory elements. 
 *
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for RegFile
    ctrl_writeReg,                  // O: Register to write to in RegFile
    ctrl_readRegA,                  // O: Register to read from port A of RegFile
    ctrl_readRegB,                  // O: Register to read from port B of RegFile
    data_writeReg,                  // O: Data to write to for RegFile
    data_readRegA,                  // I: Data from port A of RegFile
    data_readRegB                   // I: Data from port B of RegFile
	 
	);

	// Control signals
	input clock, reset;
	
	// Imem
    output [31:0] address_imem;
	input [31:0] q_imem;

	// Dmem
	output [31:0] address_dmem, data;
	output wren;
	input [31:0] q_dmem;

	// Regfile
	output ctrl_writeEnable;
	output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	output [31:0] data_writeReg;
	input [31:0] data_readRegA, data_readRegB;

	/* YOUR CODE STARTS HERE */
    wire setx;
    wire[31:0] target, normal_out;
    wire[99:0] in_XM, out_XM;
    wire[1:0] which_B, which_A, which_B_rd;
    wire ctrl_MULT, ctrl_DIV, multdiv_exception, multdiv_resultRDY, should_mult, turn_on_mult, turn_on_div, should_div, muldiv_ready;
    wire[99:0] in_MW, out_MW;
    wire access_memory, Cout, isNotEqual2, isLessThan2, overflow2, stall, xs, WM_pass;
    wire[31:0] PC_in, plus4_out, PC_out;
    wire[31:0] branch_adder_sum, branch_mux_out, jump_val, jump_mux_out, PC_mux_out, ALUinA_out, mux1_out, multdiv_ex_out, Addi_ovf_status;
    wire[63:0] in_FD, out_FD, into_FD_reg;
    wire[31:0] immed_extended, B_mux_out, B_rd, B_r, nop, instruct, to_write, status_out, write_out, B, A, not_addi_ovf_out, ovf_status, alu_out, multdiv_result, operation_out;
    wire[4:0] ALU_mux_out, rd, if_branch, rt_rd_out, jal_only_mux_out;
    wire[131:0] in_DX, out_DX;
    wire clock_mux_out, multdiv_clock, is_JAL, is_JAL_DX, jump_adder_cout, not_zero, less_than, branch_mux_ctrl, setx_except_ctrl;

    mux_2_1bit clock_mux(clock_mux_out, multdiv_clock, !clock, 1'b0);

    register PC(PC_out, PC_in, clock_mux_out, !stall, reset);
    assign address_imem = PC_out;
    adder_32bit plus4(plus4_out, Cout, PC_out, 32'b1, 1'b0);
    // assign PC_in = plus4_out; //Change this after arithmetic submission

    assign in_FD[63:32] = plus4_out;
    assign in_FD[31:0] = q_imem;
    mux_2_64bits flush_FD(into_FD_reg, (branch_mux_ctrl || setx_except_ctrl || out_DX[0]), in_FD, 64'b0);
    reg_64 FD(out_FD, into_FD_reg, clock_mux_out, !stall, reset); //Should you always be able to write here?

    // D stage
    assign nop = 32'b0;
    assign xs = (out_FD[31:27] == 5'b10110) || (out_FD[31:27] == 5'b10101);
    assign stall = (out_DX[35:31] == 5'b01000) && ((out_FD[21:17] == out_DX[30:26]) || ((out_FD[16:12] == out_DX[30:26]) && (out_FD[31:27] != 5'b00111)));
    mux_2 nopers(instruct, (stall || branch_mux_ctrl || setx_except_ctrl || out_DX[0]), out_FD[31:0], nop);
    assign in_DX[131:100] = out_FD[63:32];
    decode_OP decoder(instruct[31:27], in_DX[3], in_DX[2], in_DX[1], in_DX[0]);
    mux_2_5bit if_bex_A(ctrl_readRegA, xs, instruct[21:17], 5'b11110);
    mux_2_5bit rt_or_rd(rt_rd_out, (in_DX[2] || in_DX[0]), instruct[16:12], instruct[26:22]);
    mux_2_5bit if_bex_B(ctrl_readRegB, xs, rt_rd_out, 5'b0);
    assign in_DX[99:68] = data_readRegA;
    assign in_DX[67:36] = data_readRegB;
    assign in_DX[35:4] = instruct[31:0];
    reg_132 DX(out_DX, in_DX, clock_mux_out, 1'b1, reset);

    // X stage

    //PC stuff
    adder_32bit branch_adder(branch_adder_sum, jump_adder_cout, out_DX[131:100], immed_extended, 1'b0);
    assign not_zero = isNotEqual2 && ((!out_DX[35] && !out_DX[34] && !out_DX[33] && out_DX[32] && !out_DX[31]) || (out_DX[35] && !out_DX[34] && out_DX[33] && out_DX[32] && !out_DX[31]));
    assign less_than = isLessThan2 && (!out_DX[35] && !out_DX[34] && out_DX[33] && out_DX[32] && !out_DX[31]);
    assign branch_mux_ctrl = not_zero || less_than;
    mux_2 branch_mux(branch_mux_out, branch_mux_ctrl, out_DX[131:100], branch_adder_sum);
    assign jump_val[31:27] = 5'b0;
    assign jump_val[26:0] = out_DX[30:4];
    assign setx_except_ctrl = (out_DX[1] && (out_DX[35:31] != 5'b10101) && ((out_DX[35:31] != 5'b10110) || ((out_DX[35:31] == 5'b10110) && not_zero)));
    mux_2 jump_mux(jump_mux_out, setx_except_ctrl, branch_mux_out, jump_val);
    mux_2 PC_mux(PC_mux_out, (branch_mux_ctrl || setx_except_ctrl), plus4_out, jump_mux_out);
    mux_2 jr_mux(PC_in, out_DX[0], PC_mux_out, B);

    sign_ex sign_extender(immed_extended, out_DX[20:4]);
    assign which_B[0] = ((out_MW[35:31] == 5'b00010) || (out_MW[35:31] == 5'b00110) || (out_MW[35:31] != 5'b00111) && (out_MW[30:26] == out_DX[20:16])) && ((out_XM[35:31] != 5'b00111) && ((out_XM[35:31] == 5'b00010) || (out_XM[35:31] == 5'b00110) || out_XM[30:26] != out_DX[20:16]));
    assign which_B[1] = ((out_MW[35:31] == 5'b00111) || (out_DX[20:16] == 5'b0) || (out_XM[30:26] != out_DX[20:16])) && ((out_XM[35:31] == 5'b00111) || (out_DX[20:16] == 5'b0) || (out_MW[30:26] != out_DX[20:16]));
    mux_4 ALUinB(B_r, which_B, out_XM[99:68], write_out, out_DX[67:36], out_DX[67:36]);

    assign which_B_rd[0] = ((out_MW[35:31] != 5'b00111) && (out_MW[30:26] == out_DX[30:26])) && ((out_XM[35:31] != 5'b00111) && (out_XM[30:26] != out_DX[30:26]));
    assign which_B_rd[1] = ((out_MW[35:31] == 5'b00111) || (out_DX[30:26] == 5'b0) || (out_XM[30:26] != out_DX[30:26])) && ((out_XM[35:31] == 5'b00111) || (out_DX[30:26] == 5'b0) || (out_MW[30:26] != out_DX[30:26]));
    mux_4 ALUinB_rd(B_rd, which_B_rd, out_XM[99:68], write_out, out_DX[67:36], out_DX[67:36]);

    mux_2 if_I_orJII(B, (out_DX[2] || out_DX[0]), B_r, B_rd);

    assign which_A[0] = ((out_MW[35:31] != 5'b00111) && (out_MW[30:26] == out_DX[25:21])) && ((out_XM[35:31] != 5'b00111) && (out_XM[30:26] != out_DX[25:21]));
    assign which_A[1] = ((out_MW[35:4] == 32'b0) || (out_MW[35:31] == 5'b00111) || (out_MW[30:26] == 5'b0) || (out_MW[30:26] != out_DX[25:21])) && ((out_XM[35:4] == 32'b0) || (out_XM[35:31] == 5'b00111) || (out_XM[30:26] == 5'b0) || (out_XM[30:26] != out_DX[25:21]));
    mux_4 ALUinA(ALUinA_out, which_A, out_XM[99:68], write_out, out_DX[99:68], out_DX[99:68]);

    mux_2 bex_mux1(mux1_out, (out_DX[35:31] == 5'b10110 && out_XM[35:31] == 5'b10101), ALUinA_out, out_XM[30:4]);
    mux_2 bex_mux2(A, (out_DX[35:31] == 5'b10110 && out_MW[35:31] == 5'b10101), mux1_out, out_MW[30:4]);

    assign ctrl_MULT = (!out_DX[35] && !out_DX[34] && !out_DX[33] && !out_DX[32] && !out_DX[31]) && (!out_DX[10] && !out_DX[9] && out_DX[8] && out_DX[7] && !out_DX[6]);
    assign ctrl_DIV = (!out_DX[35] && !out_DX[34] && !out_DX[33] && !out_DX[32] && !out_DX[31]) && (!out_DX[10] && !out_DX[9] && out_DX[8] && out_DX[7] && out_DX[6]);
    dffe_ref mult_stall(turn_on_mult, ctrl_MULT ^ multdiv_resultRDY, clock, 1'b1, 1'b0);
    assign should_mult = ctrl_MULT && !turn_on_mult;
    dffe_ref div_stall(turn_on_div, ctrl_DIV ^ multdiv_resultRDY, clock, 1'b1, 1'b0);
    assign should_div = ctrl_DIV && !turn_on_div;
    assign multdiv_clock = multdiv_resultRDY ^ (ctrl_DIV || ctrl_MULT);
    r_multdiv mul_div(A, B, should_mult, should_div, clock, multdiv_result, multdiv_exception, multdiv_resultRDY);
    mux_2 multdiv_ex(multdiv_ex_out, out_DX[6], 32'd4, 32'd5);

    mux_2 B_mux(B_mux_out, (out_DX[2] && out_DX[35:31] != 5'b00010 && out_DX[35:31] != 5'b00110), B, immed_extended);
    mux_2_5bit ALU_mux(ALU_mux_out, out_DX[2], out_DX[10:6], 5'b0);
    mux_2_5bit ALU_branch_mux(if_branch, (out_DX[35:31] == 5'b00010 || out_DX[35:31] == 5'b00110), ALU_mux_out, 5'b00001);
    alu X_alu(A, B_mux_out, if_branch, out_DX[15:11], alu_out, isNotEqual2, isLessThan2, overflow2);
    mux_2 multdiv_or_alu(operation_out, multdiv_resultRDY, alu_out, multdiv_result);
    mux_2 not_addi_ovf(not_addi_ovf_out, out_DX[6], 32'd1, 32'd3);
    mux_2 addi_ovf(Addi_ovf_status, (out_DX[35:31] == 5'b00101), not_addi_ovf_out, 32'd2);
    mux_2 if_md(ovf_status, (out_DX[3] && ((out_DX[10:6] == 5'b00110) || (out_DX[10:6] == 5'b00111))), Addi_ovf_status, multdiv_ex_out);
    mux_2_5bit ovf(in_XM[30:26], overflow2 || (multdiv_exception && ((out_DX[10:6] == 5'b00110) || (out_DX[10:6] == 5'b00111))), out_DX[30:26], 5'b11110);
    mux_2 over_status(status_out, overflow2 || (multdiv_exception && ((out_DX[10:6] == 5'b00110) || (out_DX[10:6] == 5'b00111))), operation_out, ovf_status);
    assign is_JAL_DX = !out_DX[35] && !out_DX[34] && !out_DX[33] && out_DX[32] && out_DX[31];
    mux_2 jal_mux(in_XM[99:68], is_JAL_DX, status_out, out_DX[131:100]);
    assign in_XM[67:36] = out_DX[67:36];
    assign in_XM[35:31] = out_DX[35:31];
    assign in_XM[25:0] = out_DX[25:0];
    reg_100 XM(out_XM, in_XM, clock_mux_out, 1'b1, reset);

    // M stage
    assign address_dmem = out_XM[99:68];
    assign WM_pass = out_MW[30:26] == out_XM[30:26];
    mux_2 Mem_mux(data, WM_pass, out_XM[67:36], write_out);

    assign wren = !out_XM[35] & !out_XM[34] & out_XM[33] & out_XM[32] & out_XM[31];
    assign in_MW[99:68] = out_XM[99:68];
    assign in_MW[67:36] = q_dmem;
    assign in_MW[35:0] = out_XM[35:0];
    reg_100 MW(out_MW, in_MW, clock_mux_out, 1'b1, reset);

    // W stage
    assign setx = (out_MW[35:31] == 5'b10101);
    assign target[31:27] = 5'b0;
    assign target[26:0] = out_MW[30:4];
    assign is_JAL = !out_MW[35] && !out_MW[34] && !out_MW[33] && out_MW[32] && out_MW[31];
    assign access_memory = (!out_MW[35] & out_MW[34] & !out_MW[33] & !out_MW[32] & !out_MW[31]);
    mux_2 out_mux(normal_out, access_memory, out_MW[99:68], out_MW[67:36]);
    mux_2 setx_mux(write_out, setx, normal_out, target);
    assign data_writeReg = write_out;
    mux_2_5bit jal_only_mux(jal_only_mux_out, is_JAL, out_MW[30:26], 5'b11111);
    mux_2_5bit setx_only_mux(rd, setx, jal_only_mux_out, 5'b11110);
    assign ctrl_writeReg = rd;
    assign ctrl_writeEnable = (!out_MW[35] & !out_MW[33] & !out_MW[32] & !out_MW[31]) | (!out_MW[35] & !out_MW[34] & out_MW[33] & !out_MW[32] & out_MW[31]) | is_JAL | setx;
	/* END CODE */

endmodule