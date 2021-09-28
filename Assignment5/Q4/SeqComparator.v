`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Assignment: 05
// Engineeer: Parth Jindal, Pranav Rajput Group 024
// Module Name: SeqComparator
// Description: This module is used to shift the bits of the input A,B by one and use an FSM for comparison
//////////////////////////////////////////////////////////////////////////////////
module SeqComparator(
    output Lout,		// Line-L
    output Eout,		// Line-E
    output Gout,		// Line-G
    input OP,			// Input OP signal
    input [31:0] A,		// Input A
    input [31:0] B,		// Input B
    input clk,			// clock
    input rst,			// reset
	input load);		// load signal for A and B
	 
	reg [1:0] PS, NS;
	reg L,E,G;
	 
	parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;	// States of FSM
	 
	wire a, b, l, e, g;
	
	assign Lout = L & OP;
	assign Gout = G & OP;
	assign Eout = E & OP;
	 
	BitShift B1(a,A,clk,load,rst);
	BitShift B2(b,B,clk,load,rst);
	Comparator C1(l,e,g,a,b);
	 
	always @(posedge clk or posedge rst) begin
		if (rst)
			PS <= 0;
		else
			PS <= NS;
	end
	
	// Mealy FSM
	always @(*) begin
		case (PS)
			S0: begin
				L = l;
				G = g;
				E = e;
				NS = (e == 1) ? S0 : (l == 1) ? S1 : S2;
				end
			S1: begin
				L = 1;
				G = 0;
				E = 0;
				NS = S1;
				end
			S2: begin
				L = 0;
				G = 1;
				E = 0;
				NS = S2;
				end
		endcase
	end

endmodule
