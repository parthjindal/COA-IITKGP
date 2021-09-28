`timescale 10ns/1ps

module LFSR(nextbit, seed, clkslow, rst, sel);
    // input
    input [3:0] seed ;
    input clkslow ;
    input rst ;
    input sel ;

    output nextbit ;

    // wire for intermediate
    wire [5:1] w ;
    wire [4:1] wint ;

    mux m3(wint[1], w[1], seed[0], sel) ;
    DFF dff3(w[2], wint[1], clkslow, rst) ;

    mux m2(wint[2], w[2], seed[1], sel) ;
    DFF dff2(w[3], wint[2], clkslow, rst) ;
        
    mux m1(wint[3], w[3], seed[2], sel) ;
    DFF dff1(w[4], wint[3], clkslow, rst) ;

    mux m0(wint[4], w[4], seed[3], sel) ;
    DFF dff0(w[5], wint[4], clkslow, rst) ;

    assign w[1] = w[4] ^ w[5] ;

    assign q = w[1] ;
    
endmodule
