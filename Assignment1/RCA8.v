`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    RCA8
// Assignment: Lab-1
// Problem: 1-(c) Implementation of a 8-bit Ripple Carry Adder
// Group:  24
// Group Members: Parth Jindal, Pranav Rajput
////////////////////////////////////////////////////////////////////////////////
module RCA8(s,cOut,cIn,a,b);
    input [7:0] a, b; //input bits
    input cIn; //carry in
    output [7:0] s; //sum
    output cOut; //carry out
    wire [7:1] c; //carry forward connections 
	 
	 //Instantiate 8 cascaded FullAdder modules
    FullAdder FA1(s[0],c[1],cIn,a[0],b[0]);
    FullAdder FA2(s[1],c[2],c[1],a[1],b[1]);
    FullAdder FA3(s[2],c[3],c[2],a[2],b[2]);
    FullAdder FA4(s[3],c[4],c[3],a[3],b[3]);
    FullAdder FA5(s[4],c[5],c[4],a[4],b[4]);
    FullAdder FA6(s[5],c[6],c[5],a[5],b[5]);
    FullAdder FA7(s[6],c[7],c[6],a[6],b[6]);
    FullAdder FA8(s[7],cOut,c[7],a[7],b[7]);
endmodule
