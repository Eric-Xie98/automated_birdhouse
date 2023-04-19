module mult(data_result, data_exception, data_resultRDY, data_operandA, data_operandB, ctrl_MULT, clock);

    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, clock;

    output [31:0] data_result;
    output data_exception, data_resultRDY;

    wire ctrl_into_reg, shift, as, WE, Cout, count_Cout;
    wire [4:0] counter_in, counter_out;
    wire [31:0] mult_shifted, muxB_out, add_out, notB, write_out, count_add_out, count_add_in;
    wire [64:0] prod, prod_out, reg_out, into_reg;
    wire signed [64:0] pre_shift;

    assign prod[64:33] = 32'b0;
    assign prod[32:1] = data_operandB;
    assign prod[0] = 1'b0;

    //mux

    register_5bit count(counter_out, counter_in, clock, 1'b1, ctrl_MULT);

    or first_mux(ctrl_into_reg, counter_out[0], counter_out[1], counter_out[2], counter_out[3], counter_out[4]);
    mux_2_65bit going_into_reg(into_reg, ctrl_into_reg, prod, reg_out);

    prod_reg product(prod_out, into_reg, clock, 1'b1, ctrl_MULT);
    
    prod_control ctrl(prod_out[2:0], shift, as, WE);
    assign mult_shifted = data_operandA <<< shift;

    mux_2 B_mux(muxB_out, as, mult_shifted, ~mult_shifted);

    adder_32bit adder(add_out, Cout, muxB_out, prod_out[64:33], as);
    mux_2 write(write_out, WE, add_out, prod_out[64:33]);

    assign pre_shift[64:33] = write_out;
    assign pre_shift[32:0] = prod_out[32:0];
    assign reg_out = pre_shift >>> 2;

    assign data_result = reg_out[32:1];
    and ready(data_resultRDY, !counter_out[0], !counter_out[1], !counter_out[2], !counter_out[3], counter_out[4]);
    
    wire matching, w1, w2, w3, cant_be;
    xor match(matching, data_operandA[31], data_operandB[31]);
    or m3(cant_be, ~|data_operandA, ~|data_operandB);
    xor m1(w2, matching, reg_out[32]);
    and m4(w3, w2, ~cant_be);
    nor nor1(w1, &reg_out[64:32], ~|reg_out[64:32]);
    or ovf(data_exception, w1, w3);

    assign count_add_in[4:0] = counter_out;
    assign count_add_in[31:5] = 27'b0;
    adder_32bit count_add(count_add_out, count_Cout, count_add_in, 32'b1, 1'b0);
    assign counter_in = count_add_out[4:0];
endmodule
    // and ready(data_resultRDY, counter_out[0], ~counter_out[1], ~counter_out[2], ~counter_out[3], counter_out[4]);
    // assign data_result = prod_out[32:1];
    // nor nor1(data_exception, &reg_out[64:32], ~|reg_out[64:32]);
    
    // assign data_result = prod_out[32:1];
    // nor nor1(data_exception, &reg_out[64:32], ~|reg_out[64:32]);
    // assign data_resultRDY = counter_out[4];

    // and a2(w3, &data_operandA, &data_operandB, matching);
    // xor ovf(w1, reg_out[32], |reg_out[64:33]);
    // xor ovf2(w2, w3, reg_out[32]);
    // or ovf_final(data_exception, w1, w2);
    // and m2(w3, w2, &reg_out[32:1]);