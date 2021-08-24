/**
 * @file FA.v
 * @assignment: Assignment 1
 * @problem: (1) Ripple Carry Adder
 * @description: Implementation for a Full Adder module using a half adder
 * @author Parth Jindal(19CS30033), Pranav Rajput(19CS30036)
 * @group X
 */

`include "HA.v"

module FullAdder(s,cOut,cIn,a,b);
    input a, b, cIn;
    output s, cOut;
    wire s0,cOut0,cOut1; //connection wires

    HalfAdder HA1(s0,cOut0,a,b);
    HalfAdder HA2(s,cOut1,s0,cIn);
    assign cOut = cOut0 | cOut1;
endmodule