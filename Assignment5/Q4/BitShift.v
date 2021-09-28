`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Assignment: 05
// Engineeer: Parth Jindal, Pranav Rajput Group 024
// Module Name: BitShift
// Description: This module is used to shift the bits of the input data by one and outputs the MSB
//				The input is cached into a register which is shifted left by one bit every cycle
//////////////////////////////////////////////////////////////////////////////////
module BitShift(
	output reg out,				// Output register
	input  [31:0] inp,			// Input
    input clk,					// Clock
	input load,					// Bit to check if to parallel load the cpy reg with inp or not
	input rst);					// Reset
	
	reg [31:0] cpy;				// Register to cache the input
	 
	always @(posedge clk or posedge load or posedge rst) begin
		if (rst)
			cpy <= 32'd0;
		else if (load)
			cpy <= inp;
		else 
			cpy <= { cpy[30:0], 1'b0 };
	 end
	
	always @(*) begin
		out = cpy[31];			// Output the MSB
	end

endmodule
