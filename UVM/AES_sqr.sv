package AES_sqr_pkg;
import AES_seqitem_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"  
class AES_sqr extends uvm_sequencer #(AES_seq_item);
   `uvm_component_utils(AES_sqr)

function new(string name = "AES_sqr", uvm_component parent = null);
    super.new(name, parent);
endfunction //new()
endclass
endpackage   