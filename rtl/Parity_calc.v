module Parity_calc (
    input wire [7:0] P_DATA ,
    input wire Data_Valid ,
    input wire PAR_TYP ,
    input wire CLK ,
    input wire RST ,
    input wire busy ,
    output reg Par_bit
);
 always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        Par_bit <= 0 ; // default value
    end

    else if (Data_Valid && !busy) begin
        if (PAR_TYP) begin
            Par_bit <= ~^ P_DATA ; // odd parity
        end            
        else begin
            Par_bit <= ^ P_DATA ; // even parity
        end          
    end
 end   
endmodule
