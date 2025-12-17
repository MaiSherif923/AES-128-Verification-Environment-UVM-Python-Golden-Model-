vlib work
vlog +define+SIM -f file.list +cover -covercells
vsim -voptargs=+acc work.AES_TOP_tb -cover -classdebug -uvmcontrol=all +UVM_VERBOSITY=UVM_MEDIUM
do wave.do
coverage save AES_TOP_tb.ucdb -onexit 
run -all
##quit -sim
vcover report AES_TOP_tb.ucdb -details -annotate -all -output top_tbCOV.txt