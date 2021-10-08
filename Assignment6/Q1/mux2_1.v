`timescale 1ns/1ps

module mux2_1(
    output [7:0] out, 
    input [7:0] in0,
    input [7:0] in1,
    input shiftval
) ;

assign out = shiftval ? in1 : in0 ;

endmodule
