module div(data_result, data_exception, data_resultRDY, data_operandA, data_operandB, ctrl_DIV, clock);

    input [31:0] data_operandA, data_operandB;
    input ctrl_DIV, clock;

    output [31:0] data_result;
    output data_exception, data_resultRDY;

    wire ctrl_into_first_mux, negate, done, CoutA, CoutB, Cout_adder, Cout_R, count_Cout;
    wire [5:0] counter_in, counter_out;
    wire [31:0] count_add_out, count_add_in, add_out, negativeA, negativeB, A, B, pseudoResult, negativeResult;
    wire [63:0] initial_val, reg_out, into_reg, div_out, div_shifted;

    xor neg(negate, data_operandA[31], data_operandB[31]);

    adder_32bit addA(negativeA, CoutA, 32'b0, ~data_operandA, 1'b1);
    adder_32bit addB(negativeB, CoutB, 32'b0, ~data_operandB, 1'b1);

    mux_2 check_negativeA(A, data_operandA[31], data_operandA, negativeA);
    mux_2 check_negativeB(B, data_operandB[31], data_operandB, negativeB);

    assign initial_val[63:32] = 32'b0;
    assign initial_val[31:0] = A;

    register_6bit count(counter_out, counter_in, clock, 1'b1, ctrl_DIV);

    or first_mux(ctrl_into_first_mux, counter_out[0], counter_out[1], counter_out[2], counter_out[3], counter_out[4], counter_out[5]);
    mux_2_64bits going_into_reg(into_reg, ctrl_into_first_mux, initial_val, reg_out);

    div_reg result(div_out, into_reg, clock, 1'b1, ctrl_DIV);

    assign div_shifted = div_out <<< 1;
    adder_32bit adder(add_out, Cout_adder, div_shifted[63:32], ~B, 1'b1);

    assign reg_out[0] = ~add_out[31];
    mux_2 restore(reg_out[63:32], add_out[31], add_out[31:0], div_shifted[63:32]);
    assign reg_out[31:1] = div_shifted[31:1];

    assign pseudoResult = reg_out[31:0];
    adder_32bit addR(negativeResult, Cout_R, 32'b0, ~pseudoResult, 1'b1);
    mux_2 final(data_result, negate, pseudoResult, negativeResult);
    // and ready(data_resultRDY, ~counter_out[0],  counter_out[5]);
    and ready(data_resultRDY, ~counter_out[0], ~counter_out[1], ~counter_out[2], ~counter_out[3], ~counter_out[4], counter_out[5]);
    // or now_ready(data_resultRDY, done, data_exception);
    // assign remainder = reg_out[63:32];

    assign data_exception = ~|data_operandB;

    assign count_add_in[5:0] = counter_out;
    adder_32bit count_add(count_add_out, count_Cout, count_add_in, 32'b1, 1'b0);
    assign counter_in = count_add_out[5:0];

endmodule