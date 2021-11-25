`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: RCA32
// Assignment: Lab-1
// Problem: 1-(c) Implementation of a 32 bit Ripple Carry Adder
// Group:  24
// Group Members: Parth Jindal, Pranav Rajput
//////////////////////////////////////////////////////////////////////////////////
module RCA32(s,cOut,cIn,a,b);
    input [31:0] a, b; //inputs
    input cIn; //carry in
    output [31:0] s; //sum
    output cOut; //carry out
    wire c; //carry forward from one RCA16 unit to the next
    
	 RCA16 RCA1(s[15:0],c,cIn,a[15:0],b[15:0]);
    RCA16 RCA2(s[31:16],cOut,c,a[31:16],b[31:16]);
	 
endmodule
