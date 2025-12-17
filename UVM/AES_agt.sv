package AES_agt_pkg;
import AES_cfg_pkg::*;
import AES_sqr_pkg::*;
import AES_drv_pkg::*;
import AES_seqitem_pkg::*;
import AES_mon_pkg::*;
import shared_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh" 
class AES_agt extends uvm_agent;
    `uvm_component_utils(AES_agt)
    AES_drv AES_driver;
    AES_cfg AES_config;
    AES_sqr AES_seqr;
    AES_mon AES_monitor;
    uvm_analysis_port #(AES_seq_item) agt_ap;
function new(string name = "AES_agt", uvm_component parent = null);
    super.new(name, parent);        
endfunction //new()

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(AES_cfg)::get(this,"","AES_CFG",AES_config ))
        `uvm_fatal("Build phase","Unable to get config object")
    if(AES_config.AES_mode == UVM_ACTIVE) begin
        AES_seqr = AES_sqr::type_id::create("AES_seqr", this);
        AES_driver = AES_drv::type_id::create("AES_driver",this);
    end
  AES_monitor = AES_mon::type_id::create("AES_monitor", this);
 agt_ap = new("agt_ap", this);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if ( AES_config.AES_mode == UVM_ACTIVE)
    begin
        AES_driver.drv_if = AES_config.cfg_if;
        AES_driver.seq_item_port.connect(AES_seqr.seq_item_export);
    end
    AES_monitor.mon_if = AES_config.cfg_if;
    AES_monitor.mon_ap.connect(agt_ap);
endfunction


endclass //AES_agt extends uvm_agent

endpackage