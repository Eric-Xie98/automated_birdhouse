module reg_132(out, in, clk, wE, reset);
    input clk, wE, reset;
    input [131:0] in;
    output[131:0] out;

    register r1(out[31:0], in[31:0], clk, wE, reset);
    register r2(out[63:32], in[63:32], clk, wE, reset);
    register r3(out[95:64], in[95:64], clk, wE, reset);
    register r4(out[127:96], in[127:96], clk, wE, reset);
    dffe_ref dffe0(out[128], in[128] , clk, wE, reset);
    dffe_ref dffe1(out[129], in[129] , clk, wE, reset);
    dffe_ref dffe2(out[130], in[130] , clk, wE, reset);
    dffe_ref dffe3(out[131], in[131] , clk, wE, reset);
endmodule