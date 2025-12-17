package AES_env_pkg;
import AES_agt_pkg::*;
import AES_cov_col_pkg::*;
import AES_sb_pkg::*;
import shared_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh" 
class AES_env extends uvm_env;
 `uvm_component_utils(AES_env)
  AES_agt agt;
  AES_sb sb;
  AES_cov_col cov;
    function new(string name = "AES_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt = AES_agt::type_id::create("agt", this);
        sb = AES_sb::type_id::create("sb", this);
        cov = AES_cov_col::type_id::create("cov", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        agt.agt_ap.connect(sb.sb_export);
        agt.agt_ap.connect(cov.cov_export);
    endfunction
endclass //AES_env extends uvm_env    
endpackage