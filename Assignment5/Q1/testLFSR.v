`timescale 10ns/1ps

module testbench;
    // input as reg
    reg rst ;
    reg [3:0] seed ;
    reg clk = 0 ;
    reg sel ;

    // output as wire
    wire bitNext ;

    always 
    #5 clk = ~clk ;

    // instantiation
    LFSR ll1(bitNext, seed, clk, rst, sel) ;

    // testing
    initial 
    begin
        rst = 0 ;
        sel = 1 ;

        #10 seed = 4'b1111 ;
        #15 $display("shift = %b", bitNext) ;

        #20 seed = 4'b0111 ;
        #25 $display("shift = %b", bitNext) ;

        #30 seed = 4'b0011 ;
        #35 $display("shift = %b", bitNext) ;

        #40 seed = 4'b0001 ;
        #45 $display("shift = %b", bitNext) ;

        #50 seed = 4'b1000 ;
        #55 $display("shift = %b", bitNext) ;

        #60 seed = 4'b0100 ;
        #65 $display("shift = %b", bitNext) ;

        #70 seed = 4'b0010 ;
        #75 $display("shift = %b", bitNext) ;

        #80 seed = 4'b1001 ;
        #85 $display("shift = %b", bitNext) ;

        #90 seed = 4'b1100 ;
        #95 $display("shift = %b", bitNext) ;

        #100 seed = 4'b0110 ;
        #105 $display("shift = %b", bitNext) ;

        #110 seed = 4'b1011 ;
        #115 $display("shift = %b", bitNext) ;

        #120 seed = 4'b0101 ;
        #125 $display("shift = %b", bitNext) ;

        #130 seed = 4'b1010 ;
        #135 $display("shift = %b", bitNext) ;

        #140 seed = 4'b1101 ;
        #145 $display("shift = %b", bitNext) ;
        
        #150 seed = 4'b1110 ;
        #155 $display("shift = %b", bitNext) ;

        #160 $finish ;     
    end

endmodule