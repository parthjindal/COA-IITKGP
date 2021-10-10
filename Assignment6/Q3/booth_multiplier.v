`timescale 1ns/1ps

module booth_multiplier(
    // output
    output reg signed[15:0] out,

    // input
    input signed[7:0] a,
    input signed[7:0] b, 

    // control input variables 

    // clock
    input clk,
    // load 
    input load,
    // reset
    input reset
    );

    // booth multiplier 

    // registers to store a and b
    reg signed [7:0] x ;
    reg signed [7:0] y ;

    // register to store product 
    reg signed [15:0] prod ;

    // check for storing  adjacents bits ( used for checking for 00,01,11,10
    reg [1:0] check ;

    // bP = positive multiplicand b
    reg [7:0] bP ;
    
    // nP = negative multiplicand b
    reg [7:0] nP ;

    //check_bit = stores the right most bit of the current product
    //used for checking condition
    reg check_bit ; 

    // loop counter 
    integer ctr ; 

    always @ (posedge clk)
    begin
        // if reset is ON, reset all values to default
        if(reset)
        begin
            check_bit <= 1'b0 ;
            x <= 8'b0 ;
            y <= 8'b0 ;
            bP <= 8'b0 ;
            nP <= 8'b0 ;
            prod <= 16'b0 ;
            ctr <= 0 ;
        end

        // else if load is ON, then load all values in parallel 
        else if(load)
        begin
            check_bit <= 1'b0 ;
            if(a >= 0) begin
                x <= a ;
                y <= b ;
                bP <= b ;
                nP <= -b ;
                prod <= a ;
            end

            else begin
                x <= -a ;
                y <= -b ;
                bP <= -b ;
                nP <= b ;
                prod <= -a ;
            end

            ctr <= 0 ;
        end

        // else perform booth's multiplication
        else 
        begin
            // appending 2nd rightmost and rightmost bit for condition checking 
            // leftmost bit = 0 for first run 
            check = {x[ctr] , check_bit} ;

            if (check == 2'b01)
            begin
                // if An-1An = 01 
                // then add B to the upper-half bits and right-shift
                // [7:1] and not [7:0] as product is storing final right-shifted answer and last bit is removed
                prod[14:0] = {prod[15:8] + bP, prod[7:1]} ;
            end

            else if (check == 2'b10)
            begin
                // else if An-1An = 10 
                // then subtract B from the upper-half bits and right-shift 
                // [7:1] and not [7:0] as product is storing final right-shifted answer and last bit is removed
                prod[14:0] = {prod[15:8] + nP, prod[7:1]} ;
            end

            else 
            begin
                // if An-1An = 00 or 11 
                // then just right-shift
                prod[14:0] = prod[15:1] ;
            end

            // rightmost bit set using 2nd last bit 
            prod[15] = prod[14] ; 

            // setting rightmost bit 
            check_bit = x[ctr] ;

            // incrementing loop counter 
            ctr <= ctr + 1 ;
        end
    end

    always @ (*)
    begin
        if(ctr < 8)
        begin
            out <= prod ;
        end

        if(reset)
        begin
            prod <= 16'b0 ;
        end
    end
    
endmodule 