`timescale 10ns/1ps

module DFF(Q, D, clk, rst);
    // input
    input clk ;
    input rst ;
    input D ;

    // output
    output Q ;
    reg Q ;

    always @(posedge clk)
    begin
        if(rst)
        Q <= 0 ;
        else 
        Q <= D ;
    end

endmodule