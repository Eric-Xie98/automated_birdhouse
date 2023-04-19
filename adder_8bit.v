module ADD_8(sum, G0, P0, A, B, C);
    input[7:0] A, B;
    input C;
    output[7:0] sum;
    output G0, P0;
    wire[7:0] P, G;
    wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16;
    wire w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28;
    wire[7:0] cs;
    assign cs[0] = C;
    
    P_0 p_ans(P, P0, A, B);
    G_0 g_ans(G, G0, A, B, P);

    xor s0(sum[0], A[0], B[0], cs[0]);

    and p0_c0(w1, P[0], cs[0]);
    or g0_(cs[1], w1, G[0]);
    xor s1(sum[1], A[1], B[1], cs[1]);

    and g0_p1(w2, G[0], P[1]);
    and p1_c0(w3, P[0], P[1], cs[0]);
    or g1_(cs[2], G[1], w2, w3);
    xor s2(sum[2], cs[2], A[2], B[2]);

    and g1_p2(w4, P[2], G[1]);
    and g0_p2(w5, P[2], P[1], G[0]);
    and p2_c0(w6, P[2], P[1], P[0], cs[0]);
    or g2_(cs[3], G[2], w4, w5, w6);
    xor s3(sum[3], cs[3], A[3], B[3]);

    and g2_p3(w7, G[2], P[3]);
    and g1_p3(w8, P[3], P[2], G[1]);
    and g0_p3(w9, P[3], P[2], P[1], G[0]);
    and p3_c0(w10, P[3], P[2], P[1], P[0], cs[0]);
    or g3_(cs[4], G[3], w7, w8, w9, w10);
    xor s4(sum[4], cs[4], A[4], B[4]);

    and g3_p4(w11, G[3], P[4]);
    and g2_p4(w12, G[2], P[3], P[4]);
    and g1_p4(w13, P[3], P[2], G[1], P[4]);
    and g0_p4(w14, P[3], P[2], P[1], G[0], P[4]);
    and p4_c0(w15, P[3], P[2], P[1], P[0], cs[0], P[4]);
    or g4_(cs[5], G[4], w11, w12, w13, w14, w15);
    xor s5(sum[5], cs[5], A[5], B[5]);

    and g4_p5(w16, G[4], P[5]);
    and g3_p5(w17, G[3], P[5], P[4]);
    and g2_p5(w18, G[2], P[5], P[4], P[3]);
    and g1_p5(w19, G[1], P[5], P[4], P[3], P[2]);
    and g0_p5(w20, G[0], P[5], P[4], P[3], P[2], P[1]);
    and p5_c0(w21, cs[0], P[5], P[4], P[3], P[2], P[1], P[0]);
    or g5_(cs[6], G[5], w16, w17, w18, w19, w20, w21);
    xor s6(sum[6], cs[6], A[6], B[6]);

    and g5_p6(w22, G[5], P[6]);
    and g4_p6(w23, G[4], P[6], P[5]);
    and g3_p6(w24, G[3], P[6], P[5], P[4]);
    and g2_p6(w25, G[2], P[6], P[5], P[4], P[3]);
    and g1_p6(w26, G[1], P[6], P[5], P[4], P[3], P[2]);
    and g0_p6(w27, G[0], P[6], P[5], P[4], P[3], P[2], P[1]);
    and p6_c0(w28, cs[0], P[6], P[5], P[4], P[3], P[2], P[1], P[0]);
    or g6_(cs[7], G[6], w22, w23, w24, w25, w26, w27, w28);
    xor s7(sum[7], cs[7], A[7], B[7]);
endmodule

module P_0(P, P0, A, B);
    input[7:0] A, B;
    output[7:0] P;
    output P0;

    or p0(P[0], A[0], B[0]);
    or p1(P[1], A[1], B[1]);
    or p2(P[2], A[2], B[2]);
    or p3(P[3], A[3], B[3]);
    or p4(P[4], A[4], B[4]);
    or p5(P[5], A[5], B[5]);
    or p6(P[6], A[6], B[6]);
    or p7(P[7], A[7], B[7]);
    and P0_(P0, P[0], P[1], P[2], P[3], P[4], P[5], P[6], P[7]);
endmodule

module G_0(G, G0, A, B, P);
    input[7:0] A, B, P;
    output[7:0] G;
    output G0;

    wire w1, w2, w3, w4, w5, w6, w7;

    and g0(G[0], A[0], B[0]);
    and g1(G[1], A[1], B[1]);
    and g2(G[2], A[2], B[2]);
    and g3(G[3], A[3], B[3]);
    and g4(G[4], A[4], B[4]);
    and g5(G[5], A[5], B[5]);
    and g6(G[6], A[6], B[6]);
    and g7(G[7], A[7], B[7]);
    and pg(w1, P[7], G[6]);
    and ppg(w2, P[7], P[6], G[5]);
    and pppg(w3, P[7], P[6], P[5], G[4]);
    and ppppg(w4, P[7], P[6], P[5], P[4], G[3]);
    and pppppg(w5, P[7], P[6], P[5], P[4], P[3], G[2]);
    and ppppppg(w6, P[7], P[6], P[5], P[4], P[3], P[2], G[1]);
    and pppppppg(w7, P[7], P[6], P[5], P[4], P[3], P[2], P[1], G[0]);
    or G0_(G0, G[7], w1, w2, w3, w4, w5, w6, w7);
endmodule