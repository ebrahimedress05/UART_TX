/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Thu Aug 13 05:12:31 2026
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
  DFFRQX2M \current_state_reg[2]  ( .D(next_state[2]), .CK(CLK), .RN(RST), .Q(
        current_state[2]) );
  CLKBUFX8M U3 ( .A(n14), .Y(busy) );
  AOI21XLM U4 ( .A0(current_state[2]), .A1(n13), .B0(n10), .Y(n11) );
  OAI21X2M U5 ( .A0(n11), .A1(n12), .B0(mux_sel[0]), .Y(n14) );
  INVX2M U6 ( .A(mux_sel[0]), .Y(ser_en) );
  NAND2X2M U7 ( .A(n7), .B(n3), .Y(mux_sel[1]) );
  NAND2X2M U8 ( .A(n12), .B(n2), .Y(mux_sel[0]) );
  INVX2M U9 ( .A(n10), .Y(n3) );
  OAI31X1M U10 ( .A0(n6), .A1(PAR_EN), .A2(n7), .B0(n3), .Y(next_state[2]) );
  NAND3X2M U11 ( .A(n4), .B(n2), .C(current_state[1]), .Y(n7) );
  INVX2M U12 ( .A(current_state[2]), .Y(n2) );
  CLKXOR2X2M U13 ( .A(current_state[0]), .B(current_state[1]), .Y(n12) );
  NOR2X2M U14 ( .A(n13), .B(current_state[2]), .Y(n10) );
  NAND2X2M U15 ( .A(current_state[0]), .B(current_state[1]), .Y(n13) );
  INVX2M U16 ( .A(current_state[0]), .Y(n4) );
  OAI32X1M U17 ( .A0(n4), .A1(current_state[2]), .A2(current_state[1]), .B0(n8), .B1(n7), .Y(next_state[1]) );
  NOR2X2M U18 ( .A(PAR_EN), .B(n6), .Y(n8) );
  OAI31X1M U19 ( .A0(n5), .A1(n7), .A2(n6), .B0(n9), .Y(next_state[0]) );
  NAND4BX1M U20 ( .AN(current_state[1]), .B(Data_Valid), .C(n4), .D(n2), .Y(n9) );
  INVX2M U21 ( .A(PAR_EN), .Y(n5) );
  INVX2M U22 ( .A(ser_done), .Y(n6) );
endmodule


module serializer ( P_DATA, ser_en, RST, CLK, ser_data, ser_done );
  input [7:0] P_DATA;
  input ser_en, RST, CLK;
  output ser_data, ser_done;
  wire   N36, N37, N38, N39, N40, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11,
         n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, n28, n29;
  wire   [3:0] count;
  wire   [7:0] shift_register;

  DFFRQX2M ser_done_reg ( .D(N36), .CK(CLK), .RN(RST), .Q(ser_done) );
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
  DFFRQX2M \shift_register_reg[0]  ( .D(n23), .CK(CLK), .RN(RST), .Q(
        shift_register[0]) );
  DFFRQX2M \count_reg[1]  ( .D(N38), .CK(CLK), .RN(RST), .Q(count[1]) );
  DFFRQX2M \count_reg[3]  ( .D(N40), .CK(CLK), .RN(RST), .Q(count[3]) );
  DFFRQX2M \count_reg[2]  ( .D(N39), .CK(CLK), .RN(RST), .Q(count[2]) );
  DFFRQX2M \count_reg[0]  ( .D(N37), .CK(CLK), .RN(RST), .Q(count[0]) );
  DFFRX1M ser_data_reg ( .D(n22), .CK(CLK), .RN(RST), .Q(ser_data), .QN(n1) );
  NAND2X2M U4 ( .A(ser_en), .B(n4), .Y(n8) );
  NOR4X2M U5 ( .A(count[0]), .B(count[1]), .C(count[2]), .D(count[3]), .Y(n7)
         );
  INVX2M U6 ( .A(n8), .Y(n2) );
  INVX2M U7 ( .A(ser_en), .Y(n3) );
  AND2X2M U8 ( .A(n7), .B(n2), .Y(n11) );
  AND2X2M U9 ( .A(n6), .B(n2), .Y(n10) );
  OR2X2M U10 ( .A(n7), .B(n6), .Y(n4) );
  NOR2X2M U11 ( .A(n8), .B(n18), .Y(N40) );
  OAI32X1M U12 ( .A0(n1), .A1(n3), .A2(n4), .B0(n5), .B1(n3), .Y(n22) );
  AOI22X1M U13 ( .A0(shift_register[0]), .A1(n6), .B0(P_DATA[0]), .B1(n7), .Y(
        n5) );
  OAI2BB1X2M U14 ( .A0N(n8), .A1N(shift_register[6]), .B0(n12), .Y(n24) );
  AOI22X1M U15 ( .A0(1'b0), .A1(n10), .B0(P_DATA[7]), .B1(n11), .Y(n12) );
  OAI2BB1X2M U16 ( .A0N(n8), .A1N(shift_register[3]), .B0(n15), .Y(n27) );
  AOI22X1M U17 ( .A0(shift_register[4]), .A1(n10), .B0(P_DATA[4]), .B1(n11), 
        .Y(n15) );
  OAI2BB1X2M U18 ( .A0N(n8), .A1N(shift_register[0]), .B0(n9), .Y(n23) );
  AOI22X1M U19 ( .A0(shift_register[1]), .A1(n10), .B0(P_DATA[1]), .B1(n11), 
        .Y(n9) );
  OAI2BB1X2M U20 ( .A0N(n8), .A1N(shift_register[4]), .B0(n14), .Y(n26) );
  AOI22X1M U21 ( .A0(shift_register[5]), .A1(n10), .B0(P_DATA[5]), .B1(n11), 
        .Y(n14) );
  OAI2BB1X2M U22 ( .A0N(n8), .A1N(shift_register[1]), .B0(n17), .Y(n29) );
  AOI22X1M U23 ( .A0(shift_register[2]), .A1(n10), .B0(P_DATA[2]), .B1(n11), 
        .Y(n17) );
  OAI2BB1X2M U24 ( .A0N(n8), .A1N(shift_register[5]), .B0(n13), .Y(n25) );
  AOI22X1M U25 ( .A0(shift_register[6]), .A1(n10), .B0(P_DATA[6]), .B1(n11), 
        .Y(n13) );
  OAI2BB1X2M U26 ( .A0N(n8), .A1N(shift_register[2]), .B0(n16), .Y(n28) );
  AOI22X1M U27 ( .A0(shift_register[3]), .A1(n10), .B0(P_DATA[3]), .B1(n11), 
        .Y(n16) );
  NOR2X2M U28 ( .A(n7), .B(count[3]), .Y(n6) );
  NAND2X2M U29 ( .A(count[1]), .B(count[0]), .Y(n20) );
  NAND2BX2M U30 ( .AN(n20), .B(count[2]), .Y(n18) );
  NOR2X2M U31 ( .A(count[0]), .B(n8), .Y(N37) );
  AOI2B1X1M U32 ( .A1N(count[3]), .A0(n18), .B0(n3), .Y(N36) );
  NOR2X2M U33 ( .A(n19), .B(n8), .Y(N39) );
  CLKXOR2X2M U34 ( .A(n20), .B(count[2]), .Y(n19) );
  NOR2X2M U35 ( .A(n21), .B(n8), .Y(N38) );
  XNOR2X2M U36 ( .A(count[1]), .B(count[0]), .Y(n21) );
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

  NOR2BX2M U3 ( .AN(mux_sel[1]), .B(Par_bit), .Y(n2) );
  CLKBUFX8M U4 ( .A(n5), .Y(TX_OUT) );
  CLKINVX2M U5 ( .A(mux_sel[0]), .Y(n1) );
  OAI21X2M U6 ( .A0(n2), .A1(n1), .B0(n3), .Y(n5) );
  NAND3X2M U7 ( .A(mux_sel[1]), .B(n1), .C(ser_data), .Y(n3) );
endmodule


module UART_TX ( P_DATA, Data_Valid, PAR_EN, PAR_TYP, CLK, RST, TX_OUT, Busy
 );
  input [7:0] P_DATA;
  input Data_Valid, PAR_EN, PAR_TYP, CLK, RST;
  output TX_OUT, Busy;
  wire   ser_done, ser_en, ser_data, Par_bit;
  wire   [1:0] mux_sel;

  FSM F1 ( .Data_Valid(Data_Valid), .PAR_EN(PAR_EN), .ser_done(ser_done), 
        .CLK(CLK), .RST(RST), .ser_en(ser_en), .mux_sel(mux_sel), .busy(Busy)
         );
  serializer S1 ( .P_DATA(P_DATA), .ser_en(ser_en), .RST(RST), .CLK(CLK), 
        .ser_data(ser_data), .ser_done(ser_done) );
  Parity_calc P1 ( .P_DATA(P_DATA), .Data_Valid(Data_Valid), .PAR_TYP(PAR_TYP), 
        .CLK(CLK), .RST(RST), .busy(Busy), .Par_bit(Par_bit) );
  MUX M1 ( .ser_data(ser_data), .Par_bit(Par_bit), .mux_sel(mux_sel), .TX_OUT(
        TX_OUT) );
endmodule

