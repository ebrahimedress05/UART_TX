onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB_SIGNALS -color Red /tb/CLK_tb
add wave -noupdate -expand -group TB_SIGNALS -color {Medium Blue} /tb/RST_tb
add wave -noupdate -expand -group TB_SIGNALS /tb/P_DATA_tb
add wave -noupdate -expand -group TB_SIGNALS /tb/Data_Valid_tb
add wave -noupdate -expand -group TB_SIGNALS /tb/PAR_EN_tb
add wave -noupdate -expand -group TB_SIGNALS /tb/PAR_TYP_tb
add wave -noupdate -expand -group TB_SIGNALS /tb/TX_OUT_tb
add wave -noupdate -expand -group TB_SIGNALS /tb/Busy_tb
add wave -noupdate -expand -group TB_SIGNALS /tb/check_reg_p
add wave -noupdate -expand -group TB_SIGNALS /tb/check_reg
add wave -noupdate -expand -group FSM_SIGNALS /tb/DUT/FSM/Data_Valid
add wave -noupdate -expand -group FSM_SIGNALS /tb/DUT/FSM/PAR_EN
add wave -noupdate -expand -group FSM_SIGNALS /tb/DUT/FSM/ser_done
add wave -noupdate -expand -group FSM_SIGNALS /tb/DUT/FSM/ser_en
add wave -noupdate -expand -group FSM_SIGNALS /tb/DUT/FSM/mux_sel
add wave -noupdate -expand -group FSM_SIGNALS /tb/DUT/FSM/busy
add wave -noupdate -expand -group FSM_SIGNALS /tb/DUT/FSM/current_state
add wave -noupdate -expand -group FSM_SIGNALS /tb/DUT/FSM/next_state
add wave -noupdate -expand -group SERIALIZER_SIGNALS /tb/DUT/serializer/P_DATA
add wave -noupdate -expand -group SERIALIZER_SIGNALS /tb/DUT/serializer/ser_en
add wave -noupdate -expand -group SERIALIZER_SIGNALS /tb/DUT/serializer/Data_Valid
add wave -noupdate -expand -group SERIALIZER_SIGNALS /tb/DUT/serializer/Busy
add wave -noupdate -expand -group SERIALIZER_SIGNALS /tb/DUT/serializer/ser_data
add wave -noupdate -expand -group SERIALIZER_SIGNALS /tb/DUT/serializer/ser_done
add wave -noupdate -expand -group SERIALIZER_SIGNALS /tb/DUT/serializer/shift_register
add wave -noupdate -expand -group SERIALIZER_SIGNALS -radix unsigned /tb/DUT/serializer/count
add wave -noupdate -expand -group PARITY_SIGNALS /tb/DUT/Parity_calc/PAR_TYP
add wave -noupdate -expand -group PARITY_SIGNALS /tb/DUT/Parity_calc/Par_bit
add wave -noupdate -expand -group MUX_SIGNALS /tb/DUT/MUX/ser_data
add wave -noupdate -expand -group MUX_SIGNALS /tb/DUT/MUX/Par_bit
add wave -noupdate -expand -group MUX_SIGNALS /tb/DUT/MUX/mux_sel
add wave -noupdate -expand -group MUX_SIGNALS /tb/DUT/MUX/TX_OUT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12500 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 245
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {118178 ps}
