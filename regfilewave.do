onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /regfile_tb/DUT/data_in
add wave -noupdate /regfile_tb/DUT/writenum
add wave -noupdate /regfile_tb/DUT/readnum
add wave -noupdate /regfile_tb/DUT/write
add wave -noupdate /regfile_tb/DUT/clk
add wave -noupdate /regfile_tb/DUT/data_out
add wave -noupdate /regfile_tb/DUT/decoderoutput1
add wave -noupdate /regfile_tb/DUT/decoderoutput2
add wave -noupdate /regfile_tb/DUT/load
add wave -noupdate /regfile_tb/DUT/R0
add wave -noupdate /regfile_tb/DUT/R1
add wave -noupdate /regfile_tb/DUT/R2
add wave -noupdate /regfile_tb/DUT/R3
add wave -noupdate /regfile_tb/DUT/R4
add wave -noupdate /regfile_tb/DUT/R5
add wave -noupdate /regfile_tb/DUT/R6
add wave -noupdate /regfile_tb/DUT/R7
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ps} {406 ps}
