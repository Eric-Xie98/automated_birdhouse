module sra(out, A, select);
    input[31:0] A;
    input[4:0] select;
    output[31:0] out;

    wire[31:0] w1, w2, w3, w4, w5;
    wire[31:0] mOut1, mOut2, mOut3, mOut4;

    assign w1[15:0] = A[31:16];
    assign w1[16] = A[31];
    assign w1[17] = A[31];
    assign w1[18] = A[31];
    assign w1[19] = A[31];
    assign w1[20] = A[31];
    assign w1[21] = A[31];
    assign w1[22] = A[31];
    assign w1[23] = A[31];
    assign w1[24] = A[31];
    assign w1[25] = A[31];
    assign w1[26] = A[31];
    assign w1[27] = A[31];
    assign w1[28] = A[31];
    assign w1[29] = A[31];
    assign w1[30] = A[31];
    assign w1[31] = A[31];
    mux_2 mux1(mOut1, select[4], A, w1);

    assign w2[23:0] = mOut1[31:8];
    assign w2[24] = mOut1[31];
    assign w2[25] = mOut1[31];
    assign w2[26] = mOut1[31];
    assign w2[27] = mOut1[31];
    assign w2[28] = mOut1[31];
    assign w2[29] = mOut1[31];
    assign w2[30] = mOut1[31];
    assign w2[31] = mOut1[31];
    mux_2 mux2(mOut2, select[3], mOut1, w2);

    assign w3[27:0] = mOut2[31:4];
    assign w3[28] = mOut2[31];
    assign w3[29] = mOut2[31];
    assign w3[30] = mOut2[31];
    assign w3[31] = mOut2[31];
    mux_2 mux3(mOut3, select[2], mOut2, w3);

    assign w4[29:0] = mOut3[31:2];
    assign w4[30] = mOut3[31];
    assign w4[31] = mOut3[31];
    mux_2 mux4(mOut4, select[1], mOut3, w4);

    assign w5[30:0] = mOut4[31:1];
    assign w5[31] = mOut4[31];
    mux_2 mux5(out, select[0], mOut4, w5);

endmodule