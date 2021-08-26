`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:10:54 08/26/2021 
// Design Name: 
// Module Name:    HalfAdder
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
module HalfAdder(s, c, a, b);
    input a, b;
    output s, c;
    assign s = a ^ b;
    assign c = a & b;
endmodule
