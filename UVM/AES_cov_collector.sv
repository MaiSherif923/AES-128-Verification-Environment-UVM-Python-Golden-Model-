package AES_cov_col_pkg;
import AES_seqitem_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh" 
class AES_cov_col extends uvm_component;
`uvm_component_utils(AES_cov_col)
AES_seq_item seq_cov;
uvm_analysis_export #(AES_seq_item) cov_export;
uvm_tlm_analysis_fifo #(AES_seq_item) cov_fifo;  
covergroup AES_cov_gp;
    // Coverpoint for valid_out signal
    valid_out_cp : coverpoint seq_cov.valid_out {
        bins valid_out_bins[2] = {0, 1};
    }
    // Coverpoint for valid_in signal
    valid_in_cp : coverpoint seq_cov.valid_in {
        bins valid_in_bins[2] = {0, 1};
    }
    // Coverpoint for reset_n signal
    reset_n_cp : coverpoint seq_cov.reset_n {
        bins reset_n_bins[2] = {0, 1};
    }
    // Cross coverage between valid_in and valid_out
    valid_in_valid_out_cross : cross valid_in_cp, valid_out_cp
    { 
        ignore_bins high_out_low_in = binsof (valid_in_cp) intersect{0} && binsof (valid_out_cp) intersect{1};
    }
endgroup

function new(string name = "AES_cov_col", uvm_component parent = null); 
    super.new(name, parent);
    AES_cov_gp = new();
endfunction //new()

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cov_export = new("cov_export", this);
    cov_fifo = new("cov_fifo", this);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    cov_export.connect(cov_fifo.analysis_export);
endfunction

task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
        cov_fifo.get(seq_cov);
        AES_cov_gp.sample();
    end
endtask
endclass //AES_cov_col extends uvm_component
endpackage