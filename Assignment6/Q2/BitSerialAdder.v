`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:32:21 10/08/2021 
// Design Name: 
// Module Name:    BitSerialAdder 
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
module BitSerialAdder(
	input [7:0] A,
	input [7:0] B,
	input clk,
	input rst,
	input Cin,
	output [7:0] Out,
	output Cout
    );
	wire a, b;
	wire s;
	reg cIn;

	always @(posedge clk) begin
		if (rst) begin
			cIn <= Cin;
		end
		else 
			cIn <= Cout;
	end
	
	assign s = a ^ b ^ cIn;
	assign Cout = (a & b) | (b & cIn) | (cIn & a);
	
	PISO P1(A, clk, rst, a);
	PISO P2(B, clk, rst, b);
	SIPO S1(s, clk, rst, Out);
	
endmodule
