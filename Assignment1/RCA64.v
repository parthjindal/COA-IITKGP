`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:58:20 08/26/2021 
// Design Name: 
// Module Name:    RCA64 
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
module RCA64(s,cOut,cIn,a,b);
	input [63:0] a, b; //inputs
	input cIn; //carry in
   output [63:0] s; //sum
   output cOut; //carry out
   wire c; //carry wire from one 32-bit ripple carry adder to another
   RCA32 RCA1(s[31:0],c,cIn,a[31:0],b[31:0]);
   RCA32 RCA2(s[63:32],cOut,c,a[63:32],b[63:32]);
endmodule
