`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: CLA_2
// Assignment: Lab-1
// Problem: 2 (a) Carry Look-ahead adder Augmented
// Description: The augmented CLA module also has output P and G bits unlike the Base-CLA module,
//					 Unlike The Non-augmented CLA there is no output carry-out bit (can be computed using,
//					(G or (P and CarryIn)). We can use the P and G unit for block propogation and generation
// Group:  
// Group Members: Parth Jindal, Pranav Rajput
//////////////////////////////////////////////////////////////////////////////////
module CLA_2(s,P,G,cIn,a,b);
	input [3:0] a, b; //inputs
	input cIn; //carry in
	output [3:0] s;//sum
	output P/*block-propogate bit*/, G/*block-generate bit*/;
	wire [3:0] g/*internal propogate bits*/,p/*internal generate bit*/;
	wire [3:1] c; // intermediate carry forward connections
	
	assign g = a & b;
	assign p = a ^ b;
	
	assign c[1] = g[0] | (p[0] & cIn);
	assign c[2] = g[1] |	(p[1] & g[0]) 
					| (p[1] & p[0] & cIn);
	assign c[3] = g[2] | (p[2] & g[1])
					| (p[2] & p[1] & g[0])
					| (p[2] & p[1] & p[0] & cIn);
	
	assign P = p[0] & p[1] & p[2] & p[3];
	assign G = g[3] | (p[3] & g[2])
				| (p[3] & p[2] & g[1])
				| (p[3] & p[2] & p[1] & g[0]);					
	
	assign s[0] = p[0] ^ cIn;
	assign s[1] = p[1] ^ c[1];
	assign s[2] = p[2] ^ c[2];
	assign s[3] = p[3] ^ c[3];
endmodule
