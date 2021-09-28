`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Assignment: 05
// Engineeer: Parth Jindal, Pranav Rajput Group 024
// Module Name: Comparator
// Description: This module is used to compare two values and returns LESS, EQUAL, GREATER
//////////////////////////////////////////////////////////////////////////////////
module Comparator(
    output wire L,
	output wire E,
	output wire G,
	input a,
    input b);
	 
	assign L = a < b;
	assign G = a > b;
	assign E = a == b;

endmodule
