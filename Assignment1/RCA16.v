`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:48:20 08/26/2021 
// Design Name: 
// Module Name:    RCA16 
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
module RCA16(s,cOut,cIn,a,b);
    input [15:0] a, b; //inputs
    input cIn; //carry in
    output [15:0] s; //sum
    output cOut; //carry out
    wire c; //carry forward from one RCA8 unit to the next
    RCA8 RCA1(s[7:0],c,cIn,a[7:0],b[7:0]);
    RCA8 RCA2(s[15:8],cOut,c,a[15:8],b[15:8]);
endmodule
