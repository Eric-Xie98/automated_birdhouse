module register_6bit(out, in, clk, wE, reset);
    input clk, wE, reset;
    input [5:0] in;
    output[5:0] out;

    dffe_ref dffe0(out[0], in[0] , clk, wE, reset);
    dffe_ref dffe1(out[1], in[1] , clk, wE, reset);
    dffe_ref dffe2(out[2], in[2] , clk, wE, reset);
    dffe_ref dffe3(out[3], in[3] , clk, wE, reset);
    dffe_ref dffe4(out[4], in[4] , clk, wE, reset);
    dffe_ref dffe5(out[5], in[5] , clk, wE, reset);
endmodule