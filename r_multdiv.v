module r_multdiv(
	data_operandA, data_operandB, 
	ctrl_MULT, ctrl_DIV, 
	clock, 
	data_result, data_exception, data_resultRDY);

    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock;

    output [31:0] data_result;
    output data_exception, data_resultRDY;

    wire which_operation; // 0 if Mult, 1 if Div
    wire data_exception_mult, data_exception_div, data_resultRDY_mult, data_resultRDY_div;
    wire [31:0] data_result_mult, data_result_div;

    dffe_ref dffe0(which_operation, ctrl_DIV , clock, ctrl_DIV, ctrl_MULT);

    mult multiplier(data_result_mult, data_exception_mult, data_resultRDY_mult, data_operandA, data_operandB, ctrl_MULT, clock);

    div divider(data_result_div, data_exception_div, data_resultRDY_div, data_operandA, data_operandB, ctrl_DIV, clock);

    mux_2 result(data_result, which_operation, data_result_mult, data_result_div);
    mux_2_1bit ready(data_resultRDY, which_operation, data_resultRDY_mult, data_resultRDY_div);
    mux_2_1bit except(data_exception, which_operation, data_exception_mult, data_exception_div);

endmodule