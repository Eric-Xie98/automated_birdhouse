module decode_OP(opcode, R, I, JI, JII);
    input[4:0] opcode;
    output R, I, JI, JII;

    assign R = ~|opcode;
    assign I = !opcode[4] & (!opcode[3] | !opcode[2]) & (!opcode[3] | !opcode[1]) & (opcode[3] | opcode[2] | opcode[1]) & (opcode[2] | !opcode[0]);
    assign JI = (!opcode[4] | opcode[2]) & (opcode[4] | !opcode[2]) & !opcode[3] & (!opcode[2] | !opcode[1] | !opcode[0]) & (opcode[2] | opcode[0]) & (opcode[1] | opcode[0]);
    assign JII = !opcode[4] & !opcode[3] & opcode[2] & !opcode[1] & !opcode[0];

endmodule