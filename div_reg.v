module div_reg(out, in, clk, wE, reset);
    input clk, wE, reset;
    input[63:0] in;
    output[63:0] out;

    register reg1(out[31:0], in[31:0], clk, wE, reset);
    register reg2(out[63:32], in[63:32], clk, wE, reset);
endmodule