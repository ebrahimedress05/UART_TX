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
add wave -noupdate -expand -group SERIALIZER_UNIT /tb/DUT/S1/ser_en
add wave -noupdate -expand -group SERIALIZER_UNIT /tb/DUT/S1/ser_data
add wave -noupdate -expand -group SERIALIZER_UNIT /tb/DUT/S1/ser_done
add wave -noupdate -expand -group SERIALIZER_UNIT /tb/DUT/S1/shift_register
add wave -noupdate -expand -group SERIALIZER_UNIT /tb/DUT/S1/count
add wave -noupdate -expand -group FSM_UNIT /tb/DUT/F1/Data_Valid
add wave -noupdate -expand -group FSM_UNIT /tb/DUT/F1/ser_done
add wave -noupdate -expand -group FSM_UNIT /tb/DUT/F1/ser_en
add wave -noupdate -expand -group FSM_UNIT /tb/DUT/F1/mux_sel
add wave -noupdate -expand -group FSM_UNIT /tb/DUT/F1/busy
add wave -noupdate -expand -group FSM_UNIT /tb/DUT/F1/current_state
add wave -noupdate -expand -group FSM_UNIT /tb/DUT/F1/next_state
add wave -noupdate -expand -group MUX4x1_UNIT /tb/DUT/M1/mux_sel
add wave -noupdate -expand -group PARITY_CALC /tb/DUT/P1/PAR_TYP
add wave -noupdate -expand -group PARITY_CALC /tb/DUT/P1/Par_bit
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {288400 ps} {416400 ps}
