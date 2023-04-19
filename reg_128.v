module reg_128(out, in, clk, wE, reset);
    input clk, wE, reset;
    input [127:0] in;
    output[127:0] out;

    register r1(out[31:0], in[31:0], clk, wE, reset);
    register r2(out[63:32], in[63:32], clk, wE, reset);
    register r3(out[95:64], in[95:64], clk, wE, reset);
    register r4(out[127:96], in[127:96], clk, wE, reset);
endmodule