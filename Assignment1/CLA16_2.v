`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:06:47 08/27/2021 
// Design Name: 
// Module Name:    CLA16_2 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CLA16_2(s,cOut,P,G,cIn,a,b);
	input [15:0] a,b; input cIn;
	output [15:0] s; output cOut;
	output [3:0] P,G;
	wire [3:1] c;
	
	assign c1 = G[0] | (P[0] & cIn);
	assign c2 = G[1] | (P[1] & G[0]) | (P[1] & P[0] & cIn);
	assign c3 = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0])
				 |(P[2] & P[1] & P[0] & cIn);
	
	assign cOut = G[3] | (P[3] & G[2])
					| (P[3] & P[2] & G[1])
					| (P[3] & P[2] & P[1] & G[0])
					| (P[3] & P[2] & P[1] & P[0] & cIn);
	CLA_2 C1(s[3:0],P[0],G[0],cIn,a[3:0],b[3:0]);
	CLA_2 C2(s[7:4],P[1],G[1],c[1],a[7:4],b[7:4]);
	CLA_2 C3(s[11:8],P[2],G[2],c[2],a[11:8],b[11:8]);
	CLA_2 C4(s[15:12],P[3],G[3],c[3],a[15:12],b[15:12]);
	
endmodule
