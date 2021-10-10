`timescale 1ns/1ps

module testbench;

// output variables as wires
wire signed [15:0] P ;

// input variables as reg
reg signed [7:0] A ;
reg signed [7:0] B ;
    // control variables
reg clk ;
reg load ;
reg reset ;

always 
begin
    #5 clk = ~clk ;
end

// unit under test 
booth_multiplier uut(P, A, B, clk, load, reset) ;


// initial for test values
initial 
begin
    // setting initial values for all parameters
    clk = 0 ;
    reset = 1 ;
    A = 12 ;
    B = 37 ;
    load = 0 ;

    // changing reset to 0 and load to 1 to load values
    #1 load = 1 ; reset = 0 ;

    // load = 0 to stop loading values and start calculation
    #6 load = 0 ;

    // waiting for the loop in booth's algo to finish calculation 
    // each cycle of loop takes 1 clock cycle
    #100 $display("A = %d, B = %d, prod = %d", A, B, P);

    #105 load = 1 ; A = 31 ; B = -21 ;

    // load = 0 to stop loading values and start calculation
    #6 load = 0 ;

    // waiting for the loop in booth's algo to finish calculation 
    // each cycle of loop takes 1 clock cycle
    #100 $display("A = %d, B = %d, prod = %d", A, B, P);

    #105 load = 1 ; A = -22 ; B = -15 ;

    // load = 0 to stop loading values and start calculation
    #6 load = 0 ;

    // waiting for the loop in booth's algo to finish calculation 
    // each cycle of loop takes 1 clock cycle
    #100 $display("A = %d, B = %d, prod = %d", A, B, P);

    #105 load = 1 ; A = -14 ; B = 7 ;

    // load = 0 to stop loading values and start calculation
    #6 load = 0 ;

    // waiting for the loop in booth's algo to finish calculation 
    // each cycle of loop takes 1 clock cycle
    #100 $display("A = %d, B = %d, prod = %d", A, B, P);

    $finish ;

end
endmodule

