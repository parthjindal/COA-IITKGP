`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:54:38 08/26/2021 
// Design Name: 
// Module Name:    RCA32 
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
module RCA32(s,cOut,cIn,a,b);
    input [31:0] a, b; //inputs
    input cIn; //carry in
    output [31:0] s; //sum
    output cOut; //carry out
    wire c; //carry forward from one RCA16 unit to the next
    
	 RCA16 RCA1(s[15:0],c,cIn,a[15:0],b[15:0]);
    RCA16 RCA2(s[31:16],cOut,c,a[31:16],b[31:16]);
	 
endmodule
