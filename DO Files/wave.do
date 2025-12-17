onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /AES_TOP_tb/aes_if/clk
add wave -noupdate /AES_TOP_tb/aes_if/reset_n
add wave -noupdate /AES_TOP_tb/aes_if/valid_in
add wave -noupdate /AES_TOP_tb/aes_if/cipher_key
add wave -noupdate /AES_TOP_tb/aes_if/plain_text
add wave -noupdate /AES_TOP_tb/aes_if/cipher_text
add wave -noupdate /AES_TOP_tb/aes_if/valid_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 100
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ns} {16 ns}
