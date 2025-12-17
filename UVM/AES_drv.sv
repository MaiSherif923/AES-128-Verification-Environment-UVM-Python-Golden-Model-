package AES_drv_pkg;
import AES_cfg_pkg::*;
import AES_seqitem_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"  
class AES_drv extends uvm_driver #(AES_seq_item);
    `uvm_component_utils(AES_drv)
    virtual AES_if drv_if;
    AES_seq_item drv_seq_item;
function new(string name = "AES_drv", uvm_component parent = null );        
    super.new(name, parent);
endfunction

task run_phase (uvm_phase phase);
    super.run_phase(phase);
    forever begin
        drv_seq_item = AES_seq_item::type_id::create("drv_seq_item");
        seq_item_port.get_next_item(drv_seq_item);
       // wait(valid_is_high.triggered);
        drv_if.reset_n    <= drv_seq_item.reset_n;
        drv_if.valid_in   <= drv_seq_item.valid_in;
        drv_if.cipher_key <= drv_seq_item.cipher_key;
        drv_if.plain_text <= drv_seq_item.plain_text;
        do begin
            @(posedge drv_if.clk);
        end while (drv_if.valid_out == 1'b0 && drv_if.reset_n == 1'b1 && drv_seq_item.valid_in == 1'b1);
        // @(posedge drv_if.clk);
        seq_item_port.item_done();
        `uvm_info("run_phase", drv_seq_item.convert2string_stimulus(), UVM_HIGH)
    end
endtask

endclass 
endpackage