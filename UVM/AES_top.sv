import AES_test_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
module AES_TOP_tb;
bit clk;

//Clock Generation
initial begin
    clk = 0;
    forever begin
        #1 clk = ~clk;
    end
end

//instantiations
AES_if aes_if(clk);
AES_128 DUT (aes_if);
//run_test
initial begin
    uvm_config_db #(virtual AES_if)::set(null, "uvm_test_top", "AES_IF", aes_if);
    run_test("AES_test");
end

    
endmodule