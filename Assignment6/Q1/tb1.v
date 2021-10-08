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
    // some values     
end

endmodule 
