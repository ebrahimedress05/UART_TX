module serializer (
    input wire [7:0] P_DATA ,
    input wire ser_en ,
    input wire RST ,
    input wire CLK ,
    output reg ser_data ,
    output reg ser_done
);
  reg [7:0] shift_register ;
  reg [3:0] count ;
  always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        shift_register <= 8'b0 ;
        ser_done <= 1'b0 ;
        count <= 4'b0 ;
        ser_data <= 1'b0 ;
    end

    else if (ser_en) begin  
        if (count == 4'b0) begin
        shift_register <= P_DATA >> 1 ;
        ser_done <= 1'b0 ;
        count <= count + 1 ; 
        ser_data <= P_DATA [0] ;           
        end
        else if (count < 4'd8) begin
        if (count == 4'd7) begin
            ser_done <= 1'b1 ;
        end
        else begin
             ser_done <= 1'b0 ;
        end
        count <= count + 1'b1 ; 
        ser_data <= shift_register [0] ;  
        shift_register <= shift_register >> 1 ;
        end  
        else  begin
        ser_done <= 1'b1 ;
        count <= 4'b0 ; 
        end  
    end
    
        else begin
        ser_done <= 1'b0 ;
        count <= 4'b0 ;
        ser_data <= 1'b0 ;          
        end          
  end
endmodule