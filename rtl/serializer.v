module serializer (
    input wire [7:0] P_DATA ,
    input wire ser_en ,
    input wire RST ,
    input wire CLK ,
    input wire Data_Valid ,
    input wire Busy ,
    output wire ser_data ,
    output wire ser_done
);
  reg [7:0] shift_register ;
  reg [2:0] count ;
  always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        shift_register <= 8'b0 ;
        count <= 3'b0 ;
    end

    else if (Data_Valid && !Busy) begin
        shift_register <= P_DATA ;
    end

    else if (ser_en) begin  
        shift_register <= shift_register >> 1 ; 
        count <= count + 1'b1 ; 
        end  
    
    else begin
        count <= 3'b0 ;        
        end          
  end

  assign ser_data = shift_register[0] ;
  assign ser_done = (count == 3'b111) ? 1 : 0 ;

endmodule