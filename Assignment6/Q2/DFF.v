`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Assignment: 05
// Engineeer: Parth Jindal, Pranav Rajput Group 024
// Module Name: DFF 
//////////////////////////////////////////////////////////////////////////////////
module DFF(Q, D, clk, rst);
	input D, clk, rst;
	output reg Q;
	always @(posedge clk or posedge rst)
	begin
		if(rst)
			Q <= 0;
		else
			Q <= D;
	end
endmodule