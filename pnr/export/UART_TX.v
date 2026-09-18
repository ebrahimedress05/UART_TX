module UART_TX (
	P_DATA, 
	Data_Valid, 
	PAR_EN, 
	PAR_TYP, 
	CLK, 
	RST, 
	SI, 
	SE, 
	test_mode, 
	scan_CLK, 
	scan_RST, 
	SO, 
	TX_OUT, 
	Busy);
   input [7:0] P_DATA;
   input Data_Valid;
   input PAR_EN;
   input PAR_TYP;
   input CLK;
   input RST;
   input SI;
   input SE;
   input test_mode;
   input scan_CLK;
   input scan_RST;
   output SO;
   output TX_OUT;
   output Busy;

   // Internal wires
   wire CLK__L2_N0;
   wire CLK__L1_N0;
   wire scan_CLK__L2_N0;
   wire scan_CLK__L1_N0;
   wire CLK_M__L3_N0;
   wire CLK_M__L2_N0;
   wire CLK_M__L1_N0;
   wire ser_done;
   wire CLK_M;
   wire RST_M;
   wire ser_en;
   wire ser_data;
   wire Par_bit;
   wire n5;
   wire [1:0] mux_sel;

   CLKINVX8M CLK__L2_I0 (.Y(CLK__L2_N0), 
	.A(CLK__L1_N0));
   CLKINVX40M CLK__L1_I0 (.Y(CLK__L1_N0), 
	.A(CLK));
   CLKINVX8M scan_CLK__L2_I0 (.Y(scan_CLK__L2_N0), 
	.A(scan_CLK__L1_N0));
   CLKINVX40M scan_CLK__L1_I0 (.Y(scan_CLK__L1_N0), 
	.A(scan_CLK));
   CLKINVX32M CLK_M__L3_I0 (.Y(CLK_M__L3_N0), 
	.A(CLK_M__L2_N0));
   CLKINVX24M CLK_M__L2_I0 (.Y(CLK_M__L2_N0), 
	.A(CLK_M__L1_N0));
   CLKBUFX12M CLK_M__L1_I0 (.Y(CLK_M__L1_N0), 
	.A(CLK_M));
   FSM_test_1 FSM (.Data_Valid(Data_Valid), 
	.PAR_EN(PAR_EN), 
	.ser_done(ser_done), 
	.CLK(CLK_M__L3_N0), 
	.RST(RST_M), 
	.ser_en(ser_en), 
	.mux_sel({ mux_sel[1],
		mux_sel[0] }), 
	.busy(Busy), 
	.test_si(SI), 
	.test_so(n5), 
	.test_se(SE));
   serializer_test_1 serializer (.P_DATA({ P_DATA[7],
		P_DATA[6],
		P_DATA[5],
		P_DATA[4],
		P_DATA[3],
		P_DATA[2],
		P_DATA[1],
		P_DATA[0] }), 
	.ser_en(ser_en), 
	.RST(RST_M), 
	.CLK(CLK_M__L3_N0), 
	.Data_Valid(Data_Valid), 
	.Busy(Busy), 
	.ser_data(ser_data), 
	.ser_done(ser_done), 
	.test_si(Par_bit), 
	.test_so(SO), 
	.test_se(SE));
   Parity_calc_test_1 Parity_calc (.P_DATA({ P_DATA[7],
		P_DATA[6],
		P_DATA[5],
		P_DATA[4],
		P_DATA[3],
		P_DATA[2],
		P_DATA[1],
		P_DATA[0] }), 
	.Data_Valid(Data_Valid), 
	.PAR_TYP(PAR_TYP), 
	.CLK(CLK_M__L3_N0), 
	.RST(RST_M), 
	.busy(Busy), 
	.Par_bit(Par_bit), 
	.test_si(n5), 
	.test_se(SE));
   MUX MUX (.ser_data(ser_data), 
	.Par_bit(Par_bit), 
	.mux_sel({ mux_sel[1],
		mux_sel[0] }), 
	.TX_OUT(TX_OUT), 
	.ser_en(ser_en));
   MUX2_1_1 U0 (.IN_0(CLK__L2_N0), 
	.IN_1(scan_CLK__L2_N0), 
	.sel(test_mode), 
	.OUT(CLK_M));
   MUX2_1_0 U1 (.IN_0(RST), 
	.IN_1(scan_RST), 
	.sel(test_mode), 
	.OUT(RST_M));
endmodule

/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Mon Sep  7 07:02:25 2026
/////////////////////////////////////////////////////////////
module FSM_test_1 (
	Data_Valid, 
	PAR_EN, 
	ser_done, 
	CLK, 
	RST, 
	ser_en, 
	mux_sel, 
	busy, 
	test_si, 
	test_so, 
	test_se);
   input Data_Valid;
   input PAR_EN;
   input ser_done;
   input CLK;
   input RST;
   output ser_en;
   output [1:0] mux_sel;
   output busy;
   input test_si;
   output test_so;
   input test_se;

   // Internal wires
   wire n17;
   wire n9;
   wire n10;
   wire n11;
   wire n12;
   wire n13;
   wire n14;
   wire n15;
   wire n5;
   wire n6;
   wire n7;
   wire n8;
   wire n16;
   wire [2:0] current_state;
   wire [2:0] next_state;

   assign test_so = current_state[2] ;

   SDFFRQX2M \current_state_reg[0]  (.SI(test_si), 
	.SE(test_se), 
	.RN(RST), 
	.Q(current_state[0]), 
	.D(next_state[0]), 
	.CK(CLK));
   SDFFRQX2M \current_state_reg[2]  (.SI(current_state[1]), 
	.SE(test_se), 
	.RN(RST), 
	.Q(current_state[2]), 
	.D(next_state[2]), 
	.CK(CLK));
   SDFFRQX2M \current_state_reg[1]  (.SI(current_state[0]), 
	.SE(test_se), 
	.RN(RST), 
	.Q(current_state[1]), 
	.D(next_state[1]), 
	.CK(CLK));
   OA21X2M U6 (.Y(n17), 
	.B0(mux_sel[0]), 
	.A1(n14), 
	.A0(n13));
   CLKINVX12M U7 (.Y(busy), 
	.A(n17));
   AOI21XLM U8 (.Y(n13), 
	.B0(n12), 
	.A1(n15), 
	.A0(current_state[2]));
   INVX2M U9 (.Y(ser_en), 
	.A(mux_sel[0]));
   NAND2X2M U10 (.Y(mux_sel[0]), 
	.B(n8), 
	.A(n14));
   OAI31X1M U11 (.Y(next_state[2]), 
	.B0(n7), 
	.A2(n9), 
	.A1(PAR_EN), 
	.A0(n5));
   INVX2M U12 (.Y(n5), 
	.A(ser_done));
   INVX2M U13 (.Y(n7), 
	.A(n12));
   NAND2X2M U14 (.Y(mux_sel[1]), 
	.B(n7), 
	.A(n9));
   CLKXOR2X2M U15 (.Y(n14), 
	.B(current_state[1]), 
	.A(current_state[0]));
   NOR2X2M U16 (.Y(n12), 
	.B(current_state[2]), 
	.A(n15));
   NAND2X2M U17 (.Y(n15), 
	.B(current_state[1]), 
	.A(current_state[0]));
   INVX2M U18 (.Y(n8), 
	.A(current_state[2]));
   OAI31X1M U19 (.Y(next_state[0]), 
	.B0(n11), 
	.A2(n5), 
	.A1(n9), 
	.A0(n16));
   INVX2M U20 (.Y(n16), 
	.A(PAR_EN));
   NAND4BX1M U21 (.Y(n11), 
	.D(n8), 
	.C(n6), 
	.B(Data_Valid), 
	.AN(current_state[1]));
   NAND3X2M U22 (.Y(n9), 
	.C(current_state[1]), 
	.B(n8), 
	.A(n6));
   INVX2M U23 (.Y(n6), 
	.A(current_state[0]));
   OAI32X1M U24 (.Y(next_state[1]), 
	.B1(n9), 
	.B0(n10), 
	.A2(current_state[1]), 
	.A1(current_state[2]), 
	.A0(n6));
   NOR2X2M U25 (.Y(n10), 
	.B(n5), 
	.A(PAR_EN));
endmodule

module serializer_test_1 (
	P_DATA, 
	ser_en, 
	RST, 
	CLK, 
	Data_Valid, 
	Busy, 
	ser_data, 
	ser_done, 
	test_si, 
	test_so, 
	test_se);
   input [7:0] P_DATA;
   input ser_en;
   input RST;
   input CLK;
   input Data_Valid;
   input Busy;
   output ser_data;
   output ser_done;
   input test_si;
   output test_so;
   input test_se;

   // Internal wires
   wire FE_OFN0_SO;
   wire n17;
   wire n18;
   wire n19;
   wire n20;
   wire n21;
   wire n22;
   wire n23;
   wire n24;
   wire n25;
   wire n26;
   wire n27;
   wire n28;
   wire n29;
   wire n30;
   wire n31;
   wire n32;
   wire n33;
   wire n34;
   wire n35;
   wire n36;
   wire n37;
   wire n38;
   wire n39;
   wire n40;
   wire n13;
   wire n14;
   wire n15;
   wire n16;
   wire n41;
   wire n44;
   wire n45;
   wire n46;
   wire [7:1] shift_register;
   wire [2:0] count;

   assign test_so = shift_register[7] ;

   BUFX10M FE_OFC0_SO (.Y(shift_register[7]), 
	.A(FE_OFN0_SO));
   SDFFRQX2M \shift_register_reg[6]  (.SI(shift_register[5]), 
	.SE(n44), 
	.RN(RST), 
	.Q(shift_register[6]), 
	.D(n35), 
	.CK(CLK));
   SDFFRQX2M \shift_register_reg[5]  (.SI(shift_register[4]), 
	.SE(n44), 
	.RN(RST), 
	.Q(shift_register[5]), 
	.D(n36), 
	.CK(CLK));
   SDFFRQX2M \shift_register_reg[4]  (.SI(shift_register[3]), 
	.SE(n44), 
	.RN(RST), 
	.Q(shift_register[4]), 
	.D(n37), 
	.CK(CLK));
   SDFFRQX2M \shift_register_reg[3]  (.SI(shift_register[2]), 
	.SE(test_se), 
	.RN(RST), 
	.Q(shift_register[3]), 
	.D(n38), 
	.CK(CLK));
   SDFFRQX2M \shift_register_reg[2]  (.SI(shift_register[1]), 
	.SE(test_se), 
	.RN(RST), 
	.Q(shift_register[2]), 
	.D(n39), 
	.CK(CLK));
   SDFFRQX2M \shift_register_reg[0]  (.SI(count[2]), 
	.SE(test_se), 
	.RN(RST), 
	.Q(ser_data), 
	.D(n33), 
	.CK(CLK));
   SDFFRQX2M \shift_register_reg[1]  (.SI(ser_data), 
	.SE(test_se), 
	.RN(RST), 
	.Q(shift_register[1]), 
	.D(n40), 
	.CK(CLK));
   SDFFRQX2M \count_reg[2]  (.SI(count[1]), 
	.SE(test_se), 
	.RN(RST), 
	.Q(count[2]), 
	.D(n30), 
	.CK(CLK));
   SDFFRQX2M \count_reg[1]  (.SI(count[0]), 
	.SE(test_se), 
	.RN(RST), 
	.Q(count[1]), 
	.D(n31), 
	.CK(CLK));
   SDFFRQX2M \count_reg[0]  (.SI(test_si), 
	.SE(test_se), 
	.RN(RST), 
	.Q(count[0]), 
	.D(n32), 
	.CK(CLK));
   INVX2M U15 (.Y(n16), 
	.A(n19));
   NOR2X2M U16 (.Y(n22), 
	.B(n16), 
	.A(n21));
   NAND2X2M U17 (.Y(n19), 
	.B(n41), 
	.A(ser_en));
   INVX2M U18 (.Y(n41), 
	.A(n21));
   AOI21X2M U19 (.Y(n20), 
	.B0(n21), 
	.A1(n16), 
	.A0(n13));
   NOR2BX2M U20 (.Y(n21), 
	.B(Busy), 
	.AN(Data_Valid));
   NOR3X2M U21 (.Y(ser_done), 
	.C(n14), 
	.B(n13), 
	.A(n15));
   OAI32X1M U22 (.Y(n30), 
	.B1(n15), 
	.B0(n18), 
	.A2(n14), 
	.A1(count[2]), 
	.A0(n17));
   OA21X2M U23 (.Y(n18), 
	.B0(n20), 
	.A1(count[1]), 
	.A0(n19));
   OAI22X1M U24 (.Y(n32), 
	.B1(n19), 
	.B0(count[0]), 
	.A1(n41), 
	.A0(n13));
   OAI22X1M U25 (.Y(n31), 
	.B1(n17), 
	.B0(count[1]), 
	.A1(n14), 
	.A0(n20));
   NAND2X2M U26 (.Y(n17), 
	.B(count[0]), 
	.A(n16));
   OAI2BB1X2M U27 (.Y(n35), 
	.B0(n24), 
	.A1N(shift_register[6]), 
	.A0N(n22));
   AOI22X1M U28 (.Y(n24), 
	.B1(n21), 
	.B0(P_DATA[6]), 
	.A1(n16), 
	.A0(n46));
   OAI2BB1X2M U29 (.Y(n39), 
	.B0(n28), 
	.A1N(shift_register[2]), 
	.A0N(n22));
   AOI22X1M U30 (.Y(n28), 
	.B1(n21), 
	.B0(P_DATA[2]), 
	.A1(n16), 
	.A0(shift_register[3]));
   OAI2BB1X2M U31 (.Y(n38), 
	.B0(n27), 
	.A1N(shift_register[3]), 
	.A0N(n22));
   AOI22X1M U32 (.Y(n27), 
	.B1(n21), 
	.B0(P_DATA[3]), 
	.A1(n16), 
	.A0(shift_register[4]));
   OAI2BB1X2M U33 (.Y(n40), 
	.B0(n29), 
	.A1N(n22), 
	.A0N(shift_register[1]));
   AOI22X1M U34 (.Y(n29), 
	.B1(n21), 
	.B0(P_DATA[1]), 
	.A1(n16), 
	.A0(shift_register[2]));
   OAI2BB1X2M U35 (.Y(n36), 
	.B0(n25), 
	.A1N(shift_register[5]), 
	.A0N(n22));
   AOI22X1M U36 (.Y(n25), 
	.B1(n21), 
	.B0(P_DATA[5]), 
	.A1(n16), 
	.A0(shift_register[6]));
   OAI2BB1X2M U37 (.Y(n33), 
	.B0(n23), 
	.A1N(n22), 
	.A0N(ser_data));
   AOI22X1M U38 (.Y(n23), 
	.B1(n21), 
	.B0(P_DATA[0]), 
	.A1(n16), 
	.A0(shift_register[1]));
   OAI2BB1X2M U39 (.Y(n37), 
	.B0(n26), 
	.A1N(shift_register[4]), 
	.A0N(n22));
   AOI22X1M U40 (.Y(n26), 
	.B1(n21), 
	.B0(P_DATA[4]), 
	.A1(n16), 
	.A0(shift_register[5]));
   AO22X1M U41 (.Y(n34), 
	.B1(n21), 
	.B0(P_DATA[7]), 
	.A1(n46), 
	.A0(n22));
   INVX2M U42 (.Y(n13), 
	.A(count[0]));
   INVX2M U43 (.Y(n14), 
	.A(count[1]));
   INVX2M U44 (.Y(n15), 
	.A(count[2]));
   INVXLM U46 (.Y(n45), 
	.A(shift_register[7]));
   INVXLM U47 (.Y(n46), 
	.A(n45));
   SDFFRQX4M \shift_register_reg[7]  (.SI(shift_register[6]), 
	.SE(n44), 
	.RN(RST), 
	.Q(FE_OFN0_SO), 
	.D(n34), 
	.CK(CLK));
   BUFX2M U3 (.Y(n44), 
	.A(test_se));
endmodule

module Parity_calc_test_1 (
	P_DATA, 
	Data_Valid, 
	PAR_TYP, 
	CLK, 
	RST, 
	busy, 
	Par_bit, 
	test_si, 
	test_se);
   input [7:0] P_DATA;
   input Data_Valid;
   input PAR_TYP;
   input CLK;
   input RST;
   input busy;
   output Par_bit;
   input test_si;
   input test_se;

   // Internal wires
   wire n1;
   wire n2;
   wire n3;
   wire n4;
   wire n5;
   wire n6;
   wire n8;

   SDFFRQX2M Par_bit_reg (.SI(test_si), 
	.SE(test_se), 
	.RN(RST), 
	.Q(Par_bit), 
	.D(n8), 
	.CK(CLK));
   OAI2BB2X1M U2 (.Y(n8), 
	.B1(n2), 
	.B0(n1), 
	.A1N(n2), 
	.A0N(Par_bit));
   XOR3XLM U3 (.Y(n1), 
	.C(n4), 
	.B(PAR_TYP), 
	.A(n3));
   NAND2BX1M U4 (.Y(n2), 
	.B(Data_Valid), 
	.AN(busy));
   XOR3XLM U5 (.Y(n4), 
	.C(n5), 
	.B(P_DATA[0]), 
	.A(P_DATA[1]));
   XNOR2X2M U6 (.Y(n5), 
	.B(P_DATA[2]), 
	.A(P_DATA[3]));
   XOR3XLM U7 (.Y(n3), 
	.C(n6), 
	.B(P_DATA[4]), 
	.A(P_DATA[5]));
   CLKXOR2X2M U8 (.Y(n6), 
	.B(P_DATA[6]), 
	.A(P_DATA[7]));
endmodule

module MUX (
	ser_data, 
	Par_bit, 
	mux_sel, 
	TX_OUT, 
	ser_en);
   input ser_data;
   input Par_bit;
   input [1:0] mux_sel;
   output TX_OUT;
   input ser_en;

   // Internal wires
   wire n5;
   wire n2;
   wire n3;

   BUFX10M U3 (.Y(TX_OUT), 
	.A(n5));
   OAI21X2M U4 (.Y(n5), 
	.B0(n3), 
	.A1(ser_en), 
	.A0(n2));
   NAND3X2M U5 (.Y(n3), 
	.C(ser_data), 
	.B(ser_en), 
	.A(mux_sel[1]));
   NOR2BX2M U7 (.Y(n2), 
	.B(Par_bit), 
	.AN(mux_sel[1]));
endmodule

module MUX2_1_1 (
	IN_0, 
	IN_1, 
	sel, 
	OUT);
   input IN_0;
   input IN_1;
   input sel;
   output OUT;

   // Internal wires
   wire N0;

   assign N0 = sel ;

   MX2X2M U1 (.Y(OUT), 
	.S0(N0), 
	.B(IN_1), 
	.A(IN_0));
endmodule

module MUX2_1_0 (
	IN_0, 
	IN_1, 
	sel, 
	OUT);
   input IN_0;
   input IN_1;
   input sel;
   output OUT;

   // Internal wires
   wire N0;

   assign N0 = sel ;

   MX2X2M U1 (.Y(OUT), 
	.S0(N0), 
	.B(IN_1), 
	.A(IN_0));
endmodule

