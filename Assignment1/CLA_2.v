`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:30:53 08/27/2021 
// Design Name: 
// Module Name:    CLA_2 
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
module CLA_2(s,P,G,cIn,a,b);
	input [3:0] a, b; input cIn;
	output [3:0] s; output P, G;
	wire [3:0] g,p;
	wire [3:1] c;
	
	assign g = a & b;
	assign p = a ^ b;
	
	assign c[1] = g[0] | (p[0] & cIn);
	assign c[2] = g[1] |	(p[1] & g[0]) 
					| (p[1] & p[0] & cIn);
	assign c[3] = g[2] | (p[2] & g[1])
					| (p[2] & p[1] & g[0])
					| (p[2] & p[1] & p[0] & cIn);					
	assign s[0] = p[0] ^ cIn;
	assign s[1] = p[1] ^ c[1];
	assign s[2] = p[2] ^ c[2];
	assign s[3] = p[3] ^ c[3];
	assign P = p[0] & p[1] & p[2] & p[3];
	assign G = g[3] | (p[3] & g[2])
				| (p[3] & p[2] & g[1])
				| (p[3] & p[2] & p[1] & g[0]);
endmodule
