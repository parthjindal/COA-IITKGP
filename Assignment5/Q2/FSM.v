`timescale 10ns/1ps

module twoBitsComplement(bitOut, bitIn, clk, rst);
    // output
    output bitOut ;
    // input
    input bitIn, clk, rst ;

    reg bitOut ;

    reg carryOver ;                            
    // the value of carryOver signifies 2 states 
    // carryOver = 1 : still one carry over left from previous bit ( also signifies start state)
    // carryOver = 0 : simple negation of bit for output

    always @(posedge clk)                   // checking for positive edges on clock cycle
        begin
            if(rst == 1)                         // if reset is ON 
                begin
                    carryOver = 1 ;        // carryOver = 1 i.e. start state
                    bitOut = 0 ;           // output bit = 0
                end

            else if(carryOver == 1)              // If carryOver = 1
                begin
                    carryOver = ~bitIn ;    // carryOver = 0 if input bit = 1 and carryOver = 0 if input bit = 1
                    bitOut = bitIn ;         // output bit is same as input bit
                end

            else                            // else if carryOver = 0
                begin   
                    carryOver = 0   ;       // carryOver stays the same as only negation of bits is taking place
                    bitOut = ~bitIn ;       // output bit = negation of input bit
                end
        end

endmodule
