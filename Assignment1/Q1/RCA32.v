/**
 * @file RCA32.v
 * @assignment: Assignment 1
 * @problem: (1) Ripple Carry Adder
 * @description: Implementation for a 32-bit ripple carry adder using a 16-bit ripple carry adder
 * @author Parth Jindal(19CS30033), Pranav Rajput(19CS30036)
 * @group X
 */

`include "RCA16.v"

module RCA32(s,cOut,cIn,a,b);
    input [31:0] a, b; //inputs
    input cIn; //carry in
    output [31:0] s; //sum
    output cOut; //carry out
    wire c; //carry forward from one RCA16 unit to the next
    RCA16 RCA1(s[15:0],c,cIn,a[15:0],b[15:0]);
    RCA16 RCA2(s[31:16],cOut,c,a[31:16],b[31:16]);
endmodule