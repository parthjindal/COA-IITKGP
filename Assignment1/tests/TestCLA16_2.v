`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Module Name: TestCLA16_2
// Assignment: Lab-1
// Problem: 2 (a)Testing the Carry Look-ahead adder for 16bit using the Augmented CLA unit (using block propogates)
// Group:  24
// Group Members: Parth Jindal, Pranav Rajput
////////////////////////////////////////////////////////////////////////////////

module TestCLA16_2;

	// Inputs
	reg cIn;
	reg [15:0] a;
	reg [15:0] b;

	// Outputs
	wire [15:0] s;
	wire cOut;
	wire [3:0] P;
	wire [3:0] G;

	// Instantiate the Unit Under Test (UUT)
	CLA16_2 uut (
		.s(s), 
		.cOut(cOut), 
		.P(P), 
		.G(G), 
		.cIn(cIn), 
		.a(a), 
		.b(b)
	);

	initial begin
		// Initialize Inputs
		cIn = 0;
		a = 0;
		b = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		$monitor($time,"\ta=%d,\tb=%d,\tcIn=%b,\ts=%d,\tcOut=%b",a,b,cIn,s,cOut);
		#1 a =    32; b = 64; cIn = 0;
		#1 a =    32; b = 64; cIn = 1;
		#1 a = 65531; b =  4; cIn = 0;
		#1 a = 65531; b =  4; cIn = 1;
	end
endmodule

