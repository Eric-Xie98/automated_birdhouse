module regfile (
	clock,
	ctrl_writeEnable, ctrl_reset, ctrl_writeReg,
	ctrl_readRegA, ctrl_readRegB, data_writeReg,
	data_readRegA, data_readRegB
);

	input clock, ctrl_writeEnable, ctrl_reset;
	input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	input [31:0] data_writeReg;

	output [31:0] data_readRegA, data_readRegB;
	wire[31:0] reg_out0, reg_out1, reg_out2, reg_out3, reg_out4, reg_out5, reg_out6, reg_out7, reg_out8, reg_out9;
	wire[31:0] reg_out10, reg_out11, reg_out12, reg_out13, reg_out14, reg_out15, reg_out16, reg_out17, reg_out18, reg_out19;
	wire[31:0] reg_out20, reg_out21, reg_out22, reg_out23, reg_out24, reg_out25, reg_out26, reg_out27, reg_out28, reg_out29;
	wire[31:0] reg_out30, reg_out31;
    wire o0, o1, o2, o3, o4, o5, o6, o7, o8, o9, o10, o11, o12, o13, o14, o15, o16, o17, o18, o19, o20, o21, o22, o23, o24, o25, o26, o27, o28, o29, o30, o31;
	wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31;

	// add your code here
	decoder dec(ctrl_writeReg, o0, o1, o2, o3, o4, o5, o6, o7, o8, o9, o10, o11, o12, o13, o14, o15, o16, o17, o18, o19, o20, o21, o22, o23, o24, o25, o26, o27, o28, o29, o30, o31);
	assign reg_out0 = 32'b0;
	and a1(w1, o1, ctrl_writeEnable);
	register reg1(reg_out1, data_writeReg, clock, w1, ctrl_reset);
	and a2(w2, o2, ctrl_writeEnable);
	register reg2(reg_out2, data_writeReg, clock, w2, ctrl_reset);
	and a3(w3, o3, ctrl_writeEnable);
	register reg3(reg_out3, data_writeReg, clock, w3, ctrl_reset);
	and a4(w4, o4, ctrl_writeEnable);
	register reg4(reg_out4, data_writeReg, clock, w4, ctrl_reset);
	and a5(w5, o5, ctrl_writeEnable);
	register reg5(reg_out5, data_writeReg, clock, w5, ctrl_reset);
	and a6(w6, o6, ctrl_writeEnable);
	register reg6(reg_out6, data_writeReg, clock, w6, ctrl_reset);
	and a7(w7, o7, ctrl_writeEnable);
	register reg7(reg_out7, data_writeReg, clock, w7, ctrl_reset);
	and a8(w8, o8, ctrl_writeEnable);
	register reg8(reg_out8, data_writeReg, clock, w8, ctrl_reset);
	and a9(w9, o9, ctrl_writeEnable);
	register reg9(reg_out9, data_writeReg, clock, w9, ctrl_reset);
	and a10(w10, o10, ctrl_writeEnable);
	register reg10(reg_out10, data_writeReg, clock, w10, ctrl_reset);
	and a11(w11, o11, ctrl_writeEnable);
	register reg11(reg_out11, data_writeReg, clock, w11, ctrl_reset);
	and a12(w12, o12, ctrl_writeEnable);
	register reg12(reg_out12, data_writeReg, clock, w12, ctrl_reset);
	and a13(w13, o13, ctrl_writeEnable);
	register reg13(reg_out13, data_writeReg, clock, w13, ctrl_reset);
	and a14(w14, o14, ctrl_writeEnable);
	register reg14(reg_out14, data_writeReg, clock, w14, ctrl_reset);
	and a15(w15, o15, ctrl_writeEnable);
	register reg15(reg_out15, data_writeReg, clock, w15, ctrl_reset);
	and a16(w16, o16, ctrl_writeEnable);
	register reg16(reg_out16, data_writeReg, clock, w16, ctrl_reset);
	and a17(w17, o17, ctrl_writeEnable);
	register reg17(reg_out17, data_writeReg, clock, w17, ctrl_reset);
	and a18(w18, o18, ctrl_writeEnable);
	register reg18(reg_out18, data_writeReg, clock, w18, ctrl_reset);
	and a19(w19, o19, ctrl_writeEnable);
	register reg19(reg_out19, data_writeReg, clock, w19, ctrl_reset);
	and a20(w20, o20, ctrl_writeEnable);
	register reg20(reg_out20, data_writeReg, clock, w20, ctrl_reset);
	and a21(w21, o21, ctrl_writeEnable);
	register reg21(reg_out21, data_writeReg, clock, w21, ctrl_reset);
	and a22(w22, o22, ctrl_writeEnable);
	register reg22(reg_out22, data_writeReg, clock, w22, ctrl_reset);
	and a23(w23, o23, ctrl_writeEnable);
	register reg23(reg_out23, data_writeReg, clock, w23, ctrl_reset);
	and a24(w24, o24, ctrl_writeEnable);
	register reg24(reg_out24, data_writeReg, clock, w24, ctrl_reset);
	and a25(w25, o25, ctrl_writeEnable);
	register reg25(reg_out25, data_writeReg, clock, w25, ctrl_reset);
	and a26(w26, o26, ctrl_writeEnable);
	register reg26(reg_out26, data_writeReg, clock, w26, ctrl_reset);
	and a27(w27, o27, ctrl_writeEnable);
	register reg27(reg_out27, data_writeReg, clock, w27, ctrl_reset);
	and a28(w28, o28, ctrl_writeEnable);
	register reg28(reg_out28, data_writeReg, clock, w28, ctrl_reset);
	and a29(w29, o29, ctrl_writeEnable);
	register reg29(reg_out29, data_writeReg, clock, w29, ctrl_reset);
	and a30(w30, o30, ctrl_writeEnable);
	register reg30(reg_out30, data_writeReg, clock, w30, ctrl_reset);
	and a31(w31, o31, ctrl_writeEnable);
	register reg31(reg_out31, data_writeReg, clock, w31, ctrl_reset);

	wire r1_0, r1_1, r1_2, r1_3, r1_4, r1_5, r1_6, r1_7, r1_8, r1_9, r1_10, r1_11, r1_12, r1_13, r1_14, r1_15, r1_16, r1_17, r1_18, r1_19, r1_20, r1_21, r1_22, r1_23, r1_24, r1_25, r1_26, r1_27, r1_28, r1_29, r1_30, r1_31;
	wire r2_0, r2_1, r2_2, r2_3, r2_4, r2_5, r2_6, r2_7, r2_8, r2_9, r2_10, r2_11, r2_12, r2_13, r2_14, r2_15, r2_16, r2_17, r2_18, r2_19, r2_20, r2_21, r2_22, r2_23, r2_24, r2_25, r2_26, r2_27, r2_28, r2_29, r2_30, r2_31;
	decoder dec_r1(ctrl_readRegA, r1_0, r1_1, r1_2, r1_3, r1_4, r1_5, r1_6, r1_7, r1_8, r1_9, r1_10, r1_11, r1_12, r1_13, r1_14, r1_15, r1_16, r1_17, r1_18, r1_19, r1_20, r1_21, r1_22, r1_23, r1_24, r1_25, r1_26, r1_27, r1_28, r1_29, r1_30, r1_31);
	decoder dec_r2(ctrl_readRegB, r2_0, r2_1, r2_2, r2_3, r2_4, r2_5, r2_6, r2_7, r2_8, r2_9, r2_10, r2_11, r2_12, r2_13, r2_14, r2_15, r2_16, r2_17, r2_18, r2_19, r2_20, r2_21, r2_22, r2_23, r2_24, r2_25, r2_26, r2_27, r2_28, r2_29, r2_30, r2_31);
	assign data_readRegA = r1_0 ? reg_out0 : 32'bz;
	assign data_readRegA = r1_1 ? reg_out1 : 32'bz;
	assign data_readRegA = r1_2 ? reg_out2 : 32'bz;
	assign data_readRegA = r1_3 ? reg_out3 : 32'bz;
	assign data_readRegA = r1_4 ? reg_out4 : 32'bz;
	assign data_readRegA = r1_5 ? reg_out5 : 32'bz;
	assign data_readRegA = r1_6 ? reg_out6 : 32'bz;
	assign data_readRegA = r1_7 ? reg_out7 : 32'bz;
	assign data_readRegA = r1_8 ? reg_out8 : 32'bz;
	assign data_readRegA = r1_9 ? reg_out9 : 32'bz;
	assign data_readRegA = r1_10 ? reg_out10 : 32'bz;
	assign data_readRegA = r1_11 ? reg_out11 : 32'bz;
	assign data_readRegA = r1_12 ? reg_out12 : 32'bz;
	assign data_readRegA = r1_13 ? reg_out13 : 32'bz;
	assign data_readRegA = r1_14 ? reg_out14 : 32'bz;
	assign data_readRegA = r1_15 ? reg_out15 : 32'bz;
	assign data_readRegA = r1_16 ? reg_out16 : 32'bz;
	assign data_readRegA = r1_17 ? reg_out17 : 32'bz;
	assign data_readRegA = r1_18 ? reg_out18 : 32'bz;
	assign data_readRegA = r1_19 ? reg_out19 : 32'bz;
	assign data_readRegA = r1_20 ? reg_out20 : 32'bz;
	assign data_readRegA = r1_21 ? reg_out21 : 32'bz;
	assign data_readRegA = r1_22 ? reg_out22 : 32'bz;
	assign data_readRegA = r1_23 ? reg_out23 : 32'bz;
	assign data_readRegA = r1_24 ? reg_out24 : 32'bz;
	assign data_readRegA = r1_25 ? reg_out25 : 32'bz;
	assign data_readRegA = r1_26 ? reg_out26 : 32'bz;
	assign data_readRegA = r1_27 ? reg_out27 : 32'bz;
	assign data_readRegA = r1_28 ? reg_out28 : 32'bz;
	assign data_readRegA = r1_29 ? reg_out29 : 32'bz;
	assign data_readRegA = r1_30 ? reg_out30 : 32'bz;
	assign data_readRegA = r1_31 ? reg_out31 : 32'bz;

	assign data_readRegB = r2_0 ? reg_out0 : 32'bz;
	assign data_readRegB = r2_1 ? reg_out1 : 32'bz;
	assign data_readRegB = r2_2 ? reg_out2 : 32'bz;
	assign data_readRegB = r2_3 ? reg_out3 : 32'bz;
	assign data_readRegB = r2_4 ? reg_out4 : 32'bz;
	assign data_readRegB = r2_5 ? reg_out5 : 32'bz;
	assign data_readRegB = r2_6 ? reg_out6 : 32'bz;
	assign data_readRegB = r2_7 ? reg_out7 : 32'bz;
	assign data_readRegB = r2_8 ? reg_out8 : 32'bz;
	assign data_readRegB = r2_9 ? reg_out9 : 32'bz;
	assign data_readRegB = r2_10 ? reg_out10 : 32'bz;
	assign data_readRegB = r2_11 ? reg_out11 : 32'bz;
	assign data_readRegB = r2_12 ? reg_out12 : 32'bz;
	assign data_readRegB = r2_13 ? reg_out13 : 32'bz;
	assign data_readRegB = r2_14 ? reg_out14 : 32'bz;
	assign data_readRegB = r2_15 ? reg_out15 : 32'bz;
	assign data_readRegB = r2_16 ? reg_out16 : 32'bz;
	assign data_readRegB = r2_17 ? reg_out17 : 32'bz;
	assign data_readRegB = r2_18 ? reg_out18 : 32'bz;
	assign data_readRegB = r2_19 ? reg_out19 : 32'bz;
	assign data_readRegB = r2_20 ? reg_out20 : 32'bz;
	assign data_readRegB = r2_21 ? reg_out21 : 32'bz;
	assign data_readRegB = r2_22 ? reg_out22 : 32'bz;
	assign data_readRegB = r2_23 ? reg_out23 : 32'bz;
	assign data_readRegB = r2_24 ? reg_out24 : 32'bz;
	assign data_readRegB = r2_25 ? reg_out25 : 32'bz;
	assign data_readRegB = r2_26 ? reg_out26 : 32'bz;
	assign data_readRegB = r2_27 ? reg_out27 : 32'bz;
	assign data_readRegB = r2_28 ? reg_out28 : 32'bz;
	assign data_readRegB = r2_29 ? reg_out29 : 32'bz;
	assign data_readRegB = r2_30 ? reg_out30 : 32'bz;
	assign data_readRegB = r2_31 ? reg_out31 : 32'bz;

endmodule