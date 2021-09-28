`timescale 10ns/1ps

module LFSR(seed, clkslow, rst)
    // input
    input [3:0] seed ;
    input clkslow ;
    input rst ;
    
    wire [4:0] w ;

    // wire for intermediate
    wire [3:0] wint ;

    always @(posedge clkslow) 
    begin

        assign w[0] = w[3] ^ w[4] ;

        mux m3 (wint[0], w[0], seed[0], sel) ;
        DFF dff3 (w[1], wint[0], clkslow, rst) ;

        mux m2 (wint[1], w[1], seed[1], sel) ;
        DFF dff2 (w[2], wint[1], clkslow, rst) ;
        
        mux m1 (wint[2], w[2], seed[2], sel) ;
        DFF dff1 (w[3], wint[2], clkslow, rst) ;

        mux m0 (wint[3], w[3], seed[3], sel) ;
        DFF dff3 (w[4], wint[3], clkslow, rst) ;
        
    end
    

endmodule

