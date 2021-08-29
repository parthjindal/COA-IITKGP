`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: CLA16_2
// Assignment: Lab-1
// Problem: 2 (a) Carry Look-ahead adder for 16bit using the Augmented CLA unit (using block propogates)
// Description: The augmented CLA16 module also has output P[3:0] and G[3:0] bits unlike the Base-CLA module,
//					 We can use the P and G unit for block propogation and generation in further blocks such as 32-bit or 64-bit
// Group:  
// Group Members: Parth Jindal, Pranav Rajput
//////////////////////////////////////////////////////////////////////////////////
module CLA16_2(s,cOut,P,G,cIn,a,b);
	input [15:0] a,b; //inputs
	input cIn; //carry In
	output [15:0] s; //sum
	output cOut; //carry Out
	output [3:0] P/*Block-propogate bits*/,G/*Block-generate bits*/;
	wire [3:0] c; //carry forward connections
	
	LCU L1(c,P,G,cIn); //Look-ahead Carry unit 
	
	assign cOut = c[3];				
	CLA_2 C1(s[3:0],P[0],G[0],cIn,a[3:0],b[3:0]);
	CLA_2 C2(s[7:4],P[1],G[1],c[0],a[7:4],b[7:4]);
	CLA_2 C3(s[11:8],P[2],G[2],c[1],a[11:8],b[11:8]);
	CLA_2 C4(s[15:12],P[3],G[3],c[2],a[15:12],b[15:12]);
	
endmodule
