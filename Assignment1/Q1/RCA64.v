/**
 * @file RCA64.v
 * @assignment: Assignment 1
 * @problem: (1) Ripple Carry Adder
 * @description: Implementation for a 64-bit ripple carry adder using a 32-bit ripple carry adder
 * @author Parth Jindal(19CS30033), Pranav Rajput(19CS30036)
 * @group X
 */

`include "RCA32.v"

module RCA64(s,cOut,cIn,a,b);
    input [63:0] a, b; //inputs
    input cIn; //carry in
    output [63:0] s; //sum
    output cOut; //carry out
    wire c; //carry wire from one 32-bit ripple carry adder to another
    RCA32 RCA1(s[31:0],c,cIn,a[31:0],b[31:0]);
    RCA32 RCA2(s[63:32],cOut,c,a[63:32],b[63:32]);
endmodule