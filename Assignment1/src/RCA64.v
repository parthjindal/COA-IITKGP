`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: RCA64
// Assignment: Lab-1
// Problem: 1-(c) Implementation of a 64 bit Ripple Carry Adder
// Group:  24
// Group Members: Parth Jindal, Pranav Rajput
//////////////////////////////////////////////////////////////////////////////////
module RCA64(s,cOut,cIn,a,b);
	input [63:0] a, b; //inputs
	input cIn; //carry in
   output [63:0] s; //sum
   output cOut; //carry out
   wire c; //carry wire from one 32-bit ripple carry adder to another
   RCA32 RCA1(s[31:0],c,cIn,a[31:0],b[31:0]);
   RCA32 RCA2(s[63:32],cOut,c,a[63:32],b[63:32]);
endmodule
