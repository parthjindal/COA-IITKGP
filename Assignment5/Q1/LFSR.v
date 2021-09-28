`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Assignment: 05
// Engineeer: Parth Jindal, Pranav Rajput Group 024
// Module Name: LFSR 
// Description: Linear Feedback Shift Register 
//////////////////////////////////////////////////////////////////////////////////
module LFSR(
    input [3:0] seed, 	// seed for the LFSR
    input clk,			// clock
    input rst,			// reset
    input sel,			// select for loading the seed
    output [3:0] out	// output of the LFSR
    );
	
	// LFSR Logic //
	
	wire [0:3] wInt;	
	wire[4:0] w;
	
	assign out = wInt;
	assign w[0] = w[4] ^ w[3];

	DFF DFF3(w[1],wInt[0],clk,rst);
	DFF DFF2(w[2],wInt[1],clk,rst);
	DFF DFF1(w[3],wInt[2],clk,rst);
	DFF DFF0(w[4],wInt[3],clk,rst);
	
	MUX m3(wInt[0],w[0],seed[3],sel);
	MUX m2(wInt[1],w[1],seed[2],sel);
	MUX m1(wInt[2],w[2],seed[1],sel);
	MUX m0(wInt[3],w[3],seed[0],sel);
	
endmodule
