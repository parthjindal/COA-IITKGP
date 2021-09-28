`timescale 10ns/1ps

module testbench;
    // input as reg
    reg rst = 0;
    reg [3:0] seed = 0 ;
    reg clk = 0 ;
    reg sel = 0 ;

    // output as wire
    wire bitNext ;

    always 
    #5 clk = ~clk ;

    // instantiation
    LFSR ll1(bitNext, seed, clk, rst, sel) ;

    // testing
    initial 
    begin
        #10 seed = 4b'1111 ;
    end

endmodule
