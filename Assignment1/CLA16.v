`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:55:41 08/27/2021 
// Design Name: 
// Module Name:    CLA16 
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
module CLA16(s,cOut,cIn,a,b);
	input [15:0] a,b; input cIn;
	output [15:0] s; output cOut;
	
	wire [3:1] c;
	CLA C1(s[3:0],c[1],cIn,a[3:0],b[3:0]);
	CLA C2(s[7:4],c[2],c[1],a[7:4],b[7:4]);
	CLA C3(s[11:8],c[3],c[2],a[11:8],b[11:8]);
	CLA C4(s[15:12],cOut,c[3],a[15:12],b[15:12]);

endmodule
