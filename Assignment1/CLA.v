`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:CLA 
// Assignment: Lab-1
// Problem: 2 (a) Carry Look-ahead adder (4-bit)
// Group:  
// Group Members: Parth Jindal, Pranav Rajput
//////////////////////////////////////////////////////////////////////////////////
module CLA(s,cOut,cIn,a,b);
	input [3:0] a, b; //inputs
	input cIn; //carry in
	
	output [3:0] s; //sum
	output cOut; //carry out
	
	wire [3:0] g/*generators*/,p/*propogater*/;
	wire [3:1] c; //intermediate carry wire connections
	
	assign g = a & b;
	assign p = a ^ b;
	
	assign c[1] = g[0] | (p[0] & cIn);
	assign c[2] = g[1] |	(p[1] & g[0]) 
					| (p[1] & p[0] & cIn);
	assign c[3] = g[2] | (p[2] & g[1])
					| (p[2] & p[1] & g[0])
					| (p[2] & p[1] & p[0] & cIn);
	assign cOut = g[3] | (p[3] & g[2])
					| (p[3] & p[2] & g[1])
					| (p[3] & p[2] & p[1] & g[0])
					| (p[3] & p[2] & p[1] & p[0] & cIn);
					
	assign s[0] = p[0] ^ cIn;
	assign s[1] = p[1] ^ c[1];
	assign s[2] = p[2] ^ c[2];
	assign s[3] = p[3] ^ c[3];
endmodule
