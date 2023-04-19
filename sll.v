module sll(out, A, select);
    input[31:0] A;
    input[4:0] select;
    output[31:0] out;
    wire[31:0] w1, w2, w3, w4, w5;
    wire[31:0] mOut1, mOut2, mOut3, mOut4;
    wire[15:0] zeros;
    assign zeros[0] = 0;
    assign zeros[1] = 0;
    assign zeros[2] = 0;
    assign zeros[3] = 0;
    assign zeros[4] = 0;
    assign zeros[5] = 0;
    assign zeros[6] = 0;
    assign zeros[7] = 0;
    assign zeros[8] = 0;
    assign zeros[9] = 0;
    assign zeros[10] = 0;
    assign zeros[11] = 0;
    assign zeros[12] = 0;
    assign zeros[13] = 0;
    assign zeros[14] = 0;
    assign zeros[15] = 0;

    assign w1[31:16] = A[15:0];
    assign w1[15:0] = zeros[15:0];
    mux_2 mux1(mOut1, select[4], A, w1);

    assign w2[31:8] = mOut1[23:0];
    assign w2[7:0] = zeros[7:0];
    mux_2 mux2(mOut2, select[3], mOut1, w2);

    assign w3[31:4] = mOut2[27:0];
    assign w3[3:0] = zeros[3:0];
    mux_2 mux3(mOut3, select[2], mOut2, w3);

    assign w4[31:2] = mOut3[29:0];
    assign w4[1:0] = zeros[1:0];
    mux_2 mux4(mOut4, select[1], mOut3, w4);

    assign w5[31:1] = mOut4[30:0];
    assign w5[0] = zeros[0];
    mux_2 mux5(out, select[0], mOut4, w5);
endmodule