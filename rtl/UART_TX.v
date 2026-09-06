module UART_TX (
    input wire [7:0] P_DATA ,
    input wire Data_Valid , 
    input wire PAR_EN ,
    input wire PAR_TYP ,
    input wire CLK ,
    input wire RST ,
    input wire SI ,
    input wire SE ,
    input wire test_mode ,
    input wire scan_CLK ,
    input wire scan_RST ,
    output wire SO ,    
    output wire TX_OUT ,
    output wire Busy
);

// internal connections
wire ser_done ;
wire ser_en ;
wire [1:0] mux_sel ; 
wire ser_data ;
wire Par_bit ;
wire CLK_M ;
wire RST_M ;

// Modules Instantiation
FSM FSM (.Data_Valid(Data_Valid) , .PAR_EN(PAR_EN) , .ser_done(ser_done) , 
        .CLK(CLK_M) , .RST(RST_M) , .ser_en(ser_en) , .mux_sel(mux_sel) , .busy(Busy) ) ;  

serializer serializer (.P_DATA(P_DATA) , .ser_en(ser_en) , .RST(RST_M) , .CLK(CLK_M) , .Data_Valid(Data_Valid) , 
               .Busy(Busy) , .ser_data(ser_data) , .ser_done(ser_done)) ;  

Parity_calc Parity_calc (.P_DATA(P_DATA) , .Data_Valid(Data_Valid) , .PAR_TYP(PAR_TYP) , .CLK(CLK_M) ,
                .RST(RST_M) , .busy(Busy) , .Par_bit(Par_bit)) ;

MUX MUX (.ser_data(ser_data) , .Par_bit(Par_bit) , .mux_sel(mux_sel) , .TX_OUT(TX_OUT)) ;

MUX2_1 U0 (
    .IN_0(CLK) ,
    .IN_1(scan_CLK) ,
    .sel(test_mode) ,
    .OUT(CLK_M)
) ;

MUX2_1 U1 (
    .IN_0(RST) ,
    .IN_1(scan_RST) ,
    .sel(test_mode) ,
    .OUT(RST_M)
) ;

endmodule