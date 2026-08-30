module MUX (
    input wire ser_data ,
    input wire Par_bit ,
    input wire [1:0] mux_sel ,
    output reg TX_OUT
);

  parameter start_bit = 1'b0 ;
  parameter stop_bit = 1'b1 ; 
   
   always @(*) begin
    case (mux_sel)
    2'b00    : TX_OUT = start_bit ;
    2'b01    : TX_OUT = stop_bit ;
    2'b10    : TX_OUT = ser_data ;
    2'b11    : TX_OUT = Par_bit ;            
    default  : TX_OUT = 1'b1 ; // IDLE value  
    endcase
   end 
endmodule