
########################### Define Top Module ############################
                                                   
set top_module UART_TX

##################### Define Working Library Directory ######################
                                                   
define_design_lib work -path ./work

########################### Formality Setup file ############################

set_svf UART_TX.svf

################## Design Compiler Library Files #setup ######################

puts "###########################################"
puts "#      #setting Design Libraries           #"
puts "###########################################"

#Add the path of the libraries to the search_path variable
lappend search_path /home/ICer/Labs/Ass_Syn_2.0/std_cells
lappend search_path /home/ICer/Labs/Ass_Syn_2.0/rtl

set SSLIB "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

## Standard Cell libraries 
set target_library [list $SSLIB $TTLIB $FFLIB]

## Standard Cell & Hard Macros libraries 
set link_library [list * $SSLIB $TTLIB $FFLIB]  

######################## Reading RTL Files #################################

puts "###########################################"
puts "#             Reading RTL Files           #"
puts "###########################################"

analyze -format sverilog FSM.sv
analyze -format verilog  {MUX.v Parity_calc.v serializer.v UART_TX.v MUX2_1.v}
elaborate $top_module

###################### Defining toplevel ###################################

current_design $top_module

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## Liniking All The Design Parts ########"
puts "###############################################"

link 

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## checking design consistency ##########"
puts "###############################################"

check_design

#################### Define Design Constraints #########################
puts "###############################################"
puts "############ Design Constraints #### ##########"
puts "###############################################"


source -echo ./cons.tcl


#################### Archirecture Scan Chains #########################
puts "###############################################"
puts "############ Configure scan chains ############"
puts "###############################################"

set_scan_configuration -max_length 100

###################### Mapping and optimization ########################
puts "###############################################"
puts "########## Mapping & Optimization #############"
puts "###############################################"


compile -scan

################################################################### 
# Setting Test Timing Variables
################################################################### 

# Preclock Measure Protocol (default protocol)
set test_default_period 1000
set test_default_delay 0
set test_default_bidir_delay 0
set test_default_strobe 200
set test_default_strobe_width 0

########################## Define DFT Signals ##########################

set_dft_signal -port [get_ports scan_CLK] -type ScanClock -view existing_dft -timing {500 1000}
set_dft_signal -port [get_ports scan_RST] -type Reset -view existing_dft -active_state 0
set_dft_signal -port [get_ports test_mode] -type Constant -view existing_dft -active_state 1
set_dft_signal -port [get_ports test_mode] -type TestMode -view spec -active_state 1
set_dft_signal -port [get_ports SE] -type ScanEnable -view spec -active_state 1
set_dft_signal -port [get_ports SI] -type ScanDataIn -view spec
set_dft_signal -port [get_ports SO] -type ScanDataOut -view spec

############################# Create Test Protocol #####################

create_test_protocol
                            
###################### Pre-DFT Design Rule Checking ####################

dft_drc -verbose

############################# Preview DFT ##############################

preview_dft -show scan_summary


############################# Insert DFT ###############################

insert_dft


######################## Optimize Logic post DFT #######################

compile -scan -incremental

###################### Design Rule Checking post DFT ###################

dft_drc -verbose -coverage_estimate > dft_drc_post_dft.rpt

##################### Close Formality Setup file ###########################

set_svf -off

####################################################################################
           #########################################################
                            #### Case Analysis ####
           #########################################################
####################################################################################

set_case_analysis 0 [get_port test_mode]

####################################################################################
#############################################################################
# Write out Design after initial compile
#############################################################################

write -format verilog -hierarchy -output UART_TX_netlist.v

write -format ddc -hierarchy -output UART_TX.ddc

write_sdf UART_TX.sdf

write_sdc UART_TX.sdc

################# reporting #######################

report_power -hierarchy > power.rpt

report_area -hierarchy > Area.rpt

report_timing -max_paths 100 -delay_type max > setup.rpt

report_timing -max_paths 100 -delay_type min > hold.rpt

report_clock -attributes > clocks.rpt

report_constraint -all_violators > constraints.rpt

report_port -verbose > ports.rpt

################# starting graphical user interface #######################

gui_start

#exit
