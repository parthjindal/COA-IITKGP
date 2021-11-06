`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:59:56 11/05/2021 
// Design Name: 
// Module Name:    Adder 
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
module Adder(
    input [31:0] a,
	 input [31:0] b,
	 output [31:0] sum,
	 output carry
    );
	 
	 assign {carry, sum} = a + b;

endmodule
