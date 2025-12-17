package AES_sb_pkg;
import AES_seqitem_pkg::*;
import shared_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh" 
class AES_sb extends uvm_scoreboard;
`uvm_component_utils(AES_sb)
AES_seq_item seq_sb;
uvm_analysis_export #(AES_seq_item) sb_export;
uvm_tlm_analysis_fifo #(AES_seq_item) sb_fifo;    

int correct_cnt = 0;
int error_cnt = 0;
int status;
int fd_data, fd_key, fd_cipher;
string cipher_text_gm;
logic [DATA_W-1:0] cipher_gm;
logic [DATA_W-1:0] cipher_from_py;
logic valid_out_gm; 

function new(string name = "AES_sb", uvm_component parent = null); 
    super.new(name, parent);
endfunction //new()

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sb_export = new("sb_export", this);
    sb_fifo = new("sb_fifo", this);
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    sb_export.connect(sb_fifo.analysis_export);
endfunction

task run_phase (uvm_phase phase);
    super.run_phase(phase);
    forever begin
    sb_fifo.get(seq_sb);    
    golden_model(seq_sb);
    end
endtask


task golden_model( AES_seq_item gm_seq);
    if(gm_seq.reset_n == 1'b1 && gm_seq.valid_in == 1'b1) begin

 fd_data = $fopen("data.txt", "w");
    $fdisplay(fd_data, "%032h", gm_seq.plain_text);
    $display ("data.txt is opened = %0h", gm_seq.plain_text);
    $fclose(fd_data);

    fd_key = $fopen("key.txt", "w");
    $fdisplay(fd_key, "%032h", gm_seq.cipher_key);
     $display ("key.txt is opened = %0h", gm_seq.cipher_key);
    $fclose(fd_key);
    
    // Call external AES executable
    status =  $system("python encrypt.py");if (status != 0) begin
        `uvm_fatal("AES_GM", $sformatf("Python failed, status=%0d", status))
    end

    // wait for file to be generated
    fd_cipher = $fopen("cipher_text.txt", "r");
    $fgets(cipher_text_gm, fd_cipher);
    $display ("cipher_text.txt is opened = %0h", cipher_text_gm);
    cipher_text_gm = cipher_text_gm.toupper();
    cipher_text_gm = cipher_text_gm.substr(0, cipher_text_gm.len()-1); // remove newline

    cipher_from_py = cipher_text_gm.atohex();

    $display ("cipher_from_py = %0h", cipher_from_py);
    $fclose(fd_cipher);
    // end else begin
    //     cipher_from_py = '0;
    //     cipher_gm = '0;
    //     valid_out_gm = 1'b0;
    end
    if (gm_seq.reset_n == 1'b0) begin
        cipher_from_py = '0;
        cipher_gm = '0;
        valid_out_gm = 1'b0;
    end
   

 if((cipher_gm != gm_seq.cipher_text) || (valid_out_gm != gm_seq.valid_out))
    begin
        `uvm_error("run_phase", $sformatf("Comparison failed, Transaction recieved by the DUT: %s While the ref gm_cipher_text =%0h, gm_valid_out_gm = %0h", 
        gm_seq.convert2string(), cipher_gm, valid_out_gm));
        error_cnt = error_cnt + 1;
    end
    else begin
        `uvm_info("run_phase", $sformatf("Comparison Successed,Transaction recieved by the DUT: %sWhile the ref gm_cipher_text =%0h, gm_valid_out_gm = %0h", gm_seq.convert2string(), cipher_gm, valid_out_gm), UVM_MEDIUM);
        correct_cnt = correct_cnt + 1;
    end

     if(gm_seq.valid_in == 1'b1 && gm_seq.reset_n == 1'b1) begin
        valid_out_gm = 1'b1;
        cipher_gm = cipher_from_py;
    end
    else
        valid_out_gm = 1'b0;   

endtask


function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("report_phase", $sformatf("Total successful transaction: %0d", correct_cnt), UVM_MEDIUM);
    `uvm_info("report_phase", $sformatf("Total failed transaction: %0d", error_cnt), UVM_MEDIUM);
endfunction
endclass 
endpackage