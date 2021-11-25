`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:  LCU
// Assignment: Lab-1
// Problem: 2 Look-ahead Carry Unit
// Description: The LCU is used inside the 16-bit CLA which optimizes the 16-bit Rippled CLA by adding block-level
//					 propagate and generate signals
// Group: 24
// Group Members: Parth Jindal, Pranav Rajput
//////////////////////////////////////////////////////////////////////////////////
module LCU(C,P,G,cIn);
	input [3:0] P, G; input cIn;
	output [3:0] C;
	
	assign C[0] = G[0] | (P[0] & cIn);
	assign C[1] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & cIn);
	assign C[2] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0])
				 |(P[2] & P[1] & P[0] & cIn);
	
	assign C[3] = G[3] | (P[3] & G[2])
					| (P[3] & P[2] & G[1])
					| (P[3] & P[2] & P[1] & G[0])
					| (P[3] & P[2] & P[1] & P[0] & cIn);
endmodule
