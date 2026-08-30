vlib work
vlog *.*v
vsim -voptargs=+acc work.tb
do wave.do
run -all