`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: HalfAdder
// Assignment: Lab-1
// Problem: 1-(a)
// Group: 24
// Group Members: Parth Jindal, Pranav Rajput
// Description: Half adder for computing sum and carry for 2 binary bits
//////////////////////////////////////////////////////////////////////////////////
module HalfAdder(s/*sum*/, c/*carry*/, a/*inp*/, b/*inp*/);
    input a, b;
    output s, c;
    assign s = a ^ b;
    assign c = a & b;
endmodule
