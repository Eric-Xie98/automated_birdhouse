module reg_100(out, in, clk, wE, reset);
    input clk, wE, reset;
    input [99:0] in;
    output[99:0] out;

    register r1(out[31:0], in[31:0], clk, wE, reset);
    register r2(out[63:32], in[63:32], clk, wE, reset);
    register r3(out[95:64], in[95:64], clk, wE, reset);
    dffe_ref dffe0(out[96], in[96] , clk, wE, reset);
    dffe_ref dffe1(out[97], in[97] , clk, wE, reset);
    dffe_ref dffe2(out[98], in[98] , clk, wE, reset);
    dffe_ref dffe3(out[99], in[99] , clk, wE, reset);
endmodule