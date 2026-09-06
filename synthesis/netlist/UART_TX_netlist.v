/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Mon Sep  7 05:16:05 2026
/////////////////////////////////////////////////////////////


module FSM ( Data_Valid, PAR_EN, ser_done, CLK, RST, ser_en, mux_sel, busy );
  output [1:0] mux_sel;
  input Data_Valid, PAR_EN, ser_done, CLK, RST;
  output ser_en, busy;
  wire   n14, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13;
  wire   [2:0] current_state;
  wire   [2:0] next_state;

  DFFRQX2M \current_state_reg[0]  ( .D(next_state[0]), .CK(CLK), .RN(RST), .Q(
        current_state[0]) );
  DFFRQX2M \current_state_reg[1]  ( .D(next_state[1]), .CK(CLK), .RN(RST), .Q(
        current_state[1]) );
  DFFRX1M \current_state_reg[2]  ( .D(next_state[2]), .CK(CLK), .RN(RST), .Q(
        current_state[2]), .QN(n2) );
  OA21X2M U3 ( .A0(n11), .A1(n12), .B0(mux_sel[0]), .Y(n14) );
  INVX8M U4 ( .A(n14), .Y(busy) );
  AOI21XLM U5 ( .A0(current_state[2]), .A1(n13), .B0(n10), .Y(n11) );
  INVX2M U6 ( .A(mux_sel[0]), .Y(ser_en) );
  NAND2X2M U7 ( .A(n7), .B(n3), .Y(mux_sel[1]) );
  NAND2X2M U8 ( .A(n12), .B(n2), .Y(mux_sel[0]) );
  INVX2M U9 ( .A(n10), .Y(n3) );
  OAI31X1M U10 ( .A0(n6), .A1(PAR_EN), .A2(n7), .B0(n3), .Y(next_state[2]) );
  INVX2M U11 ( .A(ser_done), .Y(n6) );
  NAND3X2M U12 ( .A(n4), .B(n2), .C(current_state[1]), .Y(n7) );
  CLKXOR2X2M U13 ( .A(current_state[0]), .B(current_state[1]), .Y(n12) );
  NOR2X2M U14 ( .A(n13), .B(current_state[2]), .Y(n10) );
  NAND2X2M U15 ( .A(current_state[0]), .B(current_state[1]), .Y(n13) );
  INVX2M U16 ( .A(current_state[0]), .Y(n4) );
  OAI32X1M U17 ( .A0(n4), .A1(current_state[2]), .A2(current_state[1]), .B0(n8), .B1(n7), .Y(next_state[1]) );
  NOR2X2M U18 ( .A(PAR_EN), .B(n6), .Y(n8) );
  OAI31X1M U19 ( .A0(n5), .A1(n7), .A2(n6), .B0(n9), .Y(next_state[0]) );
  INVX2M U20 ( .A(PAR_EN), .Y(n5) );
  NAND4BX1M U21 ( .AN(current_state[1]), .B(Data_Valid), .C(n4), .D(n2), .Y(n9) );
endmodule


module serializer ( P_DATA, ser_en, RST, CLK, Data_Valid, Busy, ser_data, 
        ser_done );
  input [7:0] P_DATA;
  input ser_en, RST, CLK, Data_Valid, Busy;
  output ser_data, ser_done;
  wire   N26, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15,
         n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30;
  wire   [7:1] shift_register;
  wire   [2:0] count;
  assign ser_done = N26;

  DFFRQX2M \shift_register_reg[6]  ( .D(n24), .CK(CLK), .RN(RST), .Q(
        shift_register[6]) );
  DFFRQX2M \shift_register_reg[5]  ( .D(n25), .CK(CLK), .RN(RST), .Q(
        shift_register[5]) );
  DFFRQX2M \shift_register_reg[4]  ( .D(n26), .CK(CLK), .RN(RST), .Q(
        shift_register[4]) );
  DFFRQX2M \shift_register_reg[3]  ( .D(n27), .CK(CLK), .RN(RST), .Q(
        shift_register[3]) );
  DFFRQX2M \shift_register_reg[2]  ( .D(n28), .CK(CLK), .RN(RST), .Q(
        shift_register[2]) );
  DFFRQX2M \shift_register_reg[1]  ( .D(n29), .CK(CLK), .RN(RST), .Q(
        shift_register[1]) );
  DFFRQX2M \shift_register_reg[7]  ( .D(n23), .CK(CLK), .RN(RST), .Q(
        shift_register[7]) );
  DFFRQX2M \count_reg[2]  ( .D(n19), .CK(CLK), .RN(RST), .Q(count[2]) );
  DFFRQX2M \count_reg[1]  ( .D(n20), .CK(CLK), .RN(RST), .Q(count[1]) );
  DFFRQX2M \count_reg[0]  ( .D(n21), .CK(CLK), .RN(RST), .Q(count[0]) );
  DFFRQX2M \shift_register_reg[0]  ( .D(n22), .CK(CLK), .RN(RST), .Q(ser_data)
         );
  BUFX2M U3 ( .A(n10), .Y(n30) );
  INVX2M U4 ( .A(n8), .Y(n4) );
  NAND2X2M U5 ( .A(ser_en), .B(n5), .Y(n8) );
  NOR2X4M U6 ( .A(n30), .B(n4), .Y(n11) );
  AOI21X2M U7 ( .A0(n3), .A1(n4), .B0(n30), .Y(n9) );
  INVX2M U8 ( .A(n30), .Y(n5) );
  NOR3X2M U9 ( .A(n1), .B(n3), .C(n2), .Y(N26) );
  OAI32X1M U10 ( .A0(n2), .A1(count[2]), .A2(n6), .B0(n7), .B1(n1), .Y(n19) );
  OA21X2M U11 ( .A0(n8), .A1(count[1]), .B0(n9), .Y(n7) );
  OAI22X1M U12 ( .A0(n3), .A1(n5), .B0(count[0]), .B1(n8), .Y(n21) );
  OAI22X1M U13 ( .A0(n9), .A1(n2), .B0(count[1]), .B1(n6), .Y(n20) );
  NAND2X2M U14 ( .A(count[0]), .B(n4), .Y(n6) );
  NOR2BXLM U15 ( .AN(Data_Valid), .B(Busy), .Y(n10) );
  OAI2BB1X2M U16 ( .A0N(ser_data), .A1N(n11), .B0(n12), .Y(n22) );
  AOI22X1M U17 ( .A0(shift_register[1]), .A1(n4), .B0(P_DATA[0]), .B1(n30), 
        .Y(n12) );
  OAI2BB1X2M U18 ( .A0N(n11), .A1N(shift_register[4]), .B0(n15), .Y(n26) );
  AOI22X1M U19 ( .A0(shift_register[5]), .A1(n4), .B0(P_DATA[4]), .B1(n30), 
        .Y(n15) );
  OAI2BB1X2M U20 ( .A0N(shift_register[1]), .A1N(n11), .B0(n18), .Y(n29) );
  AOI22X1M U21 ( .A0(shift_register[2]), .A1(n4), .B0(P_DATA[1]), .B1(n30), 
        .Y(n18) );
  OAI2BB1X2M U22 ( .A0N(n11), .A1N(shift_register[5]), .B0(n14), .Y(n25) );
  AOI22X1M U23 ( .A0(shift_register[6]), .A1(n4), .B0(P_DATA[5]), .B1(n30), 
        .Y(n14) );
  OAI2BB1X2M U24 ( .A0N(n11), .A1N(shift_register[2]), .B0(n17), .Y(n28) );
  AOI22X1M U25 ( .A0(shift_register[3]), .A1(n4), .B0(P_DATA[2]), .B1(n30), 
        .Y(n17) );
  OAI2BB1X2M U26 ( .A0N(n11), .A1N(shift_register[6]), .B0(n13), .Y(n24) );
  AOI22X1M U27 ( .A0(shift_register[7]), .A1(n4), .B0(P_DATA[6]), .B1(n30), 
        .Y(n13) );
  OAI2BB1X2M U28 ( .A0N(n11), .A1N(shift_register[3]), .B0(n16), .Y(n27) );
  AOI22X1M U29 ( .A0(shift_register[4]), .A1(n4), .B0(P_DATA[3]), .B1(n30), 
        .Y(n16) );
  AO22X1M U30 ( .A0(n11), .A1(shift_register[7]), .B0(P_DATA[7]), .B1(n30), 
        .Y(n23) );
  INVX2M U31 ( .A(count[0]), .Y(n3) );
  INVX2M U32 ( .A(count[1]), .Y(n2) );
  INVX2M U33 ( .A(count[2]), .Y(n1) );
endmodule


module Parity_calc ( P_DATA, Data_Valid, PAR_TYP, CLK, RST, busy, Par_bit );
  input [7:0] P_DATA;
  input Data_Valid, PAR_TYP, CLK, RST, busy;
  output Par_bit;
  wire   n1, n2, n3, n4, n5, n6, n7;

  OAI2BB2X1M U2 ( .B0(n1), .B1(n2), .A0N(Par_bit), .A1N(n2), .Y(n7) );
  NAND2BX1M U3 ( .AN(busy), .B(Data_Valid), .Y(n2) );
  XOR3XLM U4 ( .A(n3), .B(PAR_TYP), .C(n4), .Y(n1) );
  XOR3XLM U5 ( .A(P_DATA[1]), .B(P_DATA[0]), .C(n5), .Y(n4) );
  XNOR2X1M U6 ( .A(P_DATA[3]), .B(P_DATA[2]), .Y(n5) );
  XOR3XLM U7 ( .A(P_DATA[5]), .B(P_DATA[4]), .C(n6), .Y(n3) );
  CLKXOR2X2M U8 ( .A(P_DATA[7]), .B(P_DATA[6]), .Y(n6) );
  DFFRQX2M Par_bit_reg ( .D(n7), .CK(CLK), .RN(RST), .Q(Par_bit) );
endmodule


module MUX ( ser_data, Par_bit, mux_sel, TX_OUT );
  input [1:0] mux_sel;
  input ser_data, Par_bit;
  output TX_OUT;
  wire   n5, n1, n2, n3;

  CLKBUFX8M U3 ( .A(n5), .Y(TX_OUT) );
  OAI21X2M U4 ( .A0(n2), .A1(n1), .B0(n3), .Y(n5) );
  NAND3X2M U5 ( .A(mux_sel[1]), .B(n1), .C(ser_data), .Y(n3) );
  INVX2M U6 ( .A(mux_sel[0]), .Y(n1) );
  NOR2BX2M U7 ( .AN(mux_sel[1]), .B(Par_bit), .Y(n2) );
endmodule


module UART_TX ( P_DATA, Data_Valid, PAR_EN, PAR_TYP, CLK, RST, TX_OUT, Busy
 );
  input [7:0] P_DATA;
  input Data_Valid, PAR_EN, PAR_TYP, CLK, RST;
  output TX_OUT, Busy;
  wire   ser_done, ser_en, ser_data, Par_bit;
  wire   [1:0] mux_sel;

  FSM FSM ( .Data_Valid(Data_Valid), .PAR_EN(PAR_EN), .ser_done(ser_done), 
        .CLK(CLK), .RST(RST), .ser_en(ser_en), .mux_sel(mux_sel), .busy(Busy)
         );
  serializer serializer ( .P_DATA(P_DATA), .ser_en(ser_en), .RST(RST), .CLK(
        CLK), .Data_Valid(Data_Valid), .Busy(Busy), .ser_data(ser_data), 
        .ser_done(ser_done) );
  Parity_calc Parity_calc ( .P_DATA(P_DATA), .Data_Valid(Data_Valid), 
        .PAR_TYP(PAR_TYP), .CLK(CLK), .RST(RST), .busy(Busy), .Par_bit(Par_bit) );
  MUX MUX ( .ser_data(ser_data), .Par_bit(Par_bit), .mux_sel(mux_sel), 
        .TX_OUT(TX_OUT) );
endmodule

