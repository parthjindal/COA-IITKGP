/**
 * @file RCA16.v
 * @assignment: Assignment 1
 * @problem: (1) Ripple Carry Adder
 * @description: Implementation for a 16-bit ripple carry adder using a 8-bit ripple carry adder
 * @author Parth Jindal(19CS30033), Pranav Rajput(19CS30036)
 * @group X
 */

`include "RCA8.v"

module RCA16(s,cOut,cIn,a,b);
    input [15:0] a, b; //inputs
    input cIn; //carry in
    output [15:0] s; //sum
    output cOut; //carry out
    wire c; //carry forward from one RCA8 unit to the next
    RCA8 RCA1(s[7:0],c,cIn,a[7:0],b[7:0]);
    RCA8 RCA2(s[15:8],cOut,c,a[15:8],b[15:8]);
endmodule