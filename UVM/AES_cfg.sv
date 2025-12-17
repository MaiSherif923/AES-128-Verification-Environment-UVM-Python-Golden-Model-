package AES_cfg_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"  

    class AES_cfg extends uvm_object;
    `uvm_object_utils(AES_cfg)
    virtual AES_if cfg_if;
    uvm_active_passive_enum AES_mode;
        function new(string name = "AES_cfg");
            super.new(name);
        endfunction //new()
    endclass 
endpackage