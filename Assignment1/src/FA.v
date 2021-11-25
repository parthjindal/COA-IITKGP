`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: FullAdder
// Assignment: Lab-1
// Problem: 1-(b) Full Adder
// Group: 24
// Group Members: Parth Jindal, Pranav Rajput
// Description: Full adder module for computing sum and carry of two inputs a,b and carry in c	
//////////////////////////////////////////////////////////////////////////////////
module FullAdder(s,cOut,cIn,a,b);
	input a, b, cIn; 
	output s, cOut;
	//Full Adder as a combinational circuit
	assign s = cIn ^ (a ^ b);
   assign cOut = (a & b) | (b & cIn) | (cIn & a);
endmodule
