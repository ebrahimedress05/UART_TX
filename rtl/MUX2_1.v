module MUX2_1 (
    input wire IN_0 ,
    input wire IN_1 ,
    input wire sel ,
    output wire OUT
);
    
    assign OUT = sel ? IN_1 : IN_0 ;
    
endmodule