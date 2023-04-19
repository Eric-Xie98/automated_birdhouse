module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);
        
    input [31:0] data_operandA, data_operandB;
    input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

    output [31:0] data_result;
    output isNotEqual, isLessThan, overflow;

    // add your code here:
    wire[31:0] notB, muxB_out, adder_out, and_out, or_out, sll_out, sra_out;
    wire Cout, w1, eq1, eq2, eq3, eq4, notAdd_out, notA, w2, w3, notBmuxed, LT_mux_out;
    not_32bit notB_gate(notB, data_operandB);
    mux_2 B_mux(muxB_out, ctrl_ALUopcode[0], data_operandB, notB);
    adder_32bit adder(adder_out, Cout, data_operandA, muxB_out, ctrl_ALUopcode[0]);
    and_32bit A_and_B(and_out, data_operandA, data_operandB);
    or_32bit A_or_B(or_out, data_operandA, data_operandB);
    sll shift_left(sll_out, data_operandA, ctrl_shiftamt);
    sra shift_right(sra_out, data_operandA, ctrl_shiftamt);
    mux_8 ALU_mux(data_result, ctrl_ALUopcode[2:0], adder_out, adder_out, and_out, or_out, sll_out, sra_out, 32'b0, 32'b0);

    or check_equal1(eq1, adder_out[0], adder_out[1], adder_out[2], adder_out[3], adder_out[4], adder_out[5], adder_out[6], adder_out[7]);
    or check_equal2(eq2, adder_out[8], adder_out[9], adder_out[10], adder_out[11], adder_out[12], adder_out[13], adder_out[14], adder_out[15]);
    or check_equal3(eq3, adder_out[16], adder_out[17], adder_out[18], adder_out[19], adder_out[20], adder_out[21], adder_out[22], adder_out[23]);
    or check_equal4(eq4, adder_out[24], adder_out[25], adder_out[26], adder_out[27], adder_out[28], adder_out[29], adder_out[30], adder_out[31]);
    or check_equal_final(isNotEqual, eq1, eq2, eq3, eq4);

    not notAdder_out(notAdd_out, adder_out[31]);
    not notA_gate(notA, data_operandA[31]);
    not notB_muxed(notBmuxed, muxB_out[31]);
    and ovf_and1(w2, notAdd_out, muxB_out[31], data_operandA[31]);
    and ovf_and2(w3, adder_out[31], notBmuxed, notA);
    or ovf_or(overflow, w2, w3);

    mux_2_1bit LT_mux(LT_mux_out, overflow, !adder_out[31], !notAdd_out);
    mux_2_1bit another_LT_mux(isLessThan, (data_operandA == data_operandB), LT_mux_out, 1'b0);
endmodule