module adder_32bit(Sum, Cout, A, B, C);
    input[31:0] A, B;
    input C;
    output[31:0] Sum;
    output Cout;
    wire G0, P0, G1, P1, G2, P2, G3, P3;
    wire c8, inter1, c16, c24, inter2, inter3, inter4, inter5, inter6, inter7, inter8, inter9, inter10;

    ADD_8 adder1(Sum[7:0], G0, P0, A[7:0], B[7:0], C);

    and P0_c0(inter1, P0, C);
    or G0_(c8, G0, inter1);
    ADD_8 adder2(Sum[15:8], G1, P1, A[15:8], B[15:8], c8);

    and P1_G0(inter2, P1, G0);
    and P1_c0(inter3, P1, P0, C);
    or G1_(c16, G1, inter2, inter3);
    ADD_8 adder3(Sum[23:16], G2, P2, A[23:16], B[23:16], c16);

    and P2_G1(inter4, P2, G1);
    and P2_G0(inter5, P2, P1, G0);
    and P2_c0(inter6, P2, P1, P0, C);
    or G2_(c24, G2, inter4, inter5, inter6);
    ADD_8 adder4(Sum[31:24], G3, P3, A[31:24], B[31:24], c24);

    and P3_G2(inter7, P3, G2);
    and P3_G1(inter8, P3, P2, G1);
    and P3_G0(inter9, P3, P2, P1, G0);
    and P3_c0(inter10, P3, P2, P1, P0, C);
    or G3_(Cout, G3, inter7, inter8, inter9, inter10);

endmodule