################################ Variables ####################################

set load_fp 0
set top_module UART_TX


########### Define Aspect Ratio (Length/Width) of Digital Macro  ############

if {$load_fp == 0} {

floorPlan -d 60 100 3.0 3.0 3.0 3.0

} else {

loadFPlan ./$top_module.fp

}

