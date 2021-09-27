`timescale 10ns/1ps

module testBench;
    // input as reg variables
    reg reset = 0 ;
    reg clock = 0 ;
    reg inpBit ;

    // output as wires
    wire outBit ;

    // generating clock cycles with always loop
    always 
        begin
        #2 clock = ~clock ;
        $display("time = %d, input bit = %b, output bit = %b, reset = %b", $time, inpBit, outBit, reset) ;
        end

    // Instantiating twoBitsComplement
   // twoBitsComplement inst (.outBit(bitOut), .inpBit(bitIn), .clock(clk), .reset(rst)) ;
    twoBitsComplement inst (.bitOut(outBit), .bitIn(inpBit), .clk(clock), .rst(reset)) ;
    // twoBitsComplement inst (outBit, inpBit, clock, reset) ;
    // testing with initial that runs at the start 
    initial 
        begin
        // $monitor("time = %d, input bit = %b, output bit = %b, reset = %b", $time, inpBit, outBit, reset) ;
        #1 reset = 1  ;
        #2 reset = 0  ;
        #2 inpBit = 1 ;
        #2 inpBit = 0 ;
        #2 inpBit = 1 ;
        #2 inpBit = 0 ;
        #2 inpBit = 1 ;
        #2 $finish ;
        end
endmodule
