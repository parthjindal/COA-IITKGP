`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    RCA4
// Assignment: Lab-1
// Problem: 2 (4-bit RCA for comparison with a 4-bit CLA)
// Group:  
// Group Members: Parth Jindal, Pranav Rajput
//////////////////////////////////////////////////////////////////////////////////
module RCA4(s,cOut,cIn,a,b);
    input [3:0] a, b; //input bits
    input cIn; //carry in
    output [3:0] s; //sum
    output cOut; //carry out
    wire [3:1] c; //carry forward connections 
	 
	 // Instantiate 4 cascaded FullAdder modules
    FullAdder FA1(s[0],c[1],cIn,a[0],b[0]);
    FullAdder FA2(s[1],c[2],c[1],a[1],b[1]);
    FullAdder FA3(s[2],c[3],c[2],a[2],b[2]);
    FullAdder FA4(s[3],cOut,c[3],a[3],b[3]);
endmodule
