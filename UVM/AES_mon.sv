package AES_mon_pkg;
import AES_cfg_pkg::*;
import AES_seqitem_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"  
class AES_mon extends uvm_monitor;
    `uvm_component_utils(AES_mon)
    virtual AES_if mon_if;
    AES_seq_item mon_seq_item;
    uvm_analysis_port #(AES_seq_item) mon_ap;
function new(string name = "AES_mon", uvm_component parent = null );        
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_ap = new("mon_ap", this);
endfunction

task run_phase (uvm_phase phase);
    super.run_phase(phase);
    forever begin
        mon_seq_item = AES_seq_item::type_id::create("mon_seq_item");
        @(posedge mon_if.clk);
        mon_seq_item.reset_n = mon_if.reset_n;
        mon_seq_item.valid_in = mon_if.valid_in;
        mon_seq_item.cipher_key = mon_if.cipher_key;
        mon_seq_item.plain_text = mon_if.plain_text;
        mon_seq_item.cipher_text = mon_if.cipher_text;
        mon_seq_item.valid_out = mon_if.valid_out;
        mon_ap.write(mon_seq_item);
        // if(mon_seq_item.valid_out == 1'b1 || mon_seq_item.reset_n == 1'b0)
        // ->valid_is_high;
        `uvm_info("run_phase", mon_seq_item.convert2string(), UVM_HIGH)
    end
endtask
endclass 
endpackage