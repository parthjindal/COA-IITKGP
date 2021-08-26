`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:31:22 08/26/2021 
// Design Name: 
// Module Name:    FullAdder
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
module FullAdder(s,cOut,cIn,a,b);
	input a, b, cIn;
	output s, cOut;
	wire s0,cOut0,cOut1; 

   HalfAdder HA1(s0,cOut0,a,b);
   HalfAdder HA2(s,cOut1,s0,cIn);
   assign cOut = cOut0 | cOut1;

endmodule
