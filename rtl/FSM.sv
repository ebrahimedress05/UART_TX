module FSM (
    input wire Data_Valid ,
    input wire PAR_EN ,
    input wire ser_done ,
    input wire CLK ,
    input wire RST ,
    output reg ser_en ,
    output reg [1:0] mux_sel ,
    output reg busy
);

  typedef enum bit [2:0] {
             IDLE = 3'b000 ,
             start = 3'b001 ,
             data = 3'b010 ,
             parity = 3'b011 ,
             stop = 3'b100     
  } state_e;

  state_e current_state, next_state ;          

  // state transition 
  always @(posedge CLK or negedge RST) begin
    if (!RST) begin
    current_state <= IDLE ; 
    end
    else begin
    current_state <= next_state ;      
    end
  end

  // next_state and output logic
  always @(*) begin
    case (current_state)
    IDLE    : begin
      ser_en = 1'b0 ;
      mux_sel = 2'b01 ; // stop_bit is same idle_bit = 1 
      busy = 0 ;
      if (Data_Valid) begin
        next_state = start ;
      end
      else begin
        next_state = IDLE ; 
      end
    end

    start    : begin
      ser_en = 1'b1 ;
      mux_sel = 2'b00 ;
      busy = 1 ;
      next_state = data ;
      end
    
    data    : begin
      mux_sel = 2'b10 ;
      busy = 1 ;
      ser_en = 1'b1 ;
      if (ser_done) begin
        if (PAR_EN) begin
          next_state = parity ;  
        end
        else begin
          next_state = stop ;
        end
      end
      else begin
        next_state = data ;
      end       
      end  

    parity    : begin
      ser_en = 1'b0 ;
      mux_sel = 2'b11 ;
      busy = 1 ;
      next_state = stop ;
      end 

    stop    : begin
      ser_en = 1'b0 ;
      mux_sel = 2'b01 ;
      busy = 1 ;
      next_state = IDLE ;
      end  

    default   : begin
      ser_en = 1'b0 ;
      mux_sel = 2'b01 ; // stop_bit is same idle_bit = 1 
      busy = 0 ;
      next_state = IDLE ;
    end
    endcase
  end

endmodule