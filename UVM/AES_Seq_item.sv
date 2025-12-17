package AES_seqitem_pkg;
import shared_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh" 
class AES_seq_item extends uvm_sequence_item;
    `uvm_object_utils(AES_seq_item)
    //AES signals
   rand logic reset_n;                      //asynch reset
   rand logic valid_in;                     //cipherkey valid signal
   rand logic [KEY_L-1:0] cipher_key;       //cipher key
   rand logic [DATA_W-1:0] plain_text;      //plain text
   logic [DATA_W-1:0] cipher_text;          //cipher text
   logic valid_out;                         //output valid signal

    constraint reset_c {reset_n dist {1:=95, 0:=5};} //default reset_n to 1
    constraint valid_in_c {valid_in dist {1:=70, 0:=30};} //default valid_in to 1

    function new(string name = "AES_seq_item");
        super.new(name);
    endfunction 

    function string convert2string();
        return $sformatf ("%s reset_n = %0d, valid_in = %0b, cipher_key = %0h, plain_text = %0h, cipher_text = %0h, valid_out = %0b",
        super.convert2string(),reset_n, valid_in, cipher_key, plain_text, cipher_text, valid_out);
    endfunction
    function string convert2string_stimulus();
    return $sformatf("reset_n = 0b%0b, valid_in = 0b%0b, cipher_key = 0h%0h, plain_text = 0h%0h",
    reset_n,valid_in,cipher_key,plain_text);
    endfunction


endclass 
endpackage