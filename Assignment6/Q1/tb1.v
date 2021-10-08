`timescale 1ns/1ps

module testbench;

// output as wires
wire [7:0] out_test ;

// input as regs
reg [7:0] in_test ;
reg dir_test ;
reg [2:0] shamt_test ;

// test instantiation of barrel shifter
barrel_shifter unit_test(in_test, shamt_test, dir_test, out_test) ;

// setting values for input, direction (left/right shift) , and shift amount 
initial 
begin
    // setting test values

    // right shift
    in_test = 8'b10011010 ;
    dir_test = 0 ;
    shamt_test = 3'b101 ;

    #100
    $display("input =%d , shift =%d , direction = %b : output = %d ", in_test, shamt_test, dir_test, out_test) ;

    #100
    // left shift
    in_test= 8'b10010011 ;
    dir_test = 1 ;
    shamt_test = 3'b111 ;

    #100
    $display("input =%d , shift =%d , direction = %b : output = %d ", in_test, shamt_test, dir_test, out_test) ;

    #100
    $finish ;
end

endmodule 
