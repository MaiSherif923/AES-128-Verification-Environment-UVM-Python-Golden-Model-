import shared_pkg::*;
interface AES_if(clk);
input bit clk;                      //system clock
logic reset_n;                    //asynch reset
logic valid_in;                    //cipherkey valid signal
logic [KEY_L-1:0] cipher_key;     //cipher key
logic [DATA_W-1:0] plain_text;     //plain text
logic [DATA_W-1:0] cipher_text;    //cipher text
logic valid_out;                   //output valid signal

modport DUT (
input clk, reset_n, valid_in, cipher_key, plain_text,
output cipher_text, valid_out);

endinterface 