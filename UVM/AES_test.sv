package AES_test_pkg;
import AES_cfg_pkg::*;
import AES_env_pkg::*;
import AES_sequence_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"  
class AES_test extends uvm_test;
`uvm_component_utils(AES_test)
AES_cfg AES_config;
AES_env AES_ENV;
reset_sequence reset_seq;
Main_sequence main_seq;

virtual AES_if vif;

function new(string name = "AES_test", uvm_component parent = null );        
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
reset_seq = reset_sequence::type_id::create("reset_seq");
main_seq = Main_sequence::type_id::create("main_seq");
AES_ENV = AES_env::type_id::create("AES_ENV", this);
AES_config = AES_cfg::type_id::create("AES_config");

if(!uvm_config_db #(virtual AES_if) ::get(this ,"", "AES_IF", AES_config.cfg_if) )
    `uvm_fatal("build phase", "Test - couldn't get the virtual interface from the uvm_config_db")
AES_config.AES_mode = UVM_ACTIVE;
uvm_config_db #(AES_cfg)::set(this,"*", "AES_CFG", AES_config);    
endfunction

task run_phase(uvm_phase phase);
super.run_phase(phase);
phase.raise_objection(this);
`uvm_info("run phase", "reset sequence has started", UVM_LOW);
reset_seq.start(AES_ENV.agt.AES_seqr);
`uvm_info("run phase", "main sequence has started", UVM_LOW);
main_seq.start(AES_ENV.agt.AES_seqr);

phase.drop_objection(this);
endtask

endclass //apb_master_test extends superClass

endpackage

