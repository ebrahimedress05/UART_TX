`timescale 1ns/1ps

module tb ;

/////////////////////////////////////////////////////////
///////////////////// Parameters ////////////////////////
/////////////////////////////////////////////////////////

parameter real Clock_PERIOD = 5.0 ;

/////////////////////////////////////////////////////////
//////////////////// DUT Signals ////////////////////////
/////////////////////////////////////////////////////////

reg   [7:0]   P_DATA_tb;
reg           Data_Valid_tb;
reg           PAR_EN_tb;
reg           PAR_TYP_tb;
reg           CLK_tb;
reg           RST_tb;
wire          TX_OUT_tb;
wire          Busy_tb;

reg   [9:0]   check_reg_p ;
reg   [10:0]  check_reg ;

////////////////////////////////////////////////////////
////////////////// Clock Generator  ////////////////////
////////////////////////////////////////////////////////

always #(Clock_PERIOD/2.0) CLK_tb = ~CLK_tb ;


////////////////////////////////////////////////////////
/////////////////// DUT Instantiation //////////////////
////////////////////////////////////////////////////////

UART_TX DUT (
    .P_DATA(P_DATA_tb),
    .Data_Valid(Data_Valid_tb),
    .PAR_EN(PAR_EN_tb),
    .PAR_TYP(PAR_TYP_tb),
    .CLK(CLK_tb),
    .RST(RST_tb),
    .TX_OUT(TX_OUT_tb),
    .Busy(Busy_tb)
);


////////////////////////////////////////////////////////
////////////////// Initial Block /////////////////////// 
////////////////////////////////////////////////////////

initial begin
    // Waveform Dumping
    $dumpfile("UART_TX.vcd");   
    $dumpvars(0, tb); 

    $display("\n==================================================");
    $display("------------ STARTING UART_TX TESTBENCH --------------");
    $display("==================================================");

    // --------------------------------------------------
    // Reset & Signal Initialization 
    // --------------------------------------------------
    RST_tb        = 1'b0 ;
    CLK_tb        = 1'b0 ;
    P_DATA_tb     = 8'b0 ;
    Data_Valid_tb = 1'b0 ;
    PAR_EN_tb     = 1'b0 ;
    PAR_TYP_tb    = 1'b0 ;
    #(Clock_PERIOD) ;
    RST_tb        = 1'b1 ;
    #(Clock_PERIOD) ;

    // --------------------------------------------------
    // Case 1: Transmit with no parity (P_DATA = 8'hF3)
    // --------------------------------------------------
    $display("\n--- Running Case 1: Transmit with No Parity ---");
    Data_Valid_tb = 1'b1 ; 
    P_DATA_tb     = 8'hf3 ;
    PAR_EN_tb     = 1'b0 ; 
    wait (Busy_tb) ;
    #(Clock_PERIOD / 2.0) ; 
    Data_Valid_tb = 1'b0 ;            
    check_p();
    if (check_reg_p == 10'b1_1111_0011_0) begin
      $display ("Transmit with no parity case PASSED") ;
    end
    else begin
      $display ("Transmit with no parity case FAILED (Got: %b)", check_reg_p) ;      
    end

    // --------------------------------------------------
    // Case 2: Transmit with even parity (P_DATA = 8'h05)
    // --------------------------------------------------
    #(Clock_PERIOD * 2) ;
    $display("\n--- Running Case 2: Transmit with Even Parity ---");
    Data_Valid_tb = 1'b1 ; 
    P_DATA_tb     = 8'h05 ;
    PAR_EN_tb     = 1'b1 ; 
    PAR_TYP_tb    = 1'b0 ;
    wait (Busy_tb) ;
    #(Clock_PERIOD / 2.0) ;
    Data_Valid_tb = 1'b0 ;            
    check();
    if (check_reg == 11'b1_0_0000_0101_0) begin
      $display ("Transmit with even parity case PASSED") ;
    end
    else begin
      $display ("Transmit with even parity case FAILED (Got: %b)", check_reg) ;      
    end

    // --------------------------------------------------
    // Case 3: Transmit with odd parity (P_DATA = 8'h10)
    // --------------------------------------------------
    #(Clock_PERIOD * 2) ;
    $display("\n--- Running Case 3: Transmit with Odd Parity ---");
    Data_Valid_tb = 1'b1 ; 
    P_DATA_tb     = 8'h10 ;
    PAR_EN_tb     = 1'b1 ; 
    PAR_TYP_tb    = 1'b1 ;
    wait (Busy_tb) ;
    #(Clock_PERIOD / 2.0) ;
    Data_Valid_tb = 1'b0 ;            
    check();
    if (check_reg == 11'b1_0_0001_0000_0) begin
      $display ("Transmit with odd parity case PASSED") ;
    end
    else begin
      $display ("Transmit with odd parity case FAILED (Got: %b)", check_reg) ;      
    end

    // --------------------------------------------------
    // Case 4: Ignore Data_Valid & P_DATA change while Busy
    // --------------------------------------------------
    #(Clock_PERIOD * 2) ;
    $display("\n--- Running Case 4: Ignore Valid while Busy (Glitch Test) ---");
    Data_Valid_tb = 1'b1 ; 
    P_DATA_tb     = 8'ha5 ; // Original Data
    PAR_EN_tb     = 1'b0 ; 
    wait (Busy_tb) ;
    #(Clock_PERIOD / 2.0) ;
    Data_Valid_tb = 1'b0 ;
    
    // Schedule glitch to occur midway during transmission without blocking check_p
    P_DATA_tb     <= #(Clock_PERIOD * 2) 8'hff ; // Fake Data
    Data_Valid_tb <= #(Clock_PERIOD * 2) 1'b1 ; // Fake Valid Pulse
    Data_Valid_tb <= #(Clock_PERIOD * 3) 1'b0 ;

    check_p();

    if (check_reg_p == 10'b1_1010_0101_0) begin
      $display ("Ignore valid while busy case PASSED") ;
    end
    else begin
      $display ("Ignore valid while busy case FAILED (Got: %b)", check_reg_p) ;      
    end

    // --------------------------------------------------
    // Case 5: Boundary Pattern (All Zeros 8'h00)
    // --------------------------------------------------
    #(Clock_PERIOD * 2) ;
    $display("\n--- Running Case 5: Boundary Pattern All Zeros (0x00) ---");
    Data_Valid_tb = 1'b1 ; 
    P_DATA_tb     = 8'h00 ;
    PAR_EN_tb     = 1'b1 ; 
    PAR_TYP_tb    = 1'b0 ; // Even
    wait (Busy_tb) ;
    #(Clock_PERIOD / 2.0) ;
    Data_Valid_tb = 1'b0 ;            
    check();
    if (check_reg == 11'b1_0_0000_0000_0) begin
      $display ("Boundary all zeros case PASSED") ;
    end
    else begin
      $display ("Boundary all zeros case FAILED (Got: %b)", check_reg) ;      
    end

    // --------------------------------------------------
    // Case 6: Boundary Pattern (All Ones 8'hFF)
    // --------------------------------------------------
    #(Clock_PERIOD * 2) ;
    $display("\n--- Running Case 6: Boundary Pattern All Ones (0xFF) ---");
    Data_Valid_tb = 1'b1 ; 
    P_DATA_tb     = 8'hff ;
    PAR_EN_tb     = 1'b1 ; 
    PAR_TYP_tb    = 1'b1 ; // Odd
    wait (Busy_tb) ;
    #(Clock_PERIOD / 2.0) ;
    Data_Valid_tb = 1'b0 ;            
    check();
    if (check_reg == 11'b1_1_1111_1111_0) begin
      $display ("Boundary all ones case PASSED") ;
    end
    else begin
      $display ("Boundary all ones case FAILED (Got: %b)", check_reg) ;      
    end

    $stop;
end  


////////////////////////////////////////////////////////
/////////////////////// TASKS //////////////////////////
////////////////////////////////////////////////////////

/////////////// Check (no parity) output //////////////////
task check_p ;
    integer i;
    begin
        for (i = 0; i < 10; i = i + 1) begin
            check_reg_p[i] = TX_OUT_tb ; // Store bits LSB to MSB
            #(Clock_PERIOD);
        end
    end
endtask


/////////////// Check (parity) output //////////////////
task check ;
    integer i;
    begin
        for (i = 0; i < 11; i = i + 1) begin
            check_reg[i] = TX_OUT_tb ; // Store bits LSB to MSB
            #(Clock_PERIOD);
        end
    end
endtask

endmodule