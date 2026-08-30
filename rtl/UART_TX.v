module UART_TX (
    input wire [7:0] P_DATA ,
    input wire Data_Valid , 
    input wire PAR_EN ,
    input wire PAR_TYP ,
    input wire CLK ,
    input wire RST ,
    output wire TX_OUT ,
    output wire Busy
);

// internal connections
wire ser_done ;
wire ser_en ;
wire [1:0] mux_sel ; 
wire ser_data ;
wire Par_bit ;

// Modules Instantiation
FSM F1 (.Data_Valid(Data_Valid) , .PAR_EN(PAR_EN) , .ser_done(ser_done) , 
        .CLK(CLK) , .RST(RST) , .ser_en(ser_en) , .mux_sel(mux_sel) , .busy(Busy) ) ;  

serializer S1 (.P_DATA(P_DATA) , .ser_en(ser_en) , .RST(RST) , .CLK(CLK) , .ser_data(ser_data) , 
               .ser_done(ser_done)) ;  

Parity_calc P1 (.P_DATA(P_DATA) , .Data_Valid(Data_Valid) , .PAR_TYP(PAR_TYP) , .CLK(CLK) ,
                .RST(RST) , .busy(Busy) , .Par_bit(Par_bit)) ;

MUX M1 (.ser_data(ser_data) , .Par_bit(Par_bit) , .mux_sel(mux_sel) , .TX_OUT(TX_OUT)) ;

endmodule