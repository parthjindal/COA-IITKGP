`timescale 10ns/1ps

module LFSR(seed, clkslow, rst)
    // input
    input [3:0] seed ;
    input clkslow ;
    input rst ;

    // output
    output [4:0] w ;

    // wire for intermediate
    wire [3:0] wint ;

    always @(posedge clkslow) 
    begin
        
    end
    

endmodule

