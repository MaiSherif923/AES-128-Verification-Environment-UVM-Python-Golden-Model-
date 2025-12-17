package AES_sequence_pkg;
import shared_pkg::*;
import AES_seqitem_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class reset_sequence extends uvm_sequence #(AES_seq_item);
    `uvm_object_utils(reset_sequence)
    AES_seq_item rst_seq_item;
    function new(string name = "reset_sequence");
        super.new(name);        
    endfunction //new()

task body();
    rst_seq_item = AES_seq_item :: type_id::create("rst_seq_item");
    start_item(rst_seq_item);
        assert(rst_seq_item.randomize());
        rst_seq_item.reset_n = 0;
        rst_seq_item.valid_in = 0;
    finish_item(rst_seq_item);
endtask
endclass //reset_sequence_master extends superClass
    
class Main_sequence extends uvm_sequence #(AES_seq_item);
    `uvm_object_utils(Main_sequence)
    AES_seq_item main_seq_item;
    function new(string name = "Main_sequence");
        super.new(name);        
    endfunction //new()

task body();
    main_seq_item = AES_seq_item :: type_id::create("main_seq_item");
   repeat (100) begin
    start_item(main_seq_item);
        assert(main_seq_item.randomize());
    finish_item(main_seq_item);
   end
endtask
endclass

endpackage