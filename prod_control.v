module prod_control(in, shift, as, WE);
    input[2:0] in;
    output shift, as, WE;

    assign as = in[2];

    wire w1, w2, w3, w4;
    and a1(w1, ~in[2], in[1], in[0]);
    and a2(w2, in[2], ~in[1], ~in[0]);
    or o1(shift, w1, w2);

    and a3(w3, ~in[2], ~in[1], ~in[0]);
    and a4(w4, in[2], in[1], in[0]);
    or o2(WE, w3, w4);

endmodule