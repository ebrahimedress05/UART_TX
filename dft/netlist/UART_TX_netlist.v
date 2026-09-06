/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Mon Sep  7 07:02:25 2026
/////////////////////////////////////////////////////////////


module FSM_test_1 ( Data_Valid, PAR_EN, ser_done, CLK, RST, ser_en, mux_sel, 
        busy, test_si, test_so, test_se );
  output [1:0] mux_sel;
  input Data_Valid, PAR_EN, ser_done, CLK, RST, test_si, test_se;
  output ser_en, busy, test_so;
  wire   n17, n9, n10, n11, n12, n13, n14, n15, n5, n6, n7, n8, n16;
  wire   [2:0] current_state;
  wire   [2:0] next_state;
  assign test_so = current_state[2];

  SDFFRQX2M \current_state_reg[0]  ( .D(next_state[0]), .SI(test_si), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(current_state[0]) );
  SDFFRQX2M \current_state_reg[2]  ( .D(next_state[2]), .SI(current_state[1]), 
        .SE(test_se), .CK(CLK), .RN(RST), .Q(current_state[2]) );
  SDFFRQX2M \current_state_reg[1]  ( .D(next_state[1]), .SI(current_state[0]), 
        .SE(test_se), .CK(CLK), .RN(RST), .Q(current_state[1]) );
  OA21X2M U6 ( .A0(n13), .A1(n14), .B0(mux_sel[0]), .Y(n17) );
  INVX8M U7 ( .A(n17), .Y(busy) );
  AOI21XLM U8 ( .A0(current_state[2]), .A1(n15), .B0(n12), .Y(n13) );
  INVX2M U9 ( .A(mux_sel[0]), .Y(ser_en) );
  NAND2X2M U10 ( .A(n14), .B(n8), .Y(mux_sel[0]) );
  OAI31X1M U11 ( .A0(n5), .A1(PAR_EN), .A2(n9), .B0(n7), .Y(next_state[2]) );
  INVX2M U12 ( .A(ser_done), .Y(n5) );
  INVX2M U13 ( .A(n12), .Y(n7) );
  NAND2X2M U14 ( .A(n9), .B(n7), .Y(mux_sel[1]) );
  CLKXOR2X2M U15 ( .A(current_state[0]), .B(current_state[1]), .Y(n14) );
  NOR2X2M U16 ( .A(n15), .B(current_state[2]), .Y(n12) );
  NAND2X2M U17 ( .A(current_state[0]), .B(current_state[1]), .Y(n15) );
  INVX2M U18 ( .A(current_state[2]), .Y(n8) );
  OAI31X1M U19 ( .A0(n16), .A1(n9), .A2(n5), .B0(n11), .Y(next_state[0]) );
  INVX2M U20 ( .A(PAR_EN), .Y(n16) );
  NAND4BX1M U21 ( .AN(current_state[1]), .B(Data_Valid), .C(n6), .D(n8), .Y(
        n11) );
  NAND3X2M U22 ( .A(n6), .B(n8), .C(current_state[1]), .Y(n9) );
  INVX2M U23 ( .A(current_state[0]), .Y(n6) );
  OAI32X1M U24 ( .A0(n6), .A1(current_state[2]), .A2(current_state[1]), .B0(
        n10), .B1(n9), .Y(next_state[1]) );
  NOR2X2M U25 ( .A(PAR_EN), .B(n5), .Y(n10) );
endmodule


module serializer_test_1 ( P_DATA, ser_en, RST, CLK, Data_Valid, Busy, 
        ser_data, ser_done, test_si, test_so, test_se );
  input [7:0] P_DATA;
  input ser_en, RST, CLK, Data_Valid, Busy, test_si, test_se;
  output ser_data, ser_done, test_so;
  wire   n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n12, n13, n14, n15,
         n16, n41, n44, n45, n46, n47;
  wire   [7:1] shift_register;
  wire   [2:0] count;
  assign test_so = shift_register[7];

  SDFFRQX2M \shift_register_reg[6]  ( .D(n35), .SI(shift_register[5]), .SE(n44), .CK(CLK), .RN(RST), .Q(shift_register[6]) );
  SDFFRQX2M \shift_register_reg[5]  ( .D(n36), .SI(shift_register[4]), .SE(n44), .CK(CLK), .RN(RST), .Q(shift_register[5]) );
  SDFFRQX2M \shift_register_reg[4]  ( .D(n37), .SI(shift_register[3]), .SE(n44), .CK(CLK), .RN(RST), .Q(shift_register[4]) );
  SDFFRQX2M \shift_register_reg[3]  ( .D(n38), .SI(shift_register[2]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(shift_register[3]) );
  SDFFRQX2M \shift_register_reg[2]  ( .D(n39), .SI(shift_register[1]), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(shift_register[2]) );
  SDFFRQX2M \shift_register_reg[0]  ( .D(n33), .SI(count[2]), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(ser_data) );
  SDFFRQX2M \shift_register_reg[1]  ( .D(n40), .SI(ser_data), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(shift_register[1]) );
  SDFFRQX2M \count_reg[2]  ( .D(n30), .SI(count[1]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(count[2]) );
  SDFFRQX2M \count_reg[1]  ( .D(n31), .SI(count[0]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(count[1]) );
  SDFFRQX2M \count_reg[0]  ( .D(n32), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(count[0]) );
  BUFX2M U14 ( .A(n21), .Y(n12) );
  INVX2M U15 ( .A(n19), .Y(n16) );
  NOR2X4M U16 ( .A(n12), .B(n16), .Y(n22) );
  NAND2X2M U17 ( .A(ser_en), .B(n41), .Y(n19) );
  INVX2M U18 ( .A(n12), .Y(n41) );
  AOI21X2M U19 ( .A0(n13), .A1(n16), .B0(n12), .Y(n20) );
  NOR2BXLM U20 ( .AN(Data_Valid), .B(Busy), .Y(n21) );
  NOR3X2M U21 ( .A(n15), .B(n13), .C(n14), .Y(ser_done) );
  OAI32X1M U22 ( .A0(n17), .A1(count[2]), .A2(n14), .B0(n18), .B1(n15), .Y(n30) );
  OA21X2M U23 ( .A0(n19), .A1(count[1]), .B0(n20), .Y(n18) );
  OAI22X1M U24 ( .A0(n13), .A1(n41), .B0(count[0]), .B1(n19), .Y(n32) );
  OAI22X1M U25 ( .A0(n20), .A1(n14), .B0(count[1]), .B1(n17), .Y(n31) );
  NAND2X2M U26 ( .A(n16), .B(count[0]), .Y(n17) );
  OAI2BB1X2M U27 ( .A0N(n22), .A1N(shift_register[6]), .B0(n24), .Y(n35) );
  AOI22X1M U28 ( .A0(n47), .A1(n16), .B0(P_DATA[6]), .B1(n12), .Y(n24) );
  OAI2BB1X2M U29 ( .A0N(n22), .A1N(shift_register[2]), .B0(n28), .Y(n39) );
  AOI22X1M U30 ( .A0(shift_register[3]), .A1(n16), .B0(P_DATA[2]), .B1(n12), 
        .Y(n28) );
  OAI2BB1X2M U31 ( .A0N(n22), .A1N(shift_register[3]), .B0(n27), .Y(n38) );
  AOI22X1M U32 ( .A0(shift_register[4]), .A1(n16), .B0(P_DATA[3]), .B1(n12), 
        .Y(n27) );
  OAI2BB1X2M U33 ( .A0N(shift_register[1]), .A1N(n22), .B0(n29), .Y(n40) );
  AOI22X1M U34 ( .A0(shift_register[2]), .A1(n16), .B0(P_DATA[1]), .B1(n12), 
        .Y(n29) );
  OAI2BB1X2M U35 ( .A0N(n22), .A1N(shift_register[5]), .B0(n25), .Y(n36) );
  AOI22X1M U36 ( .A0(shift_register[6]), .A1(n16), .B0(P_DATA[5]), .B1(n12), 
        .Y(n25) );
  OAI2BB1X2M U37 ( .A0N(ser_data), .A1N(n22), .B0(n23), .Y(n33) );
  AOI22X1M U38 ( .A0(shift_register[1]), .A1(n16), .B0(P_DATA[0]), .B1(n12), 
        .Y(n23) );
  OAI2BB1X2M U39 ( .A0N(n22), .A1N(shift_register[4]), .B0(n26), .Y(n37) );
  AOI22X1M U40 ( .A0(shift_register[5]), .A1(n16), .B0(P_DATA[4]), .B1(n12), 
        .Y(n26) );
  AO22X1M U41 ( .A0(n22), .A1(n46), .B0(P_DATA[7]), .B1(n12), .Y(n34) );
  INVX2M U42 ( .A(count[0]), .Y(n13) );
  INVX2M U43 ( .A(count[1]), .Y(n14) );
  INVX2M U44 ( .A(count[2]), .Y(n15) );
  INVXLM U46 ( .A(shift_register[7]), .Y(n45) );
  INVXLM U47 ( .A(n45), .Y(n46) );
  INVXLM U48 ( .A(n45), .Y(n47) );
  SDFFRHQX8M \shift_register_reg[7]  ( .D(n34), .SI(shift_register[6]), .SE(
        n44), .CK(CLK), .RN(RST), .Q(shift_register[7]) );
  BUFX2M U3 ( .A(test_se), .Y(n44) );
endmodule


module Parity_calc_test_1 ( P_DATA, Data_Valid, PAR_TYP, CLK, RST, busy, 
        Par_bit, test_si, test_se );
  input [7:0] P_DATA;
  input Data_Valid, PAR_TYP, CLK, RST, busy, test_si, test_se;
  output Par_bit;
  wire   n1, n2, n3, n4, n5, n6, n8;

  SDFFRQX2M Par_bit_reg ( .D(n8), .SI(test_si), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(Par_bit) );
  OAI2BB2X1M U2 ( .B0(n1), .B1(n2), .A0N(Par_bit), .A1N(n2), .Y(n8) );
  XOR3XLM U3 ( .A(n3), .B(PAR_TYP), .C(n4), .Y(n1) );
  NAND2BX1M U4 ( .AN(busy), .B(Data_Valid), .Y(n2) );
  XOR3XLM U5 ( .A(P_DATA[1]), .B(P_DATA[0]), .C(n5), .Y(n4) );
  XNOR2X2M U6 ( .A(P_DATA[3]), .B(P_DATA[2]), .Y(n5) );
  XOR3XLM U7 ( .A(P_DATA[5]), .B(P_DATA[4]), .C(n6), .Y(n3) );
  CLKXOR2X2M U8 ( .A(P_DATA[7]), .B(P_DATA[6]), .Y(n6) );
endmodule


module MUX ( ser_data, Par_bit, mux_sel, TX_OUT );
  input [1:0] mux_sel;
  input ser_data, Par_bit;
  output TX_OUT;
  wire   n5, n2, n3, n4;

  CLKBUFX8M U3 ( .A(n5), .Y(TX_OUT) );
  OAI21X2M U4 ( .A0(n2), .A1(n4), .B0(n3), .Y(n5) );
  NAND3X2M U5 ( .A(mux_sel[1]), .B(n4), .C(ser_data), .Y(n3) );
  INVX2M U6 ( .A(mux_sel[0]), .Y(n4) );
  NOR2BX2M U7 ( .AN(mux_sel[1]), .B(Par_bit), .Y(n2) );
endmodule


module MUX2_1_1 ( IN_0, IN_1, sel, OUT );
  input IN_0, IN_1, sel;
  output OUT;
  wire   N0;
  assign N0 = sel;

  MX2X2M U1 ( .A(IN_0), .B(IN_1), .S0(N0), .Y(OUT) );
endmodule


module MUX2_1_0 ( IN_0, IN_1, sel, OUT );
  input IN_0, IN_1, sel;
  output OUT;
  wire   N0;
  assign N0 = sel;

  CLKMX2X4M U1 ( .A(IN_0), .B(IN_1), .S0(N0), .Y(OUT) );
endmodule


module UART_TX ( P_DATA, Data_Valid, PAR_EN, PAR_TYP, CLK, RST, SI, SE, 
        test_mode, scan_CLK, scan_RST, SO, TX_OUT, Busy );
  input [7:0] P_DATA;
  input Data_Valid, PAR_EN, PAR_TYP, CLK, RST, SI, SE, test_mode, scan_CLK,
         scan_RST;
  output SO, TX_OUT, Busy;
  wire   ser_done, CLK_M, RST_M, ser_en, ser_data, Par_bit, n1, n2, n5;
  wire   [1:0] mux_sel;

  BUFX2M U2 ( .A(Data_Valid), .Y(n2) );
  BUFX2M U3 ( .A(PAR_EN), .Y(n1) );
  FSM_test_1 FSM ( .Data_Valid(n2), .PAR_EN(n1), .ser_done(ser_done), .CLK(
        CLK_M), .RST(RST_M), .ser_en(ser_en), .mux_sel(mux_sel), .busy(Busy), 
        .test_si(SI), .test_so(n5), .test_se(SE) );
  serializer_test_1 serializer ( .P_DATA(P_DATA), .ser_en(ser_en), .RST(RST_M), 
        .CLK(CLK_M), .Data_Valid(n2), .Busy(Busy), .ser_data(ser_data), 
        .ser_done(ser_done), .test_si(Par_bit), .test_so(SO), .test_se(SE) );
  Parity_calc_test_1 Parity_calc ( .P_DATA(P_DATA), .Data_Valid(n2), .PAR_TYP(
        PAR_TYP), .CLK(CLK_M), .RST(RST_M), .busy(Busy), .Par_bit(Par_bit), 
        .test_si(n5), .test_se(SE) );
  MUX MUX ( .ser_data(ser_data), .Par_bit(Par_bit), .mux_sel(mux_sel), 
        .TX_OUT(TX_OUT) );
  MUX2_1_1 U0 ( .IN_0(CLK), .IN_1(scan_CLK), .sel(test_mode), .OUT(CLK_M) );
  MUX2_1_0 U1 ( .IN_0(RST), .IN_1(scan_RST), .sel(test_mode), .OUT(RST_M) );
endmodule

