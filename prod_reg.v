module prod_reg(out, in, clk, wE, reset);
    input clk, wE, reset;
    input[64:0] in;
    output[64:0] out;

    register reg1(out[31:0], in[31:0], clk, wE, reset);
    register reg2(out[63:32], in[63:32], clk, wE, reset);
    dffe_ref dffe32(out[64], in[64] , clk, wE, reset);
endmodule